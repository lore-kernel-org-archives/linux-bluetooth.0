Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1254200583.2659.82.camel@localhost.localdomain>
References: <113d36d80909262020y3dc487v880012747475a8e7@mail.gmail.com>
	 <1254200583.2659.82.camel@localhost.localdomain>
Date: Tue, 29 Sep 2009 23:16:37 +0800
Message-ID: <113d36d80909290816g4065595ax1488ed014a11c7de@mail.gmail.com>
Subject: Re: null pointer error in bluez kernel
From: Lan Zhu <zhu.lan.cn@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2009/9/29 Marcel Holtmann <marcel@holtmann.org>:
> Hi,
>
>> When we test Bluetooth "out of range" case, occasionally we got kernel
>> panic result. From the panic log we can see it was caused by NULL
>> point error.
>>
>> In one panic case, the NULL pointer happens at:
>>
>> " if (sk->sk_state == BT_CONNECTED)" in the function
>> l2cap_sock_sendmsg() of l2cap.c
>>
>> In another panic case, the NULL pointer is at:
>>
>> "parent->sk_data_ready(parent, 0);" in the function l2cap_conn_start()
>> of l2cap.c
>>
>> In a normal call sequence, these null pointer shall never happen,
>> because it is already well considered. But it seems that the "out of
>> range" test usually leads the unexpected call sequence which may
>> randomly cause NULL pointer. Is there any way we can use to avoid the
>> NULL pointer?
>
> what kernel version is this? Never had this problem since the link
> supervision timeout should trigger a HCI Disconnect.
>
> Regards
>
> Marcel
>
>
>

The kernel version is 2.6.29.

Thanks,
Zhu Lan
