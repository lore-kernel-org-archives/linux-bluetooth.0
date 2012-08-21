Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Aug 2012 14:55:34 -0300
From: Gustavo Padovan <gustavo@padovan.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 4/4] Bluetooth: trivial: Use preferred method for NULL
 check
Message-ID: <20120821175534.GD17005@joana>
References: <1344351906-27563-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1344351906-27563-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120815041655.GD3344@joana>
 <20120815095721.GA5154@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120815095721.GA5154@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com> [2012-08-15 12:57:23 +0300]:

> Hi Gustavo,
> 
> On Wed, Aug 15, 2012 at 01:16:55AM -0300, Gustavo Padovan wrote:
> > > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > 
> > > Use standard bluetooth way to check NULL pointer !var instead of
> > > var == NULL.
> > > 
> > > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > ---
> > >  net/bluetooth/af_bluetooth.c |    4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > I applied patches 2, 3 and 4 to bluetooth-next. Patch 1 needs rebase. Thanks.
> 
> Patches 1 and 3 needs patch from linux-next and wireless-testing

I dropped them from the tree until this patch lands on bluetooth-next.

	Gustavo
