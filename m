Return-Path: <cyrus@holtmann.org>
Message-ID: <487F9160.20909@suse.de>
Date: Thu, 17 Jul 2008 20:37:20 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: nased0 <nased0@aster.pl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Bluez-utils-3.36 hidd daemon does not compile on Suse 11 x64
References: <1059545251.20080712172856@aster.pl>
In-Reply-To: <1059545251.20080712172856@aster.pl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

nased0 wrote:
> Suse 11 64-bit distribution does not have a hidd daemon file included,
> therefore its Bluetooth configurators only pretend to work.

I'd be interested in what you think is "only pretending to work". I don't want
to rule out a packaging flaw on my side, but at least for me it is working
fine with HID devices and rfcomm/dialup.

> I think that Suse 11 x64 distro developers were not able to
> compile is also.

I strongly object to that suspicion ;-)
It's not included on purpose, since it is obsoleted by input-service, as
Marcel already stated.

http://en.opensuse.org/Bluetooth might contain useful information to help you
set up your devices.

Have fun,

	Stefan
-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
