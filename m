Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCHes] Implement Bluetooth Wacom tablet's mode change in
 the kernel
From: Marcel Holtmann <marcel@holtmann.org>
To: Bastien Nocera <hadess@hadess.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input <linux-input@vger.kernel.org>,
	BlueZ development <linux-bluetooth@vger.kernel.org>,
	Jiri Kosina <jikos@jikos.cz>
In-Reply-To: <1263988051.1735.2474.camel@localhost.localdomain>
References: <1263988051.1735.2474.camel@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 Jan 2010 03:52:13 -0800
Message-ID: <1263988333.5591.205.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

> Here's a patch to do the Bluetooth Wacom tablet's mode setting in the
> kernel. In the past, it was done in a patch in bluetootd.
> 
> - 0001-hidp-Use-the-control-socket-for-raw-messages.patch
> 
> As discussed, now uses the ctrl channel for sending raw reports to the device.
> 
> - 0002-hid-wacom-Implement-Wacom-quirk-in-the-kernel.patch
> 
> Uses the above to poke at the device and turn it into mode2
> 
> - 0001-hid-sony-Fix-typo-in-error-message.patch
> 
> Small typo, for the input tree
> 
> - 0001-hid-Enable-Sixaxis-controller-over-Bluetooth-as-well.patch
> 
> Use the hidp patch above to enable the sixaxis controller

please send them one patch per email and send them inline. In case of
troubles just use git send-email.

Regards

Marcel


