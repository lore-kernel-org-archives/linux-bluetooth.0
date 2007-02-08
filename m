Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45CB106D.3040302@sawicz.net>
Date: Thu, 08 Feb 2007 12:58:37 +0100
From: =?UTF-8?B?TWljaGHFgiBTYXdpY3o=?= <michal@sawicz.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <371315.31993.qm@web58112.mail.re3.yahoo.com>
In-Reply-To: <371315.31993.qm@web58112.mail.re3.yahoo.com>
Subject: Re: [Bluez-devel] serial port problem
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0834517230=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a cryptographically signed message in MIME format.

--===============0834517230==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms000302080800000804040406"

This is a cryptographically signed message in MIME format.

--------------ms000302080800000804040406
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Raja Kedarisetti wrote:
> Hi,
>       I have a IBM thinkpad T41 and im using linux kernel 2.6.20=20
> when i tried configuring ttyS1 as my irda port, Im facing some problem.=

>=20
> I followed the following steps:
> step 1: In bios i enabled the irda port.
> step 2: I gave the command "setserial /dev/ttyS1"
>       /dev/ttyS1, UART: undefined, Port: 0x02f8, IRQ: 3
> step 3: and finally i gave the command "iratach /dev/ttyS1 -s"
>=20
> but my ir port is not working.
> then i  saw the kernel messages using the command dmesg, its showing th=
e
> message
>  "ttyS1: LSR safety check engaged! "
> =20
> Im not sure how to proceed. Any suggestions would help me.
> Hope fully get some replies.

And how does it belong here? It's a bluetooth utils development list...

--=20
Pozdrawiam,
Micha=C5=82 Sawicz


