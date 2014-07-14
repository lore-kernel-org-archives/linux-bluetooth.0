Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: cmtp: Remove unnecessary null test
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20140714203412.GA16532@himangi-Dell>
Date: Mon, 14 Jul 2014 23:02:26 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Linux Bluetooth mailing list
	<linux-bluetooth@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>,
	linux-kernel@vger.kernel.org, julia.lawall@lip6.fr
Message-Id: <E909042B-4973-4601-92AD-07D948BBDA83@holtmann.org>
References: <20140714203412.GA16532@himangi-Dell>
To: Himangi Saraogi <himangi774@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Himangi,

> This patch removes the null test on ctrl. ctrl is initialized at the
> beginning of the function to &session->ctrl. Since session is
> dereferenced prior to the null test, session must be a valid pointer,
> and &session->ctrl cannot be null.
> 
> The following Coccinelle script is used for detecting the change:
> 
> @r@
> expression e,f;
> identifier g,y;
> statement S1,S2;
> @@
> 
> *e = &f->g
> <+...
> f->y
> ...+>
> *if (e != NULL || ...)
> S1 else S2
> 
> Signed-off-by: Himangi Saraogi <himangi774@gmail.com>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> ---
> net/bluetooth/cmtp/capi.c | 6 ------
> 1 file changed, 6 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

