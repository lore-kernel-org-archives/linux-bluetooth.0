Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Add udev mode to bluetoothd
From: Bastien Nocera <hadess@hadess.net>
To: Stefan Seyfried <seife@suse.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4A3211A3.2040203@suse.de>
References: <1244741895.11069.1319.camel@cookie.hadess.net>
	 <1244742638.27363.51.camel@violet> <4A320683.7000103@suse.de>
	 <4A3211A3.2040203@suse.de>
Content-Type: text/plain
Date: Fri, 12 Jun 2009 18:43:39 +0100
Message-Id: <1244828619.11069.2769.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, 2009-06-12 at 10:28 +0200, Stefan Seyfried wrote:
> Stefan Seyfried wrote:
> 
> > I had patches for waiting for the bus long time ago and can dig them out if
> > wanted.
> 
> Actually I quickly dug them out and adapted them to the current code.
> 
> I arbitrarily chose to stop waiting after 5 minutes. This timeout is certainly
>  a topic that might need to be discussed.

This patch won't work as part of the udev mode, as we don't daemonise
until we have a D-Bus connection. That would make udev hang for 5
minutes waiting for the helper to come back.

