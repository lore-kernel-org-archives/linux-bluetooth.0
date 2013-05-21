Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <41BA1C3C-C3B7-430C-8EAC-651DBDC5033B@holtmann.org>
References: <CAE6HaM=ogwUXRFM1+Pv-O9Cg0W3ueOpATMtU8kW2=D4Ghb93JA@mail.gmail.com>
	<20130503044355.GB3742@x220>
	<A060FC80-17F1-4666-B3CE-DA0B576D3A0D@holtmann.org>
	<CACJA=fV1ctv-D8FUccuYNN7obA_T7BQQMp-MyS+9ueYRUukxew@mail.gmail.com>
	<41BA1C3C-C3B7-430C-8EAC-651DBDC5033B@holtmann.org>
Date: Tue, 21 May 2013 16:05:10 -0300
Message-ID: <CACJA=fUGFOJOfzg-uC6sibT+=DZVQj_TZ3pk5RQJx+n6A+=8Hw@mail.gmail.com>
Subject: Re: GATT Clients and Servers in the kernel (was Re:[PATCH BlueZ v3
 06/16] attrib...)
From: Andre Guedes <andre.guedes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>, Vinicius Gomes <vinicius.gomes@openbossa.org>,
	Jefferson Delfes <jefferson.delfes@openbossa.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

Last week we did some brainstorming about the two LE connection
approaches. So far, the only drawback we see in this accept() approach
is that it requires at least three new mgmt LE-specific commands to
add, remove and clear the set of devices we want to connect to. IIRC,
we don't want commands LE-specific in Management Interface.

Also, during discussion, some questions were raised and we'd like to
share with the ML:

* What happens with connect()? What should it implement?

* How this approach integrates with peripheral role and advertising support=
?

BR,

Andre

On Fri, May 3, 2013 at 12:17 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Andre,
>
>>>>>> the long term plan is to use standard types like bool, char, uint8_t
>>>>>> and also void * here. However we might want to also see how to get
>>>>>> rid of g_ prefix as well. Especially g_attrib seems to be a good
>>>>>> candidate to get rid of.
>>>>>>
>>>>>> I also like to see ATT and GATT being implemented as src/shared/
>>>>>> under LGPL so we can be easily share it in the future. I already
>>>>>> have some (unpublished) code for src/shared/att.[ch] and
>>>>>> src/shared/gatt.[ch] already, but I think what we first need to do
>>>>>> is to figure out how we handle clients and servers from the kernel
>>>>>> side. Especially with the background of the kernel auto-connecting
>>>>>> LE channels in the future.
>>>>>
>>>>> I am assuming you were talking about the connection establishment. If
>>>>> not, I am not following.
>>>>>
>>>>> I can only think of an evolutionary approach of what we are already
>>>>> doing:
>>>>>
>>>>> -  when we are the initiating side, the kernel will only auto-connect
>>>>> devices that have an associated socket blocking on connect(); the
>>>>> kernel may even use the white list if it seems appropriate (no
>>>>> resolvable addresses in the list of "to be connected" sockets for
>>>>> example).
>>>>
>>>> You'll need to sync up with Marcel regarding how this should be done
>>>> (I'll be effectively offline until next Tuesday so you wont be getting
>>>> more clarifications from me before that).
>>>>
>>>> I've never thought that doing tying connect() to the auto-connect
>>>> procedure is a good idea, and based on my last chat with Marcel a few
>>>> days ago he was agreeing. Having a pending connect() for potentially
>>>> days or even months is not really very intuitive compared to how
>>>> connect() is typically used. Instead, I think the ATT server socket
>>>> should always be the point of entry of new connections, regardless of
>>>> who is initiating. We'll then have a new mgmt command to add devices t=
o
>>>> a kernel-side list, potentially along with the necessary scan
>>>> parameters, and the kernel will then do the passive scanning based on
>>>> that.
>>>
>>> that is still my thinking here. Essentially every LE connection will be=
come an incoming connection. At least from the point of bluetoothd.
>>>
>>> The reasoning so far is pretty simple. The kernel needs to take control=
 over the connect and auto-connect procedures. This means it has to figure =
out the right scanning parameters. No call to connect() will be able to pro=
vide the right amount of parameters here anyway. And doing a connect() with=
 an infinite timeout seems the wrong approach.
>>
>> Still in the connect() approach for the initiating side, what about if
>> we had a socket option to set up the connection parameters? The user
>> would call setsockopt() to provide the right connection parameters
>> (for this connection) and then call connect(). If there is more than
>> one LE connection attempt going on, the kernel chooses the set of
>> parameters (provided by each setsockopt()) which is more restrictive.
>>
>> This way, we wouldn't require a extra mgmt command and the whole LE
>> connection functionality would be confined in the socket interface
>> instead of a mix of socket and management interfaces.
>>
>> Regarding the connect() with no timeout, yes, I think it is a bit
>> weird too. However, it seems this is the way connection is handled by
>> the LE spec.
>
> please carefully read my statement about the number of file descriptors. =
All these file descriptors are backed by kernel sockets and its memory. Whi=
le you think 30 is not a lot, but this can easily increase.
>
> And how to you handle reboots for example. We would just load an initial =
set of settings into the kernel via one management command, but with connec=
t() we have to create x new sockets.
>
>>> So I think it is better for bluetoothd to just sit and only consume 1 f=
ile descriptor for the listen socket instead of 10 or more for keeping one =
for every connect() we are holding. Especially with cases where devices are=
 running for month and only ever now and then they want to actually connect=
. This is especially important if the connection interval is actually handl=
ed by the peripheral and we have no control.
>>
>> Following the server socket approach, let's say we have a BlueZ vs
>> BlueZ scenario (one the GATT server the other the GATT client). Both
>> (server and client) would call accept() to establish a connection.
>> This seems a weird usage of socket interface.
>
>
> Why are we thinking in GATT server and GATT client terms here. That is ju=
st wrong. Every single LE connection has a GATT client + server. The proced=
ures run in both directions. This is more about what services we expose.
>
> Regards
>
> Marcel
>
