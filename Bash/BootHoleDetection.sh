#!/bin/bash

# Boot Hole Detection Bash Script
# Copyright (c) 2020, Eclypsium, Inc.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.


# Revoked ubuntu certificate encoded in base64
ubuntu_cert_b64="
Q2VydGlmaWNhdGU6CiAgICBEYXRhOgogICAgICAgIFZlcnNpb246IDMgKDB4MikKICAgICAgICBT
ZXJpYWwgTnVtYmVyOiAxICgweDEpCiAgICAgICAgU2lnbmF0dXJlIEFsZ29yaXRobTogc2hhMjU2
V2l0aFJTQUVuY3J5cHRpb24KICAgICAgICBJc3N1ZXI6IEMgPSBHQiwgU1QgPSBJc2xlIG9mIE1h
biwgTCA9IERvdWdsYXMsIE8gPSBDYW5vbmljYWwgTHRkLiwgQ04gPSBDYW5vbmljYWwgTHRkLiBN
YXN0ZXIgQ2VydGlmaWNhdGUgQXV0aG9yaXR5CiAgICAgICAgVmFsaWRpdHkKICAgICAgICAgICAg
Tm90IEJlZm9yZTogQXByIDEyIDExOjM5OjA4IDIwMTIgR01UCiAgICAgICAgICAgIE5vdCBBZnRl
ciA6IEFwciAxMSAxMTozOTowOCAyMDQyIEdNVAogICAgICAgIFN1YmplY3Q6IEMgPSBHQiwgU1Qg
PSBJc2xlIG9mIE1hbiwgTyA9IENhbm9uaWNhbCBMdGQuLCBPVSA9IFNlY3VyZSBCb290LCBDTiA9
IENhbm9uaWNhbCBMdGQuIFNlY3VyZSBCb290IFNpZ25pbmcKICAgICAgICBTdWJqZWN0IFB1Ymxp
YyBLZXkgSW5mbzoKICAgICAgICAgICAgUHVibGljIEtleSBBbGdvcml0aG06IHJzYUVuY3J5cHRp
b24KICAgICAgICAgICAgICAgIFJTQSBQdWJsaWMtS2V5OiAoMjA0OCBiaXQpCiAgICAgICAgICAg
ICAgICBNb2R1bHVzOgogICAgICAgICAgICAgICAgICAgIDAwOmM5OjVmOjliOjYyOjhmOjBiOmIw
OjY0OjgyOmFjOmJlOmM5OmUyOjYyOgogICAgICAgICAgICAgICAgICAgIGUzOjRiOmQyOjlmOjFl
OjhhOmQ1OjYxOjFhOjJiOjVkOjM4OmY0OmI3OmNlOgogICAgICAgICAgICAgICAgICAgIGI5Ojlh
OmI4OjQzOmI4OjQzOjk3Ojc3OmFiOjRmOjdmOjBjOjcwOjQ2OjBiOgogICAgICAgICAgICAgICAg
ICAgIGZjOjdmOjZkOmM2OjZkOmVhOjgwOjVlOjAxOmQyOmI3OjY2OjFlOjg3OmRlOgogICAgICAg
ICAgICAgICAgICAgIDBkOjZkOmQwOjQxOjk3OmE4OmE1OmFmOjBjOjYzOjRmOmY3OjdjOmMyOjUy
OgogICAgICAgICAgICAgICAgICAgIGNjOmEwOjMxOmE5OmJiOjg5OjVkOjk5OjFlOjQ2OjZmOjU1
OjczOmI5Ojc2OgogICAgICAgICAgICAgICAgICAgIDY5OmVjOmQ3OmMxOmZjOjIxOmQ2OmM2OjA3
OmU3OjRmOmJkOjIyOmRlOmU0OgogICAgICAgICAgICAgICAgICAgIGE4OjViOjJkOmRiOjk1OjM0
OjE5Ojk3OmQ2OjI4OjRiOjIxOjRjOmNhOmJiOgogICAgICAgICAgICAgICAgICAgIDFkOjc5OmE2
OjE3OjdmOjVhOmY5OjY3OmU2OjVjOjc4OjQ1OjNkOjEwOjZkOgogICAgICAgICAgICAgICAgICAg
IGIwOjE3OjU5OjI2OjExOmM1OjU3OmUzOjdmOjRlOjgyOmJhOmY2OjJjOjRlOgogICAgICAgICAg
ICAgICAgICAgIGM4OjM3OjRkOmZmOjg1OjE1Ojg0OjQ3OmUwOmVkOjNiOjdjOjdmOmJjOmFmOgog
ICAgICAgICAgICAgICAgICAgIGU5OjAxOjA1OmE3OjBjOjZmOmMzOmU5OjhkOmEzOmNlOmJlOmE2
OmUzOmNkOgogICAgICAgICAgICAgICAgICAgIDNjOmI1OjU4OjJjOjllOmMyOjAzOjFjOjYwOjIy
OjM3OjM5OmZmOjQxOjAyOgogICAgICAgICAgICAgICAgICAgIGMxOjI5OmE0OjY1OjUxOmZmOjMz
OjM0OmFhOjQyOjE1OmY5Ojk1Ojc4OmZjOgogICAgICAgICAgICAgICAgICAgIDJkOmY1OmRhOjhh
Ojg1OjdjOjgyOjlkOmZiOjM3OjJjOjZiOmE1OmE4OmRmOgogICAgICAgICAgICAgICAgICAgIDdj
OjU1OjBiOjgwOjJlOjNjOmIwOjYzOmUxOmNkOjM4OjQ4Ojg5OmU4OjE0OgogICAgICAgICAgICAg
ICAgICAgIDA2OjBiOjgyOmJjOmZkOmQ0OjA3OjY4OjFiOjBmOjNlOmQ5OjE1OmRkOjk0OgogICAg
ICAgICAgICAgICAgICAgIDExOjFiCiAgICAgICAgICAgICAgICBFeHBvbmVudDogNjU1MzcgKDB4
MTAwMDEpCiAgICAgICAgWDUwOXYzIGV4dGVuc2lvbnM6CiAgICAgICAgICAgIFg1MDl2MyBCYXNp
YyBDb25zdHJhaW50czogY3JpdGljYWwKICAgICAgICAgICAgICAgIENBOkZBTFNFCiAgICAgICAg
ICAgIFg1MDl2MyBFeHRlbmRlZCBLZXkgVXNhZ2U6IAogICAgICAgICAgICAgICAgQ29kZSBTaWdu
aW5nLCAxLjMuNi4xLjQuMS4zMTEuMTAuMy42CiAgICAgICAgICAgIE5ldHNjYXBlIENvbW1lbnQ6
IAogICAgICAgICAgICAgICAgT3BlblNTTCBHZW5lcmF0ZWQgQ2VydGlmaWNhdGUKICAgICAgICAg
ICAgWDUwOXYzIFN1YmplY3QgS2V5IElkZW50aWZpZXI6IAogICAgICAgICAgICAgICAgNjE6NDg6
MkE6QTI6ODM6MEQ6MEE6QjI6QUQ6NUE6RjE6MEI6NzI6NTA6REE6OTA6MzM6REQ6Q0U6RjAKICAg
ICAgICAgICAgWDUwOXYzIEF1dGhvcml0eSBLZXkgSWRlbnRpZmllcjogCiAgICAgICAgICAgICAg
ICBrZXlpZDpBRDo5MTo5OTowQjpDMjoyQTpCMTpGNToxNzowNDo4QzoyMzpCNjo2NTo1QToyNjo4
RTozNDo1QTo2MwoKICAgIFNpZ25hdHVyZSBBbGdvcml0aG06IHNoYTI1NldpdGhSU0FFbmNyeXB0
aW9uCiAgICAgICAgIDhmOjhhOmExOjA2OjFmOjI5OmI3OjBhOjRhOmQ1OmM1OmZkOjgxOmFiOjI1
OmVhOmMwOjdkOgogICAgICAgICBlMjpmYzo2YTo5NjphMDo3OTo5Mzo2NzplZTowNTowZToyNTox
MjoyNTplNDo1YTpmNjphYToKICAgICAgICAgMWE6ZjE6MTI6ZjM6MDU6OGQ6ODc6NWU6ZjE6NWE6
NWM6Y2I6OGQ6MjM6NzM6NjU6MWQ6MTU6CiAgICAgICAgIGI5OmRlOjIyOjZiOmQ2OjQ5OjY3OmM5
OmEzOmM2OmQ3OjYyOjRlOjVjOmI1OmY5OjAzOjgzOgogICAgICAgICA0MDo4MTpkYzo4Nzo5Yzoz
YzozZjoxYzowZDo1MTo5Zjo5NDo2NTowYTo4NDo0ODo2NzplNDoKICAgICAgICAgYTI6Zjg6YTY6
NGE6ZjA6ZTc6Y2Q6Y2Q6YmQ6OTQ6ZTM6MDk6ZDI6NWQ6MmQ6MTY6MWI6MDU6CiAgICAgICAgIDE1
OjBiOmNiOjQ0OmI0OjNlOjYxOjQyOjIyOmM0OjJhOjVjOjRlOmM1OjFkOmEzOmUyOmUwOgogICAg
ICAgICA1MjpiMjplYjpmNDo4YjoyYjpkYzozODozOTo1ZDpmYjo4ODphMTo1Njo2NTo1ZjoyYjo0
ZjoKICAgICAgICAgMjY6ZmY6MDY6Nzg6MTA6MTI6ZWI6OGM6NWQ6MzI6ZTM6YzY6NDU6YWY6MjU6
OWI6YTA6ZmY6CiAgICAgICAgIDhlOmVmOjQ3OjA5OmEzOmU5OjhiOjM3OjkyOjkyOjY5Ojc2Ojdl
OjM0OjNiOjkyOjA1OjY3OgogICAgICAgICA0ZTpiMDoyNTplZDpiYzo1ZTo1Zjo4ZjpiNDpkNjpj
YTo0MDpmZjplNDplMjozMToyMzowYzoKICAgICAgICAgODU6MjU6YWU6MGM6NTU6MDE6ZWM6ZTU6
NDc6NWU6ZGY6NWI6YmM6MTQ6MzM6ZTM6YzY6ZjU6CiAgICAgICAgIDE4OmI2OmQ5OmY3OmRkOmIz
OmI0OmExOjMxOmQzOjVhOjVjOjVkOjdkOjNlOmJmOjBhOmU0OgogICAgICAgICBlNDplODpiNDo1
OTo3ZDozYjpiNDo4YzphMzoxYjpiNToyMDphMzpiOTozZTo4NDo2Zjo4YzoKICAgICAgICAgMjE6
MDA6YzM6MzkKLS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUVJRENDQXdpZ0F3SUJBZ0lC
QVRBTkJna3Foa2lHOXcwQkFRc0ZBRENCaERFTE1Ba0dBMVVFQmhNQ1IwSXgKRkRBU0JnTlZCQWdN
QzBsemJHVWdiMllnVFdGdU1SQXdEZ1lEVlFRSERBZEViM1ZuYkdGek1SY3dGUVlEVlFRSwpEQTVE
WVc1dmJtbGpZV3dnVEhSa0xqRTBNRElHQTFVRUF3d3JRMkZ1YjI1cFkyRnNJRXgwWkM0Z1RXRnpk
R1Z5CklFTmxjblJwWm1sallYUmxJRUYxZEdodmNtbDBlVEFlRncweE1qQTBNVEl4TVRNNU1EaGFG
dzAwTWpBME1URXgKTVRNNU1EaGFNSDh4Q3pBSkJnTlZCQVlUQWtkQ01SUXdFZ1lEVlFRSURBdEpj
MnhsSUc5bUlFMWhiakVYTUJVRwpBMVVFQ2d3T1EyRnViMjVwWTJGc0lFeDBaQzR4RkRBU0JnTlZC
QXNNQzFObFkzVnlaU0JDYjI5ME1Tc3dLUVlEClZRUUREQ0pEWVc1dmJtbGpZV3dnVEhSa0xpQlRa
V04xY21VZ1FtOXZkQ0JUYVdkdWFXNW5NSUlCSWpBTkJna3EKaGtpRzl3MEJBUUVGQUFPQ0FROEFN
SUlCQ2dLQ0FRRUF5VitiWW84THNHU0NyTDdKNG1MalM5S2ZIb3JWWVJvcgpYVGowdDg2NW1yaER1
RU9YZDZ0UGZ3eHdSZ3Y4ZjIzR2JlcUFYZ0hTdDJZZWg5NE5iZEJCbDZpbHJ3eGpUL2Q4CndsTE1v
REdwdTRsZG1SNUdiMVZ6dVhacDdOZkIvQ0hXeGdmblQ3MGkzdVNvV3kzYmxUUVpsOVlvU3lGTXly
c2QKZWFZWGYxcjVaK1pjZUVVOUVHMndGMWttRWNWWDQzOU9ncnIyTEU3SU4wMy9oUldFUitEdE8z
eC92Sy9wQVFXbgpERy9ENlkyanpyNm00ODA4dFZnc25zSURIR0FpTnpuL1FRTEJLYVJsVWY4ek5L
cENGZm1WZVB3dDlkcUtoWHlDCm5mczNMR3VscU45OFZRdUFManl3WStITk9FaUo2QlFHQzRLOC9k
UUhhQnNQUHRrVjNaUVJHd0lEQVFBQm80R2cKTUlHZE1Bd0dBMVVkRXdFQi93UUNNQUF3SHdZRFZS
MGxCQmd3RmdZSUt3WUJCUVVIQXdNR0Npc0dBUVFCZ2pjSwpBd1l3TEFZSllJWklBWWI0UWdFTkJC
OFdIVTl3Wlc1VFUwd2dSMlZ1WlhKaGRHVmtJRU5sY25ScFptbGpZWFJsCk1CMEdBMVVkRGdRV0JC
UmhTQ3FpZ3cwS3NxMWE4UXR5VU5xUU05M084REFmQmdOVkhTTUVHREFXZ0JTdGtaa0wKd2lxeDlS
Y0VqQ08yWlZvbWpqUmFZekFOQmdrcWhraUc5dzBCQVFzRkFBT0NBUUVBajRxaEJoOHB0d3BLMWNY
OQpnYXNsNnNCOTR2eHFscUI1azJmdUJRNGxFaVhrV3ZhcUd2RVM4d1dOaDE3eFdsekxqU056WlIw
VnVkNGlhOVpKClo4bWp4dGRpVGx5MStRT0RRSUhjaDV3OFB4d05VWitVWlFxRVNHZmtvdmltU3ZE
bnpjMjlsT01KMGwwdEZoc0YKRlF2TFJMUStZVUlpeENwY1RzVWRvK0xnVXJMcjlJc3IzRGc1WGZ1
SW9WWmxYeXRQSnY4R2VCQVM2NHhkTXVQRwpSYThsbTZEL2p1OUhDYVBwaXplU2ttbDJmalE3a2dW
blRyQWw3YnhlWDQrMDFzcEEvK1RpTVNNTWhTV3VERlVCCjdPVkhYdDlidkJRejQ4YjFHTGJaOTky
enRLRXgwMXBjWFgwK3Z3cms1T2kwV1gwN3RJeWpHN1VnbzdrK2hHK00KSVFERE9RPT0KLS0tLS1F
TkQgQ0VSVElGSUNBVEUtLS0tLQo=
"

