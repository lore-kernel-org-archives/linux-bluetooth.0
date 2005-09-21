Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <43318946.1000506@chello.at>
From: Roland Lezuo <roland.lezuo@chello.at>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature"; micalg=sha1; boundary="------------ms030306070106050008000402"
Subject: [Bluez-users] No audio, just noise with btsco
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 21 Sep 2005 18:24:38 +0200

This is a cryptographically signed message in MIME format.

--------------ms030306070106050008000402
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have the following BT headset:

Requesting information ...
         BD Address:  00:09:DD:30:65:2B
         Device Name: BT Headset
         LMP Version: 1.1 (0x1) LMP Subversion: 0x434
         Manufacturer: Cambridge Silicon Radio (10)
         Features: 0xfc 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
                 <encryption> <slot offset> <timing accuracy> <role switch>
                 <hold mode> <sniff mode> <park state> <RSSI> <channel 
quality>
                 <SCO link> <HV2 packets> <HV3 packets> <u-law log> 
<A-law log>
                 <CVSD> <paging scheme> <power control> <transparent SCO>


I managed to compile snd-bt-sco.ko and btsco

./btsco -v 00:09:DD:30:65:2B
btsco v0.4c
Device is 1:0
Voice setting: 0x0060
RFCOMM channel 1 connected
^^
when playing something with aplay -D plughw:Headset sound.wav btsco says

speaker volume: 12 mic volume: 1
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd
recieved AT+VGS=12
Sending up speaker change 12
^^
I hear increased noise but no sound. When aborting btsco says:

speaker volume: 12 mic volume: 1
driver is not in use
disconnected SCO channel
^^

from dmesg I get:
snd-bt-sco: playback_open
snd-bt-sco: prepare ok bps: 16000 size: 8000 count: 2000
snd-bt-sco: playback_trigger 1
snd-bt-sco: setting playback to bspcm
snd-bt-sco: playback_trigger 0
snd-bt-sco: setting playback to NULL
snd-bt-sco: Disposing of previous socket count 3
snd-bt-sco: file_count is 2 (expected 3)
^^

