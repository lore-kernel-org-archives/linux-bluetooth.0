Return-Path: <cyrus@holtmann.org>
Message-ID: <48D29276.5060708@suse.de>
Date: Thu, 18 Sep 2008 19:40:06 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org,
	Bastien Nocera <hadess@hadess.net>,
	David Woodhouse <dwmw2@infradead.org>
Subject: Re: Packaging question
References: <48C685F1.9040905@suse.de>	 <1221084945.13336.31.camel@californication>  <48C8D96A.6060900@suse.de>	 <1221237288.6695.19.camel@californication>  <48D22F30.1060301@suse.de> <1221758180.6782.22.camel@californication>
In-Reply-To: <1221758180.6782.22.camel@californication>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel Holtmann wrote:
>> I had that old udev rule hack that would call the init script at adapter
>> plugin, but that's ugly and racy (because it typically starts before DBus is
>> started).
>>
>> Any innovative ideas?
> 
> we had the discussion for Fedora and we want to start it via udev,
> however then we need D-Bus before udev runs and that is not an option
> right now. So the current solution is to just do it via init.d, but in
> the future we want udev.

What about the old hack that I had back in the old days that would let hcid
wait until D-Bus came up? ;-) One problem with init.d is that the daemon is
running, even if there is no device plugged in...

> The D-Bus service activation is nice, but makes
> problems when you wanna use the mouse and keyboard early.

Yes, I already noticed that :)
-- 
Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG Nürnberg)
