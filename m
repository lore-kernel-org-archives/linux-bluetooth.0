Return-Path: <cyrus@holtmann.org>
Subject: Re: resending patch to retry reset in case it failed
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-bluetooth@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <201008120944.49044.oneukum@suse.de>
References: <201008120944.49044.oneukum@suse.de>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 12 Aug 2010 07:25:23 -0400
Message-ID: <1281612323.12579.252.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> may I ask what happened to this patch?
> Do you take it, want modifications or reject it?
> 
> 	Regards
> 		Oliver
> 
> From af61f0663f095599003290b13ad6fadee1d4fb25 Mon Sep 17 00:00:00 2001
> From: Oliver Neukum <oliver@neukum.org>
> Date: Tue, 6 Jul 2010 08:08:42 +0200
> Subject: [PATCH] bluetooth: retry reset for devices that fail
> 
> Some devices fail to reset properly at the first attempt to reset
> them under unknown circumstances. Failures can be identified by
> an invalid btaddr. Retry in those cases.

I was pondering about it and haven't really made up my mind with this
stuff. To be honest, I don't like the patch a little bit. I can see your
point why you want it, but the patch is a bit too ugly for my taste.

Tell me which device is causing this and I might be able to reproduce
this and find small less ugly fix. Also keep in mind that the init
routine needs changing to accommodate AMP and LE devices. So we have to
be really careful here.

Regards

Marcel


