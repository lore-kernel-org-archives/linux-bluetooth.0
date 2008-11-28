Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Move PIN codes to an external database
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1227887446.19071.1.camel@violet.holtmann.net>
References: <1227886615.26649.1181.camel@cookie.hadess.net>
	 <1227887446.19071.1.camel@violet.holtmann.net>
Content-Type: text/plain
Date: Fri, 28 Nov 2008 16:15:59 +0000
Message-Id: <1227888959.26649.1222.camel@cookie.hadess.net>
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2008-11-28 at 16:50 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > This is a patch to move the PIN quirks to an external tab-separated text
> > file. The parser is very simple and naive, but does the job for all the
> > devices I tested.
> > 
> > string_to_type() should probably be using an array instead of the
> > current code, and I've managed to move the current quirks to the
> > external file without a problem.
> > 
> > When this gets in, I'll work on moving all the quirks filed as bugs
> > against the wizard[1] into bluez-gnome proper.
> 
> should we not better store this in GConf?

GConf is a configuration database. This isn't configuration...
