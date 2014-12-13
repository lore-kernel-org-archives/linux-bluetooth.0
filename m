Return-Path: <cyrus@holtmann.org>
Date: Fri, 12 Dec 2014 22:28:55 -0800
From: Tristan Lelong <tristan@lelong.xyz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	Tristan Lelong <tlelong@adeneo-embedded.us>
Subject: Re: [PATCH 2/2] bcsp: Change tx window size in configuration
Message-ID: <20141213062855.GB3058@localhost.localdomain>
References: <1418368478-13956-1-git-send-email-tristan@lelong.xyz>
 <1418368478-13956-3-git-send-email-tristan@lelong.xyz>
 <4DDEED41-D60D-47D0-9AB6-6FD43A0BCE0C@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4DDEED41-D60D-47D0-9AB6-6FD43A0BCE0C@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Dec 12, 2014 at 02:58:30PM +0100, Marcel Holtmann wrote:
Hi Marcel,

> > 
> > +config BT_HCIUART_BCSP_WINSIZE
> > +	int "BCSP reliable packet TX window size"
> > +	default 4
> > +	depends on BT_HCIUART_BCSP
> > +	help
> > +	  Defines the number of packets that can be sent before receiving a ACK.
> > +
> 
> I would prefer if we get a bit more help text here.
> 

Yes, I can make it a bit more explicit and descriptive.

> > 
> > -	if (bcsp->unack.qlen < BCSP_TXWINSIZE) {
> > +	if (bcsp->unack.qlen < CONFIG_BT_HCIUART_BCSP_WINSIZE) {
> > 		skb = skb_dequeue(&bcsp->rel);
> > 		if (skb != NULL) {
> > 			struct sk_buff *nskb = bcsp_prepare_pkt(bcsp, skb->data, skb->len,
> 
> This is fine with me, but we might also want to add a module parameter to allow changing it. If people want to play with it then they do not need to rebuild their module.
> 
> Another alternative is to provide an ioctl for changing it.

That makes sense, I think a parameter is a good solution, and if nobody shows any preference, I'll implement it this way.

Thanks
