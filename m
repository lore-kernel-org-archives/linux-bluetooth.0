Return-Path: <cyrus@holtmann.org>
From: "Wang, Arron" <arron.wang@intel.com>
To: "marcel@holtmann.org" <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCHv2] Bluetooth: Move SCO support under BT_BREDR config
 option
Date: Tue, 9 Jun 2015 09:31:15 +0000
Message-ID: <3B8E4CEA2CC045459E7856C66B82CE931135E504@SHSMSX103.ccr.corp.intel.com>
References: <1433324130-3771-1-git-send-email-arron.wang@intel.com>
 <0F875A25-15B1-4296-95F9-1FD5720C9403@holtmann.org>
In-Reply-To: <0F875A25-15B1-4296-95F9-1FD5720C9403@holtmann.org>
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=SHA1; boundary="----=_NextPart_000_0128_01D0A2DA.158B5F10"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

------=_NextPart_000_0128_01D0A2DA.158B5F10
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi Marcel,

>-----Original Message-----
>From: Marcel Holtmann [mailto:marcel@holtmann.org]
>Sent: Saturday, June 6, 2015 12:54 PM
>To: Wang, Arron
>Cc: linux-bluetooth@vger.kernel.org
>Subject: Re: [PATCHv2] Bluetooth: Move SCO support under BT_BREDR config
>option
>
>Hi Arron,
>
>> SCO/eSCO link is supported by BR/EDR controller, it is suitable to
>> move them under BT_BREDR config option
>>
>> Signed-off-by: Arron Wang <arron.wang@intel.com>
>> ---
>> include/net/bluetooth/bluetooth.h |   11 +++++++++++
>> include/net/bluetooth/hci_core.h  |   14 +++++++++++++-
>> net/bluetooth/Makefile            |    3 ++-
>> net/bluetooth/sco.c               |    5 ++---
>> 4 files changed, 28 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/net/bluetooth/bluetooth.h
>> b/include/net/bluetooth/bluetooth.h
>> index 7dba805..38d8a34 100644
>> --- a/include/net/bluetooth/bluetooth.h
>> +++ b/include/net/bluetooth/bluetooth.h
>> @@ -365,8 +365,19 @@ extern struct dentry *bt_debugfs; int
>> l2cap_init(void); void l2cap_exit(void);
>>
>> +#if IS_ENABLED(CONFIG_BT_BREDR)
>> int sco_init(void);
>> void sco_exit(void);
>> +#else
>> +static inline int sco_init(void)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void sco_exit(void)
>> +{
>> +}
>> +#endif
>>
>> int mgmt_init(void);
>> void mgmt_exit(void);
>> diff --git a/include/net/bluetooth/hci_core.h
>> b/include/net/bluetooth/hci_core.h
>> index a056c2b..387bbc3 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -532,8 +532,20 @@ int l2cap_connect_ind(struct hci_dev *hdev,
>> bdaddr_t *bdaddr); int l2cap_disconn_ind(struct hci_conn *hcon); int
>> l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16
>> flags);
>>
>> +#if IS_ENABLED(CONFIG_BT_BREDR)
>> int sco_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8
>> *flags); -int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff
>> *skb);
>> +void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb);
>> +#else static inline int sco_connect_ind(struct hci_dev *hdev,
>> +bdaddr_t *bdaddr,
>> +				  __u8 *flags)
>> +{
>> +	return 0;
>> +}
>> +
>> +static inline void sco_recv_scodata(struct hci_conn *hcon, struct
>> +sk_buff *skb) { } #endif
>>
>> /* ----- Inquiry cache ----- */
>> #define INQUIRY_CACHE_AGE_MAX   (HZ*30)   /* 30 seconds */
>> diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile index
>> 9a8ea23..29c12ae 100644
>> --- a/net/bluetooth/Makefile
>> +++ b/net/bluetooth/Makefile
>> @@ -12,9 +12,10 @@ obj-$(CONFIG_BT_6LOWPAN) += bluetooth_6lowpan.o
>> bluetooth_6lowpan-y := 6lowpan.o
>>
>> bluetooth-y := af_bluetooth.o hci_core.o hci_conn.o hci_event.o mgmt.o \
>> -	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o sco.o lib.o \
>> +	hci_sock.o hci_sysfs.o l2cap_core.o l2cap_sock.o smp.o lib.o \
>> 	a2mp.o amp.o ecc.o hci_request.o mgmt_util.o
>>
>> +bluetooth-$(CONFIG_BT_BREDR) += sco.o
>> bluetooth-$(CONFIG_BT_DEBUGFS) += hci_debugfs.o
>> bluetooth-$(CONFIG_BT_SELFTEST) += selftest.o
>>
>> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c index
>> 4322c83..f348383 100644
>> --- a/net/bluetooth/sco.c
>> +++ b/net/bluetooth/sco.c
>> @@ -1110,7 +1110,7 @@ static void sco_disconn_cfm(struct hci_conn *hcon,
>__u8 reason)
>> 	sco_conn_del(hcon, bt_to_errno(reason)); }
>>
>> -int sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
>> +void sco_recv_scodata(struct hci_conn *hcon, struct sk_buff *skb)
>> {
>
>I prefer that we do this change in a separate patch and do it for
sco_recv_scodata
>and also l2cap_recv_acldata. Since both are in the same boat here and
should be
>just fixed first.

Ok, I'll submit new patches for them.

Thanks
Arron

------=_NextPart_000_0128_01D0A2DA.158B5F10
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"

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
VMv3yxHO8jex40LgMIIFtDCCBJygAwIBAgITMwAAX4le2zD54Qv9OAAAAABfiTANBgkqhkiG9w0B
AQUFADB5MQswCQYDVQQGEwJVUzELMAkGA1UECBMCQ0ExFDASBgNVBAcTC1NhbnRhIENsYXJhMRow
GAYDVQQKExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMg
SXNzdWluZyBDQSA0QTAeFw0xNDEwMjIwMDI2MzZaFw0xNzEwMDYwMDI2MzZaMDsxFDASBgNVBAMT
C1dhbmcsIEFycm9uMSMwIQYJKoZIhvcNAQkBFhRhcnJvbi53YW5nQGludGVsLmNvbTCCASIwDQYJ
KoZIhvcNAQEBBQADggEPADCCAQoCggEBAIp2DPMnUYAGFnnjHHQHXOT0PUPWAPPWJWlHmcB6YN5/
1PWRH5jGKBmQMakAZLzLnREksomwY+jXeFgky22bs1L7/U0UlGvpzuGyKrJ4ZafKg5xXWrJqMdxC
ZkjaA1idQN8GRVgi16Y0thlsANseGPWnML960oODNX+hM0esKFb6H7227ZIahaPyT3rNfZMAP/eL
aVB2AqBnqXihO63OCZKQJCf+lOZ+O/cYPzpLFGcRuSSwMXw2c59D27QMXpCZ1Qu01GO4W/3a+fyZ
V7NKVI96yQaQ95brtHzKug11o6lmRXb2omihgg7IcvrrusNWI13RdQ46rq2SKyVX8NBrkPMCAwEA
AaOCAnEwggJtMEQGCSqGSIb3DQEJDwQ3MDUwDgYIKoZIhvcNAwICAgCAMA4GCCqGSIb3DQMEAgIA
gDAHBgUrDgMCBzAKBggqhkiG9w0DBzAdBgNVHQ4EFgQUGjkTqg2vQY5JCa0Q3QwAl04xjTswCwYD
VR0PBAQDAgeAMB8GA1UdIwQYMBaAFB5pKrTcKP5HGE4hCz+8rBEv8Jj1MGUGA1UdHwReMFwwWqBY
oFaGVGh0dHA6Ly93d3cuaW50ZWwuY29tL3JlcG9zaXRvcnkvQ1JML0ludGVsJTIwRXh0ZXJuYWwl
MjBCYXNpYyUyMElzc3VpbmclMjBDQSUyMDRBLmNybDCBnwYIKwYBBQUHAQEEgZIwgY8waQYIKwYB
BQUHMAKGXWh0dHA6Ly93d3cuaW50ZWwuY29tL3JlcG9zaXRvcnkvY2VydGlmaWNhdGVzL0ludGVs
JTIwRXh0ZXJuYWwlMjBCYXNpYyUyMElzc3VpbmclMjBDQSUyMDRBLmNydDAiBggrBgEFBQcwAYYW
aHR0cDovL29jc3AuaW50ZWwuY29tLzA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnl
UYP9gSiFjp9TgpHACWeB3r05lfBDAgFkAgEIMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3
CgMMMCkGCSsGAQQBgjcVCgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBFBgNVHREEPjA8
oCQGCisGAQQBgjcUAgOgFgwUYXJyb24ud2FuZ0BpbnRlbC5jb22BFGFycm9uLndhbmdAaW50ZWwu
Y29tMA0GCSqGSIb3DQEBBQUAA4IBAQC5WXyOvQf4uaZYY+cLIuZOyy5FKrCtOXdqSWbv3URr85mu
oM1mGhTjq5J/6CRF3Ncb/35c66iEh1VkxTsvccMOLLvmPvSeN9TlKYDZ5THRwl3FILtSWpitXfgd
u2Pxh0Ks5heGWgRu1yuXmdQufbnEi+1JrOFUjfSKp67KUUq38RALF0ms3y+p2Dlg79s8sWsN3T9R
Q+Tot/NkJsOEtc+o8WtvwF91s9cZYI1bRvOzgIzntgKOOYs0gtj/+VTvOGB+10aV6n3G++TWPkgQ
Zu6QIMDYEJduaSzgKw++qDOZLNQAVA5AkalcLQzaGYly87nGc0CejykfvTCAVxioeclZMIIFtTCC
BJ2gAwIBAgITMwAACNQ0VT2wmC4yAgAAAAAI1DANBgkqhkiG9w0BAQUFADB5MQswCQYDVQQGEwJV
UzELMAkGA1UECBMCQ0ExFDASBgNVBAcTC1NhbnRhIENsYXJhMRowGAYDVQQKExFJbnRlbCBDb3Jw
b3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMgSXNzdWluZyBDQSA0QjAeFw0x
NDEwMjIwMDI2NTlaFw0xNzEwMDYwMDI2NTlaMDsxFDASBgNVBAMTC1dhbmcsIEFycm9uMSMwIQYJ
KoZIhvcNAQkBFhRhcnJvbi53YW5nQGludGVsLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCC
AQoCggEBAMCBc7sZGTzt+lJ5qeDW7KV4Crxxf43Xttfs001pakIhcXfvQe5IFjPey/aJ1ZBRm6ce
SJ61e17CM1+U6M0D4dQfn8VsIky2YJWavq+6s21uFsxekFaNhj7ErohSs3bFiEp5icdDVlBjxyyh
gyDf+mpUkVkMDVk9FM8+lC9Avgg6iVEv2woUQnoJ4LWgZJOXxD9vZ7nKIIuBg0pcnobrphtNzDct
GUcpmwGkmH9VoIa8SPWV/ZrBvBLuzR8at3/qq/17qN42RXLy5SYcbTQszodUxwiAZ54cQYv59xjw
0AVDd5MdGf51VMvZkwDjeK8E/5204E79+iZudGifHIdrbq0CAwEAAaOCAnIwggJuMEQGCSqGSIb3
DQEJDwQ3MDUwDgYIKoZIhvcNAwICAgCAMA4GCCqGSIb3DQMEAgIAgDAHBgUrDgMCBzAKBggqhkiG
9w0DBzAdBgNVHQ4EFgQUlJx/5ddHMKhcOmUvBgLdndM4MZMwCwYDVR0PBAQDAgQwMB8GA1UdIwQY
MBaAFNpBI5xaj3GvV4M+INPjZdsMywvbMGUGA1UdHwReMFwwWqBYoFaGVGh0dHA6Ly93d3cuaW50
ZWwuY29tL3JlcG9zaXRvcnkvQ1JML0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMElzc3Vpbmcl
MjBDQSUyMDRCLmNybDCBnwYIKwYBBQUHAQEEgZIwgY8wIgYIKwYBBQUHMAGGFmh0dHA6Ly9vY3Nw
LmludGVsLmNvbS8waQYIKwYBBQUHMAKGXWh0dHA6Ly93d3cuaW50ZWwuY29tL3JlcG9zaXRvcnkv
Y2VydGlmaWNhdGVzL0ludGVsJTIwRXh0ZXJuYWwlMjBCYXNpYyUyMElzc3VpbmclMjBDQSUyMDRC
LmNydDA9BgkrBgEEAYI3FQcEMDAuBiYrBgEEAYI3FQiGw4x1hJnlUYP9gSiFjp9TgpHACWeEudlB
h4T/TgIBZAIBDTAfBgNVHSUEGDAWBggrBgEFBQcDBAYKKwYBBAGCNwoDBDApBgkrBgEEAYI3FQoE
HDAaMAoGCCsGAQUFBwMEMAwGCisGAQQBgjcKAwQwRQYDVR0RBD4wPKAkBgorBgEEAYI3FAIDoBYM
FGFycm9uLndhbmdAaW50ZWwuY29tgRRhcnJvbi53YW5nQGludGVsLmNvbTANBgkqhkiG9w0BAQUF
AAOCAQEAE36Pwz8Su4NAcv+3th5UKSMuuwSTSzYqge1NvPNG+910YbA6a6v/U4ETegBUCq7we1RQ
V/NVHuxmbo0We1NVQ5AwtoSNI46Go1PDITtk2JOhhGuecZlQP15FDNsPln+evOGWuK09nR2iSvme
e+rNVjCFrWB5eSHG48dSzeiL9DPm56spHjoL6xFsVLfi3WJxCWhh/yLis/vk6IUZuMBC/cd8LK29
4DG5i/X/txLaqQBzuHb+wsIgr9VzoW4WEGQA4j8my1MGqkp4+F/GoaMijlPdmrAZ5ogggex7W6Tu
s/O6xdip56Qxb2KONK31EQEZcopcJUVUsoyt7OKIipdbFTGCA9cwggPTAgEBMIGQMHkxCzAJBgNV
BAYTAlVTMQswCQYDVQQIEwJDQTEUMBIGA1UEBxMLU2FudGEgQ2xhcmExGjAYBgNVBAoTEUludGVs
IENvcnBvcmF0aW9uMSswKQYDVQQDEyJJbnRlbCBFeHRlcm5hbCBCYXNpYyBJc3N1aW5nIENBIDRB
AhMzAABfiV7bMPnhC/04AAAAAF+JMAkGBSsOAwIaBQCgggIbMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE1MDYwOTA5MzExNFowIwYJKoZIhvcNAQkEMRYEFIY5+vMF
ILLuY8WySi5OzcOqaBeyMHIGCSqGSIb3DQEJDzFlMGMwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQB
FjAKBggqhkiG9w0DBzALBglghkgBZQMEAQIwBwYFKw4DAhowCwYJYIZIAWUDBAIDMAsGCWCGSAFl
AwQCAjALBglghkgBZQMEAgEwgaEGCSsGAQQBgjcQBDGBkzCBkDB5MQswCQYDVQQGEwJVUzELMAkG
A1UECBMCQ0ExFDASBgNVBAcTC1NhbnRhIENsYXJhMRowGAYDVQQKExFJbnRlbCBDb3Jwb3JhdGlv
bjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMgSXNzdWluZyBDQSA0QgITMwAACNQ0VT2w
mC4yAgAAAAAI1DCBowYLKoZIhvcNAQkQAgsxgZOggZAweTELMAkGA1UEBhMCVVMxCzAJBgNVBAgT
AkNBMRQwEgYDVQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMRSW50ZWwgQ29ycG9yYXRpb24xKzAp
BgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3VpbmcgQ0EgNEICEzMAAAjUNFU9sJguMgIA
AAAACNQwDQYJKoZIhvcNAQEBBQAEggEAFdfjGjn+X2yPJcTM00LBW2jlTId4Gm534fPFwfGfMWQg
GyCKGJ2ZvPGybldV7V21mNS5qVlyTv8gXoA6Ni48jH6Z+SILgYbyDkMCxVkNUCFEoGlE0ZXIwEgY
TLzBHJmXaHjLdxvesa57q50N65ulfanDYwJMVVftHJ0u0FU+kiQJUXpWwNAXTfqt/+LGD80Xd1Bd
z4lnpgDX145xWm01j6L2zRn5pKfar52xygcV8BuMtCzKoA3r/ohW8UryIpxN5tHQTqqVz/3ry6R5
HUTXyrF6qRSYs3o/tzVh0Xgzg/jYrDEKu/ln9NKL0euTEfzbHHnlkYXG/Y/4hjFzwADrBQAAAAAA
AA==

------=_NextPart_000_0128_01D0A2DA.158B5F10--
