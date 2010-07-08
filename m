Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 1/1] Bluetooth: hidp: Add support for hidraw
 HIDIOCGFEATURE and HIDIOCSFEATURE
From: Marcel Holtmann <marcel@holtmann.org>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
Cc: David Miller <davem@davemloft.net>, ospite@studenti.unina.it,
	alan@signal11.us, jkosina@suse.cz, mdpoole@troilus.org,
	hadess@hadess.net, eric.dumazet@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
In-Reply-To: <AANLkTiktvYWdZmpQs_k7mJRqMCqgfhy1b0T8tX8emmtU@mail.gmail.com>
References: <1276467601-9066-1-git-send-email-alan@signal11.us>
	 <20100628131437.bde782b6.ospite@studenti.unina.it>
	 <20100629.001216.91341775.davem@davemloft.net>
	 <AANLkTiktvYWdZmpQs_k7mJRqMCqgfhy1b0T8tX8emmtU@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 08 Jul 2010 18:08:52 -0300
Message-ID: <1278623332.10421.71.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> >> On Sun, 13 Jun 2010 18:20:01 -0400
> >> Alan Ott <alan@signal11.us> wrote:
> >>
> >>> This patch adds support or getting and setting feature reports for bluetooth
> >>> HID devices from HIDRAW.
> >>>
> >>> Signed-off-by: Alan Ott <alan@signal11.us>
> >>> ---
> >>
> >> Ping.
> >
> > We effectively don't have a bluetooth maintainer at the current point
> > in time.  I've tried to let patches sit for a while hoping the listed
> > maintainer would do something, at least occaisionally, but that simply
> > isn't happening.
> > So I'll just pick patches up directly as I find time to review them,
> > but I have to warn that for me it's going to be done in a very low
> > priority way because I really don't find bluetooth all that exciting. :-)
> 
> This would be good. We have a backlog of bluetooth kernel patches
> waiting for several months.
> This takes too much time to return to them again and again...
> 
> Please keep this ML informed.

as soon as Ville is back from vacation, he should be helping out with
patch review and maintenance.

Regards

Marcel


