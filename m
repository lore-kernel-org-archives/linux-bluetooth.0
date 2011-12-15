Return-Path: <cyrus@holtmann.org>
Date: Thu, 15 Dec 2011 11:19:13 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv0] Bluetooth: General HCI callback implementation
Message-ID: <20111215091912.GD15283@aemeltch-MOBL1>
References: <1323436248-3736-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1323901223.1965.70.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1323901223.1965.70.camel@aeonflux>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Wed, Dec 14, 2011 at 11:20:23PM +0100, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Add general HCI callback implementation. Can be used for executing
> > HCI commands from A2MP protocol.
> > ---
> >  include/net/bluetooth/hci_core.h |   14 +++++++++++
> >  net/bluetooth/hci_core.c         |   47 ++++++++++++++++++++++++++++++++++++++
> >  net/bluetooth/hci_event.c        |    4 +++
> >  3 files changed, 65 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index cc5481d..e473cd2 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -121,6 +121,15 @@ struct adv_entry {
> >  	u8 bdaddr_type;
> >  };
> >  
> > +struct hci_dev;
> > +
> > +struct cb_cmd {
> > +	struct list_head list;
> > +	u16 opcode;
> > +	void *opt;
> > +	void (*cb)(struct hci_dev *hdev, void *opt);
> > +};
> > +
> 
> so I am actually thinking that we might just update hci_request into a
> bit more flexible schema.

Do you mean that we can use blocking hci_request? This may work but some
commands requires special logic (like executing several Read AMP Assoc
data requests). I don't know would it be the best solution especially when
executing from A2MP/L2CAP code.

> Gustavo is working on moving everything into a process context, so we
> can actually sleep. And we could just make a simple premise to only

This would be good, meanwhile I have implemented callback execution in a
workqueue. I will send second RFC version later today.

Best regards 
Andrei Emeltchenko 

> allow one request at a time. That would also then allow us to utilize
> hci_request. We just need a clean way to report back the result.
> 
> Regards
> 
> Marcel
