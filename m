Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/1] HID: Add full support for logitech Unifying
 receivers
From: Bastien Nocera <hadess@hadess.net>
To: Nestor Lopez Casado <nlopezcasad@logitech.com>
Cc: jkosina@suse.cz, linux-input@vger.kernel.org, xnlopez@gmail.com,
	rtitmuss@logitech.com, ogay@logitech.com,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Sat, 14 May 2011 21:10:46 +0100
In-Reply-To: <1305297084-10224-1-git-send-email-nlopezcasad@logitech.com>
References: <1305297084-10224-1-git-send-email-nlopezcasad@logitech.com>
Content-Type: text/plain; charset="ISO-8859-1"
Message-ID: <1305403852.2427.240.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-input-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hey Nestor,

On Fri, 2011-05-13 at 16:31 +0200, Nestor Lopez Casado wrote:
> With this driver, all the devices paired to a single Unifying receiver are exposed to user processes in separated /input/dev nodes.
> Keyboards with different layouts can be treated differently
> Multiplayer games on single PC (like home theater PC) can differentiate input coming from different kbds paired to the same receiver
> 
> Up to now, when Logitech Unifying receivers are connected to a Linux based system, a single keyboard and a single mouse are presented to
> the HID Layer, even if the Unifying receiver can pair up to six compatible devices. The Unifying receiver by default multiplexes all
> incoming events (from multiple keyboards/mice) into these two.

I'm very happy to see Logitech taking notice of Linux and helping out
support their devices better. I wanted to know whether you had any
information about switching those devices into HCI mode (Bluetooth), and
details for how one would read and write Bluetooth link keys, to make
sure that devices that worked through the "Unifying receiver" carry on
working in Bluetooth mode.

Cheers

