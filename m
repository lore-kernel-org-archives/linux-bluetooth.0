Return-Path: <cyrus@holtmann.org>
Message-ID: <478448C4.3020102@psu.edu>
Date: Tue, 08 Jan 2008 23:08:36 -0500
From: Chip McArtor <mcm262@psu.edu>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Headset audio capture failing when using Bluez's ALSA
	plugin
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2067707894=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a cryptographically signed message in MIME format.

--===============2067707894==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms030906060601030502020306"

This is a cryptographically signed message in MIME format.

--------------ms030906060601030502020306
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello, I recently installed a USB bluetooth dongle with the intent of
using my Jabra BT500 headset in VOIP applications.  I've followed the
Bluez audio service wiki with some degree of success; audio playback on
my headset works flawlessly with a variety of players. Audio recording
through the headset's mic, on the other hand, consistently stops
capturing audio after what appears to be ~250ms into the recording session.

I've tested this using both arecord and Skype's test call feature.
Running arecord yields
$ arecord -D bluetooth -f S16_LE
>boo.wav                                       Recording WAVE 'stdin' :
Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Aborted by signal Interrupt...
 (manually stopped after several seconds)

The output file boo.wav is exactly 250ms long, and appears to contain
the very beginning of my recording.  Skype similarly fails on the call
test (audio playback is fine, but the capture test fails to grab any
audio).  In both cases, the Jabra makes the "call end" tone when I
finish my recording test.  Also while recording, I get the following
system message several times:

hci_scodata_packet: hci0 SCO packet for unknown connection handle 45

Any thoughts on what the problem could be?  Thanks for your help.

Chip McArtor

Software versions:
bluez-libs 3.24
bluez-utils 3.24
alsa-lib 1.0.14a
linux 2.6.23 i686 SMP


BT adapter info:

hci0:   Type: USB
        BD Address: 00:15:83:BE:9C:58 ACL MTU: 384:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:1984896 acl:74 sco:38817 events:196 errors:0
        TX bytes:1970090 acl:57 sco:38591 commands:67 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x080100
        Service Classes: Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x7a6 LMP Ver: 2.0 (0x3) LMP Subver:
0x7a6
        Manufacturer: Cambridge Silicon Radio (10)


~/.asoundrc:

pcm.bluetooth {
   type bluetooth
   device 00:16:8F:08:8F:80
   profile "voice"
}


