Return-Path: <cyrus@holtmann.org>
Date: Tue, 20 Sep 2011 09:28:19 +0300
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv1 5/5] Bluetooth: EWS: prevent unneeded fragmentation in
 l2cap
Message-ID: <20110920062816.GA28526@aemeltch-MOBL1>
References: <1315404314-12045-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1315404314-12045-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <20110914035104.GN16856@joana>
 <20110916114308.GA25990@aemeltch-MOBL1>
 <20110919171330.GA2643@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110919171330.GA2643@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Mon, Sep 19, 2011 at 02:13:30PM -0300, Gustavo Padovan wrote:
> > > * Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com> [2011-09-07 17:05:14 +0300]:
> > > 
> > > > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> > > > 
> > > > Calculate pdu length before creating I-frame. Otherwise if
> > > > conn->mtu - (headers) < remote_mps we get fragmented packets in
> > > > create_iframe_pdu function.
> > > 
> > > You might check the way we set the remote_mps, it seems you are not taking
> > > that in account.
> > 
> > You are right, I was confused by magic "rfc.max_pdu_size =
> > cpu_to_le16(chan->conn->mtu - 10)"
> > 
> > I will send new patch with fixes like the one below:
> > 
> > -               rfc.max_pdu_size    = cpu_to_le16(L2CAP_DEFAULT_MAX_PDU_SIZE);
> > -               if (L2CAP_DEFAULT_MAX_PDU_SIZE > chan->conn->mtu - 10)
> > -                       rfc.max_pdu_size = cpu_to_le16(chan->conn->mtu - 10);
> > +
> > +               rfc.max_pdu_size = cpu_to_le16(min_t(u16,
> > +                                               L2CAP_DEFAULT_MAX_PDU_SIZE,
> > +                                               chan->conn->mtu -
> > +                                               L2CAP_EXTENDED_HDR_SIZE -
> > +                                               L2CAP_SDULEN_SIZE -
> > +                                               L2CAP_FCS_SIZE));
> 
> Then do this in two parts:
> 
> 		size = min_t(...)
> 		rfc.max_pdu_size = cpu_to_le16(size);

This can be done, is this the only comment?

Best regards 
Andrei Emeltchenko 
