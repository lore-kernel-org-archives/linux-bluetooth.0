Return-Path: <cyrus@holtmann.org>
Date: Mon, 21 Nov 2011 13:35:39 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: Brian Gix <bgix@codeaurora.org>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH-v4 5/9] Bluetooth: Add HCI User Passkey Req Evt handling
Message-ID: <20111121153539.GB2552@joana>
References: <1321480400-17397-1-git-send-email-bgix@codeaurora.org>
 <1321480400-17397-6-git-send-email-bgix@codeaurora.org>
 <20111116234706.GA25686@samus.indt.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20111116234706.GA25686@samus.indt.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

* Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-11-16 20:47:07 -0300]:

> Hi Brian,
> 
> Sorry if these comments appear so late in this series life.
> 
> On 13:53 Wed 16 Nov, Brian Gix wrote:
> > Some MITM scenarios require handling of the User Passkey Request event,
> > by querying the user, and passing the response back.
> > 
> > Signed-off-by: Brian Gix <bgix@codeaurora.org>
> > ---
> >  include/net/bluetooth/hci_core.h |    5 +++
> >  net/bluetooth/hci_event.c        |   58 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 63 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index 1795257..e7b2e25 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -933,6 +933,11 @@ int mgmt_user_confirm_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
> >  								u8 status);
> >  int mgmt_user_confirm_neg_reply_complete(struct hci_dev *hdev,
> >  						bdaddr_t *bdaddr, u8 status);
> > +int mgmt_user_passkey_request(struct hci_dev *hdev, bdaddr_t *bdaddr);
> > +int mgmt_user_passkey_reply_complete(struct hci_dev *hdev, bdaddr_t *bdaddr,
> > +								u8 status);
> > +int mgmt_user_passkey_neg_reply_complete(struct hci_dev *hdev,
> > +						bdaddr_t *bdaddr, u8 status);
> >  int mgmt_auth_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 status);
> >  int mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
> >  int mgmt_read_local_oob_data_reply_complete(struct hci_dev *hdev, u8 *hash,
> > diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> > index dfe6fbc..980da08 100644
> > --- a/net/bluetooth/hci_event.c
> > +++ b/net/bluetooth/hci_event.c
> > @@ -931,6 +931,37 @@ static void hci_cc_user_confirm_neg_reply(struct hci_dev *hdev,
> >  	hci_dev_unlock(hdev);
> >  }
> >  
> > +static void hci_cc_user_passkey_reply(struct hci_dev *hdev, struct sk_buff *skb)
> > +{
> > +	struct hci_rp_user_confirm_reply *rp = (void *) skb->data;
> > +
> > +	BT_DBG("%s status 0x%x", hdev->name, rp->status);
> > +
> > +	hci_dev_lock(hdev);
> > +
> > +	if (test_bit(HCI_MGMT, &hdev->flags))
> > +		mgmt_user_passkey_reply_complete(hdev, &rp->bdaddr,
> > +								rp->status);
> 
> I was with the impression that the check for the MGMT bit was being
> ignored on purpose on newer code, because mgmt is going to be the
> default some time in the (near) future and if there's no one listening
> for those events the overhead should be minimal. Can anyone confirm this
> impression?

I'm ok with the checks, we can remove all of them when mgmt becomes default.

	Gustavo
