Return-Path: <cyrus@holtmann.org>
Date: Mon, 12 Dec 2011 11:15:47 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [RFCv0] Bluetooth: General HCI callback implementation
Message-ID: <20111212091544.GA6131@aemeltch-MOBL1>
References: <1323436248-3736-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <CAJdJm_NwrcB8VmK7BZjAmBYL6Md=Ksq9ONcisu0UApwPTbz-qQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CAJdJm_NwrcB8VmK7BZjAmBYL6Md=Ksq9ONcisu0UApwPTbz-qQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Sat, Dec 10, 2011 at 08:47:38AM -0400, Anderson Lizardo wrote:
> Hi Andrei,
> 
> On Fri, Dec 9, 2011 at 9:10 AM, Emeltchenko Andrei
> <Andrei.Emeltchenko.news@gmail.com> wrote:
> > From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> >
> > Add general HCI callback implementation. Can be used for executing
> > HCI commands from A2MP protocol.
> > ---
> >  include/net/bluetooth/hci_core.h |   14 +++++++++++
> >  net/bluetooth/hci_core.c         |   47 ++++++++++++++++++++++++++++++++++++++
> >  net/bluetooth/hci_event.c        |    4 +++
> >  3 files changed, 65 insertions(+), 0 deletions(-)
> >
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index cc5481d..e473cd2 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -121,6 +121,15 @@ struct adv_entry {
> >        u8 bdaddr_type;
> >  };
> >
> > +struct hci_dev;
> > +
> > +struct cb_cmd {
> > +       struct list_head list;
> > +       u16 opcode;
> > +       void *opt;
> > +       void (*cb)(struct hci_dev *hdev, void *opt);
> > +};
> > +
> 
> Isn't this a too generic name for an exported struct, which may cause clashes?

At least my cscope cannot find other struct with the same name in Linux
kernel.

But I agree that name might be better. Maybe "hci_req_cb" ?

Best regards 
Andrei Emeltchenko 

