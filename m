Return-Path: <cyrus@holtmann.org>
Message-ID: <47BBA474.3090505@psu.edu>
Date: Tue, 19 Feb 2008 22:54:28 -0500
From: Chip McArtor <mcm262@psu.edu>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <mailman.551346.1203302340.26582.bluez-users@lists.sourceforge.net>	<BLU140-W15FA67671DB5E1E6450FBECB220@phx.gbl>	<47BB5F2D.8010706@wershofen.de>
	<20080220030542.X62864@3miasto.net.pl>
	<d89ddf300802191909n62370002r1a3d883eb70ffbea@mail.gmail.com>
In-Reply-To: <d89ddf300802191909n62370002r1a3d883eb70ffbea@mail.gmail.com>
Subject: Re: [Bluez-users] Twinkle and bluetooth headset's microphone
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1415018437=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a cryptographically signed message in MIME format.

--===============1415018437==
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms020409090506030606000302"

This is a cryptographically signed message in MIME format.

--------------ms020409090506030606000302
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

While we're on the topic of VoIP applications, I'm curious if anybody
has successfully combined Bluez's ALSA plugin with ALSA slave devices. 
There's a VoIP app that I'd like to use with my headset that only
supports a 32kHz sampling rate.  Because my bluetooth headset (using
"headset" profile) only supports an 8kHz sampling rate, I tried to use
an ALSA plugin for realtime rate conversion.  This ALSA plugin works
perfectly with my main soundcard (emu10k1), but fails with the bluetooth
device.

I have defined the ALSA plugin to use the bluetooth device:
pcm.bluetooth {
   type bluetooth
   device 00:16:8F:08:8F:80
   profile "auto"
}
pcm_slave.rate {
    pcm bluetooth
    format S16_LE
    channels 1
    rate 8000
}
pcm.complex_convert {
    type plug
    slave rate
}

ALSA doesn't seem to be the culprit, because defining the slave PCM with
"hw" as the master device instead of "bluetooth" will downsample any
incoming sound stream to 8kHz.  But when I try using the device with my
bluetooth device, e.g.:

$ aplay -D 44100.wav
Playing WAVE '44100.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Mono

The headset produces a buzzing noise (sounds like a 1kHz square wave),
and causes my system to hard lock a few seconds after aplay finishes. 
Is there a known compatibility issue between Bluez and ALSA plugins?  If
it's guaranteed to not work, would a sound daemon like Pulseaudio be a
decent compromise for realtime rate conversion?

Cheers,
Chip McArtor

