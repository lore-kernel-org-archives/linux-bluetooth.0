Return-Path: <cyrus@holtmann.org>
Date: Mon, 22 Oct 2012 13:13:34 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/5 v2] Bluetooth: Add initial support for LE-only
 controllers
Message-ID: <20121022101334.GA25370@x220>
References: <1350669469-7719-1-git-send-email-johan.hedberg@gmail.com>
 <1350669469-7719-2-git-send-email-johan.hedberg@gmail.com>
 <20121022100845.GA14263@aemeltch-MOBL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121022100845.GA14263@aemeltch-MOBL1>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Oct 22, 2012, Andrei Emeltchenko wrote:
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -178,48 +178,13 @@ static void hci_reset_req(struct hci_dev *hdev, unsigned long opt)
> >  
> >  static void bredr_init(struct hci_dev *hdev)
> >  {
> > -	struct hci_cp_delete_stored_link_key cp;
> > -	__le16 param;
> > -	__u8 flt_type;
> > -
> 
> ...
> 
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 0383635..f4f0b8b 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> 
> ...
> 
> > +static void bredr_init(struct hci_dev *hdev)
> > +{
> 
> Is this a good idea to have two functions with the same names? Even static
> ones.

Another option would have been to call this bredr_setup since it's the
hci_setup function that calls it. Anyway, I'll wait for feedback from
Gustavo to see if he cares.

Johan
