Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5910C04C-A52D-401A-A298-E7031A190B08@holtmann.org>
References: <1368725646-4593-1-git-send-email-frederic.dalleau@linux.intel.com>
	<1368725646-4593-7-git-send-email-frederic.dalleau@linux.intel.com>
	<5910C04C-A52D-401A-A298-E7031A190B08@holtmann.org>
Date: Fri, 17 May 2013 10:10:15 -0300
Message-ID: <CAE6HaMkGF9-GuVY2za_7yTMK2zAZMRzygg7jx9CSF2SGiAsz=w@mail.gmail.com>
Subject: Re: [PATCH v7 6/8] Bluetooth: Parameters for outgoing SCO connections
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: =?UTF-8?B?RnLDqWTDqXJpYyBEYWxsZWF1?= <frederic.dalleau@linux.intel.com>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, May 17, 2013 at 5:55 AM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Fred,
>
>> In order to establish a transparent SCO connection, the correct settings=
 must
>> be specified in the Setup Synchronous Connection request. For that,
>> voice_setting is added to ACL connection flags to set up the desired
>> parameters. If this value is zero, a legacy SCO connection will be reque=
sted.
>> This patch uses T2 settings.
>>
>> Signed-off-by: Fr=C3=A9d=C3=A9ric Dalleau <frederic.dalleau@linux.intel.=
com>
>> ---
>> include/net/bluetooth/hci_core.h |    1 +
>> net/bluetooth/hci_conn.c         |   22 ++++++++++++++++++----
>> 2 files changed, 19 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hc=
i_core.h
>> index a6fd544..b5996b3 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -320,6 +320,7 @@ struct hci_conn {
>>       __u32           passkey_notify;
>>       __u8            passkey_entered;
>>       __u16           disc_timeout;
>> +     __u16           setting;
>>       unsigned long   flags;
>>
>>       __u8            remote_cap;
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index d1d9919..cd7452e 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -185,13 +185,25 @@ void hci_setup_sync(struct hci_conn *conn, __u16 h=
andle)
>>       conn->attempt++;
>>
>>       cp.handle   =3D cpu_to_le16(handle);
>> -     cp.pkt_type =3D cpu_to_le16(conn->pkt_type);
>>
>>       cp.tx_bandwidth   =3D __constant_cpu_to_le32(0x00001f40);
>>       cp.rx_bandwidth   =3D __constant_cpu_to_le32(0x00001f40);
>> -     cp.max_latency    =3D __constant_cpu_to_le16(0xffff);
>> -     cp.voice_setting  =3D cpu_to_le16(hdev->voice_setting);
>> -     cp.retrans_effort =3D 0xff;
>
> same here. What are we doing with Add_SCO fallback on older controllers.
>
> We could just reject setting transparent air mode for controllers that do=
 not support eSCO command procedures. And the only valid option there would=
 be CVSD then. Which is default.

I have seem some controllers (IIRC CSR 2.0) that don't have eSCO but
have support for transparent air mode, in these cases we want to use
the Setup SCO/Accept SCO procedures.

>
> In case we use Add_SCO is is important that the voice setting programmed =
into the controller is actually 16-bit CVSD at that time. That needs to be =
taken care of as well.
>
> Regards
>
> Marcel
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Cheers,
--
Vinicius
