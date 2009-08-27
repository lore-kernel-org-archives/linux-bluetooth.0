Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1251309847.2950.96.camel@localhost.localdomain>
References: <113d36d80908260307g59eead24v9311d612c8541ad0@mail.gmail.com>
	 <1251309847.2950.96.camel@localhost.localdomain>
Date: Thu, 27 Aug 2009 23:33:47 +0800
Message-ID: <113d36d80908270833q4eb7b4eg8d512fdd34e6ca83@mail.gmail.com>
Subject: Re: can we increase the send buffer size of rfcomm socket?
From: Lan Zhu <zhu.lan.cn@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2009/8/27 Marcel Holtmann <marcel@holtmann.org>:
> Hi Zhu,
>
>> We tried to write a 64k data to rfcomm socket, but it will break
>> before sending all of the data out. The problem is in function
>> rfcomm_sock_sendmsg() in net/bluetooth/rfcomm/sock.c, it breaks after
>> calling sock_alloc_send_skb().
>>
>> static int rfcomm_sock_sendmsg(...)
>> {
>> =A0 =A0...
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 skb =3D sock_alloc_send_skb(sk, size + RFCOM=
M_SKB_RESERVE,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msg->msg_fla=
gs & MSG_DONTWAIT, &err);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!skb)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0...
>> }
>>
>> Looks the send buffer is not adequate. Then I increased the send
>> buffer size in function rfcomm_sock_alloc(), =A0build kernel and try
>> again, this time the sendmsg can complete sending all the data.
>>
>> Can we use the setsockopt() method to change the socket's send/receive
>> buffer size, just like the usual =A0tcp/ip socket?
>
> yes we can. Send a patch for it and I am going to review it.
>
> Regards
>
> Marcel
>
>
>

Today I changed the send buffer size but found kernel become very
unstable. It usually crash during sending rfcomm data. Do you know
what's the reason?

Below is what I changed in net/bluetooth/rfcomm/sock.c.

in function rfcomm_sock_alloc(),

change sk->sndbuf
from
sk->sk_sndbuf =3D RFCOMM_MAX_CREDITS * RFCOMM_DEFAULT_MTU * 10
to
sk->sk_sndbuf =3D RFCOMM_MAX_CREDITS * RFCOMM_DEFAULT_MTU * 20

Thanks,
Zhu Lan
