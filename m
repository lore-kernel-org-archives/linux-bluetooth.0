Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Nov 2009 14:08:40 +0100
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: Susanne Goldammer <susanne.goldammer@gmx.de>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Make bluetoothd start w/o SDP Server
Message-ID: <20091112140840.1efa7475@strolchi.home.s3e.de>
In-Reply-To: <4AFC05BD.40508@gmx.de>
References: <4AF9721B.3010405@gmx.de>
	<1257861916.10888.1372.camel@localhost.localdomain>
	<4AF97659.2050807@gmx.de>
	<4AFBD3B6.6020706@gmx.de>
	<20091112131357.1106213e@strolchi.home.s3e.de>
	<4AFC05BD.40508@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Susanne,

On Thu, 12 Nov 2009 13:55:25 +0100
Susanne Goldammer <susanne.goldammer@gmx.de> wrote:

> Hi seife ;)
> 
> thanks a lot for your comments. I will change and provide the patch
> for 4.57 without the debian extensions, soon.

I guess that Marcel actually prefers patches against latest git if
possible, even though not much has changed since 4.57 _yet_ (and not in
the area you are touching).

> FYI: I made the patch with 4.51 cause i had errors with bluetooth usb
> devices which where no longer initialized correctly when plugged in.
> This happened after upgrading to ubuntu karmic and bluez 4.57.
> 
> With bluez 4.51 everything works fine.

That would warrant a bug report, separate from this issue ;)

Have fun,

	seife
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
