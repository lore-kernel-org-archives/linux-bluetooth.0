Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Adding support for bluetooth controller shipped with
 iMac i5
From: Marcel Holtmann <marcel@holtmann.org>
To: "Cyril Lacoux (Yack)" <clacoux@ifeelgood.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <201006162028.59280.clacoux@ifeelgood.org>
References: <201006161443.50587.clacoux@ifeelgood.org>
	 <1276695209.2301.73.camel@localhost.localdomain>
	 <201006162028.59280.clacoux@ifeelgood.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 18:05:33 -0300
Message-ID: <1278623133.10421.69.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> > please show the output of /proc/bus/usb/devices or usb-devices script
> > for this device.
> > 
> > And I want a proper kernel patch from git format-patch.
> 
> Ok, 
> 
> Here is the output of command `git format-patch -1 --stdout` against current 
> bluetooth-next-2.6 tree - hope that's ok.

please create a proper commit message and include the usb-devices output
in that message.

Also the HID part in the source code comment makes no sense. Why are you
using that one. Copy&paste from the previous one?

Regards

Marcel


