Return-Path: <cyrus@holtmann.org>
Date: Fri, 25 May 2012 16:11:31 +0300
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv3 10/18] Bluetooth: A2MP: Process A2MP Discover Request
Message-ID: <20120525131129.GJ3089@aemeltch-MOBL1>
References: <1337351150-20526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337859508-32274-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1337859508-32274-11-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20120525121934.GA31623@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120525121934.GA31623@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Fri, May 25, 2012 at 09:19:34AM -0300, Gustavo Padovan wrote:
> Hi Andrei,
> 
> > +static int a2mp_discover_req(struct amp_mgr *mgr, struct sk_buff *skb,
> > +			     struct a2mp_cmd *hdr)
> > +{
> > +	struct a2mp_discov_req *req = (struct a2mp_discov_req *) skb->data;
> 
> Just use (void *) as cast here.

This actually does not matter but I can change it. This is pity that it
was not mentioned in the 20 previous reviews ;(

> > +	rsp->mtu = cpu_to_le16(L2CAP_A2MP_DEFAULT_MTU);
> 
> __constant_cpu_to_le16() here.

OK.

Best regards 
Andrei Emeltchenko 
