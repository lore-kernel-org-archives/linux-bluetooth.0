Return-Path: <cyrus@holtmann.org>
Date: Fri, 5 Jul 2013 12:41:37 +0800
From: Adam Lee <adam.lee@canonical.com>
To: Yang Bai <hamo.by@gmail.com>, linux-bluetooth@vger.kernel.org,
	Wen-chien Jesse Sung <jesse.sung@canonical.com>,
	AceLan Kao <acelan.kao@canonical.com>,
	Tedd Ho-Jeong An <tedd.an@intel.com>,
	Anthony Wong' <anthony.wong@canonical.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] btusb: fix overflow return values
Message-ID: <20130705044137.GB10744@adam-laptop>
References: <1372941783-30657-1-git-send-email-adam.lee@canonical.com>
 <CAO_0yfOXfO1ZNTNbYRnuY-CQ44hH+DqoEB5jnCwfhLPTq-RUqQ@mail.gmail.com>
 <20130705025947.GA10744@adam-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20130705025947.GA10744@adam-laptop>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jul 05, 2013 at 10:59:47AM +0800, Adam Lee wrote:
> On Fri, Jul 05, 2013 at 10:37:07AM +0800, Yang Bai wrote:
> > The return value of btusb_setup_intel is compared with 0. Code as:
> > 
> > drivers/bluetooth/btusb.c:
> > static int btusb_probe(struct usb_interface *intf,
> > const struct usb_device_id *id)
> > if (id->driver_info & BTUSB_INTEL)
> > hdev->setup = btusb_setup_intel;
> > 
> > net/bluetooth/hci_core.c:
> > int hci_dev_open(__u16 dev)
> > if (hdev->setup && test_bit(HCI_SETUP, &hdev->dev_flags))
> > ret = hdev->setup(hdev);
> > 
> > if (!ret) {
> 
> Yes, for btusb_setup_intel(), the return value is compared with number
> "0", doesn't break the judgement.
> 
> But it still overflows stack without this fix.

And what if the lower 32bits of PTR_ERR() are all "0"? :D

> > On Thu, Jul 4, 2013 at 8:43 PM, Adam Lee <adam.lee@canonical.com> wrote:
> > 
> >     PTR_ERR() returns a long type value, but btusb_setup_intel() and
> >     btusb_setup_intel_patching() should return an int type value.
> >
> >     This bug makes the judgement "if (ret < 0)" not working on x86_64
> >     architecture systems, leading to failure as below, even panic.

-- 
Regards,
Adam Lee
Hardware Enablement
