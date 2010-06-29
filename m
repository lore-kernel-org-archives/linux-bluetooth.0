Return-Path: <cyrus@holtmann.org>
Date: Tue, 29 Jun 2010 12:07:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jiri Kosina <jkosina@suse.cz>
Cc: David Miller <davem@davemloft.net>, ospite@studenti.unina.it,
	alan@signal11.us, marcel@holtmann.org, mdpoole@troilus.org,
	hadess@hadess.net, eric.dumazet@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth: hidp: Add support for hidraw
 HIDIOCGFEATURE and HIDIOCSFEATURE
Message-ID: <20100629090742.GA2716@jh-x301>
References: <1276467601-9066-1-git-send-email-alan@signal11.us>
 <20100628131437.bde782b6.ospite@studenti.unina.it>
 <20100629.001216.91341775.davem@davemloft.net>
 <alpine.LNX.2.00.1006291047560.13809@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1006291047560.13809@pobox.suse.cz>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Jun 29, 2010, Jiri Kosina wrote:
> Frankly, I don't understand what exactly the current situation with 
> in-kernel bluetooth stack is anyway. 
> 
> What is the relation between what we have in net/bluetooth and the tree at 
> [1], which seems to be quite actively developed?

The difference is that the userspace part has essentially two
maintainers (me and Marcel) whereas the kernel side only has one
(Marcel). So even when Marcel is inactive I can at least take care of
the userspace side. I'd volunteer for the kernel also but I don't really
have any experience there (only 3-4 patches so far).

Johan
