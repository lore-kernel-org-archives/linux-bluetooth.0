Return-Path: <cyrus@holtmann.org>
Date: Mon, 19 Sep 2011 14:13:30 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 5/5] Bluetooth: EWS: prevent unneeded fragmentation in
 l2cap
Message-ID: <20110919171330.GA2643@joana>
References: <1315404314-12045-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1315404314-12045-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20110914035104.GN16856@joana>
 <20110916114308.GA25990@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110916114308.GA25990@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

* Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-09-16 14:43:17 +0300]:

> Hi Gustavo,
> 
> On Wed, Sep 14, 2011 at 12:51:04AM -0300, Gustavo Padovan wrote:
> > Hi Andrei,
> > 
> > * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-09-07 17:05:14 +0300]:
> > 
> > > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > 
> > > Calculate pdu length before creating I-frame. Otherwise if
> > > conn->mtu - (headers) < remote_mps we get fragmented packets in
> > > create_iframe_pdu function.
> > 
> > You might check the way we set the remote_mps, it seems you are not taking
> > that in account.
> 
> You are right, I was confused by magic "rfc.max_pdu_size =
> cpu_to_le16(chan->conn->mtu - 10)"
> 
> I will send new patch with fixes like the one below:
> 
> -               rfc.max_pdu_size    = cpu_to_le16(L2CAP_DEFAULT_MAX_PDU_SIZE);
> -               if (L2CAP_DEFAULT_MAX_PDU_SIZE > chan->conn->mtu - 10)
> -                       rfc.max_pdu_size = cpu_to_le16(chan->conn->mtu - 10);
> +
> +               rfc.max_pdu_size = cpu_to_le16(min_t(u16,
> +                                               L2CAP_DEFAULT_MAX_PDU_SIZE,
> +                                               chan->conn->mtu -
> +                                               L2CAP_EXTENDED_HDR_SIZE -
> +                                               L2CAP_SDULEN_SIZE -
> +                                               L2CAP_FCS_SIZE));

Then do this in two parts:

		size = min_t(...)
		rfc.max_pdu_size = cpu_to_le16(size);


	Gustavo