I found a posting on bluez-users pointing to 
http://sourceforge.net/mailarchive/message.php?msg_id=11431438
(http://sourceforge.net/mailarchive/message.php?msg_id=11487825)
but this did not work for me. Anyone having any hints?

regards
roland lezuo

--------------ms030306070106050008000402
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJ8jCC
BPUwggLdoAMCAQICAwExfTANBgkqhkiG9w0BAQQFADB5MRAwDgYDVQQKEwdSb290IENBMR4w
HAYDVQQLExVodHRwOi8vd3d3LmNhY2VydC5vcmcxIjAgBgNVBAMTGUNBIENlcnQgU2lnbmlu
ZyBBdXRob3JpdHkxITAfBgkqhkiG9w0BCQEWEnN1cHBvcnRAY2FjZXJ0Lm9yZzAeFw0wNTA2
MDcxNDM5MDBaFw0wNjA2MDcxNDM5MDBaMD4xFTATBgNVBAMTDFJvbGFuZCBMZXp1bzElMCMG
CSqGSIb3DQEJARYWcm9sYW5kLmxlenVvQGNoZWxsby5hdDCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAN2RdNhh9+90Q7jN4xuyvuez0IkANH1ay5DFiY9b22EyakUCmfecBQcC
R5oWtgMt1TUtcyE1JE32NjzbBVqUik/Fm3H1/jX3RiAvqfosr4JRXa/VgznOubt0EjiBBSP5
X6+tm/eJJBHK3wjzJVXmi4UGXFKNdzbdFDzKSsBssoquV1y3uGLujijKets5Wul105yrMwtE
1eCb5ukRBzInUMz0AqSMGMq0U4wbZoUe3mqOaV1m2irYc0BY+BwbZhvZoK2btZfhrWBklE8G
w8OplZFvMNPVOqT8j+XYLw8LexXPkwS3OQYww3h/uP2jYX+xRNBDsdv25lq4tNV2yGUmOM0C
AwEAAaOBwDCBvTAMBgNVHRMBAf8EAjAAMFYGCWCGSAGG+EIBDQRJFkdUbyBnZXQgeW91ciBv
d24gY2VydGlmaWNhdGUgZm9yIEZSRUUgaGVhZCBvdmVyIHRvIGh0dHA6Ly93d3cuQ0FjZXJ0
Lm9yZzAyBggrBgEFBQcBAQQmMCQwIgYIKwYBBQUHMAGGFmh0dHA6Ly9vY3NwLmNhY2VydC5v
cmcwIQYDVR0RBBowGIEWcm9sYW5kLmxlenVvQGNoZWxsby5hdDANBgkqhkiG9w0BAQQFAAOC
AgEAjlV3+5FM1Oy0xS5q/JTv7Zm1JQ45C+zEoi7jZH4YrySJ7Jzm48TaIlHPDug+uSBlSnQT
4/5EHGpEjXSDVTwS+xQalIYop9fwY7THVD17E/fSgay/SZ2tGWrmY9HtK3bZRpI/1hUrSCTU
XACVuuHGAmyut2a16alqUXGb46GTEQ3RQwgkIbW7kS7TQGjuoPg0QB53U4XySIQdMlsrGZ10
P8WAXj4G9EgzaP9M5x2cinnZxJx/H0GiWvyq9TXyMU//KTXgz6ZgfcchQpq2glncCzO5wA+Q
QeB7wqJkl53vvmCw4BRH4CgQD1oNGvKWB8LdkLpEKAyQzjXFRd3+0Qv11agkpPf4Mp97JD+R
nAeuKVhY/A9yyde+PttJXKu8coC1v1cA2jgMAwK9UmOlNEbrO1S0WxtVzUZSeuavEa0LTF5b
uBpOJIz22CJym5OUNGcowXc7Uj27DVVf5dT1VNqxuThlemLZj980dP1BWG3W+TRVRyWxu/nf
JlAgN9tds+TpPLTQmkMVIBtS0PzfNz6O448sGCsNWR9nt5xM3KMCyRr6l06lfbdPF3F3uyc0
RX7ULtfGcx21p9NNJeMObFe3zrMrYKwyw8ljLeEwK0RvshXfCIWiS5P63E7hkv4BY0YYYywe
of1mhIvF65UJW8E4CcE2Ol0chzpxAY+4vyPLxuIwggT1MIIC3aADAgECAgMBMX0wDQYJKoZI
hvcNAQEEBQAweTEQMA4GA1UEChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0cDovL3d3dy5jYWNl
cnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5MSEwHwYJKoZIhvcN
AQkBFhJzdXBwb3J0QGNhY2VydC5vcmcwHhcNMDUwNjA3MTQzOTAwWhcNMDYwNjA3MTQzOTAw
WjA+MRUwEwYDVQQDEwxSb2xhbmQgTGV6dW8xJTAjBgkqhkiG9w0BCQEWFnJvbGFuZC5sZXp1
b0BjaGVsbG8uYXQwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDdkXTYYffvdEO4
zeMbsr7ns9CJADR9WsuQxYmPW9thMmpFApn3nAUHAkeaFrYDLdU1LXMhNSRN9jY82wValIpP
xZtx9f4190YgL6n6LK+CUV2v1YM5zrm7dBI4gQUj+V+vrZv3iSQRyt8I8yVV5ouFBlxSjXc2
3RQ8ykrAbLKKrldct7hi7o4oynrbOVrpddOcqzMLRNXgm+bpEQcyJ1DM9AKkjBjKtFOMG2aF
Ht5qjmldZtoq2HNAWPgcG2Yb2aCtm7WX4a1gZJRPBsPDqZWRbzDT1Tqk/I/l2C8PC3sVz5ME
tzkGMMN4f7j9o2F/sUTQQ7Hb9uZauLTVdshlJjjNAgMBAAGjgcAwgb0wDAYDVR0TAQH/BAIw
ADBWBglghkgBhvhCAQ0ESRZHVG8gZ2V0IHlvdXIgb3duIGNlcnRpZmljYXRlIGZvciBGUkVF
IGhlYWQgb3ZlciB0byBodHRwOi8vd3d3LkNBY2VydC5vcmcwMgYIKwYBBQUHAQEEJjAkMCIG
CCsGAQUFBzABhhZodHRwOi8vb2NzcC5jYWNlcnQub3JnMCEGA1UdEQQaMBiBFnJvbGFuZC5s
ZXp1b0BjaGVsbG8uYXQwDQYJKoZIhvcNAQEEBQADggIBAI5Vd/uRTNTstMUuavyU7+2ZtSUO
OQvsxKIu42R+GK8kieyc5uPE2iJRzw7oPrkgZUp0E+P+RBxqRI10g1U8EvsUGpSGKKfX8GO0
x1Q9exP30oGsv0mdrRlq5mPR7St22UaSP9YVK0gk1FwAlbrhxgJsrrdmtempalFxm+OhkxEN
0UMIJCG1u5Eu00Bo7qD4NEAed1OF8kiEHTJbKxmddD/FgF4+BvRIM2j/TOcdnIp52cScfx9B
olr8qvU18jFP/yk14M+mYH3HIUKatoJZ3AszucAPkEHge8KiZJed775gsOAUR+AoEA9aDRry
lgfC3ZC6RCgMkM41xUXd/tEL9dWoJKT3+DKfeyQ/kZwHrilYWPwPcsnXvj7bSVyrvHKAtb9X
ANo4DAMCvVJjpTRG6ztUtFsbVc1GUnrmrxGtC0xeW7gaTiSM9tgicpuTlDRnKMF3O1I9uw1V
X+XU9VTasbk4ZXpi2Y/fNHT9QVht1vk0VUclsbv53yZQIDfbXbPk6Ty00JpDFSAbUtD83zc+
juOPLBgrDVkfZ7ecTNyjAska+pdOpX23Txdxd7snNEV+1C7XxnMdtafTTSXjDmxXt86zK2Cs
MsPJYy3hMCtEb7IV3wiFokuT+txO4ZL+AWNGGGMsHqH9ZoSLxeuVCVvBOAnBNjpdHIc6cQGP
uL8jy8biMYIDhzCCA4MCAQEwgYAweTEQMA4GA1UEChMHUm9vdCBDQTEeMBwGA1UECxMVaHR0
cDovL3d3dy5jYWNlcnQub3JnMSIwIAYDVQQDExlDQSBDZXJ0IFNpZ25pbmcgQXV0aG9yaXR5
MSEwHwYJKoZIhvcNAQkBFhJzdXBwb3J0QGNhY2VydC5vcmcCAwExfTAJBgUrDgMCGgUAoIIB
2zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0wNTA5MjExNjI0
MzhaMCMGCSqGSIb3DQEJBDEWBBRR9OVd3E1NAP2HZS06GfC/dGNSAzBSBgkqhkiG9w0BCQ8x
RTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIBQDAHBgUrDgMC
BzANBggqhkiG9w0DAgIBKDCBkQYJKwYBBAGCNxAEMYGDMIGAMHkxEDAOBgNVBAoTB1Jvb3Qg
Q0ExHjAcBgNVBAsTFWh0dHA6Ly93d3cuY2FjZXJ0Lm9yZzEiMCAGA1UEAxMZQ0EgQ2VydCBT
aWduaW5nIEF1dGhvcml0eTEhMB8GCSqGSIb3DQEJARYSc3VwcG9ydEBjYWNlcnQub3JnAgMB
MX0wgZMGCyqGSIb3DQEJEAILMYGDoIGAMHkxEDAOBgNVBAoTB1Jvb3QgQ0ExHjAcBgNVBAsT
FWh0dHA6Ly93d3cuY2FjZXJ0Lm9yZzEiMCAGA1UEAxMZQ0EgQ2VydCBTaWduaW5nIEF1dGhv
cml0eTEhMB8GCSqGSIb3DQEJARYSc3VwcG9ydEBjYWNlcnQub3JnAgMBMX0wDQYJKoZIhvcN
AQEBBQAEggEAMWP8j3IdBr9L5eJSAIgki3LO02pw9gYqulrgEqDCiyGR9lAplFzwtWke1O0m
dXSZGfLgGoVuPtM7uY/P7/rZhVvq2q6gXLeiDn/UIRYnxEI7a4Ep3t4MHcgOiCMecsBf+WcX
WctLi6jwRiQ68be/YmoyA7WeFu4UY/HLO0Fqze+JDMUtBk4VT/aCoSCtWZMu/hSLpUycbQQ8
zejBA7Ej4vRlvzrVZbLwXYJT9FCO/b8NgzW64S5DoObhRDDbNLUGFd4FXPwvVxWTzqcketsw
QoEdGZvSWZNn49cejHpYX4Ub3RXRGXA+BwMQtE1HAEXnsRGaZoVsJbP/59jhaCkC2gAAAAAA
AA==
--------------ms030306070106050008000402--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
