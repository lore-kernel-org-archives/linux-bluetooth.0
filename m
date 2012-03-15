Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Mar 2012 15:54:00 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Correct CID endian notation
Message-ID: <20120315185400.GB3371@joana>
References: <1331301176-28650-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120315185124.GA3371@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120315185124.GA3371@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Gustavo Padovan <gustavo@padovan.org> [2012-03-15 15:51:24 -0300]:

> Hi Andrei,
> 
> * Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-03-09 15:52:56 +0200]:
> 
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > L2CAP channel id is used in host format in internal L2CAP code.
> > Fix sparse warnings about wrong endian conversion.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/l2cap_core.c |    4 ++--
> >  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> Acked-by: Gustavo Padovan <gustavo@padovan.org>

Humm, seems Johan already picked this one.

	Gustavo
