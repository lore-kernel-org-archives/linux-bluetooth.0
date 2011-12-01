Return-Path: <cyrus@holtmann.org>
Date: Thu, 1 Dec 2011 15:23:29 +0200
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCHv2 8/8] Bluetooth: Complete Read Local Version HCI cmd
Message-ID: <20111201132328.GD2216@aemeltch-MOBL1>
References: <1322743335-8671-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1322743335-8671-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1322745177.26198.34.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1322745177.26198.34.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Dec 01, 2011 at 02:12:57PM +0100, Marcel Holtmann wrote:
> Hi Andrei,
> 
> > Mark request status as done for Read Local Version HCI command.
> > ---
> >  net/bluetooth/hci_event.c |    5 ++++-
> >  1 files changed, 4 insertions(+), 1 deletions(-)
> > 
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index a646310..e064aa1 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -598,7 +598,7 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
> >  	BT_DBG("%s status 0x%x", hdev->name, rp->status);
> >  
> >  	if (rp->status)
> > -		return;
> > +		goto done;
> >  
> >  	hdev->hci_ver = rp->hci_ver;
> >  	hdev->hci_rev = __le16_to_cpu(rp->hci_rev);
> > @@ -612,6 +612,9 @@ static void hci_cc_read_local_version(struct hci_dev *hdev, struct sk_buff *skb)
> >  
> >  	if (test_bit(HCI_INIT, &hdev->flags))
> >  		hci_setup(hdev);
> > +
> > +done:
> > +	hci_req_complete(hdev, HCI_OP_READ_LOCAL_VERSION, rp->status);
> >  }
> 
> this is all getting out of control. We call hci_req_complete for random
> functions now. And that is because our init handling sucks.

You are right here. The reason for this patch is AMP initialization where
this HCI command is last and does not "complete itself".

Maybe we need to "complete" each HCI Request?

Best regards 
Andrei Emeltchenko 