--------------ms030906060601030502020306
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJLzCC
AvIwggJboAMCAQICDyIwHzRAyYcVEXqp2OhBsDANBgkqhkiG9w0BAQUFADBiMQswCQYDVQQG
EwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMj
VGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwHhcNMDcwMjAzMTcyNDMzWhcN
MDgwMjAzMTcyNDMzWjBdMRAwDgYDVQQEEwdNY0FydG9yMRAwDgYDVQQqEwdNaWNoYWVsMRgw
FgYDVQQDEw9NaWNoYWVsIE1jQXJ0b3IxHTAbBgkqhkiG9w0BCQEWDm1jbTI2MkBwc3UuZWR1
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxHmPEiAzr3xETa2/Xg6ajPb1eHeI
o8vp35FiPkuTLyw8KlRSVWWqvaB6gDHyzOTL4agarShlMDMyCbAbh1aalyjbGqecVw55Hxbj
huaKLy0FEMfGdP8c51IbdEj7vWJMEk9pHbJCRB3PywOPcWsyBY5bclxQz1ZtyeAd8Saq2nda
r3OzmcDqLs5gwAmOBVIk27NOPka9lVv5vSJ5+81RzNOCrEe3YOiO8QIelcTSQe0GUODSY5M9
Vq2deUwZvC2FvWE9qcqJnTJuBOUEtVIMtJpkSFtgAAbAU/V89ueuGaXm0EBLOPg+saAtXw+n
AAsF4w9G/V7nnh4xrMFbj+J0nwIDAQABoyswKTAZBgNVHREEEjAQgQ5tY20yNjJAcHN1LmVk
dTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBAEVeOSqfdxKAJyyddcYgoNDv6waL
gQTwK8lZgQGPGA9MNdIqSk8P5Cdl5LfjVRNOWSBJUBq3+dTlNwBTv8GBSzaK7u7SiRXgHUlL
WST0P8p8MjjTqt7dY7Zt0FdoQQKaEKXPIsbV5AhWBM5OXtRyhkLQGPDlceHs7uRsf0btBQ3u
MIIC8jCCAlugAwIBAgIPIjAfNEDJhxUReqnY6EGwMA0GCSqGSIb3DQEBBQUAMGIxCzAJBgNV
BAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQD
EyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQTAeFw0wNzAyMDMxNzI0MzNa
Fw0wODAyMDMxNzI0MzNaMF0xEDAOBgNVBAQTB01jQXJ0b3IxEDAOBgNVBCoTB01pY2hhZWwx
GDAWBgNVBAMTD01pY2hhZWwgTWNBcnRvcjEdMBsGCSqGSIb3DQEJARYObWNtMjYyQHBzdS5l
ZHUwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDEeY8SIDOvfERNrb9eDpqM9vV4
d4ijy+nfkWI+S5MvLDwqVFJVZaq9oHqAMfLM5MvhqBqtKGUwMzIJsBuHVpqXKNsap5xXDnkf
FuOG5oovLQUQx8Z0/xznUht0SPu9YkwST2kdskJEHc/LA49xazIFjltyXFDPVm3J4B3xJqra
d1qvc7OZwOouzmDACY4FUiTbs04+Rr2VW/m9Inn7zVHM04KsR7dg6I7xAh6VxNJB7QZQ4NJj
kz1WrZ15TBm8LYW9YT2pyomdMm4E5QS1Ugy0mmRIW2AABsBT9Xz2564ZpebQQEs4+D6xoC1f
D6cACwXjD0b9XueeHjGswVuP4nSfAgMBAAGjKzApMBkGA1UdEQQSMBCBDm1jbTI2MkBwc3Uu
ZWR1MAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEARV45Kp93EoAnLJ11xiCg0O/r
BouBBPAryVmBAY8YD0w10ipKTw/kJ2Xkt+NVE05ZIElQGrf51OU3AFO/wYFLNoru7tKJFeAd
SUtZJPQ/ynwyONOq3t1jtm3QV2hBApoQpc8ixtXkCFYEzk5e1HKGQtAY8OVx4ezu5Gx/Ru0F
De4wggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEVMBMG
A1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0
ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9u
MSQwIgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEW
HHBlcnNvbmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2
MjM1OTU5WjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0
eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0Ew
gZ8wDQYJKoZIhvcNAQEBBQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9
zfVb8hp2vX8MOmHyv1HOAdTlUAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPP
K9Xzgnc9A74r/rsYPge/QIACZNenprufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGj
gZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIBADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3Js
LnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxGcmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYw
KQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZhdGVMYWJlbDItMTM4MA0GCSqGSIb3DQEB
BQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSdf0whuPg2H6otnzYvwPQcUCCTcDz9
reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmOjCBPZV+V2vf3h9bGCE6u9uo0
5RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDYTCCA10CAQEwdTBiMQswCQYDVQQGEwJa
QTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhh
d3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECDyIwHzRAyYcVEXqp2OhBsDAJBgUr
DgMCGgUAoIIBwTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0w
ODAxMDkwNDA4MzZaMCMGCSqGSIb3DQEJBDEWBBQ3mEcdKQiMUxuHrwPj1mc87jbx0TBSBgkq
hkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0DAgIB
QDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBhAYJKwYBBAGCNxAEMXcwdTBiMQswCQYDVQQG
EwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMj
VGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECDyIwHzRAyYcVEXqp2OhBsDCB
hgYLKoZIhvcNAQkQAgsxd6B1MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29u
c3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwg
SXNzdWluZyBDQQIPIjAfNEDJhxUReqnY6EGwMA0GCSqGSIb3DQEBAQUABIIBAK2ZPy8qbmC9
lB3x/NkVsaM5ipxfjTFkzdjt9lQcoYuLYpLe36JlvSBLUVWJljU5X9gLR68I8NLnMaccbFfD
4ZwkBi5EJ2P4DBI7hwJWzKlcUYoWGbY1Qiu8C/L2OqOGCqwobxyyps6psIuHee3MGBsYttPz
c6hL548ozPpLt4EVD+2np8NBWuqDWLFDqajpinzuKt68DtazbcTSNJ8E9nJjs7ExkZ5SXZb7
eCQDnmgyWwdt3kSEZ+dLvtKQJEJoQLKqX78To7HrM8jmLYHo5hlBjM0VRlUFO41pUZrpcfLw
tlqH6xdtCftJTH2BAKtWZVJt5KfT/L9xCM7PyIWcEYQAAAAAAAA=
--------------ms030906060601030502020306--


--===============2067707894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============2067707894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2067707894==--
