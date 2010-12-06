Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Dec 2010 18:37:19 -0200
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Bluetooth: Add initial Bluetooth Management
 interface callbacks
Message-ID: <20101206203719.GG883@vigoh>
References: <1291573170-3708-1-git-send-email-johan.hedberg@gmail.com>
 <1291573170-3708-3-git-send-email-johan.hedberg@gmail.com>
 <AANLkTimYKSvo8WpNa-ft61MoBaAgKZxt5j0qVuRBfCb3@mail.gmail.com>
 <20101206142116.GA19084@jh-x301>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20101206142116.GA19084@jh-x301>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

* Johan Hedberg <johan.hedberg@gmail.com> [2010-12-06 16:21:16 +0200]:

> Hi Anderson,
> 
> On Mon, Dec 06, 2010, Anderson Lizardo wrote:
> > On Sun, Dec 5, 2010 at 2:19 PM,  <johan.hedberg@gmail.com> wrote:
> > > +static void cmd_status(struct sock *sk, u16 cmd, u8 status)
> > > +{
> > 
> > I see some inconsistence on how you calculate struct sizes on this
> > function. See below...
> > 
> > > +       struct sk_buff *skb;
> > > +       struct mgmt_hdr *hdr;
> > > +       struct mgmt_ev_cmd_status *ev;
> > > +
> > > +       BT_DBG("sock %p", sk);
> > > +
> > > +       skb = alloc_skb(sizeof(*hdr) + sizeof(*ev), GFP_ATOMIC);
> > 
> > Here you use sizeof(<var>)
> 
> Yep, in Chapter 14 of Documentation/CodingStyle this seems to be the
> preferred form.
> 
> > > +       if (!skb)
> > > +               return;
> > > +
> > > +       hdr = (void *) skb_put(skb, sizeof(struct mgmt_hdr));
> > 
> > But here you use sizeof(<struct>). Could be sizeof(*hdr)?
> 
> Yes, could be.
> 
> > > +
> > > +       hdr->opcode = cpu_to_le16(MGMT_EV_CMD_STATUS);
> > > +       hdr->len = cpu_to_le16(3);
> > 
> > and here a hard-coded size. Could be sizeof(struct mgmt_ev_cmd_status)?
> 
> Yes, could be.
> 
> > > +       if (len != msglen - sizeof(struct mgmt_hdr)) {
> > 
> > You could use sizeof(*hdr) here.
> 
> Indeed.
> 
> I suppose these style fixes should be as a separate patch since the
> original one already got acks from the relevant people? (if not, someone
> please enlighten me how the kernel patch process deals with comments
> received after acks :)

>From what I understand the Acked-by is more about the whole idea of the patch,
so to me it is fine to do such styles fixes and keep the ack in the patch. You
won't change essentials parts of the patch.

-- 
Gustavo F. Padovan
http://profusion.mobi
