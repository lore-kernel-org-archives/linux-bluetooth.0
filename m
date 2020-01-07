Return-Path: <SRS0=JtZ7=24=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D3DCC33C99
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 08:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7F7206DB
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Jan 2020 08:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbgAGIuU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:50:20 -0500
Received: from mailout5.zih.tu-dresden.de ([141.30.67.74]:57143 "EHLO
        mailout5.zih.tu-dresden.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726492AbgAGIuU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 03:50:20 -0500
Received: from mail.zih.tu-dresden.de ([141.76.14.4] helo=umx-horde-web6.mailcluster.zih.tu-dresden.de)
        by mailout5.zih.tu-dresden.de with esmtps (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.84_2)
        (envelope-from <thomas.ruprecht@tu-dresden.de>)
        id 1iokZ6-0001hf-2p; Tue, 07 Jan 2020 09:50:16 +0100
Received: from thi238.inf.tu-dresden.de ([141.76.60.238])
        by umx-horde-web6.mailcluster.zih.tu-dresden.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-SHA:128)
        (Exim 4.92)
        (envelope-from <thomas.ruprecht@tu-dresden.de>)
        id 1iokZ5-000WxS-Gk; Tue, 07 Jan 2020 09:50:15 +0100
From:   Thomas Ruprecht <thomas.ruprecht@tu-dresden.de>
Subject: Bluez does not connect to A2DP sink
To:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Message-ID: <d27a0f72-4c78-92ed-4b0a-1010a4b63f0e@tu-dresden.de>
Date:   Tue, 7 Jan 2020 09:50:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms040706040401090804050903"
X-TUD-Original-From: thomas.ruprecht@tu-dresden.de
X-TUD-Virus-Scanned: mailout5.zih.tu-dresden.de
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms040706040401090804050903
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

I got a problem with bluez since 5.51 that was recently discussed in the =

thread https://marc.info/?l=3Dlinux-bluetooth&m=3D157081619423081&w=3D2: =
My=20
headset auto-connects but is not registered as a2dp sink. Unfortunately, =

the proposed patch did not solve this issue for my setup.

I also could track down this regression to commit 477ecca (policy: Add=20
logic to connect a Sink); applying it to 5.50 yields the connection=20
issues. After that, I applied your patch in commit 52faac4 (audio: Fix=20
cancelling disconnect timeout), but it did not change. I used only these =

two commits on top of version 5.50 to isolate the problem (it is the=20
same with version 5.51 and 5.52) and gathered the logs of running=20
`bluetoothd -dn` and `btmon -w` for the three setups:
* version 5.50 (patch-0),
* version 5.50 + 477ecca (patch-1), and
* version 5.50 + 477ecca + 52faac4 (patch-2).
For all three logs I powered the headset on to connect it, waited a few=20
moments, and then powered off to disconnect. You can find them at=20
https://gist.github.com/6d733ba9ac6cf04c71625a08e8365178.

@Luiz Augusto von Dentz: Sorry if I sent you this mail multiple times,=20
it probably got filtered from the mailing list as I attached the logs in =

previous attempts.

Please let me know if you need anything else. Thanks.



