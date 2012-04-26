Return-Path: <cyrus@holtmann.org>
Date: Thu, 26 Apr 2012 11:29:53 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv7 17/23] Bluetooth: A2MP: Manage incoming connections
Message-ID: <20120426082951.GD2659@aemeltch-MOBL1>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334920191-29308-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1334920191-29308-18-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120425195824.GC2781@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120425195824.GC2781@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Wed, Apr 25, 2012 at 04:58:25PM -0300, Gustavo Padovan wrote:
... 
> > @@ -4554,10 +4555,14 @@ static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk
> >  
> >  	chan = l2cap_get_chan_by_scid(conn, cid);
> >  	if (!chan) {
> > -		BT_DBG("unknown cid 0x%4.4x", cid);
> > -		/* Drop packet and return */
> > -		kfree_skb(skb);
> > -		return 0;
> > +		if (cid == L2CAP_CID_A2MP) {
> > +			chan = a2mp_channel_create(conn, skb);
> 
> This code should be inside l2cap_recv_frame. take a look there.

No, it shouldn't. We do not want to reimplement ERTM logic inside A2MP.

Best regards 
Andrei Emeltchenko 
