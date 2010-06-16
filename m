Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Adding support for bluetooth controller shipped with
 iMac i5
From: Marcel Holtmann <marcel@holtmann.org>
To: "Cyril Lacoux (Yack)" <clacoux@ifeelgood.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <201006161443.50587.clacoux@ifeelgood.org>
References: <201006161443.50587.clacoux@ifeelgood.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Jun 2010 15:33:29 +0200
Message-ID: <1276695209.2301.73.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> I recently bought an iMac i5 with bluetooth keyboard and mouse.
> 
> The bluetooth controller seems to be a BCM2046 (rebranded), but the 
> bDeviceClass is wrong.
> 
> Attached patch make it working on my system (Debian Sid / 2.6.34), could you 
> please apply it ?

please show the output of /proc/bus/usb/devices or usb-devices script
for this device.

And I want a proper kernel patch from git format-patch.

Regards

Marcel