--------------ms020409090506030606000302
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIJMTCC
AvMwggJcoAMCAQICEAUKM1NDaX3UMiYrP1SluDUwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UE
BhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMT
I1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA4MDEzMTE3MjgxNloX
DTA5MDEzMDE3MjgxNlowXTEQMA4GA1UEBBMHTWNBcnRvcjEQMA4GA1UEKhMHTWljaGFlbDEY
MBYGA1UEAxMPTWljaGFlbCBNY0FydG9yMR0wGwYJKoZIhvcNAQkBFg5tY20yNjJAcHN1LmVk
dTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALhzH0x/YTxqGNhc6w5u3yeeOSBX
tC0yMYqd0H4c+KjfaV+wYC7xYSDX+8bDDOVg4SGSEFUJQqxR9jOqM4op9wOPp4xabuVCJs49
y9yR2m3nLgJNTm3JCvlMjF3BZkuEWFQuXFFSqZ5N7xAjG8eV/pSTjE4kuaApbCvCqeEq89Fa
L7gMP8a5DtkNani1vT4E9+zBC6/DOYxMa4ISsFMO7njf6eZOkUCNWhNM10lO09OatNLspUPN
GOSjS0qDzr6K5QyUpaBESVzXUvI9XQ/Ot6SlXvWc1HWSn91RtC6g8GJGoLVNf565DebZqh87
cJ3ummCnpCEYL0QDtS6YiEMMxXMCAwEAAaMrMCkwGQYDVR0RBBIwEIEObWNtMjYyQHBzdS5l
ZHUwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQUFAAOBgQBrmi42yZBv3C5a9T3BuSh/3wsE
otnZ3V1xMRQ/dger4Nb+ds9boWmCLnKKI+pH5v+Ev1kQE5uE+qy6tvhyhFmUnlO2/dg/NUTo
Y+qWBblUGpey2MI0Be4NHHxAXr6xWjDaPMdUW/8Q2wdDenBxYFKwK/45EP9zdsfjgyQdWvZD
dDCCAvMwggJcoAMCAQICEAUKM1NDaX3UMiYrP1SluDUwDQYJKoZIhvcNAQEFBQAwYjELMAkG
A1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNV
BAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA4MDEzMTE3Mjgx
NloXDTA5MDEzMDE3MjgxNlowXTEQMA4GA1UEBBMHTWNBcnRvcjEQMA4GA1UEKhMHTWljaGFl
bDEYMBYGA1UEAxMPTWljaGFlbCBNY0FydG9yMR0wGwYJKoZIhvcNAQkBFg5tY20yNjJAcHN1
LmVkdTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALhzH0x/YTxqGNhc6w5u3yee
OSBXtC0yMYqd0H4c+KjfaV+wYC7xYSDX+8bDDOVg4SGSEFUJQqxR9jOqM4op9wOPp4xabuVC
Js49y9yR2m3nLgJNTm3JCvlMjF3BZkuEWFQuXFFSqZ5N7xAjG8eV/pSTjE4kuaApbCvCqeEq
89FaL7gMP8a5DtkNani1vT4E9+zBC6/DOYxMa4ISsFMO7njf6eZOkUCNWhNM10lO09OatNLs
pUPNGOSjS0qDzr6K5QyUpaBESVzXUvI9XQ/Ot6SlXvWc1HWSn91RtC6g8GJGoLVNf565DebZ
qh87cJ3ummCnpCEYL0QDtS6YiEMMxXMCAwEAAaMrMCkwGQYDVR0RBBIwEIEObWNtMjYyQHBz
dS5lZHUwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQUFAAOBgQBrmi42yZBv3C5a9T3BuSh/
3wsEotnZ3V1xMRQ/dger4Nb+ds9boWmCLnKKI+pH5v+Ev1kQE5uE+qy6tvhyhFmUnlO2/dg/
NUToY+qWBblUGpey2MI0Be4NHHxAXr6xWjDaPMdUW/8Q2wdDenBxYFKwK/45EP9zdsfjgyQd
WvZDdDCCAz8wggKooAMCAQICAQ0wDQYJKoZIhvcNAQEFBQAwgdExCzAJBgNVBAYTAlpBMRUw
EwYDVQQIEwxXZXN0ZXJuIENhcGUxEjAQBgNVBAcTCUNhcGUgVG93bjEaMBgGA1UEChMRVGhh
d3RlIENvbnN1bHRpbmcxKDAmBgNVBAsTH0NlcnRpZmljYXRpb24gU2VydmljZXMgRGl2aXNp
b24xJDAiBgNVBAMTG1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBDQTErMCkGCSqGSIb3DQEJ
ARYccGVyc29uYWwtZnJlZW1haWxAdGhhd3RlLmNvbTAeFw0wMzA3MTcwMDAwMDBaFw0xMzA3
MTYyMzU5NTlaMGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAo
UHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBD
QTCBnzANBgkqhkiG9w0BAQEFAAOBjQAwgYkCgYEAxKY8VXNV+065yplaHmjAdQRwnd/p/6Me
7L3N9VvyGna9fww6YfK/Uc4B1OVQCjDXAmNaLIkVcI7dyfArhVqqP3FWy688Cwfn8R+RNiQq
E88r1fOCdz0Dviv+uxg+B79AgAJk16emu59l0cUqVIUPSAR/p7bRPGEEQB5kGXJgt/sCAwEA
AaOBlDCBkTASBgNVHRMBAf8ECDAGAQH/AgEAMEMGA1UdHwQ8MDowOKA2oDSGMmh0dHA6Ly9j
cmwudGhhd3RlLmNvbS9UaGF3dGVQZXJzb25hbEZyZWVtYWlsQ0EuY3JsMAsGA1UdDwQEAwIB
BjApBgNVHREEIjAgpB4wHDEaMBgGA1UEAxMRUHJpdmF0ZUxhYmVsMi0xMzgwDQYJKoZIhvcN
AQEFBQADgYEASIzRUIPqCy7MDaNmrGcPf6+svsIXoUOWlJ1/TCG4+DYfqi2fNi/A9BxQIJNw
PP2t4WFiw9k6GX6EsZkbAMUaC4J0niVQlGLH2ydxVyWN3amcOY6MIE9lX5Xa9/eH1sYITq72
6jTlEBpbNU1341YheILcIRk13iSx0x1G/11fZU8xggNkMIIDYAIBATB2MGIxCzAJBgNVBAYT
AlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNU
aGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQBQozU0NpfdQyJis/VKW4NTAJ
BgUrDgMCGgUAoIIBwzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEP
Fw0wODAyMjAwMzU0MjhaMCMGCSqGSIb3DQEJBDEWBBRv2VxAOhkZZqk0fKRJp4gqYElHQTBS
BgkqhkiG9w0BCQ8xRTBDMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG9w0D
AgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBhQYJKwYBBAGCNxAEMXgwdjBiMQswCQYD
VQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UE
AxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECEAUKM1NDaX3UMiYrP1Sl
uDUwgYcGCyqGSIb3DQEJEAILMXigdjBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3Rl
IENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVt
YWlsIElzc3VpbmcgQ0ECEAUKM1NDaX3UMiYrP1SluDUwDQYJKoZIhvcNAQEBBQAEggEACh2J
/87jg+xysFEkQk6r8RpAYZtxO9vPaNaP29H/NHjwuRPgKcqPpl8GBXL+E/2pz5AUiT3OQxXu
OeOBeygkaLk8ayAWbHPmxJ5zElfMX09poa8IgoKBGInPyKyNhvp30XKsggM1OLlSn2/8VBlD
sTYj2cWjsJlSQmI3jZrE8mxOaUnSQgeeP3SkR5cdcGGTFhPlGZ/6rOQDA/8YrFz6+zp8SRRB
BTT88ceSYUnr4d9Qa+4jqfPPr9CHonxcVLoH3iYr3N8HA7DLolBUjzaYy9Z4UPYZWtnEIMsq
O8BQB8cY9DbowusLqwYUiGz/aPONsQ0rnDEXn1YeDXnUKzWXvQAAAAAAAA==
--------------ms020409090506030606000302--


--===============1415018437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1415018437==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1415018437==--
