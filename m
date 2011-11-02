Return-Path: <cyrus@holtmann.org>
Date: Wed, 2 Nov 2011 10:03:01 +0200
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Al Cho <acho@suse.com>
Cc: marcel@holtmann.org, padovan@profusion.mobi,
	linux-bluetooth@vger.kernel.org, oneukum@suse.com, jlee@suse.com
Subject: Re: How to add firmware uploader function to Bluez?
Message-ID: <20111102080259.GB12653@aemeltch-MOBL1>
References: <CAKzePapHJwC2VMpjgS_uK=NCUPCEAQt5+zDSEqRJNdPth-Aztw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAKzePapHJwC2VMpjgS_uK=NCUPCEAQt5+zDSEqRJNdPth-Aztw@mail.gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi AL,

On Wed, Nov 02, 2011 at 03:55:50PM +0800, Al Cho wrote:
> Hi All,
> 
> Broadcom BT4.0 module 0a5c:21e1 and 0a5c:21e3 need firmware
> to setup(enable) at the first time we use.
> We got the firmware and firmware uploader (brcm_patchram_plus_usb )
> ( user space tool ) from Broadcom ,the Licence is GPLv2,
> would it possible that add those to bluez package?or any idea for this?

Should firmware come to linux-firmware package?

Description: Firmware for Linux kernel drivers
 This package provides firmware used by Linux kernel drivers.

Do not know about "firmware-loader", probably we need to use available tools.

Best regards 
Andrei Emeltchenko 
