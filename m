Return-Path: <cyrus@holtmann.org>
Message-ID: <51DD1897.5020408@mentor.com>
Date: Wed, 10 Jul 2013 09:17:27 +0100
From: Dean Jenkins <Dean_Jenkins@mentor.com>
MIME-Version: 1.0
To: Gianluca Anzolin <gianluca@sottospazio.it>
CC: marcel@holtmann.org, gustavo@padovan.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/2] Fix tty refcounting in rfcomm/tty.c
References: <20130709170502.GA32765@debian.seek.priv>
In-Reply-To: <20130709170502.GA32765@debian.seek.priv>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gianluca,

On 09/07/13 18:05, Gianluca Anzolin wrote:
> In net/bluetooth/rfcomm/tty.c the struct tty is used without proper
> refcounting. This leads to OOPS and panics triggered by the tty layer functions
> which are invoked after the struct tty has already been destroyed.
>
> This happens for example when the bluetooth connection is lost because the host
> goes down unexpectedly.
>
> The fix uses the tty_port_* helpers already in place.
>
> This patch depends on patch "Fix refcount leak in tty_port.c" already sent to
> linux-kernel. [0]
>
> Signed-off-by: Gianluca Anzolin <gianluca@sottospazio.it>
>
> [0] http://lkml.indiana.edu/hypermail/linux/kernel/1307.1/00600.html
>

Do you have any backtraces of the OOPS and panics ?

In which kernel did you discover the failure ?

What platform were you using, I mean x86, ARM or something else ?

Is this failure easy to reproduce ?

Did you use Bluez userland to control Bluetooth ?

In the failure case, what protocol or application was bound to the 
RFCOMM TTY ? I mean was it SLIP, minicom or something else ?

Thanks,

Regards,
Dean Jenkins
Mentor Graphics
