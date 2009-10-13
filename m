Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <113d36d80910090350k54db5688p6144ec4316b7c9ec@mail.gmail.com>
References: <113d36d80909262020y3dc487v880012747475a8e7@mail.gmail.com>
	 <1254200583.2659.82.camel@localhost.localdomain>
	 <113d36d80909290816g4065595ax1488ed014a11c7de@mail.gmail.com>
	 <113d36d80910090350k54db5688p6144ec4316b7c9ec@mail.gmail.com>
Date: Tue, 13 Oct 2009 10:13:18 +0800
Message-ID: <113d36d80910121913q38fc9edao658b284fc409ded6@mail.gmail.com>
Subject: Re: null pointer error in bluez kernel
From: Lan Zhu <zhu.lan.cn@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>
> Reproduce steps:
> 1. Pair and connect with Motorola S305 headset.
> 2. Disconnect and unpair with the headset.
> 3. Turn off and then turn on the headset. The headset will auto pair with=
 phone.
> 4. Input PIN code "0000" on the phone to complete the incoming pairing.
>
> Repeat step 2-4 for many times, then kernel panic may happen right
> after step 4.
>
> From the kernel log, I found if the bt_accept_unlink() is called
> before l2cap_conn_start(), then panic will happen because in the
> bt_accept_unlink() function it set parent to NULL.
>
> Below is the call order =A0when the result is successful. We can see the
> parent is not NULL.
>
> [ =A0190.162475] bt_accept_enqueue: parent ccda5298, sk cdb68920
> [ =A0190.170104] bt_accept_enqueue: parent ccda5d10, sk cdf5cd90
> [ =A0190.191223] l2cap_conn_start: conn cd14a320
> [ =A0190.218719] l2cap_conn_start: conn cd14a320
> [ =A0190.223480] l2cap_conn_start: @@@ in l2cap_conn_start --- sk =3D
> cdb68920, parent =3D ccda5298
> [ =A0190.235565] bt_accept_unlink: sk cdb68920 state 6
>
> Below is the call order when the result is kernel panic.
> bt_accept_unlink is called first, then we can see the parent is NULL.
>
> [ =A0238.188812] bt_accept_enqueue: parent ccda5298, sk ccf60040
> [ =A0238.196350] bt_accept_enqueue: parent ccda5d10, sk cdf5c960
> [ =A0238.217590] l2cap_conn_start: conn cd14a848
> [ =A0238.223449] bt_accept_unlink: sk ccf60040 state 6
> [ =A0238.229400] l2cap_sock_accept: new socket ccf60040
> [ =A0238.245086] l2cap_conn_start: conn cd14a848
> [ =A0238.249725] l2cap_conn_start: @@@ in l2cap_conn_start --- sk =3D
> ccf60040, parent =3D (null)
> [ =A0238.258636] Unable to handle kernel NULL pointer dereference at
> virtual address 00000120
> [ =A0238.267456] pgd =3D cdb34000
> [ =A0238.270446] [00000120] *pgd=3D8db32031, *pte=3D00000000, *ppte=3D000=
00000
> [ =A0238.277740] Internal error: Oops: 17 [#1] PREEMPT
>
>
> I think this might be a call competing issue, how do we fix it?
>

any idea for this issue?

Thanks,
Zhu Lan
