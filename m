Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] Bluetooth: btusb: Apply Intel device configuration routine
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150508035946.0039963d@intel.com>
Date: Tue, 12 May 2015 17:05:21 +0200
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <0FCA425A-2499-4826-AB00-E7D6B215889F@holtmann.org>
References: <20150508035946.0039963d@intel.com>
To: Tedd Ho-Jeong An <tedd.an@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tedd,

> This patch adds support to apply the device configuration parameters
> (DDC) after firwmare downloading on Intel 8265 device.
> 
> This is optional configuration parameters and good to have.
> So, even if it fails to apply it, it is not necessary to fail the
> setup.
> 
> The file format is same as previous firmware patch (.bseq) and
> this is only applicable to Intel 8265 device.

my preference is actually to not use *.bseq files since they are generic HCI commands. We want to use a new *.ddc file format that just contains the parameters. I clearly prefer that over just sending HCI commands. What we have to do is to actually define a simple DDC file format that lets us include the key/param pairs.

Regards

Marcel

