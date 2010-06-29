Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jun 2010 10:50:24 +0200 (CEST)
From: Jiri Kosina <jkosina@suse.cz>
To: David Miller <davem@davemloft.net>
Cc: ospite@studenti.unina.it, alan@signal11.us, marcel@holtmann.org,
	mdpoole@troilus.org, hadess@hadess.net, eric.dumazet@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth: hidp: Add support for hidraw HIDIOCGFEATURE
 and HIDIOCSFEATURE
In-Reply-To: <20100629.001216.91341775.davem@davemloft.net>
Message-ID: <alpine.LNX.2.00.1006291047560.13809@pobox.suse.cz>
References: <1276467601-9066-1-git-send-email-alan@signal11.us> <20100628131437.bde782b6.ospite@studenti.unina.it> <20100629.001216.91341775.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 29 Jun 2010, David Miller wrote:

> >> This patch adds support or getting and setting feature reports for bluetooth
> >> HID devices from HIDRAW.
> >> 
> >> Signed-off-by: Alan Ott <alan@signal11.us>
> >> ---
> > 
> > Ping.
> 
> We effectively don't have a bluetooth maintainer at the current point in 
> time.  I've tried to let patches sit for a while hoping the listed 
> maintainer would do something, at least occaisionally, but that simply 
> isn't happening.

Frankly, I don't understand what exactly the current situation with 
in-kernel bluetooth stack is anyway. 

What is the relation between what we have in net/bluetooth and the tree at 
[1], which seems to be quite actively developed?

> So I'll just pick patches up directly as I find time to review them, but 
> I have to warn that for me it's going to be done in a very low priority 
> way because I really don't find bluetooth all that exciting. :-)

If needed, I can at least take over the net/bluetooth/hidp part, as I 
maintain the rest of the HID code anyway.

[1] http://git.kernel.org/?p=bluetooth/bluez.git;a=summary

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
