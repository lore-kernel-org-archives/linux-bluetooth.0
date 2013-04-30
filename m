Return-Path: <cyrus@holtmann.org>
Date: Tue, 30 Apr 2013 20:53:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 04/13] Bluetooth: Fix LE vs BR/EDR selection when
 connecting
Message-ID: <20130430175353.GA29666@x220.P-661HNU-F1>
References: <1367253345-12482-1-git-send-email-johan.hedberg@gmail.com>
 <1367253345-12482-5-git-send-email-johan.hedberg@gmail.com>
 <20130430173619.GA19710@samus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130430173619.GA19710@samus>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Tue, Apr 30, 2013, Vinicius Costa Gomes wrote:
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -1792,7 +1792,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
> >  
> >  	auth_type = l2cap_get_auth_type(chan);
> >  
> > -	if (chan->dcid == L2CAP_CID_ATT)
> > +	if (bdaddr_type_is_le(dst_type))
> 
> Wouldn't this break applications that rely on the CID for making a LE 
> connection?

An application that wants to make an LE connection but doesn't provide
an LE address type in the l2_bdaddr_type member of sockaddr_l2 is
broken.

Johan
