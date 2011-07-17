Return-Path: <cyrus@holtmann.org>
Date: Sun, 17 Jul 2011 12:46:31 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: David Miller <davem@davemloft.net>
Cc: padovan@profusion.mobi, netdev@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 0/2] Bluetooth: Fix regressions for 3.0
Message-ID: <20110717164631.GA18545@tuxdriver.com>
References: <1310790621-28510-1-git-send-email-padovan@profusion.mobi>
 <20110716.101518.1007939482226184514.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110716.101518.1007939482226184514.davem@davemloft.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Jul 16, 2011 at 10:15:18AM -0700, David Miller wrote:
> From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> Date: Sat, 16 Jul 2011 01:30:19 -0300
> 
> > From: "Gustavo F. Padovan" <padovan@profusion.mobi>
> > 
> > Gustavo F. Padovan (1):
> >   Bluetooth: Fix regression in L2CAP connection procedure
> > 
> > Ilia Kolomisnky (1):
> >   Bluetooth: Fix crash with incoming L2CAP connections
> > 
> >  net/bluetooth/l2cap_core.c |    9 +++++----
> >  1 files changed, 5 insertions(+), 4 deletions(-)
> 
> John I'm going to apply these directly so I can get them to
> Linus in time for 3.0-final.
> 
> Thanks Gustavo.

Yup, looks great -- thanks!

-- 
John W. Linville		Someday the world will need a hero, and you
linville@tuxdriver.com			might be all we have.  Be ready.
