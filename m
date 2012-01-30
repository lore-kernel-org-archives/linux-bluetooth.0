Return-Path: <cyrus@holtmann.org>
Date: Mon, 30 Jan 2012 20:24:13 -0300
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 4/8] Bluetooth: Use the updated key structures for
 handling LTKs
Message-ID: <20120130232413.GB17656@samus>
References: <1327962558-25720-1-git-send-email-vinicius.gomes@openbossa.org>
 <1327962558-25720-5-git-send-email-vinicius.gomes@openbossa.org>
 <1327963466.1955.193.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1327963466.1955.193.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 14:44 Mon 30 Jan, Marcel Holtmann wrote:
> Hi Vinicius,
> 
> > This updates all the users of the older way, that was using the
> > link_keys list to store the SMP keys, to use the new way.
> > 
> > This includes defining new types for the keys, we have a type for each
> > combination of STK/LTK and Master/Slave.
> > 
> > Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> > ---
> >  include/net/bluetooth/hci_core.h |   11 +++--
> >  net/bluetooth/hci_core.c         |   79 ++++++++++++++++++--------------------
> >  net/bluetooth/hci_event.c        |    9 +++-
> >  net/bluetooth/smp.c              |   38 +++++++++++-------
> >  4 files changed, 73 insertions(+), 64 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index 06eab3f..ae3f653 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -658,12 +658,13 @@ int hci_link_keys_clear(struct hci_dev *hdev);
> >  struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
> >  int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
> >  			bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len);
> > -struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
> > -struct link_key *hci_find_link_key_type(struct hci_dev *hdev,
> > -					bdaddr_t *bdaddr, u8 type);
> > -int hci_add_ltk(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
> > -			u8 key_size, __le16 ediv, u8 rand[8], u8 ltk[16]);
> > +struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8]);
> > +int hci_add_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 addr_type, u8 type,
> > +				int new_key, u8 authenticated, u8 tk[16],
> > +				u8 enc_size, u16 ediv, u8 rand[8]);
> >  int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
> > +struct smp_ltk *hci_find_ltk_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
> > +								u8 addr_type);
> >  int hci_smp_ltks_clear(struct hci_dev *hdev);
> >  
> >  int hci_remote_oob_data_clear(struct hci_dev *hdev);
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index a7b2d6b..d00704e 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -1222,41 +1222,40 @@ static int hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
> >  	return 0;
> >  }
> >  
> > -struct link_key *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
> > +/* If the returned key is a STK it should be free'd by the caller */
> > +struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
> >  {
> 
> this kind of API seems to be rather random. We need a bit better
> semantics here.

Ok. I can leave the work of removing the STK from the list to the
caller. Would that make more sense to you? 

The point is that it doesn't make sense to keep the STK around after
it was used.

> 
> Regards
> 
> Marcel
> 
> 

Cheers,
-- 
Vinicius
