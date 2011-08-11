Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH 0/3] RFC: prioritizing data over HCI
From: Marcel Holtmann <marcel@holtmann.org>
To: Mat Martineau <mathewm@codeaurora.org>
Cc: Gustavo Padovan <padovan@profusion.mobi>,
	Peter Hurley <peter@hurleysoftware.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, pkrystad@codeaurora.org
Date: Wed, 10 Aug 2011 17:18:18 -0700
In-Reply-To: <alpine.DEB.2.02.1108100942580.25878@mathewm-linux>
References: <1312377094-11285-1-git-send-email-luiz.dentz@gmail.com>
	 <alpine.DEB.2.02.1108040901420.13578@mathewm-linux>
	 <1312499377.2158.36.camel@THOR> <20110805191210.GA2537@joana>
	 <alpine.DEB.2.02.1108081628030.29183@mathewm-linux>
	 <20110809043210.GA2594@joana>
	 <alpine.DEB.2.02.1108100942580.25878@mathewm-linux>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1313021902.3373.130.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mat,

<snip>

> > So in the next step for ERTM we move the queue to L2CAP and create a callback
> > to call from HCI at the moment of push data to the baseband. The function in
> > L2CAP would set the last control bits in the first packet of the queue and
> > sent it through.
> 
> This actually causes some problems for ERTM, since skbs are cloned 
> before they are pushed to HCI.  skb data is not supposed to be 
> modified after cloning.
> 
> If there's a callback to L2CAP anyway, why not have L2CAP provide the 
> skb at that time instead of modifying data it provided earlier?
> 
> 
> > Then the queue can be split in two by adding a pointer that will mark which
> > element divides the queue between prio and normal. New prio skbs would just be
> > queued after this element and before the rest.
> 
> I think it's simpler and less bug-prone to just have two queues. 
> Either way, it's one more pointer.
> 
> However, I'm still not sure we want any queues in hci_chan.  It's not 
> very complicated to have the queue in the L2CAP layer, and gives ERTM 
> the control it needs.

I am fine if we just queue in L2CAP actually. Since nobody should send
ACL packets directly (besides the crazy people that wanna abuse BlueZ's
support for HCI_RAW for 3rd party stacks) anyway.

In a real fully integrated stack only L2CAP will send ACL data packets
and we can just rely on that fact if want to.

Regards

Marcel


