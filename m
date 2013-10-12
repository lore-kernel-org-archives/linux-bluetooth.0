Return-Path: <cyrus@holtmann.org>
Message-ID: <1381595148.21761.0.camel@nuvo>
Subject: Re: [PATCH] Allow using obexd without systemd in the user session
From: Bastien Nocera <hadess@hadess.net>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Giovanni Campagna <scampa.giovanni@gmail.com>,
 linux-bluetooth@vger.kernel.org, Giovanni Campagna <gcampagna@src.gnome.org>
Date: Sat, 12 Oct 2013 18:25:48 +0200
In-Reply-To: <0262656B-5656-422C-B12D-C6BF7239AA11@holtmann.org>
References: <1381592725-28212-1-git-send-email-scampa.giovanni@gmail.com>
	 <0262656B-5656-422C-B12D-C6BF7239AA11@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, 2013-10-12 at 18:08 +0200, Marcel Holtmann wrote:
> Hi Giovanni,
<snip>
> that is something your distro specific package should be fixing if
> that is needed. The focus is on integration with systemd and nothing
> else. You can use --disable-systemd and provide your own set of D-Bus
> service files.

There aren't any distributions that ship systemd for user sessions
though.
