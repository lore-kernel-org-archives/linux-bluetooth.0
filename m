Return-Path: <cyrus@holtmann.org>
Date: Sun, 5 Apr 2009 20:22:12 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Stuart Pook <linux-bluetooth4@pook.es>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez 4.34 + Linksys USBBT100 + hcitool scan -> core dump
Message-ID: <20090405172212.GB6612@jh-x301>
References: <49D89DCD.7090808@pook.es> <49D8E48A.2060807@pook.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49D8E48A.2060807@pook.es>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sun, Apr 05, 2009, Stuart Pook wrote:
> here I am replying to myself
>
> On 05/04/09 14:02, Stuart Pook wrote:
>> I tried it again with bluez 4.34 and now a simple "hcitool scan" makes 
>> bluetoothd core dump.
>
> I have just noticed that I've been getting kernel errors with all this
> plugging and unplugging of Bluetooth adapters.

I don't know about the kernel, but there's a known bug with 4.34 that can make
bluetoothd crash when unpluging/repluging adapters. This was fixed in git
already several days ago with commit 457056310229911e820357470ee8fb30c82516da
("Fix org.bluez.Audio unregistration") so you might want to try if it helps.

Johan
