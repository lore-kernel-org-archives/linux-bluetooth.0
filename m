Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <35c90d960905191429x1c3b6104qca2a672d50f0364c@mail.gmail.com>
References: <35c90d960905191429x1c3b6104qca2a672d50f0364c@mail.gmail.com>
From: Nick Pelly <npelly@google.com>
Date: Thu, 11 Jun 2009 17:24:21 -0700
Message-ID: <35c90d960906111724w4794b40aw1c51d64586ecaeb6@mail.gmail.com>
Subject: Re: Expected behavior of shutdown() in multi-threaded socket
	programming
To: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	davem@davemloft.net
Content-Type: text/plain; charset=ISO-8859-1
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Any comments on this one? I would like to correct the behavior of
shutdown() on AF_BLUETOOTH sockets, but I have been advised by Marcel
Holtmann that we need to agree on the correct behavior first.

How should shutdown() behave when other threads are blocked on the same socket?

More detail in the original mail below.

Thanks,
Nick

On Tue, May 19, 2009 at 2:29 PM, Nick Pelly<npelly@google.com> wrote:
> Hi,
>
> I am interested in the expected behavior of shutdown() on a socket
> that is also blocked on connect(), accept(), read(), write(), poll()
> or select() in another thread.
>
> For example:
>
> THREAD 1
> fd = socket()
> listen(fd)
> bind(fd)
> accept(fd)  <--- blocks
>
> THREAD 2
> shutdown(fd)  <--- what is meant to happen to accept() in thread 1?
>
> If thread 2 is run after thread 1, what should happen to the blocked
> accept() call when shutdown() is called in thread 2?
>
>
> My observations are that
> TCP sockets: accept() immediately returns with errno EINVAL
> unix domain sockets: accept() immediately returns with return errno EINVAL
> RFCOMM sockets: accept() continues to block
> L2CAP sockets: accept() continues to block
>
> I tested on 2.6.18, 2.6.28 and 2.6.29 and results were the same.
>
> Included is a sample program sock_shutdown_test.c that can easily
> exhibit this behavior. For example
> sock_shutdown_test unix accept_shutdown  # accept() returns
> sock_shutdown_test tcp accept_shutdown   # accept() returns
> sock_shutdown_test rfcomm accept_shutdown   # accept() blocks forever
> sock_shutdown_test l2cap accept_shutdown   # accept() blocks forever
>
> I also have similar results for other blocking syscalls such as
> connect(), read(), write(), poll() etc, but the test program is not as
> simple.
>
> So my question is: What is the correct behavior for sockets here?
>
>
> It is desirable for Android that shutdown() to force other threads
> blocked on that socket to return. In fact, if they don't it makes
> multi-threaded socket programming very hard since there is no other
> simple way to abort a blocked I/O operation. We have to resort to
> using poll() in combination with a selfpipe that we can write a byte
> to in order to abort the poll(). But this is quite inefficient as it
> triples the number of fd's needed for every socket not to mention the
> 4k buffer space needed in the kernel for the selfpipe. A global
> selfpipe per process is an improvement but it is quite messy getting
> this correct without race conditions.
>
>
> Input as to the correct behavior is appreciated,
> Nick
>
