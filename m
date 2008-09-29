Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez-gnome: how to turn adapter off?
From: Bastien Nocera <hadess@hadess.net>
To: Stefan Seyfried <seife@suse.de>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <48E0FB63.4000601@suse.de>
References: <48E0FB63.4000601@suse.de>
Content-Type: text/plain
Date: Mon, 29 Sep 2008 17:05:57 +0100
Message-Id: <1222704357.3311.87.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 2008-09-29 at 17:59 +0200, Stefan Seyfried wrote:
> Hi,
> 
> I now got several bugreports from people searching for the button to turn
> their bluetooth device off in the bluetooth-applet. I seem to remember that
> there was the setting "off" (in addition to "Hidden", "Always visible",
> "Temporary visible") in previous versions. So what's the rationale for
> removing it (users seem to expect to find it there)? And if I remember
> incorrectly: could we place such a button there?

There was never an "off" switch. There was:
- Other devices can connect
- Visible and connectable for other devices
- Limited discoverable and connectable

The last 2 were folded into a single option.

