Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Jul 2013 11:37:24 +0200
From: Gianluca Anzolin <gianluca@sottospazio.it>
To: Dean Jenkins <Dean_Jenkins@mentor.com>
Cc: marcel@holtmann.org, gustavo@padovan.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix tty refcounting in rfcomm/tty.c
Message-ID: <20130710093724.GA8829@debian.seek.priv>
References: <20130709170502.GA32765@debian.seek.priv>
 <51DD1897.5020408@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51DD1897.5020408@mentor.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, Jul 10, 2013 at 09:17:27AM +0100, Dean Jenkins wrote:
> Hi Gianluca,
> 
> On 09/07/13 18:05, Gianluca Anzolin wrote:
> >In net/bluetooth/rfcomm/tty.c the struct tty is used without proper
> >refcounting. This leads to OOPS and panics triggered by the tty layer functions
> >which are invoked after the struct tty has already been destroyed.
> >
> >This happens for example when the bluetooth connection is lost because the host
> >goes down unexpectedly.
> >
> >The fix uses the tty_port_* helpers already in place.
> >
> >This patch depends on patch "Fix refcount leak in tty_port.c" already sent to
> >linux-kernel. [0]
> >
> >Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
> >
> >[0] http://lkml.indiana.edu/hypermail/linux/kernel/1307.1/00600.html
> >
> 
> Do you have any backtraces of the OOPS and panics ?

Not at hand because when they happen I can't even sync to disk. I could take a
picture however maybe this evening.

> 
> In which kernel did you discover the failure ?

Linux kernel 3.10, but I see the issue is reproducible also on 3.9 because
other people reported it a while ago: have a look at this thread

http://marc.info/?t=136868685500006&r=1&w=2

Unfortunately that discussion died without results so I gave a look at the
code: the tty struct we were using died under us because it was missing
proper refcounting. So I fixed that problem with the first patch.

Then it turned out that also the tty_port structure didn't work as expected and
was destroyed while being used: the code manually checked for port.count
instead of relying on proper refcounting. That's what the 2nd patch is for.

It had a look at usb-serial.c and changed the code to mimic that behaviour. It
works for me reliably now, however it's better if someone with more knowledge
gives the patches a look.

> 
> What platform were you using, I mean x86, ARM or something else ?
> 
> Is this failure easy to reproduce ?

I'm seeing this on a x86_64 xeon cpu. It's very easy to reproduce, all you need
to do is to power off the bluetooth host you're communicating to while reading
from the tty device with some program, I use picocom for instance.

But the current code fails in many other ways: removing the device or releasing
the tty port with the port open for example.

> 
> Did you use Bluez userland to control Bluetooth ?

I'm using the bluez4 packages of ARCH linux:

blueman 1.23-10
bluez-libs 5.7-1
bluez-utils 5.7-1
bluez4 4.101-3

> 
> In the failure case, what protocol or application was bound to the
> RFCOMM TTY ? I mean was it SLIP, minicom or something else ?
> 

I was using picocom: picocom /dev/rfcomm0

> Thanks,
> 
> Regards,
> Dean Jenkins
> Mentor Graphics

Thank you for your reply :D

Gianluca
