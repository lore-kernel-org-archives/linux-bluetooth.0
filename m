Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Jun 2012 11:01:51 +0800
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix checking the wrong flag when accepting a
 socket
Message-ID: <20120605030151.GA31260@x220>
References: <1338515619-7448-1-git-send-email-vinicius.gomes@openbossa.org>
 <20120601230052.GF24769@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120601230052.GF24769@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Jun 01, 2012, Gustavo Padovan wrote:
> * Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2012-05-31 22:53:39 -0300]:
> 
> > Most probably a typo, the check should have been for BT_SK_DEFER_SETUP
> > instead of BT_DEFER_SETUP (which right now only represents a socket
> > option).
> > 
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > ---
> >  net/bluetooth/af_bluetooth.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Patch has been applied to bluetooth-next. thanks.

This patch fixes accepting L2CAP and RFCOMM connections for sockets with
defer setup enabled (i.e. pretty much *all* sockets we have). This is
now broken in 3.5-rc1 so the patch should go with the highest priority
to the upstream trees. Furthermore, you said you applied it to
bluetooth-next but it's not there. What's going on?

Johan
