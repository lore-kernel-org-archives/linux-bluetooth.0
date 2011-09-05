Return-Path: <cyrus@holtmann.org>
Date: Mon, 5 Sep 2011 11:19:50 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/3] Bluetooth: Fix not sending a Link Key Negative Reply
Message-ID: <20110905141950.GA26578@samus.indt.org>
References: <1314985882-24059-1-git-send-email-vinicius.gomes@openbossa.org>
 <1314985882-24059-3-git-send-email-vinicius.gomes@openbossa.org>
 <20110905081842.GA3517@dell.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110905081842.GA3517@dell.ger.corp.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On 11:18 Mon 05 Sep, Johan Hedberg wrote:
> Hi Vinicius,
> 
> On Fri, Sep 02, 2011, Vinicius Costa Gomes wrote:
> > In the case that there are no keys loaded in the adapter, we should
> > also respond the Link Key Request event with the Link Key Negative
> > Reply command.
> > 
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > ---
> >  net/bluetooth/hci_event.c |    8 +++++---
> >  1 files changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index 8404cd9..79f89d2 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -2208,11 +2208,13 @@ static inline void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff
> >  
> >  	BT_DBG("%s", hdev->name);
> >  
> > -	if (!test_bit(HCI_LINK_KEYS, &hdev->flags))
> > -		return;
> > -
> >  	hci_dev_lock(hdev);
> >  
> > +	if (!test_bit(HCI_LINK_KEYS, &hdev->flags)) {
> > +		BT_DBG("%s has no keys", hdev->name);
> > +		goto not_found;
> > +	}
> > +
> >  	key = hci_find_link_key(hdev, &ev->bdaddr);
> >  	if (!key) {
> >  		BT_DBG("%s link key not found for %s", hdev->name,
> > -- 
> > 1.7.6.1
> 
> Nack. The purpose of this check in the beginning of the function is to
> prevent breakage on systems that do not use the management interface.
> With your patch you'd break all systems that use hciops. The
> HCI_LINK_KEYS bit will only be set when user space sends the
> MGMT_OP_LOAD_KEYS command.

Ok. This patch is to be ignored then. The rest of the series should should
still be considered.

> 
> Johan

Cheers,
-- 
Vinicius