# Revoked debian certificate encoded in base64
debian_cert_b64="
Q2VydGlmaWNhdGU6CiAgICBEYXRhOgogICAgICAgIFZlcnNpb246IDMgKDB4MikKICAgICAgICBT
ZXJpYWwgTnVtYmVyOiAyODA2NDE4OTI3ICgweGE3NDY4ZGVmKQogICAgICAgIFNpZ25hdHVyZSBB
bGdvcml0aG06IHNoYTI1NldpdGhSU0FFbmNyeXB0aW9uCiAgICAgICAgSXNzdWVyOiBDTiA9IERl
YmlhbiBTZWN1cmUgQm9vdCBDQQogICAgICAgIFZhbGlkaXR5CiAgICAgICAgICAgIE5vdCBCZWZv
cmU6IEF1ZyAxNiAxODoyMjo1MCAyMDE2IEdNVAogICAgICAgICAgICBOb3QgQWZ0ZXIgOiBBdWcg
MTYgMTg6MjI6NTAgMjAyNiBHTVQKICAgICAgICBTdWJqZWN0OiBDTiA9IERlYmlhbiBTZWN1cmUg
Qm9vdCBTaWduZXIKICAgICAgICBTdWJqZWN0IFB1YmxpYyBLZXkgSW5mbzoKICAgICAgICAgICAg
UHVibGljIEtleSBBbGdvcml0aG06IHJzYUVuY3J5cHRpb24KICAgICAgICAgICAgICAgIFJTQSBQ
dWJsaWMtS2V5OiAoMjA0OCBiaXQpCiAgICAgICAgICAgICAgICBNb2R1bHVzOgogICAgICAgICAg
ICAgICAgICAgIDAwOmQzOmQxOjgzOjkwOjBmOmRhOjY1OmEyOjJmOjA3OjVhOjYwOjk1OmViOgog
ICAgICAgICAgICAgICAgICAgIGY3OmM3Ojg2OjdjOjIwOjg2OmRhOjY1OmEzOmE2OjEyOmViOjVi
OjNiOmNlOgogICAgICAgICAgICAgICAgICAgIGM4OmZiOjNmOmExOjcyOjRiOjllOmRmOjUwOmM1
OjAzOjMzOmE0OjBjOjJiOgogICAgICAgICAgICAgICAgICAgIDVmOmQ2OjQxOjA0OjBkOmI2OmNm
Ojk1OjQ4OmVkOjhhOmIyOmFkOmQ2OmU1OgogICAgICAgICAgICAgICAgICAgIDAxOjM3OjRlOjYw
OmNkOmIyOjRhOjM4OjA0OmIzOjQ0OjgwOjk0OmFmOjlmOgogICAgICAgICAgICAgICAgICAgIDZl
OjU0OmRiOmE4OjFmOjNjOmI3OjRiOjMwOmRlOjIxOjgxOjZmOjA5OmEzOgogICAgICAgICAgICAg
ICAgICAgIDY2OmJhOjZhOjJiOjk2OmQ2OjlhOjYxOjc3OjBjOmQ0OmVkOjNjOmQwOjcxOgogICAg
ICAgICAgICAgICAgICAgIGJiOmFkOjhjOmYwOjIyOjVjOjNlOjI1OmNjOjZkOjIyOjJlOjYxOjk3
Ojk1OgogICAgICAgICAgICAgICAgICAgIGFmOjliOjJlOjRkOjU4OmI2OjdlOjc4OjAyOmMzOjBl
OmI5OmZhOmIyOjViOgogICAgICAgICAgICAgICAgICAgIDI3OmRlOjdkOmEyOmJlOjBjOjE0OmFj
OjczOmVjOjk3OmIwOjE1OjVlOmVkOgogICAgICAgICAgICAgICAgICAgIGVkOmU1OmE1Ojc1OjNm
Ojc4OmUwOjcxOmNlOjJmOmNlOjgzOmVkOjUzOjMxOgogICAgICAgICAgICAgICAgICAgIDMwOjk4
OjRlOmU2OmY5OjAxOmEyOjg4Ojg4OmE2OjIzOjA4OjdjOjBkOmI3OgogICAgICAgICAgICAgICAg
ICAgIDU0OjNhOjE2Ojk1OmVkOjVlOjc5OjVlOjkwOjRlOmZlOmNkOmFhOmRlOjgyOgogICAgICAg
ICAgICAgICAgICAgIGZjOmY2Ojk2OjcxOjRlOjQ5OjQ5OmI5OmQzOmU5OmIwOmFiOjdmOmQ3OjJh
OgogICAgICAgICAgICAgICAgICAgIDQ3OmI3OjUzOjMwOjI3OjdjOmRjOjY2Ojk4OjA5OjZmOmQx
OjdlOmY1OjdmOgogICAgICAgICAgICAgICAgICAgIDNkOjNlOmQ0OmEyOjZhOjg4OjU5OjAyOjJm
OjJmOjNkOmM4OmM2OjI4OmRlOgogICAgICAgICAgICAgICAgICAgIDQyOmZlOmQ5OjUyOjNkOjI0
OmMyOmZjOjQwOjk4OjExOmY2Ojc2OmJmOjhjOgogICAgICAgICAgICAgICAgICAgIGJiOjY1CiAg
ICAgICAgICAgICAgICBFeHBvbmVudDogNjU1MzcgKDB4MTAwMDEpCiAgICAgICAgWDUwOXYzIGV4
dGVuc2lvbnM6CiAgICAgICAgICAgIE5ldHNjYXBlIENlcnQgVHlwZTogCiAgICAgICAgICAgICAg
ICBPYmplY3QgU2lnbmluZwogICAgICAgICAgICBYNTA5djMgRXh0ZW5kZWQgS2V5IFVzYWdlOiAK
ICAgICAgICAgICAgICAgIE1pY3Jvc29mdCBUcnVzdCBMaXN0IFNpZ25pbmcKICAgICAgICAgICAg
WDUwOXYzIEtleSBVc2FnZTogCiAgICAgICAgICAgICAgICBEaWdpdGFsIFNpZ25hdHVyZQogICAg
U2lnbmF0dXJlIEFsZ29yaXRobTogc2hhMjU2V2l0aFJTQUVuY3J5cHRpb24KICAgICAgICAgNTc6
MWI6YTQ6NjA6NGM6Mjk6ZTk6ZjI6N2Q6NmI6NWM6OTM6ZGI6Y2M6NmM6OWY6MTg6M2Y6CiAgICAg
ICAgIDY5OjQ4OjlhOjc1OmRlOjY0OmYzOjgzOjRhOjA5OmE5OjI2OjIxOmVlOmU5OjU2OjVkOmUx
OgogICAgICAgICAzZTpkOTo3NTpjYjpjYzo3ZjpiZjo0ZDplNDplODo4OTozZDo3ZToxMTo0Mjo4
Nzo0MDpjMzoKICAgICAgICAgZDU6ZTA6NzE6Nzk6ZGM6MDA6NmM6ZTE6NzE6NjI6Yzc6OTg6YzI6
Y2I6Mjc6MGI6MmY6OWY6CiAgICAgICAgIGNjOmVjOmZhOjhiOmIyOmYzOjBiOjllOmYzOmYyOmMz
OmM5OjlmOmRiOjI1OjkzOjkwOmE0OgogICAgICAgICBjZDpiYjowMTplNTo4ZTpmNDpkNzo1NTph
ODpiNDo3NTo0MTozMTpmZDo0ZTo1ZDowMzoxODoKICAgICAgICAgYTA6YzI6YWM6YzU6ZGU6NDY6
ZTc6ZGM6MWM6Y2Y6MTI6ZDU6OWQ6ZTg6NDc6OWQ6OTM6OGM6CiAgICAgICAgIDMyOmNkOjQ0OmQ1
Ojc0OmM3OjMwOjlhOjU3OmE1OjU2OmQwOjdlOmNmOjA1OjExOmI0OmY0OgogICAgICAgICBmMzoy
OTpmOTpkYjo5Yjo1MzpkMjpiZDoyZjphZDo2YTo3NToyNjo0NTo2NDpiYTpiYToyODoKICAgICAg
ICAgOTY6ODc6OGU6Yjc6ZjA6Nzk6NTc6ZmE6N2E6MGU6M2M6NGE6Mzg6OTI6YmM6ZjI6OTU6ZjI6
CiAgICAgICAgIGU3OjI4OmQwOmY3OmQ4Ojk4OjFhOjVlOjM5OjllOmI1OjY1OjgwOmJkOmYzOmRh
OjEyOjNmOgogICAgICAgICA1MDo3Njo2NzoyOTo5ZjpkMTowYjowYToxZTo4Nzo5Nzo1Yzo3Mjpk
YjpmMzowMTo3NDo0YToKICAgICAgICAgZGQ6MDc6YmE6NzY6ZTk6NmE6ZmM6ZGQ6MjI6ZGI6NDY6
MDI6ZDc6YWY6MGE6YzU6ZWQ6MTU6CiAgICAgICAgIGJjOjBmOjJiOmE5OmRiOjhkOmJmOjdmOjZm
OmFkOmEyOmI3OmM1OjRkOjRhOjQ3OmIzOmMxOgogICAgICAgICA1Njo5MDpiNjoxNwotLS0tLUJF
R0lOIENFUlRJRklDQVRFLS0tLS0KTUlJQy9EQ0NBZVNnQXdJQkFnSUZBS2RHamU4d0RRWUpLb1pJ
aHZjTkFRRUxCUUF3SURFZU1Cd0dBMVVFQXhNVgpSR1ZpYVdGdUlGTmxZM1Z5WlNCQ2IyOTBJRU5C
TUI0WERURTJNRGd4TmpFNE1qSTFNRm9YRFRJMk1EZ3hOakU0Ck1qSTFNRm93SkRFaU1DQUdBMVVF
QXhNWlJHVmlhV0Z1SUZObFkzVnlaU0JDYjI5MElGTnBaMjVsY2pDQ0FTSXcKRFFZSktvWklodmNO
QVFFQkJRQURnZ0VQQURDQ0FRb0NnZ0VCQU5QUmc1QVAybVdpTHdkYVlKWHI5OGVHZkNDRwoybVdq
cGhMcld6dk95UHMvb1hKTG50OVF4UU16cEF3clg5WkJCQTIyejVWSTdZcXlyZGJsQVRkT1lNMnlT
amdFCnMwU0FsSytmYmxUYnFCODh0MHN3M2lHQmJ3bWpacnBxSzViV21tRjNETlR0UE5CeHU2Mk04
Q0pjUGlYTWJTSXUKWVplVnI1c3VUVmkyZm5nQ3d3NjUrckpiSjk1OW9yNE1GS3h6N0pld0ZWN3Q3
ZVdsZFQ5NDRISE9MODZEN1ZNeApNSmhPNXZrQm9vaUlwaU1JZkEyM1ZEb1dsZTFlZVY2UVR2N05x
dDZDL1BhV2NVNUpTYm5UNmJDcmY5Y3FSN2RUCk1DZDgzR2FZQ1cvUmZ2Vi9QVDdVb21xSVdRSXZM
ejNJeGlqZVF2N1pVajBrd3Z4QW1CSDJkcitNdTJVQ0F3RUEKQWFNNU1EY3dFUVlKWUlaSUFZYjRR
Z0VCQkFRREFnUVFNQlVHQTFVZEpRUU9NQXdHQ2lzR0FRUUJnamNLQXdFdwpDd1lEVlIwUEJBUURB
Z2VBTUEwR0NTcUdTSWIzRFFFQkN3VUFBNElCQVFCWEc2UmdUQ25wOG4xclhKUGJ6R3lmCkdEOXBT
SnAxM21Uemcwb0pxU1loN3VsV1hlRSsyWFhMekgrL1RlVG9pVDErRVVLSFFNUFY0SEY1M0FCczRY
RmkKeDVqQ3l5Y0xMNS9NN1BxTHN2TUxudlB5dzhtZjJ5V1RrS1ROdXdIbGp2VFhWYWkwZFVFeC9V
NWRBeGlnd3F6Rgoza2JuM0J6UEV0V2Q2RWVkazR3eXpVVFZkTWN3bWxlbFZ0Qit6d1VSdFBUektm
bmJtMVBTdlMrdGFuVW1SV1M2CnVpaVdoNDYzOEhsWCtub09QRW80a3J6eWxmTG5LTkQzMkpnYVhq
bWV0V1dBdmZQYUVqOVFkbWNwbjlFTENoNkgKbDF4eTIvTUJkRXJkQjdwMjZXcjgzU0xiUmdMWHJ3
ckY3Ulc4RHl1cDI0Mi9mMit0b3JmRlRVcEhzOEZXa0xZWAotLS0tLUVORCBDRVJUSUZJQ0FURS0t
LS0tCg==
"

