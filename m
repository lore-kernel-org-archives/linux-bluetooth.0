Return-Path: <johan.hedberg@gmail.com>
Date: Sun, 25 Feb 2018 20:31:51 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@codecoup.pl>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Set auth method to just works for no mitm and
 displayonly
Message-ID: <20180225183151.GA14209@x1c.home>
References: <20180216133007.5224-1-grzegorz.kolodziejczyk@codecoup.pl>
 <97C7B48A-90EF-4327-8327-79F62358592F@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <97C7B48A-90EF-4327-8327-79F62358592F@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Feb 16, 2018, Marcel Holtmann wrote:
> > --- a/net/bluetooth/smp.c
> > +++ b/net/bluetooth/smp.c
> > @@ -893,7 +893,8 @@ static int tk_request(struct l2cap_conn *conn, u8 remote_oob, u8 auth,
> > 
> > 	/* Don't bother user space with no IO capabilities */
> > 	if (smp->method == JUST_CFM &&
> > -	    hcon->io_capability == HCI_IO_NO_INPUT_OUTPUT)
> > +	    (hcon->io_capability == HCI_IO_NO_INPUT_OUTPUT ||
> > +	    hcon->io_capability == HCI_IO_DISPLAY_ONLY))
> > 		smp->method = JUST_WORKS;
> 
> I leave this up to Johan to decide if this is our desired behavior or
> not, but if we go ahead with that, then the comment above also needs
> changing. And it also needs to be a more elaborate comment explaining
> the reasoning.

The change looks ok to me, however I agree that the code comment needs
updating. Grzegorz, please fix that and send a v2.

Johan
