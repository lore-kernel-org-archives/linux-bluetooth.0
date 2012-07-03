Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANT-zCUmB96Yu=Lij-wb+wOxjkhUP_X=RYeC5XjLio10q0Rbuw@mail.gmail.com>
References: <1340115637-2595-1-git-send-email-mikel.astiz.oss@gmail.com>
	<20120629132435.GB27007@x220>
	<CANT-zCUmB96Yu=Lij-wb+wOxjkhUP_X=RYeC5XjLio10q0Rbuw@mail.gmail.com>
Date: Tue, 3 Jul 2012 08:42:18 -0500
Message-ID: <CAB7rCTjwGwamcp83f=NH2WgM63iOt20uGi1YoF0B5kMA18yqnQ@mail.gmail.com>
Subject: Re: [RFC v0] Bluetooth: Fix lost socket error code
From: Mike <puffy.taco@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Jul 3, 2012 at 2:44 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> Hi Johan,
>
> On Fri, Jun 29, 2012 at 3:24 PM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
>> Hi Mikel,
>>
>> On Tue, Jun 19, 2012, Mikel Astiz wrote:
>>> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>>>
>>> Using sock_error() here to check the status of the socket is wrong
>>> because it resets sk->sk_err to zero. For RFCOMM sockets, this means the
>>> disconnect reason is not exposed to userland in the socket options.
>>>
>>> Signed-off-by: Mikel Astiz <mikel.astiz@bmw-carit.de>
>>> ---
>>> This a second attempt to expose ACL disconnect reason to userland, as proposed first in "[RFC v0] Bluetooth: mgmt: Add device disconnect reason".
>>>
>>> The motivation behind was explained in the userspace patchset "[RFC BlueZ v0 0/5] ACL disconnect reason".
>>>
>>> This second approach focuses on RFCOMM sockets given that L2CAP is already exposing such information.
>>>
>>>  net/bluetooth/af_bluetooth.c |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
>>> index f7db579..4799338 100644
>>> --- a/net/bluetooth/af_bluetooth.c
>>> +++ b/net/bluetooth/af_bluetooth.c
>>> @@ -313,7 +313,7 @@ int bt_sock_stream_recvmsg(struct kiocb *iocb, struct socket *sock,
>>>                       if (copied >= target)
>>>                               break;
>>>
>>> -                     err = sock_error(sk);
>>> +                     err = sk->sk_err;
>>>                       if (err)
>>>                               break;
>>>                       if (sk->sk_shutdown & RCV_SHUTDOWN)
>>
>> Looking at the implementation of sock_error (include/net/sock.h) This
>> should be:
>>
>>         err = -sk->sk_err;
>
> Right.
>
>> However, is this really needed if the error is returned for the write()
>> or read() that triggers it (through errno). And in the case of
>> POLLHUP/POLLERR there wont be any write/read that could clear the error
>> so you should be able to read it with getsockopt just fine. Am I missing
>> something?
>
> I don't actually get why rfcomm_sock_recvmsg() is being called, but
> that's what I experimentally see:
>
> [18985.546436] [73] rfcomm_l2data_ready:197: ffff880205613800 bytes 4
> [18985.546535] [21592] rfcomm_process_rx:1853: session
> ffff880230ccc9c0 state 1 qlen 1
> [18985.546546] [21592] rfcomm_recv_disc:1205: session ffff880230ccc9c0
> state 1 dlci 26
> [18985.546552] [21592] rfcomm_send_ua:773: ffff880230ccc9c0 dlci 26
> [18985.546558] [21592] rfcomm_send_cmd:750: ffff880230ccc9c0 cmd 115
> [18985.546563] [21592] rfcomm_send_frame:741: session ffff880230ccc9c0 len 4
> [18985.546591] [21592] __rfcomm_dlc_close:447: dlc ffff88016fe16500
> state 9 dlci 26 err 104 session ffff880230ccc9c0
> [18985.546597] [21592] rfcomm_dlc_clear_timer:286: dlc ffff88016fe16500 state 9
> [18985.546603] [21592] rfcomm_sk_state_change:71: dlc ffff88016fe16500
> state 9 err 104
>
> Here the error has been set.
>
> [18985.546628] [21592] rfcomm_dlc_unlink:351: dlc ffff88016fe16500
> refcnt 2 session ffff880230ccc9c0
> [18985.546635] [21592] rfcomm_session_set_timer:250: session
> ffff880230ccc9c0 state 1 timeout 2000
> [18985.546646] [21592] rfcomm_process_dlcs:1792: session
> ffff880230ccc9c0 state 1
> [18985.546701] [32724] bt_sock_stream_recvmsg:300: sk ffff880205615800 size 7768
>
> And here the error has been cleared.
>
> [18985.546780] [32724] rfcomm_sock_getsockopt:806: sk ffff880205615800
> [18985.546788] [32724] rfcomm_sock_getsockopt_old:742: sk ffff880205615800
> [18985.546791] [21576] rfcomm_sock_shutdown:882: sock
> ffff880136965180, sk ffff880205615800
> [18985.546799] [21576] __rfcomm_sock_close:209: sk ffff880205615800
> state 9 socket ffff880136965180
>
> My best guess would be that we don't shutdown the socket immediately
> after the error, and that's the reason why packets are still flowing
> around, but I can't really tell.
>
> In any case, using sock_error() to exit from bt_sock_stream_recvmsg()
> seems a bad idea. I would say it's buggy due to race conditions, since
> the socket option is temporarily set and then later cleared, don't you
> think?

Are you seeing this in reference to ofono?  I noticed that
gatchat/gatio.c, function received_data would try to do a read before
checking the condition that caused it to be called.  In this case, the
socket error would be correct at the beginning of the function, but
would no longer be correct by the time the function reaches the
condition check for G_IO_HUP as a read attempt occurs.

Mike