# Microsoft dbx revocation hashes
hashes="
6b6e59284750fc0e6fac4d6c2a46100e9b0dde54e000b7327edd4a4dced9e9a0
62c6affbee1ba9a0435562db6e092a5018effeed0bd0f1d0494f34ce6cd403e9
6a6f1c13eefcba07c0fc8aa0b70ab6fe2bc709a9eaf83090b735fec8e0dd576b
aef3e0a113345c1adca2d627c5853a11ddfc4e0e07fd28c10049a9b766c0fbc5
c7d9dab91b726dea5abaa893d8f60bd4795f489894044dc56a9d3aad9cc49740
9d61099de8327efeff7e4aea81d9f3396a2218e6b22e15d05032a765897c0eba
0e99607b20d537497169c506c6893243d3f1bd5960505c1566bd97c0a741adfb
191a99a1ef854ce43e64d1ce2fdcc0c942200b88d232f8823a439cbcd7d148c1
475552c7476ad45e42344eee8b30d44c264d200ac2468428aa86fc8795fb6e34
8310f47ba34eb1aca146a5bdb8b59138173e659fbeb57a4c89355d8c54930b6b
6a86152df323185dcd535369c94b9226feb6aab4479c00a4a916b4e82e4a85fe
24d6b301a1268ba8b373275981538855205eb0115609800f2b5b95377483b108
04a779863e698705914958cfcf521450b8d2c9ae321dfe36a2dfda00ae75adc1
06edb9f17a9007c8b6db6ee2fc240e88e238f06c7c983f987cd9be1b80010d04
03c8c9956938147bcc81a19e580ca8b5214e82829ec0494c22b0f59013ca22b2
24558c1cb417b6387e2406c70ff13f5438506e8d7560dd7b226499c872c8076f
e6cb6a3dcbd85954e5123759461198af67658aa425a6186ffc9b57b772f9158f
777adc7e8a3e1422b3fc9c10ce31e996c057fe801a5292f0902bd5c5365e7287
953a7719b50073e701730fcff79b2fee7054c72c54d1f0b0f2571d3ce7fdb925
fb5eebcd4100593a1b2890267037b7701c83f32c284b99908ff1c34d5693bfc2
d57f40a0e9018765cd79393a0d57d8e6d6d880d93b95fa57cedbda5a0b4a1ae3
aa6f27b8b2ca5826f497362042c003b5e1d7ca22383d82730fbc5c45e048d839
67fe6b4b726451375e2dc3f87a0954cd01083fb4d8f4fb074bf699536450af04
d809eddc88a14239e8a069fa71f81f3e4af4dc293f7575d71d597c80f8767816
3f8f266488f3b888eb77b8df43582fa8124366b7d0670ed78926410f9c9f411f
4e371dd0448f1de869ee087b59ff88d11865463715272bcc6c29b0d5e21dbd82
537b428a0ad622765010c4405c1603ff464fcbb24ae4c2fbf559a10b8ea4593d
338b89190177e950151a198823fd9d5f4ea25c1faf73e56ca5d9cf69d373fd66
e352109145416e3b61dcf5e09492d24410828121e7d74c08ce0d3157b45a0831
0dd832075d552da3d29b1ef471fc23b47c0d54b9fd1541935b23f1c5813da08c
f8e2a41c0444d7da76fc1682f3eb7e2a90140e1b68b413f4426bac357cbe14bb
b06dc8f3de1e7e5a53dc7ad0f8028f78a843df54884b4a92bcec21071f0e649b
a9f6c38c2608d6f36f246e74a9fd17e915c89e54eafa2281b8ace86133df22b3
571b2aa6ca8edf6479d3472814b8cdf34a0b8544939e5ce9f50261968e382b45
127b01b1f605183bba4d1a07b7eefe01ba88203a6cd6686b28f3883f33c0ed42
df4e1cf6eaf602f99849ddb6802bd91fb13cd5c3f9fb420250d8a3d750642efa
0e5eb8d0bebf089a974bc0ca85d33d73f9a0bf72ed2a5e3a62a0387b51d509ce
2f871712447dde7c3552f5aa90a2292821c6f32d92788e00dee8566f8d4de209
561d28e0888cdb0a8fce41754742aa8eb1bf5c8dd4eacbf9af0f40e0d36013c2
6e79e3d0580d244c2fc2179a4f08cb80f945ad33d8c4c325de4e35e0d41584c5
3d23947c39680b9fcf22b092b97c9d38edcc02f7ad13d3a925d1ee0b62797e73
0ac2943abf5ef953b939247b74331fb2c437e405a81dd5569d9cff1d6183d53a
1275826206fef9aa0a48a60bbc15300b3201f76f45e3cce3fd0064de2fc7cc5f
8bf4fac6f3981d1e6180db0cd53152ae9666dc40884090a522840062e0c926e7
5156a8ae596c06692aef13ac6524c7f1e20d52e4ea0f5a5ad43a6874edcc5e1f
da31fe4698ad3d0e30408927be36c938bf52fa9cb8d46b12f84f5d5ec22dd1c6
d4d97aeab61079d3eb0e55794504991dd1beb0f200315718ffe44bae89f8f330
d92b8ac828b827e4e5b9e9aeb02676783cdb1884f42194823769ccf033a7b9c5
a1111555bfde8807746c8af73deceb4bdadc52dee87004e2ad7239c038687985
98acba206e9f3843a4a7e07c66ead4366fbe7976653b65ed0c311d4efae878ab
56f9e50da4817b1de9d9291eb5f2bc63703ca3e6f4a8571bde28cf756e2c80ba
d8e8197bb6cb93157bae6b4e63effa60bb49628debb6f771f154c229f4205db3
ef43b4b4a755494b10b7431527aead697feab6fa48cf4684cca4fb5b8cd09035
8e8addb29426d845a0101c2c1f26c2e7fe8c78128ab04f16cfcb4e06461b0101
ad1a9c1667e89214ee947d6b40d61bffb7ea942abcce85319520cc3de301fa1b
e50f1f1e9fb9198e5b094773d1d0068cc1cb1987d06583abaca20adc1f8932a9
f69d87f5bc30026b00110dadd0264311d15dece6b67f046506755284af5ec002
608854c2b7a26b00a3970757c2fa176b361f74fe094f7cfa482c439071279548
6a3c1124a642244f23685b68d2e5a0ae036651aa401de70b3912efd044b62222
5613dd1553044bef74610bc012d676375588421ff0000b69dcf62d1081451ece
6484a487192e0b44cbd30eb7b3d436a9150d5b5ad271974764366bdc4e8677bb
1babf3fb76ae149ccb95b8e33b193ce7408b7134e0a5cc8ce1e884bcd01dfcf2
0ce7f3fec8bbb04e182027dd6800b7993e9f14eb579504ddecdd2f06294d7739
d764ac6251fd2641eebbfbf7a5a95e212df5997875990d90562ca65d5d966bae
4b2bd93b32de4be7235c95c97af98e12bed5f0602b7b428700f9a1348cb2f731
3141c6ef9fce61084d16f0659a9596b0156f24d6f4b03837c4b7543cfb378d61
f88e92940985413acd440daa20c08df99c54613636826d9d95b898d39c44b19b
cef9a1b433c4ed851ec0c373f7e1f19a2b8c306a821d114f177b14e8c070276f
9c904f10520295d070db9cf381101512946ab832c2bd92d4e92d42b934f40dc3
20e870697471f16eac55a9658212f83a7e443cdb3844c7d1901b4d4271828f7d
fd1cd4d4a1ac691e7a0af14c3dfb17daf3f2e6a2b286c9e233070979ec36bb6f
cd0f9839c6ccbec5ce38b882e1ab23c8ab44a8993e6b8a02026d8314eac4ea4c
e1dc3ef55626a4cf6ddc425a353208f309271b8a9fdbf8964082fb08dfb7a170
55a3628537c4fbda0fa7d27001eb2dfcdc515d8a48649715a31e1d0065a7da35
3f8091f700da0dd082c6c06d0d3b68db8d51fbe03198bbd6e4fa0d4a9eaca522
ee721020db7794de74f59992a2c6b4dca5b9fd584bbcbdef96930b9a7132be1c
ba0610793faa746150c0fd5689158b01deeea7320e2f14b31ee9af4f2c4d1587
23ebfbc7bc286cefc68b4920784b926ec28d7965815238325fbd17892177d6f3
8a73b6e52b27695c72d4776c0bcfa54d30c1340d534d5eeff8d890377cdfdfaa
957d8826bee05dfea66994c237e61bd70cc0115cc176e1d931f1d892c6c16814
52a4f27ccedcc5405d8ec128bf99861865b2273da18a9b958abadeff63df5a18
83b1d2b20830ee199d8845c999d4680b1b2b6d9c1f424dd13826da3fa7f7139e
bae97efc507382c0bdf7b1e74dbc38c0e31bf65186b7989cd9c7af29da27f656
d8c26a5324ca74212b59b59bef1bc33fb5b6946dcdde84414c60a2e315ede741
a7094801f966fc5c253dbd17066af5bbcb3af5e281d0a4dab24e30c7a4b0fb12
299e3b66b0283e23793e03fba6b795a2c6b6034864b6d571449945eba0d90a20
0742a120e871bbb67d6947d05e9301cdacbccb4af650464f996b40352ca9699b
c31524cf5814d19c11611a5e5c27b2071dcb76b7ec6dc2dec93ff9de5ce656de
2b91c0c8c0f156abc8f85274c1320c038af0179fe4696260b1011d5361e50aea
cb9e3e372c5f707858e1de6421c2d3407c240f9d7bc43a9b9f3ba1f6037615b9
29da5912698ee1928c239d394ef95a4beef0dc59262b6bffec24fa205c4b8a10
0692a9566f22f280715080ee24b8ff54ed7372a98bd4994670fcf862035281b5
0ca03ad1a65afe81ec23e2b20e05d80c41aaeb5d6d5f98e2d0c5661f46e0ce9f
ba44bd2bb872dd6c6a8687f65cc138585a963473203d6f3f64770e5365812630
aa909adbb83e05f92ba2e1144c6a33cb320a760409e1015b00a9eed666063510
cb59d546665d85dc101139e7d26d02a62e0e800deaccf9555ef0a88b95abe26a
439983268fc8238cb2dc187b033904dbd682929852d846fb69a22dda1561a422
0ed1b0fae1a6e705d1b116d08b7184e0a2ee2a0e6b0c372ce69b40e9ef34579f
5875db0835e08a9189f23833b21774fdd1c4c3bd4c5d3459471a49b85cffd1e1
edd0e7c8f136af180b3a886d06215a0c1d0a6fb7583f79e72a19711be6419df8
b6c36b2b18a3e73ea007173f8669d9a9a861fddf27c3e3c0c3f1315e2ae5b43f
b76c5689d45e7f40f8d78468d4484074167563cb06368cbb9cb4dbed65e1192a
a739c0624b7608f40645d417e79ce0b22fa568d885acebe51949f268565098b4
f8dfc2f2231fb7e654d4716a56fcdbc82bbf1ca673432f8843cdd378077b8700
6e5d8278a7a4a58dbba2f5d01b09b9de4bb20acd2dd4890846c8125a65136bf8
88b530624b67faa0c0c1039618958f4de983a997a6ff762bcca82b8201194f28
10368826dc89af42b4ad7e69a9e1f4da9486dd645c088f445998e8dca18eb0d4
2b7a243ac2248c630a51d73889e4baa33da94bd58d63e364a5fef1a0998b4f5e
3ae3da82c39c6beefd251265370d57d5bfc67181662736c62f2e6f687409c81b
bbd53435e3881c13f6ef3d7c17dde9bccf2bb2d95d303dc4623cd1aa8f51ef23
d389ede1f84051086d30b8c2cfc362797b129854df1313ca474f83a143f55d11
9e5773c34073b8473bd1ebc9d4d50780a7cdf9eb767750107d4b0f45bc8eabe8
3d3434bc5a18f072d4cf59d5651f9ce05b61b6fc3c21ebbcf371777aa1e1e1d5
77f55c6e07d808021f9e66017605d8b2ded6c55944693641902c4ce821e37878
7d092a6101832f2cf3f9de42c66a9948751b05d3d4005fb9c0e8bdf9b8daec6b
899afe09e356003605b30dc209a5ba4ef6910baef23fac268bcac6db3cfee98d
c4b5797189521611b809720ed9c4734f1dec8a2ee2597781ffe438f652a58ce5
34440cb45eb6ec2532ef89d6fcd7d3d9bc2a021677bebc9d65c47a725a6845d4
94bde75194960faff8329dcb4462bd8888b32078b0fb8fb2011c6993fda0316a
84a6c5f6c7ac07f1cc405f7b53b69bff17be0e4b9a428c21d39dce0cdd4ef16b
2aec3e859816efa89af844d6dd8ccaea345a851cb23006d3c2928081352beb25
487df121fd496d9a443c3598da3771fa187d408c589f4cb990041e546c529539
ee39a9a3fbde8b15ce4ac34519e248ea746a52ae0ae680da5b0c7ef919e583a3
103fe82e5f090184d8db7a48801d1e503e3c6fc0726783e9a49a84f9ffd4c78a
424c636253b4efa0c69f91505ee16d7079956b8ede4524ffce211a1b037ff692
7c783057c245a34dff5a9497c3cd4181fc80d06439884e12ad5d67a4f5266cd6
169d0ac3da1dda382812f7f221b8c9cd55961a05d876e3d812641313297848ba
d57796b512baa19473d7935c111245ceaa614e37c1d404fab45ff735adf245f6
f06d3e0f031a2fdc63dd2ba2be7f32e0d432434c3515c2f840d812ffbfa530f6
610d0a80fd4e876ead581903b33c96ecc4b8bd7115fc9df5579b3a25416fdaef
707beeae9b9cbf0d56aee48ae398f127d3b52fd37d25b95c561cda1db5233c50
b40f5ff7030848db736573e06a1a1c5bf49f119e66dd0ba7e48e2651e2ce7059
17f186c88052b988b4c9b62f8d7f55023ac317c82324dd5a958d05b8a1246f77
a121947909d35bb042f0049d18e4ee2b27941e10d14e4d6b1c11945ca79992e6
eec3e281a5545caf11ec02bb0df159da19698e639cba0190a0aec9ab09296beb
bdd96b78f3aa4b123851342995451880cb2498e785ed12e48ceb36f1a3f49b2b
50484376441815f7f85aa294290a9b6072a6a9e8feae79447c5c4de855c5a3d3
26a8ebb3ef412aa70d4ab4486ebee8db42656ae7f2ec868fa95fa656090f01be
8516257431a250296a10f82a4795f9cf68e5c185ceaa2f6f77ca0942cbe0c999
96520e78051325998a6d82fffee0366f85289e6d8834d1f3da9082c6ee146d26
459728935c400cbed125a0aa12d0e618ccb6f4fde3194bb2d06a511daa335350
ec16cfb5ae2297154394d9ab6b5b749dce676404486d72a44064cd9a716ec1f9
0fb12613bc1d4ab6fbb256574eba9347ae3a87f96e4a3c259028b55cde1d8053
9eabea9ae699526ad519782da21718da7190490aa3436bbbd80269d4a4cc37c5
83a5c9c78bc64206aaf7b7f9901867d19bb746201923d855aae24a2b2330f113
690b765c38be3fba65b829677d98a67943f92e24e9860ee2a13273f5932b8a0a
edfff0969567ff1c1867aa921eaa5cf4c65d20f0511ba7ee7328f7b67238df53
c33397b499368e23dda3fd5b9cc989647442f279ee6f80b53c620721c958346d
ad215b731a41cbe37cafee5280ffc282a8ac23b5e8ba25dff3d28a6aae1d2a0d
561694642d87969c00583ed6c4bb6c41527dff7164a079035e8c8b905a5e4b62
5c39f0e5e0e7fa3be05090813b13d161acaf48494fde6233b452c416d29cddbe
aa8db86be59a48e4c525dd468119beba1d836ce4293c76e4b736902d1ad62f27
df224ef3b05794cbce084c11baaf3d85f380a5213d9097e400d9fa42fc412933
97bb9fd717c396231e86ecbe5a760d56dbacf4ae8e963d16d724591e45919b65
07058c9bbccb99d58fc93ebe2c007cfe28e1bf74e51954584aa3d3ca06689fba
2f1dae62ea074fd06dbbf620009cb3e65988d15431a061eaab4d7ed1a97a3689
a95666bfaf48fd9c4caf2f3ed4eb593145c48bd3c93e4b00638088ce7ee962cf
30a947ed2f95d0e7f2746f3a4f3c458fc64554295ba5b4c302fe0ee4f8027c0c
ede70aa6a98d8130019296ce64b5ccf634a997b26401c0e119b96bbf7ace1c0c
6ae5984a47cce9129498e534db84f0fd33fe9aee2860462414416282eb0cf34a
407326c7f1c837a861ee8d187170c779a9b6a25b0736761645d7e549ebfa17c2
3e4e41310a11dd92a8daa50ab361ca97b0a9edb1bfdd38f95ed4553253e61ef7
7b5dfe4f9e4ee68e3cdd9c91bcae26db334d49ae4c1f9525cecd834de48df110
0ccd31ed42ff79e74fba9c064f59f698e3ae9f9e690be296ea63936e81982000
d84ae3f1bb7b2f2c41b986e473ad424cf6f1d136b4e91aa5f73824737169d820
a2be1eb17e12e0a66a87342c9d1cfd4d7db81504a16b4fcb32f15c6baa3f589d
e4ff4e538b4758e8e49010ed16d6d5380417b146f3e8806acb3ac40611646fdb
fccc2a01967926437dc0f5f49c6aceed4dc67ebd7e99169023b5f89a7264cb98
9ea346fcfe6db7f3140da8ffd5738f6cf97d6014da61033b32049cb17696b372
a120f42de7b5bfcb55c40afc857b6baf4d1ac60725500c27a5b2942bda970ccf
aecd34387179aff5ce02103679312cdeb1da835015a8548fce93765e7219612e
862ef2d92e8e0df128007aef6f9e4d6a6d0de3c656a4d72d1a19a18068c23508
e33e9d1b1d5ade1934ac7bd39f0ba4ceac9459a7e2aabb8d204354d4c8652e6e
24af7036c63f09febab1b84372ecd6151be32cdc94e80e57f52f7d2c3665fbc4
2df05c41acc56d0f4c9371da62ec6cb311c9afb84b4a4d8c3738583ccc874d38
1cc3d6da3017f0f1422d1b8115622edef65fbc497487234d17f4d356670f28eb
7c2fda323f09b9be6269ba979a620438413eba4a93b2ba34f9b39998268ad9cd
65c4aab0884825a8a2e4c114020e4fdb58a1d2b0cb68b7714a05d6cde3f821d1
44fd1f90799b852b3bed642de300bcf9ef6ca81036cd5588c24d5b8e00d4b9d1
e0a6813d4020a6a50db26d276f175a942150e346f056a4dba94f17ddce2264f1
c194b98bd9a2129a4c1b6044eede090f823535deaab3b48dac2685121c7ca133
3f1d987d4573048b4784fdbcb4fad6769f320651b3eddb704472a42b50ac23d0
5d6a0cbdaaf188974e98aca06e664b4ae98d458327717a20b1ff6c80518eea3d
"

