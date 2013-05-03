Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <A060FC80-17F1-4666-B3CE-DA0B576D3A0D@holtmann.org>
References: <CAE6HaM=ogwUXRFM1+Pv-O9Cg0W3ueOpATMtU8kW2=D4Ghb93JA@mail.gmail.com>
	<20130503044355.GB3742@x220>
	<A060FC80-17F1-4666-B3CE-DA0B576D3A0D@holtmann.org>
Date: Fri, 3 May 2013 12:11:57 -0300
Message-ID: <CAE6HaM=tvfFn2d9WXqXVPX2y7HFkcvKL7xZES8qWSO2CyZS4-Q@mail.gmail.com>
Subject: Re: GATT Clients and Servers in the kernel (was Re:[PATCH BlueZ v3
 06/16] attrib...)
From: Vinicius Gomes <vinicius.gomes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Jefferson Delfes <jefferson.delfes@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Fri, May 3, 2013 at 3:17 AM, Marcel Holtmann <marcel@holtmann.org> wrote=
:
> Hi Johan,
>
>>>> the long term plan is to use standard types like bool, char, uint8_t
>>>> and also void * here. However we might want to also see how to get
>>>> rid of g_ prefix as well. Especially g_attrib seems to be a good
>>>> candidate to get rid of.
>>>>
>>>> I also like to see ATT and GATT being implemented as src/shared/
>>>> under LGPL so we can be easily share it in the future. I already
>>>> have some (unpublished) code for src/shared/att.[ch] and
>>>> src/shared/gatt.[ch] already, but I think what we first need to do
>>>> is to figure out how we handle clients and servers from the kernel
>>>> side. Especially with the background of the kernel auto-connecting
>>>> LE channels in the future.
>>>
>>> I am assuming you were talking about the connection establishment. If
>>> not, I am not following.
>>>
>>> I can only think of an evolutionary approach of what we are already
>>> doing:
>>>
>>> -  when we are the initiating side, the kernel will only auto-connect
>>> devices that have an associated socket blocking on connect(); the
>>> kernel may even use the white list if it seems appropriate (no
>>> resolvable addresses in the list of "to be connected" sockets for
>>> example).
>>
>> You'll need to sync up with Marcel regarding how this should be done
>> (I'll be effectively offline until next Tuesday so you wont be getting
>> more clarifications from me before that).
>>
>> I've never thought that doing tying connect() to the auto-connect
>> procedure is a good idea, and based on my last chat with Marcel a few
>> days ago he was agreeing. Having a pending connect() for potentially
>> days or even months is not really very intuitive compared to how
>> connect() is typically used. Instead, I think the ATT server socket
>> should always be the point of entry of new connections, regardless of
>> who is initiating. We'll then have a new mgmt command to add devices to
>> a kernel-side list, potentially along with the necessary scan
>> parameters, and the kernel will then do the passive scanning based on
>> that.
>
> that is still my thinking here. Essentially every LE connection will beco=
me an incoming connection. At least from the point of bluetoothd.
>
> The reasoning so far is pretty simple. The kernel needs to take control o=
ver the connect and auto-connect procedures. This means it has to figure ou=
t the right scanning parameters. No call to connect() will be able to provi=
de the right amount of parameters here anyway. And doing a connect() with a=
n infinite timeout seems the wrong approach.

I agree that we need a way to feed the kernel the connection
parameters and that a new mgmt command seems the best way. This
infinite timeout argument still doesn't convince me that it is the
wrong approach.

>
> So I think it is better for bluetoothd to just sit and only consume 1 fil=
e descriptor for the listen socket instead of 10 or more for keeping one fo=
r every connect() we are holding. Especially with cases where devices are r=
unning for month and only ever now and then they want to actually connect. =
This is especially important if the connection interval is actually handled=
 by the peripheral and we have no control.

This one is better, with multiple connect()s we would have a very low
"used coefficient" (rate of the number of active connection over the
number of waiting connections).

There's still the point that we will have to keep the connect() side
of things playing nicely with the rest. Having a half baked connect()
is wrong.

 So we would have two alternatives for establishing connections, the
"listen way" that would be used by applications that exptect a low
"used coefficient" (bluetoothd) and the "connect way" that would be
used by applications that expect to have a high "used coefficient"
(gatttool-like applications).

>
> Regards
>
> Marcel
>



--
Vinicius
