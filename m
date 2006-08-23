Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44ECA22B.6050703@csr.com>
Date: Wed, 23 Aug 2006 19:44:59 +0100
From: Steven Singer <steven.singer@csr.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <000f01c6c59e$67014940$9d0cc70a@dlh.st.com>	<1156226067.3956.57.camel@aeonflux.holtmann.net>
	<d23110170608221347p37bc87a5mbdd1271eaf7631c3@mail.gmail.com>
In-Reply-To: <d23110170608221347p37bc87a5mbdd1271eaf7631c3@mail.gmail.com>
Subject: Re: [Bluez-devel] Host Controller to Host Flow Control
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Ulisses Furquim wrote:
> I'm also still not sure when we should send the host number of
> completed packets command. The specification says this command must be
> sent after the buffers are freed on the host but I don't know if we
> have to be strict about this. :-)

Sending back the command gives a commitment to the chip that you will
be able to take another maximum size block of data. Sending the command
before this is true will lead to a disaster.

So, if you have only a finite amount of memory to hold data coming from
the chip, you need to have at least enough space in that memory to hold
the maximum amount of data the chip could send you at that point.

You need to worry about this most on resource limited systems. In
which case, you almost certainly want to preallocate the memory for
the receive so that you can guarantee that it will be available when
the packet arrives.

If you preallocate a static buffer then as soon as the data is passed
out of the buffer the space being held in that buffer by that message
can be freed. This is the earliest the command could be issued. This
works nicely with ring buffers and is the scenario the spec is thinking
of.

It's then a system problem to make sure that you can't take messages
out of that buffer and queue them for their recipients so fast that you
deplete the memory of the entire system. In this case you can put in
some flow control mechanism internally in your system and take messages
out of the static buffer only when flow control allows.

With a dynamic allocation strategy, you should really be sending back
the command once you've allocated enough memory to receive the next
packet from the chip. Again, this could involve a flow control interlock
with the rest of the system.

One strategy for flow control is for the final consumer of the message
to inform you that the message has been processed and at that point you
could allocate memory to hold a new from chip message and send the
command. Alternatively, you could put flow control between each layer of
the stack so that the stop indication gradually flows back from a
stalled layer until the host stops issuing flow control tokens to the
controller.

Implementing host controller to host flow control without also
implementing some flow control mechanism through the layers of your
stack (if necessary, all the way to the application) just pushes
any memory exhaustion issues to other points in the system.

On a big system (with multiple megabytes of memory free) this may not
be a significant issue. On a small embedded system where you need to
track to the kilobyte level, it can be.

Apart from avoiding a crash, the other issue of interest is bandwidth.
You want to make sure that the link from the controller never stalls.
To do this, you must make sure that the controller never runs out of
flow control tokens, that is, you want to return them in advance of
the controller running out. How much in advance depends on the
reaction time of the controller. I would have thought that provided
you're returning tokens, let's say, at least 5 ms and at least 2 tokens
before the controller will run out then it shouldn't stall. However,
if you can afford it, a much larger safety margin would be nicer.

It can be more efficient on bandwidth limited host transports (UART) to
return multiple tokens in a single command. This suggests that you
shouldn't queue up lots of commands each to free up one token. Ideally
you'd note that you needed to send a token, but not actually fill in the
command payload until the host transport was free to send the command. If
the transport were immediately free then you'd send just a single token
but if the transport were busy (say, sending a large data packet to the
controller) then you might be able to send multiple tokens in a single
command once the transport freed up.

One thing you may want to watch is whether the controller can track all
the tokens you give it. If it can't then it may be able to use just a
subset. I which case, if you're waiting for the number of outstanding
tokens to hit a watermark, you may find that flow control stops long
before that point because the controller has run out of resources to
track outstanding packets.

These are all advanced techniques. For the moment, it's probably
easiest just to send tokens as soon as they become available. Worry
about optimising it once it's working properly.

Don't forget that when a disconnection occurs, all outstanding
flow control tokens for that handle are returned implicitly.

	- Steven
-- 


To access the latest news from CSR copy this link into a web browser:  http://www.csr.com/email_sig.php

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
