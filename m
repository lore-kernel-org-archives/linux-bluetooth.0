Return-Path: <cyrus@holtmann.org>
Date: Wed, 10 Jun 2009 19:19:17 +0100 (BST)
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org,
	linux-input <linux-input@vger.kernel.org>
Subject: Re: Apple Bluetooth devices: Battery level?
In-Reply-To: <1244642769.2690.51.camel@cookie.hadess.net>
References: <1244384236.30768.5690.camel@cookie.hadess.net>  <alpine.LRH.2.00.0906081530330.31685@twin.jikos.cz> <1244642769.2690.51.camel@cookie.hadess.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1244657957.425041.1259.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 10 Jun 2009, Bastien Nocera wrote:

> Doesn't look very useful, and I have no idea what the 00ff.00c0 part
> does.

I found this:

http://www.opensource.apple.com/source/IOHIDFamily/IOHIDFamily-258.1/IOHIDFamily/AppleHIDUsageTables.h

which labels it as "Reserved MouseData" and it seems to be related to the
capacitance detectors. Run "hcidump -X" and place your fingers on the
mouse top without actually clicking then move the mouse slightly. You will
see 0x00 (no touching), 0x01 (left finger), 0x02 (right finger) and 0x03
(both fingers). I didn't see any other values.

I think the battery strength is found by polling with the feature report
id#71 but I don't know how you do that, libusb might be able to do it?

as I mentioned before, you will also get an input report id#42 sent before
the mouse dies (but that is not listed in the HID descriptor)

iain