--------------ms000302080800000804040406
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
IEZSRUUgaGVhZCBvdmVyIHRvIGh0dHA6Ly93d3cuQ0FjZXJ0Lm9yZzAyBggrBgEFBQcBAQQm
MCQwIgYIKwYBBQUHMAGGFmh0dHA6Ly9vY3NwLmNhY2VydC5vcmcwHAYDVR0RBBUwE4ERbWlj
aGFsQHNhd2ljei5uZXQwDQYJKoZIhvcNAQEFBQADggIBACRHvL4ShgoCZE+Mr7TSeMhpwsHw
o4/2E2FuMaet7inaNWhwzcluCkq3FrLgzrsOnz2p5iyUU1B4ZQr32zvpHBNvKawEZbNMGC8w
6FyZ6Il7g+K95bB8M2a3mQzkv6KgwnFpKztPd8moelW0wtGqGDeZVmkEmRNbOagpsUbq20cC
DqNMCRj44f7aVM5ro2SXuyEgQZ4jFC6UkErHuaShDFnUbLH6Ue53h4Ki2P4v21VZicMyUBDF
Sb3mx9b8vhBy4tD+BU9lBQIRYrvZFVgRBrzpAQTwgerxf+Fs5mTxWNEhmKqUbHBuCi6pghZn
sze7PGFIopyQkAmRZng760qcNuzL1l33UqvYVSTiF7lo+AATmw4hyglwMLS/8Y0ZDq5OabyA
OATQZA9vH5Adtu8tvpM+aZsjmZfSxPSvbD2O/vvgaq8fAQ4JJmsu8SZCyN93ckvFyUt9D4GQ
hCGzIBAFLeTA3pQKnsFNHsRpJSwpAc2BldaeFcpP0Kmqpy075px4X3sIhu8jy7z1UXwpEwBv
HQr8gfzF0j6pES3r24KyAJtxC+hMOafl6rRmElp0pmZZZdQBpMjFuMXBos8/qJ2tHobS/r1J
848Gr4vyKxgpD9S7CbV0HpQyog0Y1v6dSaJGJSCz1dJi5tOkpb1hykKf+aK6ykSXH3yai0z5
csTJ0jaNMIIGCDCCA/CgAwIBAgIBATANBgkqhkiG9w0BAQQFADB5MRAwDgYDVQQKEwdSb290
IENBMR4wHAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQg
U2lnbmluZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAe
Fw0wNTEwMTQwNzM2NTVaFw0zMzAzMjgwNzM2NTVaMFQxFDASBgNVBAoTC0NBY2VydCBJbmMu
MR4wHAYDVQQLExVodHRwOi8vd3d3LkNBY2VydC5vcmcxHDAaBgNVBAMTE0NBY2VydCBDbGFz
cyAzIFJvb3QwggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCrSTURSHzSJn5TlM9D
qd0o10Iqi/OHeBlYfA+e2ol94fvrcpANdKGWZKufoCSZc9riVXbHF3v1BKxGuMO+f2SNEGwk
82GcwPKQ+lHm9WkBY8MPVuJKQs/iRIwlKKjFeQl9RrmK8+nzNCkIReQcn8uUBByBqBSzmGXE
Q+xOgo0J0b2qW42S0OzekMV/CsLj6+YxWl50PpczWejDAz1gM7/30W9HxM3uYoNSbi4ImqTZ
FRiRpoWSR7CuSOtttyHshRpocjWr//AQXcD0lKdq1TuSfkyQBX6TwSyLpI5idBVxbgtxA+qv
FTia1NIFcm+M+SvrWnIl+TlG43IbPgTDZCciECqKT1inA62+tC4T7V2qSNfVfdQqe1z6RgRQ
5MwOQluM7dvyz/yWk+DbETZUYjQ4jwxgmzuXVjit89Jbi6Bb6k6WuHzX1aCGcEDTkSm3ojyt
9Yy7zxqSiuQ0e8DYbF/pCsLDpyCaWt8sXVJcukfVm+8kKHA4IC/VfynAskEDaJLM4JzMl0tF
7zoQCqtwOpiVcK01seqFK6QcgCExqa5geoAmSAC4AcCTY1UikTxW56/bOiXzjzFU6iaLgVn5
odFTEcV7nQP2dBHgbbEsPyyGkZlxmqZ3izRg0RS0LKydr4wQ05/EavhvE/xzWfdmQnQeiuP4
3NJvmJzLR5iVQAX76QIDAQABo4G/MIG8MA8GA1UdEwEB/wQFMAMBAf8wXQYIKwYBBQUHAQEE
UTBPMCMGCCsGAQUFBzABhhdodHRwOi8vb2NzcC5DQWNlcnQub3JnLzAoBggrBgEFBQcwAoYc
aHR0cDovL3d3dy5DQWNlcnQub3JnL2NhLmNydDBKBgNVHSAEQzBBMD8GCCsGAQQBgZBKMDMw
MQYIKwYBBQUHAgEWJWh0dHA6Ly93d3cuQ0FjZXJ0Lm9yZy9pbmRleC5waHA/aWQ9MTAwDQYJ
KoZIhvcNAQEEBQADggIBAH8IiKHaGlBJ2on7oQhy84r3HsQ6tHlbIDCxRd7CXdNlafHCXVRU
PIVfuXtCkcKZ/RtRm6tGpaEQU55tiKxzbiwzpvD0nuB1wT6IRanhZkP+VlrRekF490DaSjrx
C1uluxYG5sLnk7mFTZdPsR44Q4Dvmw2M77inYACHV30eRBzLI++bPJmdr7UpHEV5FpZNJ23x
HGzDwlVks7wU4vOkHx4y/CcVBc/dLq4+gmF78CEQGPZE6lM5+dzQmiDgxrvgu1pPxJnIB721
vaLbLmINQjRBvP+LivVRIqqIMADisNS8vmW61QNXeZvo3MhN+FDtkaVSKKKs+zZYPumUK5FQ
hxvWXtaMzPcPEAxSTtAWYeXlCmy/F8dyRlecmPVsYGN6b165Ti/Iubm7aoW8mA3t+T6XhDSU
rgCvoeXnkm5OvfPi2RSLXNLrAWygF6UtEOucekq9ve7O/e0iQKtwOIj1CodqwqsFYMlIBdpT
wd5Ed2qz8zw87YC8pjhKKSRf/lk7myV6VmMAZLldpGJ9VzZPrYPvH5JToI53V93lYRE9IwCQ
TDz6o2CTBKOvNfYOao9PSmCnhQVsRqGP9Md246FZV/dxssRuFFxtbUFm3xuTsdQAw+7Lzzw9
IYCpX2Nl/N3gX6T0K/CFcUHUZyX7GrGXrtaZghNB0m6lG5kngOcLqagAMYIDDjCCAwoCAQEw
WjBUMRQwEgYDVQQKEwtDQWNlcnQgSW5jLjEeMBwGA1UECxMVaHR0cDovL3d3dy5DQWNlcnQu
b3JnMRwwGgYDVQQDExNDQWNlcnQgQ2xhc3MgMyBSb290AgIdWzAJBgUrDgMCGgUAoIIBiTAY
BgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNzAyMDgxMTU4Mzda
MCMGCSqGSIb3DQEJBDEWBBSvkeM3QiUgB4aKaEl9+INbD8B8DTBSBgkqhkiG9w0BCQ8xRTBD
MAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMCBzAN
BggqhkiG9w0DAgIBKDBpBgkrBgEEAYI3EAQxXDBaMFQxFDASBgNVBAoTC0NBY2VydCBJbmMu
MR4wHAYDVQQLExVodHRwOi8vd3d3LkNBY2VydC5vcmcxHDAaBgNVBAMTE0NBY2VydCBDbGFz
cyAzIFJvb3QCAh1bMGsGCyqGSIb3DQEJEAILMVygWjBUMRQwEgYDVQQKEwtDQWNlcnQgSW5j
LjEeMBwGA1UECxMVaHR0cDovL3d3dy5DQWNlcnQub3JnMRwwGgYDVQQDExNDQWNlcnQgQ2xh
c3MgMyBSb290AgIdWzANBgkqhkiG9w0BAQEFAASCAQCROBOIITeIaGTRf/wE2g0ZT91l3VN1
vNmOjyiyANfvzM7KdsaXOUNc+p+nGOtWrLqqUvN7LYeDdKFA7/veWXpm/EhSZ+UYe15bFC3A
vkQICgJ/O7JX6oB9vvUl6zK9tYvic11q7C5SaTb4MMHsZq/C1rXscIqPmx7SFx2OausmUirK
OFEtiYihK+4lI4JPgTzaMe8b1OM0jpsYUilgohDbO+641mYEYxGSZ5A2D7phEmBmMYq41J85
WRYDwUBqXJ9IeVE0HZbegCJYno4lh00NaEGuKXMfTh2T3GNWUBUGGHgtpYQuK00i3/IB4o7R
pESTVcrqTDY2p5fuVtONkHO5AAAAAAAA
--------------ms000302080800000804040406--


--===============0834517230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0834517230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0834517230==--
