Return-Path: <cyrus@holtmann.org>
Message-ID: <1417012077.5928.11.camel@linux-0dmf.site>
Subject: Re: bluetooth related firmware loader spew on resume.
From: Oliver Neukum <oneukum@suse.de>
To: Takashi Iwai <tiwai@suse.de>
Cc: Marcel Holtmann <marcel@holtmann.org>, Dave Jones <davej@redhat.com>,
 Linux Kernel <linux-kernel@vger.kernel.org>, pgynther@google.com,
 linux-bluetooth@vger.kernel.org
Date: Wed, 26 Nov 2014 15:27:57 +0100
In-Reply-To: <s5htx1mvyo8.wl-tiwai@suse.de>
References: <20141111181228.GA27815@redhat.com>
	 <s5hsih7xmgg.wl-tiwai@suse.de>
	 <D19A9DA1-3706-4351-B2E9-25D5ABA662E7@holtmann.org>
	 <s5h7fyijqc9.wl-tiwai@suse.de> <1416996623.3171.7.camel@linux-0dmf.site>
	 <0E1D95E7-64D2-4BEA-AFAA-4B119838F24E@holtmann.org>
	 <s5htx1mvyo8.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2014-11-26 at 15:12 +0100, Takashi Iwai wrote:
> At Wed, 26 Nov 2014 23:05:20 +0900,
> Marcel Holtmann wrote:
> > 
> > Hi Oliver,
> > 
> > >> In order to paper over this, we may also remember the failing firmware
> > >> and avoid loading it.  This might be an easer way than the endless
> > >> fight against UMH race...
> > > 
> > > 
> > > the full fix would be to implement reset_resume() for btusb.
> > > It seems to me that setup() should be split in two methods,
> > > one to request the firmware from user space and the second
> > > to transfer it to the device. reset_resume() would just need
> > > to repeat the second operation.
> > 
> > so when you do hci_register_dev, then hdev->setup is only called once. I really mean only once per lifetime of the hci_dev. So you would need to unregister the hci_dev first before hdev->setup will ever be called again. So I am not sure this is actually the problem here. The problem here is entirely within request_firmware() unless of course we run through the USB probe handlers again. Which I do not see happening here.
> > 
> > And we have hdev->setup this way since normally the Bluetooth devices keep their firmware patches and not forget about them and suspend-resume cycles. If the USB device of course jumps of the bus during it then all bets are off anyway.
> 
> Usually you can avoid unnecessary rebinding when you provide a proper
> reset_resume callback.  I guess that's what Oliver suggested.

Yes, but even in reset_resume() you would need to redo the setup
part, as the device lost power. The basic problem of requesting
the firmware wouldn't be solved.

	Regards
		Oliver
