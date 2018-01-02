Return-Path: <foo00@h08.hostsharing.net>
Date: Wed, 3 Jan 2018 00:36:48 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Frederic Danis <frederic.danis.oss@gmail.com>,
	Loic Poulain <loic.poulain@linaro.org>, Max Shavrick <mxms@me.com>,
	Leif Liddy <leif.liddy@gmail.com>,
	Daniel Roschka <danielroschka@phoenitydawn.de>,
	Ronald Tschalaer <ronald@innovation.ch>,
	"Peter Y. Chuang" <peteryuchuang@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 03/10] Bluetooth: hci_bcm: Enable runtime PM despite
 absence of IRQ
Message-ID: <20180102233648.GA15299@wunner.de>
References: <cover.1514916630.git.lukas@wunner.de>
 <36e7c22493235863c2ab9dd9d7aa382a3fc15675.1514916630.git.lukas@wunner.de>
 <ffd03fb7-6caa-8128-03ba-fc4cb63328ea@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ffd03fb7-6caa-8128-03ba-fc4cb63328ea@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jan 02, 2018 at 08:17:24PM +0100, Hans de Goede wrote:
> On 02-01-18 20:08, Lukas Wunner wrote:
> > Currently runtime PM is only enabled if a valid host wake IRQ was found.
> > 
> > However it is used in ways which seem unrelated to host wake:
> > E.g., runtime PM is used to force the Bluetooth device on for 5 sec
> > after a complete packet has been received.
> > 
> > Afford this functionality to devices which lack an IRQ by moving the
> > code to enable runtime PM from bcm_request_irq() to bcm_setup().
> 
> Hmm, this seems to not make much sense. If runtime_pm is not enabled
> (no host wake irq) then the device never runtime suspends, so there
> is no need to force the device on when we're sending / after a
> complete packet has been received.
> 
> That you give "after a complete packet has been received" as condition
> example illustrates nicely why I believe this commit is a bad idea,
> if say a bluetooth keyboard wants to send a keypress HID report after
> the runtime pm timeout has elapsed, how are we going to receive that
> report since we're runtime suspended and there is no host wake irq
> to tell us to wakeup the UART and enable receiving on it again?

The host UART on MacBooks apparently never runtime suspends, so this
couldn't have been observed during testing:

They use either 8250_lpss.c (which has no runtime PM callbacks)
or 8250_dw.c (which disables the clock during runtime suspend,
but the MacBooks use a fixed rate clock which can't be disabled).
Moreover intel_lpss_suspend() excludes the UART from being put
into reset.

But the objection is valid so I withdraw this patch.

On MacBooks the host wake pin is ORed with the wake pin of the trackpad
and keyboard and goes into the SMC.  I think it is only meant to be
used to wake the system from sleep and not to provide an interrupt
at runtime.  In theory we could request the SMC's GPE but we couldn't
tell if the interrupt was sent by the trackpad/keyboard or by the
Bluetooth controller, or was caused by something else entirely.

So it's probably better not to use runtime PM at all.  Let me rework
patch [10/10] and remove this hunk:

+	/* Macs wire the host wake pin to the System Management Controller,
+	 * which handles wakeup independently of the operating system.
+	 */
+	if (x86_apple_machine) {
+		err = 0;
+		goto unlock;
+	}
+

I notice that command 0xfc27 is used to write the sleep_params.
Does anyone know the command to read them so that we can check the
defaults Apple is using and find out if they can be optimized?


> I don't see how runtime pm can work without a host-wake IRQ,
> so IMHO this commit is wrong. Tip when testing this, make sure
> that you don't have the bluetooth config panel of e.g. gnome3
> open as that continuously scans for new devices, so runtime pm
> never kicks in. I've had a bad configured host IRQ pin on some
> ASUS laptops using serdev bcm bt and the only way a bt keyboard
> would work reliable was to keep the config panel open...

I don't have one of these MacBooks, I'm submitting patches on
behalf of others, but I'm told that having the gnome panel open
leads to choppy audio on these machines.  Is that normal?
The Bluetooth controllers are fixed to a baudrate of 3 Mbit
on these machines.

Thanks,

Lukas
