Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <gfpadovan@gmail.com>
Date: Mon, 2 Aug 2010 18:24:51 -0300
From: "Gustavo F. Padovan" <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Mat Martineau <mathewm@codeaurora.org>, linux-bluetooth@vger.kernel.org,
	rshaffer@codeaurora.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 3/8] Bluetooth:  Validate PSM values in calls to
 connect() and bind().
Message-ID: <20100802212451.GC20149@vigoh>
References: <1280776810-18213-1-git-send-email-mathewm@codeaurora.org>
 <1280776810-18213-4-git-send-email-mathewm@codeaurora.org>
 <1280777991.12579.39.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1280777991.12579.39.camel@localhost.localdomain>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

* Marcel Holtmann <marcel@holtmann.org> [2010-08-02 12:39:51 -0700]:

> Hi Mat,
> 
> > Signed-off-by: Mat Martineau <mathewm@codeaurora.org>
> > ---
> >  net/bluetooth/l2cap.c |   12 ++++++++++++
> >  1 files changed, 12 insertions(+), 0 deletions(-)
> > 
> > diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
> > index aed72f2..44bc6ee 100644
> > --- a/net/bluetooth/l2cap.c
> > +++ b/net/bluetooth/l2cap.c
> > @@ -1008,6 +1008,12 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
> >  		goto done;
> >  	}
> >  
> > +	/* If specified, PSM must be odd and lsb of upper byte must be 0 */
> > +	if (la.l2_psm && (__le16_to_cpu(la.l2_psm) & 0x0101) != 0x0001) {
> > +		err = -EINVAL;
> > +		goto done;
> > +	}
> > +
> 
> this was a nice feature of L2CAP in BlueZ actually ;)

And please add a commit message for this patch.


-- 
Gustavo F. Padovan
http://padovan.org
