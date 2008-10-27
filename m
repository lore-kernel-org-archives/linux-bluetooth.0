Return-Path: <cyrus@holtmann.org>
Date: Mon, 27 Oct 2008 16:14:06 -0400 (EDT)
From: "George F. Nemeyer" <tigerwolf@tigerden.com>
To: Marcel Holtmann <marcel@holtmann.org>
cc: linux-bluetooth@vger.kernel.org
Subject: Re: 4.16 Bluez compile failure
In-Reply-To: <1225136805.7157.29.camel@californication>
Message-ID: <Pine.LNX.4.53.0810271554490.18783@tiger.tigerden.com>
References: <Pine.LNX.4.53.0810260102170.14544@tiger.tigerden.com>
 <1225136805.7157.29.camel@californication>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, 27 Oct 2008, Marcel Holtmann wrote:

> you need a GLib version with g_timeout_add_seconds. So it seems that
> your version of GLib is just too old. Which version are you using?

glib-1.2.10-i386-2
glib2-2.12.10-i586-4vl58
glibc-2.3.6-i486-6
glibc-solibs-2.3.6-i486-6
glibc-i18n-2.3.6-noarch-6
glibc-zoneinfo-2.3.6-noarch-6

These are the latest currently available for this distribution.  It's
currently deployed across about 40 production machines.

Regards,

George Nemeyer
