Return-Path: <cyrus@holtmann.org>
Subject: Re: bluez-gnome: how to turn adapter off?
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Seyfried <seife@suse.de>
Cc: Bastien Nocera <hadess@hadess.net>, linux-bluetooth@vger.kernel.org
In-Reply-To: <48E1004F.20605@suse.de>
References: <48E0FB63.4000601@suse.de>
	 <1222704357.3311.87.camel@cookie.hadess.net>  <48E1004F.20605@suse.de>
Content-Type: text/plain
Date: Tue, 30 Sep 2008 01:43:08 +0200
Message-Id: <1222731788.1825.24.camel@violet.holtmann.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

> >> I now got several bugreports from people searching for the button to turn
> >> their bluetooth device off in the bluetooth-applet. I seem to remember that
> >> there was the setting "off" (in addition to "Hidden", "Always visible",
> >> "Temporary visible") in previous versions. So what's the rationale for
> >> removing it (users seem to expect to find it there)? And if I remember
> >> incorrectly: could we place such a button there?
> > 
> > There was never an "off" switch. There was:
> > - Other devices can connect
> > - Visible and connectable for other devices
> > - Limited discoverable and connectable
> > 
> > The last 2 were folded into a single option.
> 
> Ok, so I remembered wrong ;-) How about adding a "disable this adapter"
> option? Would a patch that implements this be welcome?

you might have been right, because some distros shipped a patch to add
an "off" selection to it. This wouldn't have done anything useful on the
desktop, but they did it without knowing what they are doing.

Regards

Marcel


