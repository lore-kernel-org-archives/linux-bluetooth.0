Return-Path: <cyrus@holtmann.org>
Date: Wed, 15 Aug 2012 12:57:23 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 4/4] Bluetooth: trivial: Use preferred method for NULL
 check
Message-ID: <20120815095721.GA5154@aemeltch-MOBL1>
References: <1344351906-27563-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1344351906-27563-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120815041655.GD3344@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120815041655.GD3344@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Aug 15, 2012 at 01:16:55AM -0300, Gustavo Padovan wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > 
> > Use standard bluetooth way to check NULL pointer !var instead of
> > var == NULL.
> > 
> > Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > ---
> >  net/bluetooth/af_bluetooth.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> I applied patches 2, 3 and 4 to bluetooth-next. Patch 1 needs rebase. Thanks.

Patches 1 and 3 needs patch from linux-next and wireless-testing

<------8<------------------------------------------------------------------
|  vsprintf: add %pMR for Bluetooth MAC address
|
|  author  Andrei Emeltchenko <andrei.emeltchenko@intel.com>
|          Mon, 30 Jul 2012 21:40:23 +0000 (14:40 -0700)
|  committer       Linus Torvalds <torvalds@linux-foundation.org>
|          Tue, 31 Jul 2012 00:25:14 +0000 (17:25 -0700)
|  Bluetooth uses mostly LE byte order which is reversed for visual
|  interpretation.  Currently in Bluetooth in use unsafe batostr function.
|
|  This is a slightly modified version of Joe's patch (sent Sat, Dec 4,
|  2010).
|
|  Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
|  Cc: Joe Perches <joe@perches.com>
|  Cc: Marcel Holtmann <marcel@holtmann.org>
|  Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
|  Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
|
<------8<------------------------------------------------------------------

which adds actual specifier.

Best regards 
Andrei Emeltchenko 
