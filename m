Return-Path: <cyrus@holtmann.org>
Date: Mon, 4 Jul 2011 14:38:12 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2 03/12] Bluetooth: Add functions to manipulate the link
 key list for SMP
Message-ID: <20110704173811.GA20837@piper>
References: <1309547267-9514-1-git-send-email-vinicius.gomes@openbossa.org>
 <1309547267-9514-4-git-send-email-vinicius.gomes@openbossa.org>
 <20110701192350.GG23683@joana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110701192350.GG23683@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On 16:23 Fri 01 Jul, Gustavo F. Padovan wrote:
> * Vinicius Costa Gomes <vinicius.gomes@openbossa.org> [2011-07-01 16:07:38 -0300]:
> 
> > As the LTK (the new type of key being handled now) has more data
> > associated with it, we need to store this extra data and retrieve
> > the keys based on that data.
> > 
> > Methods for searching for a key and for adding a new LTK are
> > introduced here.
> > 
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > ---
> >  include/net/bluetooth/hci_core.h |    5 ++
> >  net/bluetooth/hci_core.c         |   81 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 86 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index c92e89b..751104a 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -554,6 +554,11 @@ int hci_link_keys_clear(struct hci_dev *hdev);
> >  struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
> >  int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
> >  			bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len);
> > +struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
> > +struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
> > +					bdaddr_t *bdaddr, u8 type);
> > +int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
> > +					__le16 ediv, u8 rand[8], u8 ltk[16]);
> >  int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
> >  
> >  int hci_remote_oob_data_clear(struct hci_dev *hdev);
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index 0029e17..bf9c023 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -1059,6 +1059,50 @@ static int hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
> >  	return 0;
> >  }
> >  
> > +struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
> > +{
> > +	struct list_head *p;
> > +
> > +	list_for_each(p, &hdev->link_keys) {
> > +		struct link_key *k;
> > +		struct key_master_id *id;
> > +
> > +		k = list_entry(p, struct link_key, list);
> 
> list_for_each_entry() please.

Done.

> 
> > +
> > +		if (k->type != HCI_LK_SMP_LTK)
> > +			continue;
> > +
> > +		if (k->dlen != sizeof(*id))
> > +			continue;
> > +
> > +		id = (void *) &k->data;
> > +		if (id->ediv == ediv &&
> > +				(memcmp(rand, id->rand, sizeof(id->rand)) == 0))
> > +			return k;
> > +	}
> > +
> > +	return NULL;
> > +}
> > +EXPORT_SYMBOL(hci_find_ltk);
> > +
> > +struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
> > +					bdaddr_t *bdaddr, u8 type)
> > +{
> > +	struct list_head *p;
> > +
> > +	list_for_each(p, &hdev->link_keys) {
> > +		struct link_key *k;
> > +
> > +		k = list_entry(p, struct link_key, list);
> 
> same here.

Done.

> 
> 	Gustavo


Cheers,
-- 
Vinicius
