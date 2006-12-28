Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4593962A.6070303@sit.fraunhofer.de>
Date: Thu, 28 Dec 2006 11:02:18 +0100
From: "Matthias Ritscher,  Fraunhofer-Institut SIT" <matthias.ritscher@sit.fraunhofer.de>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Encryption Key Length Negotiation & Link Key Type
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1265981615=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a cryptographically signed message in MIME format.

--===============1265981615==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms030603030903010602060206"

This is a cryptographically signed message in MIME format.

--------------ms030603030903010602060206
Content-Type: multipart/mixed; boundary="------------060708070409000400010908"

This is a multi-part message in MIME format.
--------------060708070409000400010908
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hi Bluez-List,

1)
I´m trying to get any information about the Encryption Key Negotiation 
Process of paired Bluetooth devices (Laptop with Bluez-stack and a 
Handheld Device). Using hcidump I could not receive any information 
about this exchange which corresponds to that negotiation. I sniffed 
communication exchange during pairing and communication transmission. 
Encryption at the host is enabled in the hcid.conf file and can be seen 
using "hcitool con".
I´m interested in the length of the negotiated Encryption key Kc. Is 
there any way to retrieve its length (or value) in the Bluez-stack ?

2)
The second issue I´m focussing in this request is the question: Is there 
is a possibility in the Bluez-stack to "simulate" devices with light 
memory or computing power ;-) ? This means, is there a possibility that 
the Bluez-stack will use a Local Unit Key as Link Key proposal. I´m 
interested, since the counterpart (Handheld Device) is supposed by 
specification to accept Combination Keys as Link Keys only, and I want 
to test it.

Thanks for your attention,
Matthias


--------------060708070409000400010908
Content-Type: text/x-vcard; charset=utf-8;
 name="matthias.ritscher.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="matthias.ritscher.vcf"

begin:vcard
fn:Matthias  Ritscher
n:Ritscher;Matthias 
org:Fraunhofer-Institut Sichere Informationstechnologie;Sichere mobile Systeme
adr;quoted-printable;dom:;;Rheinstra=C3=9Fe 75;Darmstadt;;64295
email;internet:matthias.ritscher@sit.fraunhofer.de
tel;work:+49 (0) 6151 / 869 - 313
tel;fax:+49 (0) 6151 / 869 - 224
url:http://www.sit.fraunhofer.de
version:2.1
end:vcard


--------------060708070409000400010908--

