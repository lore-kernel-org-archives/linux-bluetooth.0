Return-Path: <cyrus@holtmann.org>
Message-ID: <1360225902.15783.9.camel@aeonflux>
Subject: Re: [PATCH 1/2] hostname: Fallback to static hostname if pretty
 hostname is not set
From: Marcel Holtmann <marcel@holtmann.org>
To: Szymon Janc <szymon@janc.net.pl>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 07 Feb 2013 10:31:42 +0200
In-Reply-To: <3769291.6MmiuAcpF2@athlon>
References: <1360098656-12488-1-git-send-email-szymon@janc.net.pl>
	 <1360136648.15783.3.camel@aeonflux> <3769291.6MmiuAcpF2@athlon>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Syzmon,

> > I am also not convinced that we should bother with the static hostname
> > at all. I left this out on purpose. My thinking here was that if we do
> > not have a pretty hostname, then why bother with trying to make
> > something useful out of the hostname, it would be ugly or wrong anyway.
> 
> Maybe not that fancy as pretty hostname but at least know to user(e.g for
> some reason my Fedora doesn't have pretty hostname set and falling back to 
> static hostname makes adapter name somewhat reasonable).
> Also falling back to static hostname will allow hostname plugin to number
> adapters' names. Yet, maybe main.conf parsing should be fixed instead to 
> properly substitute %h/%d as stated in comment. Currently name is simply set 
> to string '%h-%d' in such case...

I actually want to get rid of main.conf for default installs. And you
might have seen this already. We do not install it anymore. The defaults
should work as good as possible. Goal is to actually create stateless
systems without requiring /etc.

Regards

Marcel