echo "Boot Hole Detection Bash Script"
echo "Copyright (C) 2020, Eclypsium, Inc."
echo "This program comes with ABSOLUTELY NO WARRANTY."
echo "This is free software, and you are welcome to redistribute it under certain conditions;"
echo ""

if ! command -v mokutil >/dev/null; then
    echo "[-] Command 'mokutil' not found: please check README for dependencies"
    exit 1
fi

if ! command -v sbverify >/dev/null; then
    echo "[-] Command 'sbverify' not found: please check README for dependencies"
    exit 1
fi


ubuntu_cert_temp="/tmp/ubuntu_cert.txt"
debian_cert_temp="/tmp/debian_cert.txt"
err="/tmp/boothole_err"
vuln=0
sb_failed=0

check_secure_boot() {
    state=$(mokutil --sb-state 2>&1);
    mokutil_status=$?
    printf "[*] mokutil:\n%s\n\n" "$state"
    if [ $mokutil_status -ne 0 ]; then
        echo [-] mokutil returned non-zero status: exiting
        exit 1
    fi
    echo $state | grep -qs 'SecureBoot enabled'
}

check_cert() {
    if sbverify --cert $1 $2 >/dev/null 2>$err; then
        echo "[!] ${2} signed with revoked certificate"
        vuln=1
    fi

    grep -qs 'Verify error' $err
    if [ $? -eq 0 ]; then
        cat $err
        sb_failed=1
    fi
}

