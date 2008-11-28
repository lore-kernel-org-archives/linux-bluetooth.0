Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Nov 2008 18:14:35 +0100
From: Stefan Seyfried <seife@suse.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Bastien Nocera <hadess@hadess.net>,
	BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Move PIN codes to an external database
Message-ID: <20081128171435.GC15589@suse.de>
References: <1227886615.26649.1181.camel@cookie.hadess.net> <1227887446.19071.1.camel@violet.holtmann.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1227887446.19071.1.camel@violet.holtmann.net>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Nov 28, 2008 at 04:50:46PM +0100, Marcel Holtmann wrote:
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

Hopefully some day Tom will port his kde4 stuff to BlueZ-4, then it will be
nice if we have one global database, not one per project.
-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out." 

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
