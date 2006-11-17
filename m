Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <455E35AA.4080803@lix-world.net>
Date: Fri, 17 Nov 2006 23:20:26 +0100
From: Steen Eugen Poulsen <sep@lix-world.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
References: <d1a198ae0610221203n6e0dd9a4y1cdf40e4bd79f8d5@mail.gmail.com>	<200610241902.07288.mailinglists@gaboo.org>	<d1a198ae0611141934v35458c90u1d865d096e00ab72@mail.gmail.com>	<455AAB02.5030909@lix-world.net>
	<d1a198ae0611150528v36a10eackf0c1d908c8d21e95@mail.gmail.com>
In-Reply-To: <d1a198ae0611150528v36a10eackf0c1d908c8d21e95@mail.gmail.com>
Subject: Re: [Bluez-users] DiNovo + Ubuntu edgy, hid2hci is not working
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0940522405=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a cryptographically signed message in MIME format.

--===============0940522405==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms040900040104030200050608"

This is a cryptographically signed message in MIME format.

--------------ms040900040104030200050608
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Kristoffer Lund=C3=A9n wrote:
> That's a very good idea. :) Actually, I did use it in Windows in one
> rare occassion yesterday, and since I received an update to the
> software, I had to re-pair all the devices (twice, sigh), entering
> numbers and so on. Don't know if that means it was using bluetooth or
> not, but it worked just fine.

Using the setpoint software is Bluetooth mode only afaik, so clearly
your bluetooth usb hub is still working and we need the help of the devs
to find the reason why BlueZ is broken with out diNovo's.

I've used bluez for a week now, so I'm not really sure how to debug it.

If the diNovo has worked for you (in HCI mode), how about trying older
versions, grab the dapper bluez one and try it?




