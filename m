Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Mime-Version: 1.0
Message-ID: <20040122T124812Z_5232000B0001@future-gate.com>
From: "Ronny Bremer" <rbremer@future-gate.com>
To: bluez-devel@lists.sourceforge.net
Content-type: multipart/signed; boundary="__MailScanner_found_Cyrus_boundary_substring_problem__"; micalg="sha1"; protocol="application/x-pkcs7-signature"
Subject: [Bluez-devel] WindowsCE and DUND
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 22 Jan 2004 12:48:12 +0100

--__MailScanner_found_Cyrus_boundary_substring_problem__
Content-Type: multipart/alternative; boundary="____LPHMXLZMXOMRLFKSEJCW____"

--____LPHMXLZMXOMRLFKSEJCW____
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

Hi folks,

I am using RedHat Fedora Core 1 with the latest updates. I remember from ea=
rlier on, that in order to provide connectivity to a WindowsCE device I nee=
d to run
dund --listen --msdun call synce-device

which will register with SDP automatically.

2 questions

1) I created a section in /etc/bluetooth/rfcommd.conf called rfcomm1, point=
ing to channel 1. If I then use
dund --listen --msdun -P rfcomm1 call synce-device
will it always listen on channel 1 so once configured devices are connectin=
g to the right channel?

2) In order to sync you need to create an ActiveSync session. This is searc=
hing for SP (serial port) service on the linux host, but dund registers LAN=
 service only. Is there any option to have dund register both LAN and SP? O=
r am I mistaken? And why does calling
sdptool add SP
works afterwards, how does it route the request for the SP to dund?

Sorry, but I haven't found the right answers to that one.

Ronny

--____LPHMXLZMXOMRLFKSEJCW____
Content-Type: multipart/related; boundary="____WHPEPQYSAQXEHDGESJXG____"

--____WHPEPQYSAQXEHDGESJXG____
Content-Type: text/html; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable


Hi folks,<br><br>I am using RedHat Fedora Core 1 with the latest updates. I=
 remember from earlier on, that in order to provide connectivity to a Windo=
wsCE device I need to run<br>dund --listen --msdun call synce-device<br><br=
>which will register with SDP automatically.<br><br>2 questions<br><br>1) I=
 created a section in /etc/bluetooth/rfcommd.conf called rfcomm1, pointing =
to channel 1. If I then use<br>dund --listen --msdun -P rfcomm1 call synce-=
device<br>will it always listen on channel 1 so once configured devices are=
 connecting to the right channel?<br><br>2) In order to sync you need to cr=
eate an ActiveSync session. This is searching for SP (serial port) service =
on the linux host, but dund registers LAN service only. Is there any option=
 to have dund register both LAN and SP? Or am I mistaken? And why does call=
ing<br>sdptool add SP<br>works afterwards, how does it route the request fo=
r the SP to dund?<br><br>Sorry, but I haven't found the right answers to th=
at one.<br><br>Ronny<br>

--____WHPEPQYSAQXEHDGESJXG____--

--____LPHMXLZMXOMRLFKSEJCW____--

--__MailScanner_found_Cyrus_boundary_substring_problem__
Content-Type: application/x-pkcs7-signature; name=smime.p7s
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=smime.p7s
Content-Description: S/MIME Cryptographic Signature

