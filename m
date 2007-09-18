Return-Path: <Johan.Hedberg@nokia.com>
Date: Tue, 18 Sep 2007 12:09:12 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: Fabien Chevalier <fchevalier@silicom.fr>
Cc: Marcel Holtmann <marcel@holtmann.org>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: Re: [PATCH] Fix bogus avdtp error codes management
Message-ID: <20070918090912.GA15007@localhost>
References: <46EEBC41.80401@silicom.fr> <20070918081557.GA13401@localhost> <1190104027.5525.128.camel@aeonflux.holtmann.net> <46EF9302.50403@silicom.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46EF9302.50403@silicom.fr>
List-ID: <bluez-devel.lists.sourceforge.net>

On Tue, Sep 18, 2007, Fabien Chevalier wrote:
> As for the POLLOUT thing, i must say i'm confused..., and don't really 
> see the link with the patch :-(
> I guess it works already as the GIOChannels heavily rely on it.

GLib maps POLLOUT to G_IO_OUT, POLLHUP to G_IO_HUP, etc. I was saying
that to conform to how other socket types behave[1] the callback should
*not* be getting a HUP or ERR in this case but a OUT instead. As for
applying the patch, I'm fine with it even though it in essence is a
work-around for a kernel side problem. However, it's Marcel's call in
the end.

[1] I have yet to verify this but that's what the connect(2) manpage
implies (in the section about EINPROGRESS)

Johan
