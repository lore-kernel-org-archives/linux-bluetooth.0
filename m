Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oneukum@suse.de>
To: Jesse Sung <jesse.sung@canonical.com>
Subject: Re: [PATCH] Bluetooth: set reset_resume handler
Date: Tue, 25 Oct 2011 20:29:55 +0200
Cc: linux-bluetooth@vger.kernel.org, 812132@bugs.launchpad.net
References: <4EA67552.1090703@canonical.com> <201110251343.49236.oneukum@suse.de> <4EA6CC5B.2020400@canonical.com>
In-Reply-To: <4EA6CC5B.2020400@canonical.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201110252029.55900.oneukum@suse.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am Dienstag, 25. Oktober 2011, 16:48:59 schrieb Jesse Sung:

> Just tested file transferring. If there's no active connection, 
> everything goes fine. But if a file is transferring while going to S3, 
> bluetooth is not working after resume. Use applet to disable and 
> re-enable bluetooth makes it work again...
> 
> Wondering what is the right way to handle loss of power...

A virtual unplug/plug worked until now, even if it was inelegant.

	Regards
		Oliver
