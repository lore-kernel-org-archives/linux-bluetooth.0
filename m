Return-Path: <cyrus@holtmann.org>
Message-ID: <1417011395.5928.4.camel@linux-0dmf.site>
Subject: Re: bluetooth related firmware loader spew on resume.
From: Oliver Neukum <oneukum@suse.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Takashi Iwai <tiwai@suse.de>, Dave Jones <davej@redhat.com>, Linux
 Kernel <linux-kernel@vger.kernel.org>, pgynther@google.com,
 linux-bluetooth@vger.kernel.org
Date: Wed, 26 Nov 2014 15:16:35 +0100
In-Reply-To: <0E1D95E7-64D2-4BEA-AFAA-4B119838F24E@holtmann.org>
References: <20141111181228.GA27815@redhat.com>
	 <s5hsih7xmgg.wl-tiwai@suse.de>
	 <D19A9DA1-3706-4351-B2E9-25D5ABA662E7@holtmann.org>
	 <s5h7fyijqc9.wl-tiwai@suse.de> <1416996623.3171.7.camel@linux-0dmf.site>
	 <0E1D95E7-64D2-4BEA-AFAA-4B119838F24E@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 2014-11-26 at 23:05 +0900, Marcel Holtmann wrote:
> Hi Oliver,
> 
> >> In order to paper over this, we may also remember the failing firmware
> >> and avoid loading it.  This might be an easer way than the endless
> >> fight against UMH race...
> > 
> > 
> > the full fix would be to implement reset_resume() for btusb.
> > It seems to me that setup() should be split in two methods,
> > one to request the firmware from user space and the second
> > to transfer it to the device. reset_resume() would just need
> > to repeat the second operation.
> 
> so when you do hci_register_dev, then hdev->setup is only called once. I really mean only once per lifetime of the hci_dev. So you would need to unregister the hci_dev first before hdev->setup will ever be called again. So I am not sure this is actually the problem here. The problem here is entirely within request_firmware() unless of course we run through the USB probe handlers again. Which I do not see happening here.

It seems most likely to me that probing is indeed done again.
btusb does not implement reset_resume(). If power goes away
as is usual on S3/4 the device is reenumerated. The original
trace has a call to btusb_setup_bcm_patchram().
What else could be happening?

	Regards
		Oliver