--------------ms030603030903010602060206
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIILdzCC
BbUwggSdoAMCAQICAg7kMA0GCSqGSIb3DQEBBQUAME8xCzAJBgNVBAYTAkRFMRMwEQYDVQQK
EwpGcmF1bmhvZmVyMSswKQYDVQQDEyJGcmF1bmhvZmVyLUdlc2VsbHNjaGFmdCBSb290LUNB
IHYyMB4XDTA1MDkyNjEzNDMxN1oXDTA5MTIzMTIzMDAwMFowXTELMAkGA1UEBhMCREUxEzAR
BgNVBAoTCkZyYXVuaG9mZXIxDDAKBgNVBAsTA1NJVDEPMA0GA1UECxMGUGVvcGxlMRowGAYD
VQQDExFNYXR0aGlhcyBSaXRzY2hlcjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
ALyygzJc7Lt07rs9sbZWQKCIcLFwxIVhT0HFk2kmXE9MT+91aFy8wfpHtCMn34BA+g8Vh4vU
8GDFhMExgolFgzK4UBm9wWi63FWHdsw8NehkUVgSiZFViNnObnZA+ycsX6beiWKpRiwfp667
k/ceNuD28YOen42M5wrrZGAaV/Z97wf4ZTQcAC8cLWu4n0C7jhHrkfTUB/zMMSmvoUHe7Spr
0jbh9SKvCGyOg51R5LWxODUxXyMuatao21H1VFF/KpNA3Jq1spy713w2bpzLoH76ANTOnPd4
0BqVHtA7b0k5JpaJXc1qukXd90FHqB8Gh9ALOyrVoX5qDdgu6HdZ7VcCAwEAAaOCAoswggKH
MIGfBglghkgBhvhCAQ0EgZEWgY5Tb2Z0d2FyZSBaZXJ0aWZpa2F0IGRlciBaZXJ0aWZpemll
cnVuZ2luc3RhbnogKENBKSBkZXIgRnJhdW5ob2Zlci1HZXNlbGxzY2hhZnQgZS5WLiwgTXVl
bmNoZW47IFd1cnplbHplcnRpZmlrYXQgdmlhIGh0dHBzOi8vcGtpLmZyYXVuaG9mZXIuZGUv
ME0GCCsGAQUFBwEBBEEwPzA9BggrBgEFBQcwAYYxaHR0cDovL3BraS5mcmF1bmhvZmVyLmRl
L0ZoRy1DQV92Ml9PQ1NQLVJlc3BvbmRlcjBIBgNVHR8EQTA/MD2gO6A5hjdodHRwOi8vcGtp
LmZyYXVuaG9mZXIuZGUvRmhHLUNBLUNlcnRzL0ZoRy1DQV92Ml9DUkwuY3JsMAwGA1UdEwEB
/wQCMAAwSgYDVR0SBEMwQYEkemVydGlmaXppZXJ1bmdzaW5zdGFuekBmcmF1bmhvZmVyLmRl
hhlodHRwOi8vcGtpLmZyYXVuaG9mZXIuZGUvMC4GA1UdEQQnMCWBI21hdHRoaWFzLnJpdHNj
aGVyQHNpdC5mcmF1bmhvZmVyLmRlMEwGA1UdIARFMEMwQQYLKwYBBAGGClACAQEwMjAwBggr
BgEFBQcCARYkaHR0cDovL3BraS5mcmF1bmhvZmVyLmRlL3BvbGljeS5odG1sMCIGA1UdJQEB
/wQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMEMA4GA1UdDwEB/wQEAwIEMDAdBgNVHQ4EFgQU
EXuz1847Khb8bCNE2/J7NNgOu7IwHwYDVR0jBBgwFoAUAMP872PCVigvUQt1Vv97BekcyfEw
DQYJKoZIhvcNAQEFBQADggEBAEgwQmXNSdVsqus/ITj7DnBmpoJXkvExoPw2Ipol2vUs1EDG
oJR9FSct1H6D+CkwxraWJev6yHhwy11qRjgOO2PBBcsPp8g7WWEUz8lM90SUR43iTUzwQZBf
wNwREjt8Db+XAVtN5XrQ0k05EykPHi8rfuGdI9b7Sf/ICVZE1QjvtGvLTgnqriGfSs3vcNwa
kRZN24eLosxyXM2qEt3eSuJ1IcFTJS+uxI6DM53Dqn+3hqP4MccJfiNXJKZV0aZtF7akRXqE
NKROXLgfGMCncOIBTUB/ZeI54dbdtZuQmCL9jhzz/ZWdk/XyaWWgvnWCndG/CMgLKnAddsf4
TfR8IDwwggW6MIIEoqADAgECAgIO4zANBgkqhkiG9w0BAQUFADBPMQswCQYDVQQGEwJERTET
MBEGA1UEChMKRnJhdW5ob2ZlcjErMCkGA1UEAxMiRnJhdW5ob2Zlci1HZXNlbGxzY2hhZnQg
Um9vdC1DQSB2MjAeFw0wNTA5MjYxMzQzMTZaFw0wOTEyMzEyMzAwMDBaMF0xCzAJBgNVBAYT
AkRFMRMwEQYDVQQKEwpGcmF1bmhvZmVyMQwwCgYDVQQLEwNTSVQxDzANBgNVBAsTBlBlb3Bs
ZTEaMBgGA1UEAxMRTWF0dGhpYXMgUml0c2NoZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQCUuZfxGDIw86q6XzbQUDd+2kacFpu3Oor/PWuXJ/ieH9j3KPCLtKsFRKn011mr
QZ2qw2lE2NzcwdORchQxTm9fDsZJlUr2EUmPDsWPxzH/CMrLnEoiGTSu6OQDvuJ6Hc3QSLKw
dZsMazP3pc/ET1O+9snlIv6Enno2fpkbYXPodcP7hWMwk6d5IAw8yRGGE5ZfE6DMi9Ouk83q
+k9u+5u1ejP9liKmf7EQO5vdnRBfdLBY0/8WvgeTIBZM2SeUgFuFkqBoAJ2Zdy3XpE5Oeslb
2iBcfZuBFeOSIgberR+B4ej5WW44xeGXtrhuVDPWzOFZVBvqOBETtbgtkBcnFqwtAgMBAAGj
ggKQMIICjDCBnwYJYIZIAYb4QgENBIGRFoGOU29mdHdhcmUgWmVydGlmaWthdCBkZXIgWmVy
dGlmaXppZXJ1bmdpbnN0YW56IChDQSkgZGVyIEZyYXVuaG9mZXItR2VzZWxsc2NoYWZ0IGUu
Vi4sIE11ZW5jaGVuOyBXdXJ6ZWx6ZXJ0aWZpa2F0IHZpYSBodHRwczovL3BraS5mcmF1bmhv
ZmVyLmRlLzBNBggrBgEFBQcBAQRBMD8wPQYIKwYBBQUHMAGGMWh0dHA6Ly9wa2kuZnJhdW5o
b2Zlci5kZS9GaEctQ0FfdjJfT0NTUC1SZXNwb25kZXIwSAYDVR0fBEEwPzA9oDugOYY3aHR0
cDovL3BraS5mcmF1bmhvZmVyLmRlL0ZoRy1DQS1DZXJ0cy9GaEctQ0FfdjJfQ1JMLmNybDAM
BgNVHRMBAf8EAjAAMEoGA1UdEgRDMEGBJHplcnRpZml6aWVydW5nc2luc3RhbnpAZnJhdW5o
b2Zlci5kZYYZaHR0cDovL3BraS5mcmF1bmhvZmVyLmRlLzAuBgNVHREEJzAlgSNtYXR0aGlh
cy5yaXRzY2hlckBzaXQuZnJhdW5ob2Zlci5kZTBMBgNVHSAERTBDMEEGCysGAQQBhgpQAgEB
MDIwMAYIKwYBBQUHAgEWJGh0dHA6Ly9wa2kuZnJhdW5ob2Zlci5kZS9wb2xpY3kuaHRtbDAn
BgNVHSUEIDAeBggrBgEFBQcDAgYIKwYBBQUHAwMGCCsGAQUFBwMEMA4GA1UdDwEB/wQEAwIG
wDAdBgNVHQ4EFgQUWqO3wi9lVtnjHcHCBgGEEpowd7owHwYDVR0jBBgwFoAUAMP872PCVigv
UQt1Vv97BekcyfEwDQYJKoZIhvcNAQEFBQADggEBAM4AgPzs+dBTMUHAhU2tbVadQByQ/IQh
9L1rtHcemPMrTm35A37CBIdCesQ2NAF8w1n6yMDG/ot3N21rWNVCepAfPwjL7yU3+dIrIYMu
g08bFHmEm4dkhpW24gT9v2yok64lHBSxZsvk5Qruam76kEunkhGq0ou8rDc4SyIXVUhEuy7Z
kQrjhAyUHRZ4hkflJ+sjejT7DW85t/0fn1XXp5wnoJqVSD6jhkfufCm8s+7qcZL8sHNYNF09
7EI6OIrW5WsxTe0MuWlZZaduuW1sxRq1OBDDyNJiUnY+pAtfjZNHqnJt6kReDwo3zJuQif/1
W91WAK3ri9DOqDOx/azCU4sxggL/MIIC+wIBATBVME8xCzAJBgNVBAYTAkRFMRMwEQYDVQQK
EwpGcmF1bmhvZmVyMSswKQYDVQQDEyJGcmF1bmhvZmVyLUdlc2VsbHNjaGFmdCBSb290LUNB
IHYyAgIO4zAJBgUrDgMCGgUAoIIBfzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0wNjEyMjgxMDAyMThaMCMGCSqGSIb3DQEJBDEWBBRjv4XEbyjZJ+87VMXq
m/rwqC18AjBSBgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAN
BggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDBkBgkrBgEEAYI3EAQxVzBV
ME8xCzAJBgNVBAYTAkRFMRMwEQYDVQQKEwpGcmF1bmhvZmVyMSswKQYDVQQDEyJGcmF1bmhv
ZmVyLUdlc2VsbHNjaGFmdCBSb290LUNBIHYyAgIO5DBmBgsqhkiG9w0BCRACCzFXoFUwTzEL
MAkGA1UEBhMCREUxEzARBgNVBAoTCkZyYXVuaG9mZXIxKzApBgNVBAMTIkZyYXVuaG9mZXIt
R2VzZWxsc2NoYWZ0IFJvb3QtQ0EgdjICAg7kMA0GCSqGSIb3DQEBAQUABIIBAIrkuAva/KTv
d0d0GW+wAgeppkJ7sMQ1d/ylJHFtxu4z2IJEMhR7seE1fEu7EXW5ALsP5aL/pN0GC/2ldIqO
/2qoj2ThqwTNtlPULZwY4UfUsY77pF7/2vAdMA3ZCSCrJShAqLMe8nuuFJHbFeOS90IGZA9P
qMTkEAsKlA+hgcdYw6IBZZdbnpZ7dl31izY/maKUFIlHPvSeC3X+6JxxTEOb1ehn9nMSEYWE
kdAM+YkU4NCJRWLkE6REVEmWwEnaDGoPaka/GWnS4QXxq58Mg/MkEZZY6VS1UGN5wJURMDGG
KIzcmlwi1ll1ucvQSSnvUcRyr4fi1t3vFLp/esYVZ8cAAAAAAAA=
--------------ms030603030903010602060206--


--===============1265981615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1265981615==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1265981615==--