MIIKjQYJKoZIhvcNAQcCoIIKfjCCCnoCAQExCzAJBgUrDgMCGgUAMAsGCSqG
SIb3DQEHAaCCB4UwggNcMIICxaADAgECAgID6zANBgkqhkiG9w0BAQQFADCB
vDELMAkGA1UEBhMCREUxEDAOBgNVBAgTB0hhbWJ1cmcxEDAOBgNVBAcTB0hh
bWJ1cmcxOjA4BgNVBAoTMVRDIFRydXN0Q2VudGVyIGZvciBTZWN1cml0eSBp
biBEYXRhIE5ldHdvcmtzIEdtYkgxIjAgBgNVBAsTGVRDIFRydXN0Q2VudGVy
IENsYXNzIDMgQ0ExKTAnBgkqhkiG9w0BCQEWGmNlcnRpZmljYXRlQHRydXN0
Y2VudGVyLmRlMB4XDTk4MDMwOTExNTk1OVoXDTExMDEwMTExNTk1OVowgbwx
CzAJBgNVBAYTAkRFMRAwDgYDVQQIEwdIYW1idXJnMRAwDgYDVQQHEwdIYW1i
dXJnMTowOAYDVQQKEzFUQyBUcnVzdENlbnRlciBmb3IgU2VjdXJpdHkgaW4g
RGF0YSBOZXR3b3JrcyBHbWJIMSIwIAYDVQQLExlUQyBUcnVzdENlbnRlciBD
bGFzcyAzIENBMSkwJwYJKoZIhvcNAQkBFhpjZXJ0aWZpY2F0ZUB0cnVzdGNl
bnRlci5kZTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAtrTBNQUuDY3s
oEBqHA4nplCSa1AbB94u53bM4Nr8hKhejGNqK03ZTgJ2EcEL8o15ygC28bAO
1/ukFz2vq2l6lie/rzOhmipZqsS1NwjyEqUxtkP1MpZxKCirjSiG37vu4wx9
MNbDUquPXSeca8Cj5wVrV0lEs27qZM/SjnpQd3cCAwEAAaNrMGkwDwYDVR0T
AQH/BAUwAwEB/zAOBgNVHQ8BAf8EBAMCAYYwMwYJYIZIAYb4QgEIBCYWJGh0
dHA6Ly93d3cudHJ1c3RjZW50ZXIuZGUvZ3VpZGVsaW5lczARBglghkgBhvhC
AQEEBAMCAAcwDQYJKoZIhvcNAQEEBQADgYEAFj3GzcG7hXGFRp8+II9RKJns
LUUhYyNbBLtMkLiIkgRNvX0Boz/27M7x3v595eE+u8arXgvdPZbEy6nU+Sbm
Bk6eDKV6um7DfIIZ0cexscPbDY6bQHw3C/Fd6P0fkIilDk43ZCGoTo20n/He
SK3VVhhSKYtHNBIJ1LuSNe8P2zQwggQhMIIDiqADAgECAg8Aq6QAAAAC19/D
uzv7yTwwDQYJKoZIhvcNAQEFBQAwgbwxCzAJBgNVBAYTAkRFMRAwDgYDVQQI
EwdIYW1idXJnMRAwDgYDVQQHEwdIYW1idXJnMTowOAYDVQQKEzFUQyBUcnVz
dENlbnRlciBmb3IgU2VjdXJpdHkgaW4gRGF0YSBOZXR3b3JrcyBHbWJIMSIw
IAYDVQQLExlUQyBUcnVzdENlbnRlciBDbGFzcyAzIENBMSkwJwYJKoZIhvcN
AQkBFhpjZXJ0aWZpY2F0ZUB0cnVzdGNlbnRlci5kZTAeFw0wMzEwMjgwODIy
MjhaFw0wNDEwMjgwODIyMjhaMIGUMQswCQYDVQQGEwJERTEbMBkGA1UECBMS
U2NobGVzd2lnLUhvbHN0ZWluMRMwEQYDVQQHEwpEYXNzZW5kb3JmMRQwEgYD
VQQKEwtmdXR1cmUgZ2F0ZTEVMBMGA1UEAxMMUm9ubnkgQnJlbWVyMSYwJAYJ
KoZIhvcNAQkBFhdyYnJlbWVyQGZ1dHVyZS1nYXRlLmNvbTCCASIwDQYJKoZI
hvcNAQEBBQADggEPADCCAQoCggEBALCN7puqvZHCUlhsZ3gGdfAghu5r814Q
MD0w4Irv+2JWfHjlS7LK8A2Bm5Ath9vPbRMKnQkI1a673T64MvyH3R2j/1nj
sAgTmq7pzXPdpTeUl8NxfYpVcWVfuTxOsbt9l66evvIfxv839Obg/AoaYb60
dghzeqbTJyaoewfF2FUdYP+JlYUPM/TnRbNuizKcKFhXRVKbZbQPDFJJZT7W
mMFO4XJPRBoDNqDPjZgqaQAZXHWIX2XTO3XqZIQZsCUcOwal7aEjDyczilrc
2VN625yDkhv83MngxNdk7dx1TcL2QXyhJITj+BGLrXCNSMYIAuMFXGCp0129
AmIHY4ZhNA0CAwEAAaOBxjCBwzAMBgNVHRMBAf8EAjAAMA4GA1UdDwEB/wQE
AwIF4DA+BglghkgBhvhCAQgEMRYvaHR0cDovL3d3dy50cnVzdGNlbnRlci5k
ZS9ndWlkZWxpbmVzL2luZGV4Lmh0bWwwEQYJYIZIAYb4QgEBBAQDAgWgMFAG
CWCGSAGG+EIBAwRDFkFodHRwczovL25ydS50Y2NsYXNzMy50cnVzdGNlbnRl
ci5kZS9BQkE0MDAwMDAwMDJEN0RGQzNCQjNCRkJDOTNDPzANBgkqhkiG9w0B
AQUFAAOBgQAafqBXpFVMmhkIerC6sFYRHvIfT3tTGdDeWvheKpxBC6QYlK2m
xnELxZk+DTZSMo8Av1UYk0OjOxxCt88vmDO2hm4DqFaq/vlZoIseXKSlvBUM
l13cDixswZj0f+RwbjV0VRSpqOfvcdeJqDjFp+ZVG/0qSPpLiHufyKA27bjq
eTGCAtAwggLMAgEBMIHQMIG8MQswCQYDVQQGEwJERTEQMA4GA1UECBMHSGFt
YnVyZzEQMA4GA1UEBxMHSGFtYnVyZzE6MDgGA1UEChMxVEMgVHJ1c3RDZW50
ZXIgZm9yIFNlY3VyaXR5IGluIERhdGEgTmV0d29ya3MgR21iSDEiMCAGA1UE
CxMZVEMgVHJ1c3RDZW50ZXIgQ2xhc3MgMyBDQTEpMCcGCSqGSIb3DQEJARYa
Y2VydGlmaWNhdGVAdHJ1c3RjZW50ZXIuZGUCDwCrpAAAAALX38O7O/vJPDAJ
BgUrDgMCGgUAoIHVMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZI
hvcNAQkFMQ8XDTA0MDEyMjEyNDgxMVowIwYJKoZIhvcNAQkEMRYEFG3VEO28
LvKSkK3cptGS+fOAxS5bMHYGCSqGSIb3DQEJDzFpMGcwCgYIKoZIhvcNAwQw
CgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgE4MA0GCCqGSIb3DQMCAgEoMAcGBSsOAwIa
MA0GCSqGSIb3DQEBAQUABIIBABw6plG88HIxQrJPpwJTzDNvAJ10PO86g5ng
KhIsA3W9ihmAAguNzCfc5GdK03NJQIN9i7xa24eafJHeoU0g1NApmM8L5pYW
1DPZnuhD1lLudgQRivdnAFhovXI/8atAsbtfAPQDURqvhhskofsLstpgIiG1
P20K1KjHb71j+9BnQ4V6yQmxoNq78ju5OMbQIVkw5i/2PqjUpqTty6+YkykZ
W9iy8AmBpybll+amKL6BXPXKWruCypsnVAPQJbVxZmLh6KG4vhAvEsV0CWkW
R4f6IOn9RDfstfrDomUpjT97BMUDZWOIPs01+02vjrwxrYUF+oAGc+1doXYg
/9Ifkhw=

--__MailScanner_found_Cyrus_boundary_substring_problem__--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
