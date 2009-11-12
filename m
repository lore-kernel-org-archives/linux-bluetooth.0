Return-Path: <cyrus@holtmann.org>
Message-ID: <4AFC05BD.40508@gmx.de>
Date: Thu, 12 Nov 2009 13:55:25 +0100
From: Susanne Goldammer <susanne.goldammer@gmx.de>
Reply-To: Susanne Goldammer <susanne.goldammer@gmx.de>
MIME-Version: 1.0
To: Stefan Seyfried <stefan.seyfried@googlemail.com>
CC: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: Re: Make bluetoothd start w/o SDP Server
References: <4AF9721B.3010405@gmx.de>	<1257861916.10888.1372.camel@localhost.localdomain>	<4AF97659.2050807@gmx.de>	<4AFBD3B6.6020706@gmx.de> <20091112131357.1106213e@strolchi.home.s3e.de>
In-Reply-To: <20091112131357.1106213e@strolchi.home.s3e.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi seife ;)

thanks a lot for your comments. I will change and provide the patch for
4.57 without the debian extensions, soon.

FYI: I made the patch with 4.51 cause i had errors with bluetooth usb
devices which where no longer initialized correctly when plugged in.
This happened after upgrading to ubuntu karmic and bluez 4.57.

With bluez 4.51 everything works fine.


