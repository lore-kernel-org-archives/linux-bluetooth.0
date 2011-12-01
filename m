Return-Path: <cyrus@holtmann.org>
Message-ID: <1322738467.26198.26.camel@aeonflux>
Subject: RE: [RFCv0 0/3] AMP HCI interface from A2MP
From: Marcel Holtmann <marcel@holtmann.org>
To: Peter Krystad <pkrystad@codeaurora.org>
Cc: 'Emeltchenko Andrei' <Andrei.Emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Date: Thu, 01 Dec 2011 12:21:07 +0100
In-Reply-To: <000001ccaff1$1ee6c0c0$5cb44240$@org>
References: <1322661272-32027-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	 <1322663484.26198.16.camel@aeonflux> <20111130151820.GB5158@aemeltch-MOBL1>
	 <000001ccaff1$1ee6c0c0$5cb44240$@org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Peter,

> > > > The code adds AMP HCI commands from A2MP protocol. HCI events are handled
> > > > similar way as mgmt interface. amp_pending is a kind of copy of mgmt_pending.
> > >
> > > this is all kernel internal code with no interface to user space. I do
> > > not see the need for such a complex infrastructure. Can not just have
> > > proper callbacks or event callback table like with L2CAP. Or just
> > > something similar.
> > 
> > I see this as a simple callback. amp_pending is just keeping context of HCI
> > command we need to handle. I also included reference counting since we had
> > bad experience with l2cap and rfcomm.
> 
> There does have to be some way to carry the A2MP message context while performing
> local HCI operations to service the message. A2MP Get Remote Assoc requires multiple
> HCI commands with data accumulated between the commands before the response can be
> sent. 

I agree, but this amp_pending seems to be wrong. I talked about changing
the init handling and at the same time we might can apply this to the
A2MP handling.

Why not just set a bit in hdev->dev_flags or maybe even hcon->dev_flags
or something and based on that we do a nice async state machine that
sends the commands and results in calling back into A2MP core when its
finished.

That seems a bit simpler to me and more aligned in a way I wanna redo
the whole HCI command/event handling anyway. In addition we can just
expose these flags via debugfs as text and have a nice way of knowing
current states if something goes wrong.

> > > As far as I see it, we get an A2MP command over L2CAP fixed channel, we
> > > have to issue a HCI command or do some other task based on this and then
> > > respond to it. We only have one user of this first of all. And second of
> > > all, I think we can not really have pending A2MP commands anyway. This
> > > is pretty much one command at a time (per ACL link).
> 
> A2MP commands are serialized by the sender, so A2MP message context could be
> associated with the hci_conn for BR-EDR.

That is what I thought. Thanks for confirming. So using hcon->dev_flags
seems like a possible way to make this a lot simpler.

And if the sender misbehaves, we just reject that commands that way.
Testing a flag is always cheaper then iterating a list.

Regards

Marcel


