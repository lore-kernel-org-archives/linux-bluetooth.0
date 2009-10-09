Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <113d36d80909290816g4065595ax1488ed014a11c7de@mail.gmail.com>
References: <113d36d80909262020y3dc487v880012747475a8e7@mail.gmail.com>
	 <1254200583.2659.82.camel@localhost.localdomain>
	 <113d36d80909290816g4065595ax1488ed014a11c7de@mail.gmail.com>
Date: Fri, 9 Oct 2009 18:50:39 +0800
Message-ID: <113d36d80910090350k54db5688p6144ec4316b7c9ec@mail.gmail.com>
Subject: Re: null pointer error in bluez kernel
From: Lan Zhu <zhu.lan.cn@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

2009/9/29 Lan Zhu <zhu.lan.cn@gmail.com>:
> Hi,
>
> 2009/9/29 Marcel Holtmann <marcel@holtmann.org>:
>> Hi,
>>
>>> When we test Bluetooth "out of range" case, occasionally we got kernel
>>> panic result. From the panic log we can see it was caused by NULL
>>> point error.
>>>
>>> In one panic case, the NULL pointer happens at:
>>>
>>> " if (sk->sk_state == BT_CONNECTED)" in the function
>>> l2cap_sock_sendmsg() of l2cap.c
>>>
>>> In another panic case, the NULL pointer is at:
>>>
>>> "parent->sk_data_ready(parent, 0);" in the function l2cap_conn_start()
>>> of l2cap.c
>>>
>>> In a normal call sequence, these null pointer shall never happen,
>>> because it is already well considered. But it seems that the "out of
>>> range" test usually leads the unexpected call sequence which may
>>> randomly cause NULL pointer. Is there any way we can use to avoid the
>>> NULL pointer?
>>
>> what kernel version is this? Never had this problem since the link
>> supervision timeout should trigger a HCI Disconnect.
>>
>> Regards
>>
>> Marcel
>>
>>
>>
>
> The kernel version is 2.6.29.
>
> Thanks,
> Zhu Lan
>

I have caught the kernel log when the panic happened.

Reproduce steps:
1. Pair and connect with Motorola S305 headset.
2. Disconnect and unpair with the headset.
3. Turn off and then turn on the headset. The headset will auto pair with phone.
4. Input PIN code "0000" on the phone to complete the incoming pairing.

Repeat step 2-4 for many times, then kernel panic may happen right
after step 4.

>From the kernel log, I found if the bt_accept_unlink() is called
before l2cap_conn_start(), then panic will happen because in the
bt_accept_unlink() function it set parent to NULL.

Below is the call order  when the result is successful. We can see the
parent is not NULL.

[  190.162475] bt_accept_enqueue: parent ccda5298, sk cdb68920
[  190.170104] bt_accept_enqueue: parent ccda5d10, sk cdf5cd90
[  190.191223] l2cap_conn_start: conn cd14a320
[  190.218719] l2cap_conn_start: conn cd14a320
[  190.223480] l2cap_conn_start: @@@ in l2cap_conn_start --- sk =
cdb68920, parent = ccda5298
[  190.235565] bt_accept_unlink: sk cdb68920 state 6

Below is the call order when the result is kernel panic.
bt_accept_unlink is called first, then we can see the parent is NULL.

[  238.188812] bt_accept_enqueue: parent ccda5298, sk ccf60040
[  238.196350] bt_accept_enqueue: parent ccda5d10, sk cdf5c960
[  238.217590] l2cap_conn_start: conn cd14a848
[  238.223449] bt_accept_unlink: sk ccf60040 state 6
[  238.229400] l2cap_sock_accept: new socket ccf60040
[  238.245086] l2cap_conn_start: conn cd14a848
[  238.249725] l2cap_conn_start: @@@ in l2cap_conn_start --- sk =
ccf60040, parent = (null)
[  238.258636] Unable to handle kernel NULL pointer dereference at
virtual address 00000120
[  238.267456] pgd = cdb34000
[  238.270446] [00000120] *pgd=8db32031, *pte=00000000, *ppte=00000000
[  238.277740] Internal error: Oops: 17 [#1] PREEMPT


I think this might be a call competing issue, how do we fix it?

Thanks,
Zhu Lan
