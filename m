Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Dec 2010 16:21:16 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Bluetooth: Add initial Bluetooth Management
 interface callbacks
Message-ID: <20101206142116.GA19084@jh-x301>
References: <1291573170-3708-1-git-send-email-johan.hedberg@gmail.com>
 <1291573170-3708-3-git-send-email-johan.hedberg@gmail.com>
 <AANLkTimYKSvo8WpNa-ft61MoBaAgKZxt5j0qVuRBfCb3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <AANLkTimYKSvo8WpNa-ft61MoBaAgKZxt5j0qVuRBfCb3@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Mon, Dec 06, 2010, Anderson Lizardo wrote:
> On Sun, Dec 5, 2010 at 2:19 PM,  <johan.hedberg@gmail.com> wrote:
> > +static void cmd_status(struct sock *sk, u16 cmd, u8 status)
> > +{
> 
> I see some inconsistence on how you calculate struct sizes on this
> function. See below...
> 
> > +       struct sk_buff *skb;
> > +       struct mgmt_hdr *hdr;
> > +       struct mgmt_ev_cmd_status *ev;
> > +
> > +       BT_DBG("sock %p", sk);
> > +
> > +       skb = alloc_skb(sizeof(*hdr) + sizeof(*ev), GFP_ATOMIC);
> 
> Here you use sizeof(<var>)

Yep, in Chapter 14 of Documentation/CodingStyle this seems to be the
preferred form.

> > +       if (!skb)
> > +               return;
> > +
> > +       hdr = (void *) skb_put(skb, sizeof(struct mgmt_hdr));
> 
> But here you use sizeof(<struct>). Could be sizeof(*hdr)?

Yes, could be.

> > +
> > +       hdr->opcode = cpu_to_le16(MGMT_EV_CMD_STATUS);
> > +       hdr->len = cpu_to_le16(3);
> 
> and here a hard-coded size. Could be sizeof(struct mgmt_ev_cmd_status)?

Yes, could be.

> > +       if (len != msglen - sizeof(struct mgmt_hdr)) {
> 
> You could use sizeof(*hdr) here.

Indeed.

I suppose these style fixes should be as a separate patch since the
original one already got acks from the relevant people? (if not, someone
please enlighten me how the kernel patch process deals with comments
received after acks :)

> > +               err = -EINVAL;
> > +               goto done;
> > +       }
> > +
> > +       switch (opcode) {
> > +       default:
> > +               BT_DBG("Unknown op %u", opcode);
> > +               cmd_status(sk, opcode, 0x01);
> > +               break;
> > +       }
> > +
> > +       err = msglen;
> 
> Would there be a chance of integer overflow here? The function returns
> (signed) int, but msglen is (unsigned) size_t.

The core of the issue is in the way that the sendmsg callback for
sockets is defined. At least L2CAP and RFCOMM sockets do similar
assignments in their sendmsg callbacks so I've assumed it to be ok.

Johan
