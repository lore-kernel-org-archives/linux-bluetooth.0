Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 May 2015 06:50:52 -0700
From: Tedd Ho-Jeong An <tedd.an@intel.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>, Johan Hedberg
 <johan.hedberg@gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Apply Intel device configuration
 routine
Message-ID: <20150509065052.7f713c5b@tedd-fedora-vm>
In-Reply-To: <0FCA425A-2499-4826-AB00-E7D6B215889F@holtmann.org>
References: <20150508035946.0039963d@intel.com>
	<0FCA425A-2499-4826-AB00-E7D6B215889F@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Tue, 12 May 2015 17:05:21 +0200
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Tedd,
> 
> > This patch adds support to apply the device configuration parameters
> > (DDC) after firwmare downloading on Intel 8265 device.
> > 
> > This is optional configuration parameters and good to have.
> > So, even if it fails to apply it, it is not necessary to fail the
> > setup.
> > 
> > The file format is same as previous firmware patch (.bseq) and
> > this is only applicable to Intel 8265 device.
> 
> my preference is actually to not use *.bseq files since they are generic HCI commands. We want to use a new *.ddc file format that just contains the parameters. I clearly prefer that over just sending HCI commands. What we have to do is to actually define a simple DDC file format that lets us include the key/param pairs.
> 

HCI command in .bseq is pretty simple to decode so extracting DDC contents (key/parmas) will not be a problem.
For DDC file, I think the simplest is [len] [key] [params] [len] [key] [params] ... in binary. So, the driver simpley read the full data and send with Intel_DDC_Write function.

Let me know if you have anything in your mind or any example in the other driver that I can refer.

> Regards
> 
> Marcel
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
