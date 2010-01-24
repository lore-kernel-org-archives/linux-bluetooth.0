Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/1] add configurable support for bridge forward delay
From: Marcel Holtmann <marcel@holtmann.org>
To: Thomas Egerer <hakke_007@gmx.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4B5C6062.4030705@gmx.de>
References: <4B5C554D.4030702@gmx.de> <1264343316.11653.0.camel@violet>
	 <4B5C6062.4030705@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 24 Jan 2010 16:13:40 +0100
Message-ID: <1264346020.11653.1.camel@violet>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

> I get your point, but what's your suggestion? The ioctl is marked
> deprecated, too and the problem of setting the forward delay persists.
> Would it suffer your needs if I got rid of libsysfs in general and
> simply use the ioctl or is there a different replacement strategy you
> prefer?

if it has an ioctl, then use that one. I really don't understand why
everybody things ioctl are bad. They work just fine and are often
simpler to handle than sysfs files.

Regards

Marcel


