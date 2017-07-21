Return-Path: <martin.grothe@rub.de>
Subject: Re: kernel smp.c functions not called by Bluetootl LE controller
To: Marcel Holtmann <marcel@holtmann.org>
References: <38d8a549-4335-cf0b-9273-d9ef9b51ac0b@rub.de>
 <19307C37-EF03-4E42-AFAD-06855DCB7A3F@holtmann.org>
 <c27d57e1-9f43-8c7c-f352-23ea513771b0@rub.de>
 <89D1DA64-12E6-43B1-8C82-E8CA32BA2AE2@holtmann.org>
 <282CA1D1-674A-4216-B838-710D1609EDDA@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
From: Martin Grothe <martin.grothe@rub.de>
Message-ID: <44d10705-617e-d988-c1e5-c5f4d9a98f57@rub.de>
Date: Fri, 21 Jul 2017 13:44:32 +0200
MIME-Version: 1.0
In-Reply-To: <282CA1D1-674A-4216-B838-710D1609EDDA@holtmann.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000506020601090704040707"
List-ID: <linux-bluetooth.vger.kernel.org>

This is a cryptographically signed message in MIME format.

--------------ms000506020601090704040707
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: quoted-printable

Am 21.07.2017 um 13:41 schrieb Marcel Holtmann:
> Hi Martin,
>=20
>>>>> I try to call printk (with priority KERN_ALERT) functions placed in=
 the
>>>>> net/bluetooth/smp.c file of my linux kernel 4.9.35 in order to get
>>>>> output from specifc functions like:
>>>>>
>>>>> static int smp_cmd_public_key()
>>>>>
>>>>> But during a pairing with another bluetooth LE device the output of=

>>>>> these function is never shown in /var/log/kern.log
>>>>>
>>>>> Is there any way to verify, that the LE Controller accesses the Sec=
urity
>>>>> Manager Protocol source code the Linux Kernel?
>>>>>
>>>>> As far as I understood the Core Specification, in BT 4.0 an above t=
he
>>>>> Security Manager is always integrated in the Link Manager, when it =
comes
>>>>> to BR/EDR. But for LE the SM is integrated in the Host part and not=
 the
>>>>> Controller. Thus LE Controller should access the smp.c in the Linux=
 kernel.
>>>>
>>>> just run btmon and you see all the security manager exchanges.
>>>>
>>>> Regards
>>>>
>>>> Marcel
>>>>
>>> Hi Marcel,
>>> I tested it, and I saw some basic SMP messages, like:
>>>
>>> Sent Pairing Request: Bonding, MITM, Initiator Key(s): LTK CSRK ,
>>> Responder Key(s): LTK IRK CSRK
>>>
>>> I get a response and a confirmation of the pairing afterwards, but I
>>> don't see the key exchange, or the messages from Authentication Stage=
 1
>>> or 2.
>>>
>>> Is there any way to log parts of the smp.c functions into kern.log?
>>
>> just send the file created via "btmon -w trace.log" and I can tell you=
 what is going on here. My guess is that you do not have LE SC enabled. T=
hat means legacy pairing is happening which does not using public key exc=
hange.
>=20
> < ACL Data TX: Handle 3585 flags 0x00 dlen 11
>       SMP: Pairing Request (0x01) len 6
>         IO capability: DisplayYesNo (0x01)
>         OOB data: Authentication data not present (0x00)
>         Authentication requirement: Bonding, MITM, SC, No Keypresses (0=
x0d)
>         Max encryption key size: 16
>         Initiator key distribution: EncKey Sign (0x05)
>         Responder key distribution: EncKey IdKey Sign (0x07)
>> ACL Data RX: Handle 3585 flags 0x02 dlen 11
>       SMP: Pairing Response (0x02) len 6
>         IO capability: NoInputNoOutput (0x03)
>         OOB data: Authentication data not present (0x00)
>         Authentication requirement: Bonding, No MITM, Legacy, No Keypre=
sses (0x01)
>         Max encryption key size: 16
>         Initiator key distribution: Sign (0x04)
>         Responder key distribution: EncKey IdKey (0x03)
>=20
> So while your Linux side supports LE SC, your remote side only supports=
 legacy pairing. Which means no public key exchange will happen,
