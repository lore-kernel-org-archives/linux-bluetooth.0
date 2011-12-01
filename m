Return-Path: <cyrus@holtmann.org>
From: "Peter Krystad" <pkrystad@codeaurora.org>
To: "'Emeltchenko Andrei'" <Andrei.Emeltchenko.news@gmail.com>,
	"'Marcel Holtmann'" <marcel@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>
References: <1322661272-32027-1-git-send-email-Andrei.Emeltchenko.news@gmail.com> <1322663484.26198.16.camel@aeonflux> <20111130151820.GB5158@aemeltch-MOBL1>
In-Reply-To: <20111130151820.GB5158@aemeltch-MOBL1>
Subject: RE: [RFCv0 0/3] AMP HCI interface from A2MP
Date: Wed, 30 Nov 2011 22:19:00 -0800
Message-ID: <000001ccaff1$1ee6c0c0$5cb44240$@org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Andrei, Marcel

> Hi Marcel,
> > Hi Andrei,
> > > The code adds AMP HCI commands from A2MP protocol. HCI events are handled
> > > similar way as mgmt interface. amp_pending is a kind of copy of mgmt_pending.
> >
> > this is all kernel internal code with no interface to user space. I do
> > not see the need for such a complex infrastructure. Can not just have
> > proper callbacks or event callback table like with L2CAP. Or just
> > something similar.
> 
> I see this as a simple callback. amp_pending is just keeping context of HCI
> command we need to handle. I also included reference counting since we had
> bad experience with l2cap and rfcomm.

There does have to be some way to carry the A2MP message context while performing
local HCI operations to service the message. A2MP Get Remote Assoc requires multiple
HCI commands with data accumulated between the commands before the response can be
sent. 

> > As far as I see it, we get an A2MP command over L2CAP fixed channel, we
> > have to issue a HCI command or do some other task based on this and then
> > respond to it. We only have one user of this first of all. And second of
> > all, I think we can not really have pending A2MP commands anyway. This
> > is pretty much one command at a time (per ACL link).

A2MP commands are serialized by the sender, so A2MP message context could be
associated with the hci_conn for BR-EDR.

--Peter Krystad
  Employee of Qualcomm Innovation Center, Inc.
  Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum

> The picture "Figure 7.1: Overview MSC for physical link create/accept"
> BLUETOOTH SPECIFICATION Version 4.0 [Vol 5] page 49 of 60
> shows quite a lot of commands between A2MP messages, I feel that if we
> have just callback from HCI event to handle A2MP responses it might be
> difficult to sync them.
> 
> Best regards
> Andrei Emeltchenko
> 
> > If I am mistaken here, please correct here. It has been a while since I
> > read that specification.
> >
> > Regards
> >
> > Marcel
> >
> >
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