--------------ms040900040104030200050608
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIK7DCC
BXIwggRaoAMCAQICBEOGqWgwDQYJKoZIhvcNAQEFBQAwMTELMAkGA1UEBhMCREsxDDAKBgNV
BAoTA1REQzEUMBIGA1UEAxMLVERDIE9DRVMgQ0EwHhcNMDYwNzI2MTMyNTM1WhcNMDgwNzI2
MTM1NTM1WjB7MQswCQYDVQQGEwJESzEpMCcGA1UEChMgSW5nZW4gb3JnYW5pc2F0b3Jpc2sg
dGlsa255dG5pbmcxQTAaBgNVBAMTE1N0ZWVuIEV1Z2VuIFBvdWxzZW4wIwYDVQQFExxQSUQ6
OTIwOC0yMDAyLTItMzE3NjE3NjE4MTQ5MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDl
v74PjpJrPTPfGCsZVhVK+ihTc1gLzPApQLuuAwFkU1YlotH5E92uO6YAGBh0u7Nu89N/N5Ad
JV4v6Hsmr8CZRAm6K/Nib3QsIByUi8VdgCcfD/MPheu8nne/YYQ6Edws3M1vBvY22NHW7Hkd
dtjYNiD2biGQ36eNoLbCTeMClwIDAQABo4ICyjCCAsYwDgYDVR0PAQH/BAQDAgP4MCsGA1Ud
EAQkMCKADzIwMDYwNzI2MTMyNTM1WoEPMjAwODA3MjYxMzU1MzVaMIIBNwYDVR0gBIIBLjCC
ASowggEmBgoqgVCBKQEBAQEDMIIBFjAvBggrBgEFBQcCARYjaHR0cDovL3d3dy5jZXJ0aWZp
a2F0LmRrL3JlcG9zaXRvcnkwgeIGCCsGAQUFBwICMIHVMAoWA1REQzADAgEBGoHGRm9yIGFu
dmVuZGVsc2UgYWYgY2VydGlmaWthdGV0IGfmbGRlciBPQ0VTIHZpbGvlciwgQ1BTIG9nIE9D
RVMgQ1AsIGRlciBrYW4gaGVudGVzIGZyYSB3d3cuY2VydGlmaWthdC5kay9yZXBvc2l0b3J5
LiBCZW3mcmssIGF0IFREQyBlZnRlciB2aWxr5XJlbmUgaGFyIGV0IGJlZ3LmbnNldCBhbnN2
YXIgaWZ0LiBwcm9mZXNzaW9uZWxsZSBwYXJ0ZXIuMEEGCCsGAQUFBwEBBDUwMzAxBggrBgEF
BQcwAYYlaHR0cDovL29jc3AuY2VydGlmaWthdC5kay9vY3NwL3N0YXR1czAcBgNVHREEFTAT
gRFzZXBAbGl4LXdvcmxkLm5ldDCBhAYDVR0fBH0wezBLoEmgR6RFMEMxCzAJBgNVBAYTAkRL
MQwwCgYDVQQKEwNUREMxFDASBgNVBAMTC1REQyBPQ0VTIENBMRAwDgYDVQQDEwdDUkwxNDAz
MCygKqAohiZodHRwOi8vY3JsLm9jZXMuY2VydGlmaWthdC5kay9vY2VzLmNybDAfBgNVHSME
GDAWgBRgtYXsVmR+EhknZx1QFUtzrjv5EjAdBgNVHQ4EFgQUGnA0kYplEvpmQTxbkQMwljvV
XMcwCQYDVR0TBAIwADAZBgkqhkiG9n0HQQAEDDAKGwRWNy4xAwIDqDANBgkqhkiG9w0BAQUF
AAOCAQEAT5wZtMDaWA31Y7uOj4Z1YXx70TbIreJe1IdVGmQCb0X5LCapVCRHtnP0LEOOPZlJ
WuR89jSRz8Ojxi+bR/maVu2bIlP900p+S18TksLsR1k7eiEPDYta8/rz7s5EHwuG00Ts9AiO
4nySH3ra/fqBh3HgUUQCbhLLPAB9YhvHGgxJpdzICzw2g9KzzCLsXqWaGCwb64K46CE9klOX
UIFoQJ82HeJmjzsMy9ULY5c1JwKPbn8AzbxSOrQi3ssGOiuZQ51zqFfXckXGy9GPQigT/IWk
5sqzgVFmD1znzEl9+YITBfBSALKUdHxfkXu+UvOx+CjkWow4eSk/0QiF9DCZejCCBXIwggRa
oAMCAQICBEOGqWgwDQYJKoZIhvcNAQEFBQAwMTELMAkGA1UEBhMCREsxDDAKBgNVBAoTA1RE
QzEUMBIGA1UEAxMLVERDIE9DRVMgQ0EwHhcNMDYwNzI2MTMyNTM1WhcNMDgwNzI2MTM1NTM1
WjB7MQswCQYDVQQGEwJESzEpMCcGA1UEChMgSW5nZW4gb3JnYW5pc2F0b3Jpc2sgdGlsa255
dG5pbmcxQTAaBgNVBAMTE1N0ZWVuIEV1Z2VuIFBvdWxzZW4wIwYDVQQFExxQSUQ6OTIwOC0y
MDAyLTItMzE3NjE3NjE4MTQ5MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDlv74PjpJr
PTPfGCsZVhVK+ihTc1gLzPApQLuuAwFkU1YlotH5E92uO6YAGBh0u7Nu89N/N5AdJV4v6Hsm
r8CZRAm6K/Nib3QsIByUi8VdgCcfD/MPheu8nne/YYQ6Edws3M1vBvY22NHW7HkddtjYNiD2
biGQ36eNoLbCTeMClwIDAQABo4ICyjCCAsYwDgYDVR0PAQH/BAQDAgP4MCsGA1UdEAQkMCKA
DzIwMDYwNzI2MTMyNTM1WoEPMjAwODA3MjYxMzU1MzVaMIIBNwYDVR0gBIIBLjCCASowggEm
BgoqgVCBKQEBAQEDMIIBFjAvBggrBgEFBQcCARYjaHR0cDovL3d3dy5jZXJ0aWZpa2F0LmRr
L3JlcG9zaXRvcnkwgeIGCCsGAQUFBwICMIHVMAoWA1REQzADAgEBGoHGRm9yIGFudmVuZGVs
c2UgYWYgY2VydGlmaWthdGV0IGfmbGRlciBPQ0VTIHZpbGvlciwgQ1BTIG9nIE9DRVMgQ1As
IGRlciBrYW4gaGVudGVzIGZyYSB3d3cuY2VydGlmaWthdC5kay9yZXBvc2l0b3J5LiBCZW3m
cmssIGF0IFREQyBlZnRlciB2aWxr5XJlbmUgaGFyIGV0IGJlZ3LmbnNldCBhbnN2YXIgaWZ0
LiBwcm9mZXNzaW9uZWxsZSBwYXJ0ZXIuMEEGCCsGAQUFBwEBBDUwMzAxBggrBgEFBQcwAYYl
aHR0cDovL29jc3AuY2VydGlmaWthdC5kay9vY3NwL3N0YXR1czAcBgNVHREEFTATgRFzZXBA
bGl4LXdvcmxkLm5ldDCBhAYDVR0fBH0wezBLoEmgR6RFMEMxCzAJBgNVBAYTAkRLMQwwCgYD
VQQKEwNUREMxFDASBgNVBAMTC1REQyBPQ0VTIENBMRAwDgYDVQQDEwdDUkwxNDAzMCygKqAo
hiZodHRwOi8vY3JsLm9jZXMuY2VydGlmaWthdC5kay9vY2VzLmNybDAfBgNVHSMEGDAWgBRg
tYXsVmR+EhknZx1QFUtzrjv5EjAdBgNVHQ4EFgQUGnA0kYplEvpmQTxbkQMwljvVXMcwCQYD
VR0TBAIwADAZBgkqhkiG9n0HQQAEDDAKGwRWNy4xAwIDqDANBgkqhkiG9w0BAQUFAAOCAQEA
T5wZtMDaWA31Y7uOj4Z1YXx70TbIreJe1IdVGmQCb0X5LCapVCRHtnP0LEOOPZlJWuR89jSR
z8Ojxi+bR/maVu2bIlP900p+S18TksLsR1k7eiEPDYta8/rz7s5EHwuG00Ts9AiO4nySH3ra
/fqBh3HgUUQCbhLLPAB9YhvHGgxJpdzICzw2g9KzzCLsXqWaGCwb64K46CE9klOXUIFoQJ82
HeJmjzsMy9ULY5c1JwKPbn8AzbxSOrQi3ssGOiuZQ51zqFfXckXGy9GPQigT/IWk5sqzgVFm
D1znzEl9+YITBfBSALKUdHxfkXu+UvOx+CjkWow4eSk/0QiF9DCZejGCAiowggImAgEBMDkw
MTELMAkGA1UEBhMCREsxDDAKBgNVBAoTA1REQzEUMBIGA1UEAxMLVERDIE9DRVMgQ0ECBEOG
qWgwCQYFKw4DAhoFAKCCAUcwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMDYxMTE3MjIyMDI2WjAjBgkqhkiG9w0BCQQxFgQUiubtELiUBC/oWOYkL1kxopKs
IqEwSAYJKwYBBAGCNxAEMTswOTAxMQswCQYDVQQGEwJESzEMMAoGA1UEChMDVERDMRQwEgYD
VQQDEwtUREMgT0NFUyBDQQIEQ4apaDBKBgsqhkiG9w0BCRACCzE7oDkwMTELMAkGA1UEBhMC
REsxDDAKBgNVBAoTA1REQzEUMBIGA1UEAxMLVERDIE9DRVMgQ0ECBEOGqWgwUgYJKoZIhvcN
AQkPMUUwQzAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcNAwICAUAwBwYF
Kw4DAgcwDQYIKoZIhvcNAwICASgwDQYJKoZIhvcNAQEBBQAEgYB34rhb3KMm2lv6mC6rTl5Y
6OcfzYluqFyuMfFI2XCHfOyE3OL6SkBmmgJZmghZSfxoc2gwGiAa7htOArkKVY7zLNaG6zac
GUYGRFe+iNrdhNSqmEJLSxmXOrGQ8d4y9wMeTe/x46v8kghu71GTdTY+3tbcNa88Vj7q6U/d
0zqVngAAAAAAAA==
--------------ms040900040104030200050608--


--===============0940522405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0940522405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0940522405==--
