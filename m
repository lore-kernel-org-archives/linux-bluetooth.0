Return-Path: <cyrus@holtmann.org>
Date: Fri, 22 Jul 2011 12:24:59 -0300
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 08/16] Bluetooth: Fix stop_discovery()
Message-ID: <20110722152459.GA2650@joana>
References: <1310418719-12296-1-git-send-email-andre.guedes@openbossa.org>
 <1310418719-12296-9-git-send-email-andre.guedes@openbossa.org>
 <20110713201516.GB23921@joana>
 <CACJA=fUXQ_QgLCr-TURFOr-2aWva8_gCpPfYC1g=oX099V-stQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CACJA=fUXQ_QgLCr-TURFOr-2aWva8_gCpPfYC1g=oX099V-stQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

* Andre Guedes <andre.guedes@openbossa.org> [2011-07-14 11:31:01 -0300]:

> Hi Gustavo,
> 
> On Wed, Jul 13, 2011 at 5:15 PM, Gustavo Padovan <padovan@profusion.mobi> wrote:
> >> @@ -963,6 +963,11 @@ static inline void hci_cs_inquiry(struct hci_dev *hdev, __u8 status)
> >>
> >>       set_bit(HCI_INQUIRY, &hdev->flags);
> >>
> >> +     if (mgmt_has_pending_stop_discov(hdev->id)) {
> >
> > Isn't a new bit flag log HCI_INQUIRY_CANCEL better that this? First this has
> > read a list, second it is a really ugly  function name.
> 
> A flag called HCI_CANCEL_DISCOV would be more appropriated since it
> would be used to cancel the discovery procedure (inquiry/le scan).

Let it be HCI_CANCEL_DISCOV then.

> 
> My point is: I don't need a new flag to tell me the same information I already
> have by checking for pending stop discovery command. IMO, traversing the
> pending command list is not a issue today since it isn't that large.
> If that list
> becomes too large in future, then we'll have a bigger issue because lots of
> mgmt commands do traversing the command pending list. In that case we
> would need to come up with some optimization like pending list per hdev,
> for instance.
> 
> Besides, I don't think mixing up mgmt layer and hci layer logic is a good
> idea. The whole discovery procedure logic should go in mgmt layer, so no
> discovery logic should be implemented in hci layer.
> 
> >> +             mgmt_cancel_discovery(hdev->id);
> >
> > Just call hci_send_cmd(HCI_OP_INQUIRY_CANCEL)
> 
> It would mix up mgmt and hci layer logic.

No, the only thing mgmt_cancel_discovery does is call hci_send_cmd. So what
you want is do the same thing but with some more functions in your call chain.

	Gustavo
