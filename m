Return-Path: <cyrus@holtmann.org>
Subject: Re: False negative checking for SSP support
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1244919968.11069.4360.camel@localhost.localdomain>
References: <1244919968.11069.4360.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 13 Jun 2009 21:36:53 +0200
Message-Id: <1244921813.1852.2.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> I'm slowly adding SSP 2.1 support to gnome-bluetooth. For that, I got a
> laptop running Fedora 11, with a Bluetooth 2.1 dongle, in addition to
> the one in the machine I'm trying to pair from.
> 
> Is there any reason why the other machine shows up as not supporting
> SSP, when it actually does?
> 
> We already handle that case in the wizard, but it would be nicer if it
> did detect it.

it could be an older kernel or some other detail. Did you check with
hciconfig hci0 sspmode that it is enabled on both sides? You can
manually disable it (actually bluetoothd has to manually enable it).

We might also have a bug in LegacyPairing property. Could be that it is
not working correctly. Can you post dumps and further details.

Regards

Marcel


