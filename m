Return-Path: <cyrus@holtmann.org>
Date: Thu, 12 Apr 2012 11:00:14 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv6 06/26] Bluetooth: A2MP: Add chan callbacks
Message-ID: <20120412080012.GD5341@aemeltch-MOBL1>
References: <1332519246-16656-27-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1332941509-21345-7-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120406232025.GF2915@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120406232025.GF2915@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, Apr 06, 2012 at 08:20:25PM -0300, Gustavo Padovan wrote:
> > +static struct sk_buff *a2mp_chan_alloc_skb_cb(struct l2cap_chan *chan,
> > +					      unsigned long len, int nb,
> > +					      int *err)
> 
> See the patch I sent to the mailing list removing the err param.

Since I can compile my code I assume that the patch is not yet applied.

The other comments will be fixed.

Best regards 
Andrei Emeltchenko 

