Return-Path: <cyrus@holtmann.org>
Date: Sat, 13 Jun 2009 22:43:10 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: False negative checking for SSP support
Message-ID: <20090613194310.GA27600@jh-x301>
References: <1244919968.11069.4360.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1244919968.11069.4360.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Sat, Jun 13, 2009, Bastien Nocera wrote:
> I'm slowly adding SSP 2.1 support to gnome-bluetooth. For that, I got a
> laptop running Fedora 11, with a Bluetooth 2.1 dongle, in addition to
> the one in the machine I'm trying to pair from.
> 
> Is there any reason why the other machine shows up as not supporting
> SSP, when it actually does?

Do both of the machines support 2.1? The LegacyPairing property tells you
whether SSP is likely to be triggered or not when you try to pair. It
doesn't tell you whether other device supports SSP or not e.g. if your
local adapter is pre-2.1 (but if your local adapter is 2.1 capable the
property should be a good indicator of SSP support).

In theory it is possible to get a false positive for LegacyPairing if the
other device is 2.1 but for some reason has extended inquiry response
disabled (iirc the spec mandates EIR if SSP is enabled). However, if both
sides have bluez and 2.1 HW then both EIR and SSP should automatically be
get enabled by bluetoothd. If that's not happening we may have a bug
somewhere (which I haven't seen with any of my 2.1 adapters).

Johan
