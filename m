Return-Path: <cyrus@holtmann.org>
Date: Mon, 28 May 2012 14:39:45 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Steffen Becker <steffen.becker@tu-ilmenau.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: no security block - but connection still gets refused
Message-ID: <20120528173938.GA4151@samus>
References: <4FC35278.40903@tu-ilmenau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FC35278.40903@tu-ilmenau.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steffen,

On 12:24 Mon 28 May, Steffen Becker wrote:
> Hello Everyone,
> 
> I searched for an answer the whole last time, but I didn't gained
> any new information - so I hope you can help me to solve my problem.
> I have two gentoo-PCs with a Bluetooth3.0-Dongle at each PC.
> I have installed net-wireless/bluez with "test-programs" USE-Flag.
> I tried to connect them via
> # bluez-test-serial <remote address>
> and
> # bluez-test-network <remote address>
> 
> First important question:
> How do I have to use this commands? Are these "standalone" commands
> or do I have to use some "additional" command, e.g. some kind of
> "listen"-command at the remote device?

Short answer: something like it.

Long answer: For example, for network: the server side needs two pieces
of information from the user before it can be usable, a type of service
that the user wants to use (PAN, GN, NAP) and a bridge interface to
connect to. Usually, this is something that your connection manager
(ConnMan, Network Manager) does. See doc/network-api.txt (in the bluez
sources).

The serial service is similar, the user needs to inform the server which
serial port he wants to export via Bluetooth.

Those test scripts only have the client side of things.

> 
> Next big thing:
> I always got a "security block"-issue while tried to connect. I
> searched your mail-archive & you told me, this problem is solved in
> kernel 3.3 and later.
> I installed kernel 3.4 and - hooray - no "security block" anymore!
> *But* the connection still doesn't work. I connect them - they are
> connected for about 2 seconds - then connection is refused.
> So I really hope you can have a look at the following lines and tell
> me how to solve this problem.
> 
> PS:
> I'm sorry for wasting your time, but this case isn't "just for fun
> for me"; it's important that it works. So I even would donate/pay
> something if you can help me solve this problem.
> 
> Here is what I get when I use test-network:
> 
> # bluez-test-network 00:02:72:AE:58:73 NAP
> 
> Traceback (most recent call last):
>   File "/usr/bin/bluez-test-network", line 40, in <module>
>     device = adapter.FindDevice(address)
>   File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line
> 70, in __call__
>     return self._proxy_method(*args, **keywords)
>   File "/usr/lib64/python2.7/site-packages/dbus/proxies.py", line
> 145, in __call__
>     **keywords)
>   File "/usr/lib64/python2.7/site-packages/dbus/connection.py", line
> 651, in
> call_blocking
>     message, timeout)
> dbus.exceptions.DBusException: org.bluez.Error.DoesNotExist: Does Not Exist

>From this and the hcidump, the answer is that it could not find a
server running in the remote side (i.e. the SDP service search returned
nothing).


[snip]

> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Vinicius
