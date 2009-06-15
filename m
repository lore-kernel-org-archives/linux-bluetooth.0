Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1244796365.448636.603.nullmailer@galant.ukfsn.org>
References: <35c90d960905191429x1c3b6104qca2a672d50f0364c@mail.gmail.com>
	<35c90d960906111724w4794b40aw1c51d64586ecaeb6@mail.gmail.com>
	<1244796365.448636.603.nullmailer@galant.ukfsn.org>
From: Nick Pelly <npelly@google.com>
Date: Mon, 15 Jun 2009 14:20:43 -0700
Message-ID: <35c90d960906151420l1805b5f6j78d4a8172874104e@mail.gmail.com>
Subject: Re: Expected behavior of shutdown() in multi-threaded socket
	programming
To: Iain Hibbert <plunky@rya-online.net>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 12, 2009 at 1:46 AM, Iain Hibbert<plunky@rya-online.net> wrote:
> On Thu, 11 Jun 2009, Nick Pelly wrote:
>
>> Any comments on this one? I would like to correct the behavior of
>> shutdown() on AF_BLUETOOTH sockets, but I have been advised by Marcel
>> Holtmann that we need to agree on the correct behavior first.
>>
>> How should shutdown() behave when other threads are blocked on the same =
socket?
>
> IMHO consistency should apply.
>
> The opengroup specification for shutdown() says
>
> =A0"The shutdown() function shall cause all or part of a full-duplex
> =A0connection on the socket associated with the file descriptor socket to
> =A0be shut down."
>
> and while that does not really cover the case when the socket is blocked
> in accept(), if all the other socket types abort the block then that is
> what the PF_BLUETOOTH sockets should do too.
>
> The opengroup specification for accept() suggests EINVAL would be returne=
d
> if the socket was not accepting connections and arguably that is the case
> after a shutdown(), though ECONNABORTED could be used too (your program
> displays ECONNABORTED on NetBSD for instance)
>
>> I also have similar results for other blocking syscalls such as
>> connect(), read(), write(), poll() etc, but the test program is not as
>> simple.
>
> They should all handle the shutdown().

Sounds good to me.

Thanks for the input.

Nick