>=20
> The LTK information is distributed instead of locally derived as with L=
E SC that uses ECDH.
>=20
>> ACL Data RX: Handle 3585 flags 0x02 dlen 21
>       SMP: Encryption Information (0x06) len 16
>         Long term key: 8eb620e0cf2f490b9a174777d45c57b3
>> ACL Data RX: Handle 3585 flags 0x02 dlen 15
>       SMP: Master Identification (0x07) len 10
>         EDIV: 0x4be8
>         Rand: 0xf9cd7eb564bf38b9
>=20
> Btw. I have yet to see a LE HID device that uses LE SC.
>=20
> Regards
>=20
> Marcel
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetoo=
th" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

Thanks again for the help.

Is there any BE/EDR controller out there, which is open source/hardware
and which source code can be modified?

Kind Regards,
Martin


--------------ms000506020601090704040707
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
ELkwggTVMIIDvaADAgECAghQTsb1PRG0ZDANBgkqhkiG9w0BAQsFADBxMQswCQYDVQQGEwJE
RTEcMBoGA1UEChMTRGV1dHNjaGUgVGVsZWtvbSBBRzEfMB0GA1UECxMWVC1UZWxlU2VjIFRy
dXN0IENlbnRlcjEjMCEGA1UEAxMaRGV1dHNjaGUgVGVsZWtvbSBSb290IENBIDIwHhcNMTQw
NzIyMTIwODI2WhcNMTkwNzA5MjM1OTAwWjBaMQswCQYDVQQGEwJERTETMBEGA1UEChMKREZO
LVZlcmVpbjEQMA4GA1UECxMHREZOLVBLSTEkMCIGA1UEAxMbREZOLVZlcmVpbiBQQ0EgR2xv
YmFsIC0gRzAxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA6ZvDZ4X5Da71jVTD
llA1PWLpbkztlNcAW5UidNQg6zSP1uzAMQQLmYHiphTSUqAoI4SLdIkEXlvg4njBeMsWyyg1
OXstkEXQ7aAAeny/Sg4bAMOG6VwrMRF7DPOCJEOMHDiLamgAmu7cT3ir0sYTm3at7t4m6O8B
r3QPwQmi9mvOvdPNFDBP9eXjpMhim4IaAycwDQJlYE3t0QkjKpY1WCfTdsZxtpAdxO3/NYZ9
bzOz2w/FEcKKg6GUXUFr2NIQ9Uz9ylGs2b3vkoO72uuLFlZWQ8/h1RM9ph8nMM1JVNvJEzSa
cXXFbOqnC5j5IZ0nrz6jOTlIaoytyZn7wxLyvQIDAQABo4IBhjCCAYIwDgYDVR0PAQH/BAQD
AgEGMB0GA1UdDgQWBBRJt8bP6D0ff+pEexMp9/EKcD7eZDAfBgNVHSMEGDAWgBQxw3kbuvVT
1xfgiXotF2wKsyudMzASBgNVHRMBAf8ECDAGAQH/AgECMGIGA1UdIARbMFkwEQYPKwYBBAGB
rSGCLAEBBAICMBEGDysGAQQBga0hgiwBAQQDADARBg8rBgEEAYGtIYIsAQEEAwEwDwYNKwYB
BAGBrSGCLAEBBDANBgsrBgEEAYGtIYIsHjA+BgNVHR8ENzA1MDOgMaAvhi1odHRwOi8vcGtp
MDMzNi50ZWxlc2VjLmRlL3JsL0RUX1JPT1RfQ0FfMi5jcmwweAYIKwYBBQUHAQEEbDBqMCwG
CCsGAQUFBzABhiBodHRwOi8vb2NzcDAzMzYudGVsZXNlYy5kZS9vY3NwcjA6BggrBgEFBQcw
AoYuaHR0cDovL3BraTAzMzYudGVsZXNlYy5kZS9jcnQvRFRfUk9PVF9DQV8yLmNlcjANBgkq
hkiG9w0BAQsFAAOCAQEAYyAo/ZwhhnK+OUZZOTIlvKkBmw3Myn1BnIZtCm4ssxNZdbEzkhth
Jxb/w7LVNYL7hCoBSb1mu2YvssIGXW4/buMBWlvKQ2NclbbhMacf1QdfTeZlgk4y+cN8ekvN
TVx07iHydQLsUj7SyWrTkCNuSWc1vn9NVqTszC/Pt6GXqHI+ybxA1lqkCD3WvILDt7cyjrEs
jmpttzUCGc/1OURYY6ckABCwu/xOr24vOLulV0k/2G5QbyyXltwdRpplic+uzPLl2Z9Tsz6h
L5Kp2AvGhB8Exuse6J99tXulAvEkxSRjETTMWpMgKnmIOiVCkKllO3yG0xIVIyn8LNrMOVtU
FzCCBZEwggR5oAMCAQICBxekJHW1yvgwDQYJKoZIhvcNAQELBQAwWjELMAkGA1UEBhMCREUx
EzARBgNVBAoTCkRGTi1WZXJlaW4xEDAOBgNVBAsTB0RGTi1QS0kxJDAiBgNVBAMTG0RGTi1W
ZXJlaW4gUENBIEdsb2JhbCAtIEcwMTAeFw0xNDA1MjcxNDUzMjVaFw0xOTA3MDkyMzU5MDBa
MIGuMQswCQYDVQQGEwJERTEcMBoGA1UECBMTTm9yZHJoZWluLVdlc3RmYWxlbjEPMA0GA1UE
BxMGQm9jaHVtMSEwHwYDVQQKExhSdWhyLVVuaXZlcnNpdGFldCBCb2NodW0xJDAiBgNVBAMT
G1J1aHItVW5pdmVyc2l0YWV0IEJvY2h1bSBDQTEnMCUGCSqGSIb3DQEJARYYcnViY2FAcnVo
ci11bmktYm9jaHVtLmRlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAtIGt9mPn
TWezxFORNckfxxbD4S+6e+QRP2Yc9mNhRO68OriMqdX4tExeysXlOU+iIoSUpssBLLWiEmPn
HVwUWd1rK0884nzc0iRP1DQjqtKZ7ffZkOdpX5Aobd1pVqGfrqKs1dw8zLZvOORe4+HUI8Sw
WQwyZZIMP7c36RmUQLP7Q+OYC7hfYQvkf+Gnvb7ADBChob+aqof3ePChqsBpkKE3SMuUiD18
44egELSa9rahkXTEwbvhmd1KSFnmmk3TJKamE347y4FFJaY5DShfWh8jrbgAQ1yMWadps+/r
VpfSIj+aCLGUNEcjsL2sPUVjLp4sZf2j5mj4DcwM55/tTQIDAQABo4ICBTCCAgEwEgYDVR0T
AQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwEQYDVR0gBAowCDAGBgRVHSAAMB0GA1Ud
DgQWBBS7Kbg7XwQk44twe2B/Nm8XYcuukjAfBgNVHSMEGDAWgBRJt8bP6D0ff+pEexMp9/EK
cD7eZDAjBgNVHREEHDAagRhydWJjYUBydWhyLXVuaS1ib2NodW0uZGUwgYgGA1UdHwSBgDB+
MD2gO6A5hjdodHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWNhL3B1Yi9jcmwv
Y2FjcmwuY3JsMD2gO6A5hjdodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWNh
L3B1Yi9jcmwvY2FjcmwuY3JsMIHXBggrBgEFBQcBAQSByjCBxzAzBggrBgEFBQcwAYYnaHR0
cDovL29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEcGCCsGAQUFBzAChjtodHRw
Oi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBHBggrBgEFBQcwAoY7aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1jYS9w
dWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBAC7X1UserO56Dmauc3V2
+E3iY522sDt4VqGL1J9FjPVO3LZYOidi1jm7qmYh8zeR6LK7k7EzOMWO2wiIVAJiQBMYzUF/
47Q8oVBQgFCeTNR1TvZ8hf+XnfKhRmawLhT3EvkZaGQPyJVFNVRmJT7ToR3zdjz28CKREckH
da14pD/axFRrqxCkFlGPgsF/tHY1WItLNDQgC7sTYPIouxatKoc+zLgfYfISF+V6Rmx2Zdwj
dZOvzlqBzHDjiRG0ARw15+AvjSOFg4kj+Zwmakd8K7o3YBA9Rm01blS9tBR/vin3ANuDsTfz
9eUjwy22RcGm7+TLiLaptCqASTU667B+JVQwggZHMIIFL6ADAgECAgwdAZZbpRdv6ajEjSow
DQYJKoZIhvcNAQELBQAwga4xCzAJBgNVBAYTAkRFMRwwGgYDVQQIExNOb3JkcmhlaW4tV2Vz
dGZhbGVuMQ8wDQYDVQQHEwZCb2NodW0xITAfBgNVBAoTGFJ1aHItVW5pdmVyc2l0YWV0IEJv
Y2h1bTEkMCIGA1UEAxMbUnVoci1Vbml2ZXJzaXRhZXQgQm9jaHVtIENBMScwJQYJKoZIhvcN
AQkBFhhydWJjYUBydWhyLXVuaS1ib2NodW0uZGUwHhcNMTcwNDAzMDk0MTMyWhcNMTkwNzA5
MjM1OTAwWjB1MQswCQYDVQQGEwJERTEhMB8GA1UECgwYUnVoci1Vbml2ZXJzaXRhZXQgQm9j
aHVtMSswKQYDVQQLDCJDaGFpciBmb3IgTmV0d29yayBhbmQgRGF0YXNlY3VyaXR5MRYwFAYD
VQQDDA1NYXJ0aW4gR3JvdGhlMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0nYl
C/ccd892TMPnCSgCq3IK529DKQUGXHocMgfXDNYZU+MDPU8DtTdutC75VGl0UKcFj0lH6XRw
oLcEoNhH80Fb8OJZ8JJx8cFVjVZskWPY2bYr7ZiYkAOWiN8rK6Ei0tzAKZhSn0bqwiUf27K0
EWKuSs9M4420vdH6SaY9OzuIPxcfguZrE3zmsuByX2DnWSyBNuMfyPiPGruJKAEp3XLBYxyJ
QJzFaNnvxTrMr6cxCgxXDw0HdqtC/90/ZecIFTV3J0TqlkG0HcsumOutAewN+6fLFXPDODNK
/k/kSKaJaqn5qCLCelWQnjf8DjKJ3A82vz6nXrM+qov2L3UPwwIDAQABo4ICmzCCApcwQAYD
VR0gBDkwNzARBg8rBgEEAYGtIYIsAQEEAwUwEQYPKwYBBAGBrSGCLAIBBAMBMA8GDSsGAQQB
ga0hgiwBAQQwCQYDVR0TBAIwADAOBgNVHQ8BAf8EBAMCBeAwHQYDVR0lBBYwFAYIKwYBBQUH
AwIGCCsGAQUFBwMEMB0GA1UdDgQWBBSO8QhcSN1B9GdlXnitLuchFumWXTAfBgNVHSMEGDAW
gBS7Kbg7XwQk44twe2B/Nm8XYcuukjB5BgNVHREEcjBwgRRtYXJ0aW4uZ3JvdGhlQHJ1Yi5k
ZYEgbWFydGluLmdyb3RoZUBydWhyLXVuaS1ib2NodW0uZGWBFE1hcnRpbi5Hcm90aGVAcnVi
LmRlgSBNYXJ0aW4uR3JvdGhlQHJ1aHItdW5pLWJvY2h1bS5kZTCBhQYDVR0fBH4wfDA8oDqg
OIY2aHR0cDovL2NkcDEucGNhLmRmbi5kZS91bmktYm9jaHVtLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMDygOqA4hjZodHRwOi8vY2RwMi5wY2EuZGZuLmRlL3VuaS1ib2NodW0tY2EvcHViL2Ny
bC9jYWNybC5jcmwwgdUGCCsGAQUFBwEBBIHIMIHFMDMGCCsGAQUFBzABhidodHRwOi8vb2Nz
cC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwRgYIKwYBBQUHMAKGOmh0dHA6Ly9jZHAx
LnBjYS5kZm4uZGUvdW5pLWJvY2h1bS1jYS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwRgYIKwYB
BQUHMAKGOmh0dHA6Ly9jZHAyLnBjYS5kZm4uZGUvdW5pLWJvY2h1bS1jYS9wdWIvY2FjZXJ0
L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBACt8V+asQRcO5kvw1AGgNqlqIzpC6udY
UYGuV9S20ySLnAm1/jzZqzKtoPqju85OrmMjpnUv4WKNGu5syjHZxgys+9dvkPXIXI+KsdIJ
tFBztXNihuuAthUwYiQuyINmCJ0xd3G37Ny2p61bIAihkwNaS50oaftwO0yybZRENlxT5khq
EWKZsfpERXRLUpZyoiGatgjCYagLpLqmhavnuL+nPIAeVVsJTXR3PkTgUCHaE9EJD2sDABEY
kg5edjKsa9M9VtAzKcOfB4iwPEYVGbnERzexjsRCceAil33SnpP06dKcl24bsQD+jCqvFNAu
/s7JxXOzcCL2Fe3TD3KhPDExggRuMIIEagIBATCBvzCBrjELMAkGA1UEBhMCREUxHDAaBgNV
BAgTE05vcmRyaGVpbi1XZXN0ZmFsZW4xDzANBgNVBAcTBkJvY2h1bTEhMB8GA1UEChMYUnVo
ci1Vbml2ZXJzaXRhZXQgQm9jaHVtMSQwIgYDVQQDExtSdWhyLVVuaXZlcnNpdGFldCBCb2No
dW0gQ0ExJzAlBgkqhkiG9w0BCQEWGHJ1YmNhQHJ1aHItdW5pLWJvY2h1bS5kZQIMHQGWW6UX
b+moxI0qMA0GCWCGSAFlAwQCAQUAoIICfzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0xNzA3MjExMTQ0MzJaMC8GCSqGSIb3DQEJBDEiBCBBavkhJzVpf+25
kYkh0340rs03LOGNMSjpAhG899O2BDBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjAL
BglghkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFA
MAcGBSsOAwIHMA0GCCqGSIb3DQMCAgEoMIHQBgkrBgEEAYI3EAQxgcIwgb8wga4xCzAJBgNV
BAYTAkRFMRwwGgYDVQQIExNOb3JkcmhlaW4tV2VzdGZhbGVuMQ8wDQYDVQQHEwZCb2NodW0x
ITAfBgNVBAoTGFJ1aHItVW5pdmVyc2l0YWV0IEJvY2h1bTEkMCIGA1UEAxMbUnVoci1Vbml2
ZXJzaXRhZXQgQm9jaHVtIENBMScwJQYJKoZIhvcNAQkBFhhydWJjYUBydWhyLXVuaS1ib2No
dW0uZGUCDB0BllulF2/pqMSNKjCB0gYLKoZIhvcNAQkQAgsxgcKggb8wga4xCzAJBgNVBAYT
AkRFMRwwGgYDVQQIExNOb3JkcmhlaW4tV2VzdGZhbGVuMQ8wDQYDVQQHEwZCb2NodW0xITAf
BgNVBAoTGFJ1aHItVW5pdmVyc2l0YWV0IEJvY2h1bTEkMCIGA1UEAxMbUnVoci1Vbml2ZXJz
aXRhZXQgQm9jaHVtIENBMScwJQYJKoZIhvcNAQkBFhhydWJjYUBydWhyLXVuaS1ib2NodW0u
ZGUCDB0BllulF2/pqMSNKjANBgkqhkiG9w0BAQEFAASCAQArdhCy7hcFsGJ5EW4lGBUIEl6x
2+Fhd+kL8GYfpO0KxI16JEFqpGB2AAJia23fLnSFwBiuUnwN8Cm/qBU8rM47NQXdKle61gOJ
NLEsQ+SoOUXXHZdAKd0F+ZYBD1Et79UggRJF0VdXF02nV2lBXIZi9BZ4uQfrAJNpOyXZ0Ipr
Lg+p+n9QlwAb7i3QwgayRYOlt8xlR4pkR282u3siBw+/PkF1NZQzVrq2L4tK4X56RWSrOx8D
ErvMiXC9LHabUiXj15z3fevrAdJ34rBa7bpl5eHvvfHz33NUpxmzcvHFMbQxNQoc226BkRYT
lYns8bGkX8j91kgeHP9MjjtorIiEAAAAAAAA
--------------ms000506020601090704040707--
