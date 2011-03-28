Return-Path: <cyrus@holtmann.org>
From: Arnd Bergmann <arnd@arndb.de>
To: "Par-Gunnar HJALMDAHL" <par-gunnar.p.hjalmdahl@stericsson.com>
Subject: Re: [PATCH v2 2/2] mach-ux500: Add CG2900 devices
Date: Mon, 28 Mar 2011 16:47:48 +0200
Cc: Greg KH <gregkh@suse.de>,
 "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 Pavan Savoy <pavan_savoy@sify.com>,
 Vitaly Wool <vitalywool@gmail.com>,
 Alan Cox <alan@lxorguk.ukuu.org.uk>,
 Marcel Holtmann <marcel@holtmann.org>,
 Lukasz Rymanowski <Lukasz.Rymanowski@tieto.com>,
 Linus WALLEIJ <linus.walleij@stericsson.com>,
 "Par-Gunnar Hjalmdahl" <pghatwork@gmail.com>,
 Lee Jones <lee.jones@linaro.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>
References: <1301302992-10671-1-git-send-email-par-gunnar.p.hjalmdahl@stericsson.com> <20110328141237.GB19350@suse.de> <AFCDDB4A3EA003429EEF1E7B211FDBBA3377B51A1F@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <AFCDDB4A3EA003429EEF1E7B211FDBBA3377B51A1F@EXDCVYMBSTM005.EQ1STM.local>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201103281647.48802.arnd@arndb.de>
List-ID: <linux-bluetooth.vger.kernel.org>

On Monday 28 March 2011, Par-Gunnar HJALMDAHL wrote:
> But how should I then do this? As I understood it I was told that I should
> call an init function, but I was not allowed to add any staging folder
> inclusion in the board config makefile. And now I can't do any extern
> declaration either. I don't really see how I could do it then.
> 
> The only thing I can think of is to use platform device and driver for
> the cg2900_init. But I wouldn't call that to call an init-function, but that
> might be OK for this purpose?

There are at least two ways to do it:

* As Linus Walleij explained, use an initcall instead of calling a
  function from the board init code. "initcall" here refers to the
  interfaces from include/linux/init.h, e.g. module_init(). This
  will result in the function getting called at module load time,
  or at some point during bootup when it's built into the kernel.
  This initcall needs to check if you are running on the right board,
  using machine_is_xxx().

* As I explained, register a simple platform_device with the resources
  for the entire cg2900 device from the board code in a way that
  is independent of the actual driver. The driver code can then
  register all the subdevices from the cg2900_probe function.
  The code in the architecture would consist out of a single
  call to platform_device_register_simple() plus the resources.

Either way is fine with me.

	Arnd
