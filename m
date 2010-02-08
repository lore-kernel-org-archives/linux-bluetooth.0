Return-Path: <cyrus@holtmann.org>
Subject: Re: Support for Belkin dongle
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Naulls <peter@chocky.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4B708725.5040804@chocky.org>
References: <4B708725.5040804@chocky.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 08 Feb 2010 23:23:30 +0100
Message-ID: <1265667810.31341.304.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

> I have a Belkin bluetooth dongle:
> 
> Bus 002 Device 005: ID 050d:0084 Belkin Components F8T003v2 Bluetooth
> 
> I believe this was supported in Linux long ago, but is no longer
> recognized.  The following patch seems sufficient against 2.6.32.7.
> 
> The device is found, but I have not tested it in any meaningful
> way.

I doubt it. Can you send content of /proc/bus/usb/devices for this
device and the output of hciconfig -a without this patch. I need to
verify that it is really needed.

Regards

Marcel


