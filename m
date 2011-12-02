Return-Path: <cyrus@holtmann.org>
Date: Sat, 3 Dec 2011 08:33:23 +0900
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Remove magic numbers from le scan cmd
Message-ID: <20111202233323.GD13109@joana>
References: <1322662630-32759-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20111202115910.GE2570@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111202115910.GE2570@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Gustavo Padovan <padovan@profusion.mobi> [2011-12-02 20:59:10 +0900]:

> * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-11-30 16:17:10 +0200]:
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Make code readable by removing magic numbers.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  include/net/bluetooth/hci.h |    3 +++
> >  net/bluetooth/hci_event.c   |   12 ++++++++++--
> >  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> Applied, thanks.

I stepped back with this one to apply Andre's patches. Yours is trivial and
can wait a bit. Care to resend it?

	Gustavo