check_hash() {
    local file_hash=$(sha256sum $1 | cut -d ' ' -f 1)
    if echo $hashes | grep -Eqs "$file_hash"; then
        vuln=1
        echo -e "[!] ${1} matches revoked hash"
    fi
}

# Check if SecureBoot is enabled
if ! check_secure_boot; then
    echo -e "[!] ESP is not protected\n"
fi

# Attempt to mount efi partition if not available
if ! [ -r /boot/efi/EFI ]; then
    if mount /boot/efi; then
        echo -e "[*] Mounted efi partition"
    else
        echo -e "[-] Mounting efi partition failed"
        exit 1
    fi
fi

# Decode certificates
echo $ubuntu_cert_b64 | tr -d '[:space:]' | base64 -d > $ubuntu_cert_temp
echo $debian_cert_b64 | tr -d '[:space:]' | base64 -d > $debian_cert_temp


# Check all efi hashes and certs
while IFS= read -r -d '' file; do
    check_hash $file
    check_cert $ubuntu_cert_temp $file
    check_cert $debian_cert_temp $file
done < <(find /boot/efi/ -name "*.efi" -type f -print0)


if [ $vuln -eq 1 ]; then
    echo -e "\n[!] ALERT: GRUB/Shim is vulnerable to BootHole; Check for bootloader updates from Operating System"
else
    if [ $sb_failed -eq 1 ]; then
        echo -e "\n[-] sbverify failed to verify efi certificates: result inconclusive"
        exit 1
    fi
    echo -e "\n[+] No indication found that GRUB/Shim is vulnerable to BootHole"
fi