--------------ms040706040401090804050903
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFgwggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWWMIIEfqADAgECAgwcbjQkPzrYLBvMkTUwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjEyMTIxNDM5
MTZaFw0zMTAyMjIyMzU5NTlaMHMxCzAJBgNVBAYTAkRFMRAwDgYDVQQIDAdTYWNoc2VuMRAw
DgYDVQQHDAdEcmVzZGVuMSgwJgYDVQQKDB9UZWNobmlzY2hlIFVuaXZlcnNpdGFldCBEcmVz
ZGVuMRYwFAYDVQQDDA1UVSBEcmVzZGVuIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEA5+CCc42Y1+0J5tpASWPSYx/0Pxqj97P1DdzCbTh3XwppRsAMtqNwS8sTxgHMmbNA
ol18t3EqIkTH/iSXEhd5cf6OSyHumVbgvZTvjMh/c7R3VGZiwqimlhk4/UJV8nVPvrL24Guk
D17Rsv+iLe5Mse7HIMJ7e9ciArdCBV5W6kk/5O24/ZhttIEs/2I3i8MTlGoBaesNgkUy/cRa
A0hw1BBTrDbfK1vhbxV/CWb+czy0F0M5W31LToGrXuwoFrhggn5X/LrFXvCb8/9w+jSk8WzG
vJw6MlPGXHwuTfjf7oei/S0j7iHq5fyIH3lEs58M4kwxlLViv2rc3KJkTX5xmQIDAQABo4IC
BTCCAgEwEgYDVR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDAN
BgsrBgEEAYGtIYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBRS/r63JMIbCh1GUo5E
JCr0SEA9ATAfBgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGE
MECgPqA8hjpodHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9j
cmwvY2FjcmwuY3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290
LWcyLWNhL3B1Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcw
AYYnaHR0cDovL29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAC
hj5odHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQv
Y2FjZXJ0LmNydDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwt
cm9vdC1nMi1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBAEzY
RPywOGl/wZ/Mdz2gLDMbO39f7+iQcrVPRy/lbjjLt+0bouai8xTj1I9N+W4ZOhGww55gXMNO
nBiKouODdNcazTxW6+glA4+5K9bxkAKu9kl9J2ezpcMw1PNTFFcS1yG+thGQTtuy+3S3fI6V
Ifxi+RawFri9sC7010qS3RwOShmhsLk3iEjlDQ180zkBzsdevWHt1svALpqsc+7DcHuP+MgY
vkow/1uyHp3vyeTE9K7hdxcfXwRQ9IkeCo9xLJUeykuosqrTOQNe4Yw4hPhrJfRtoyH92SFq
deZenVeU6+rkquev61X3fPi+/ySpUOGyWPdggN65bQ81E8nLFYUwggWkMIIEjKADAgECAgwe
5EkHQuMYAtIEw/8wDQYJKoZIhvcNAQELBQAwczELMAkGA1UEBhMCREUxEDAOBgNVBAgMB1Nh
Y2hzZW4xEDAOBgNVBAcMB0RyZXNkZW4xKDAmBgNVBAoMH1RlY2huaXNjaGUgVW5pdmVyc2l0
YWV0IERyZXNkZW4xFjAUBgNVBAMMDVRVIERyZXNkZW4gQ0EwHhcNMTgwNDA0MTI1NjI1WhcN
MjEwNDAzMTI1NjI1WjBRMQswCQYDVQQGEwJERTEoMCYGA1UECgwfVGVjaG5pc2NoZSBVbml2
ZXJzaXRhZXQgRHJlc2RlbjEYMBYGA1UEAwwPVGhvbWFzIFJ1cHJlY2h0MIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEAmNBRqv0urw+od21vmdl9gah+8b3IL2H+YK95B7d3ORnZ
DtO/YVg3G2mHaMzXNIPfITfSdcXQusanu4AxQ4aBRiP6VkZ2Jf3qcSECJ9TTOkGtOGbsDDGu
TWQPHAKR0QaqF/eupLcGeRKtMvWJWz3AdnnE2cfJVYjEorZh13Ym9xgFtzK0xhba0RCp7azd
wdWnQna70rX8r1B7WnF1QKS9/9Q9wYv5gVYxXjQ7FIlk2/muh3u+5XXXJDKm1oEA2kPud/DI
v2UaSFn+B/6Z7oRwe1v/IQ+xlHU9utkJ5IuQLGc+9MvZPsZidnCS/OdIJZ/brMPqQgfOfs4k
LmCv0u8GJQIDAQABo4ICWDCCAlQwCQYDVR0TBAIwADAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBQoELdebSCx14ON2PL6UI9pq27J
EDAfBgNVHSMEGDAWgBRS/r63JMIbCh1GUo5EJCr0SEA9ATAoBgNVHREEITAfgR10aG9tYXMu
cnVwcmVjaHRAdHUtZHJlc2Rlbi5kZTCBjQYDVR0fBIGFMIGCMD+gPaA7hjlodHRwOi8vY2Rw
MS5wY2EuZGZuLmRlL3R1LWRyZXNkZW4tZzItY2EvcHViL2NybC9jYWNybC5jcmwwP6A9oDuG
OWh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvdHUtZHJlc2Rlbi1nMi1jYS9wdWIvY3JsL2NhY3Js
LmNybDCB2wYIKwYBBQUHAQEEgc4wgcswMwYIKwYBBQUHMAGGJ2h0dHA6Ly9vY3NwLnBjYS5k
Zm4uZGUvT0NTUC1TZXJ2ZXIvT0NTUDBJBggrBgEFBQcwAoY9aHR0cDovL2NkcDEucGNhLmRm
bi5kZS90dS1kcmVzZGVuLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBJBggrBgEFBQcw
AoY9aHR0cDovL2NkcDIucGNhLmRmbi5kZS90dS1kcmVzZGVuLWcyLWNhL3B1Yi9jYWNlcnQv
Y2FjZXJ0LmNydDBABgNVHSAEOTA3MA8GDSsGAQQBga0hgiwBAQQwEQYPKwYBBAGBrSGCLAEB
BAMIMBEGDysGAQQBga0hgiwCAQQDCDANBgkqhkiG9w0BAQsFAAOCAQEADSrrvX0k4BZRyZic
yEkbEcz36NFHoEzfrVGvkItwrRfa6KqHWRnT757VzOiDLIJ3pHsNJiFdelxIZYo+6AKa3lR9
A4hsjaLv3qsHcIVvSYXWNukp2VO4ksF/Dlt++u9Cr+z4VWtzTwaOD6c9Vyfo76AsPurlYhGB
baiZlcWRs8vnGX6lH50047uvPqeYV5OMAltPMTa37whSe0Fv0/daT0RycDMsVp0QzSsOCeV/
t5G8pufRf+kNf7CMECFcX146Xy5WB6BQO/7JkzQePhaT8pMjCLe2pxHn52foVPiFY9L2RPJq
UCwq+UF89B5mc4wKl+G9N5ftieFxBJJnjwLztzGCA7owggO2AgEBMIGDMHMxCzAJBgNVBAYT
AkRFMRAwDgYDVQQIDAdTYWNoc2VuMRAwDgYDVQQHDAdEcmVzZGVuMSgwJgYDVQQKDB9UZWNo
bmlzY2hlIFVuaXZlcnNpdGFldCBEcmVzZGVuMRYwFAYDVQQDDA1UVSBEcmVzZGVuIENBAgwe
5EkHQuMYAtIEw/8wDQYJYIZIAWUDBAIBBQCgggIHMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0B
BwEwHAYJKoZIhvcNAQkFMQ8XDTIwMDEwNzA4NTAxNVowLwYJKoZIhvcNAQkEMSIEIC3h1pnp
M0sFX0F2hEkg6tqFsBSSv9OpGuXGa0fGtK+dMGwGCSqGSIb3DQEJDzFfMF0wCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzAOBggqhkiG9w0DAgICAIAwDQYIKoZIhvcN
AwICAUAwBwYFKw4DAgcwDQYIKoZIhvcNAwICASgwgZQGCSsGAQQBgjcQBDGBhjCBgzBzMQsw
CQYDVQQGEwJERTEQMA4GA1UECAwHU2FjaHNlbjEQMA4GA1UEBwwHRHJlc2RlbjEoMCYGA1UE
CgwfVGVjaG5pc2NoZSBVbml2ZXJzaXRhZXQgRHJlc2RlbjEWMBQGA1UEAwwNVFUgRHJlc2Rl
biBDQQIMHuRJB0LjGALSBMP/MIGWBgsqhkiG9w0BCRACCzGBhqCBgzBzMQswCQYDVQQGEwJE
RTEQMA4GA1UECAwHU2FjaHNlbjEQMA4GA1UEBwwHRHJlc2RlbjEoMCYGA1UECgwfVGVjaG5p
c2NoZSBVbml2ZXJzaXRhZXQgRHJlc2RlbjEWMBQGA1UEAwwNVFUgRHJlc2RlbiBDQQIMHuRJ
B0LjGALSBMP/MA0GCSqGSIb3DQEBAQUABIIBAD1roro7NvxYJtP4stPgHpY48VG0rVrPSyhm
wvWLBOSv/sa9LbfGndgzk1+tpM/L9o1VTF9663ZqOvp6IS2MpJ009TQ6OUbdoHXjtvyaGG1z
SD7J4LtJ90MMYY5acvI3kgdmW/HsZCRyct+3TV3Dv7RTFbN8LwiGSZhImb9FTQR9VbQZKcX+
vod+znW9jyxY97oobHb0JAPxtwbEP3BhsqHdhgxkzI7AgO9uHpTz+E6d+/TC4lWiYXDQfUne
Usl6VaRpcZvs9SefCreab6C2hifHL5XGb4h/CWuiWVbKBr+mpGuWArrH5hZHnkDe7QO9obte
yGpwGCuXcrHdBvl32V0AAAAAAAA=
--------------ms040706040401090804050903--
