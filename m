Return-Path: <cyrus@holtmann.org>
Date: Thu, 7 Jul 2011 18:56:56 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v3 03/12] Bluetooth: Add functions to manipulate the link
 key list for SMP
Message-ID: <20110707215654.GA20117@piper>
References: <1309547267-9514-4-git-send-email-vinicius.gomes@openbossa.org>
 <1309980187-14404-1-git-send-email-vinicius.gomes@openbossa.org>
 <1310026154.21109.51.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1310026154.21109.51.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 10:09 Thu 07 Jul, Marcel Holtmann wrote:
> Hi Vinicius,
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
> >  include/net/bluetooth/hci_core.h |    5 +++
> >  net/bluetooth/hci_core.c         |   73 ++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 78 insertions(+), 0 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index a3d49d8..353d4a9 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -552,6 +552,11 @@ int hci_link_keys_clear(struct hci_dev *hdev);
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
> > index cd59b84..1cf8b89 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -1059,6 +1059,42 @@ static int hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
> >  	return 0;
> >  }
> >  
> > +struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
> > +{
> > +	struct link_key *k;
> > +
> > +	list_for_each_entry(k, &hdev->link_keys, list) {
> > +		struct key_master_id *id;
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
> > +	struct link_key *k;
> > +
> > +	list_for_each_entry(k, &hdev->link_keys, list)
> > +		if ((k->type == type) && (bacmp(bdaddr, &k->bdaddr) == 0))
> > +			return k;
> 
> please just do if (k->type == type && bacmp(....) == 0). No need for the
> extra braces.

Done.
 

Cheers,
-- 
Vinicius
