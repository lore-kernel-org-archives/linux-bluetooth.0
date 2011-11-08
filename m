Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Tue, 8 Nov 2011 12:47:49 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andre Guedes <andre.guedes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/3] Bluetooth: Create hci_do_inquiry()
Message-ID: <20111108144749.GA25584@joana>
References: <1320427013-5684-1-git-send-email-andre.guedes@openbossa.org>
 <1320674372-5128-1-git-send-email-andre.guedes@openbossa.org>
 <1320710040.15441.309.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1320710040.15441.309.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Marcel Holtmann <marcel@holtmann.org> [2011-11-08 08:53:57 +0900]:

> Hi Andre,
> 
> > This patch adds a function to hci_core to carry out inquiry.
> > 
> > All inquiry code from start_discovery() were replaced by a
> > hci_do_inquiry() call.
> > 
> > Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> > ---
> >  include/net/bluetooth/hci_core.h |    2 ++
> >  net/bluetooth/hci_core.c         |   17 +++++++++++++++++
> >  net/bluetooth/mgmt.c             |   11 +++--------
> >  3 files changed, 22 insertions(+), 8 deletions(-)
> 
> in general I am fine with this patch, besides some tiny nitpicks.
> 
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index f97792c..ae36ac0 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -970,4 +970,6 @@ void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
> >  void hci_le_ltk_reply(struct hci_conn *conn, u8 ltk[16]);
> >  void hci_le_ltk_neg_reply(struct hci_conn *conn);
> >  
> > +int hci_do_inquiry(struct hci_dev *hdev, u8 length);
> > +
> 
> I think the name hci_send_inquiry would be better. Since you are just
> sending the command and not handling the whole inquiry.
> 
> >  #endif /* __HCI_CORE_H */
> > diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> > index b7f6b5b..5b861c7 100644
> > --- a/net/bluetooth/hci_core.c
> > +++ b/net/bluetooth/hci_core.c
> > @@ -2560,3 +2560,20 @@ static void hci_cmd_task(unsigned long arg)
> >  		}
> >  	}
> >  }
> > +
> > +int hci_do_inquiry(struct hci_dev *hdev, u8 length)
> > +{
> > +	u8 lap[3] = { 0x33, 0x8b, 0x9e };
> > +	struct hci_cp_inquiry cp;
> > +
> > +	BT_DBG("%s", hdev->name);
> > +
> > +	if (test_bit(HCI_INQUIRY, &hdev->flags))
> > +		return -EINPROGRESS;
> > +
> > +	memset(&cp, 0, sizeof(cp));
> > +	memcpy(&cp.lap, lap, sizeof(cp.lap));
> > +	cp.length  = length;
> > +
> > +	return hci_send_cmd(hdev, HCI_OP_INQUIRY, sizeof(cp), &cp);
> > +}
> > diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> > index 747366a..17c7fbb 100644
> > --- a/net/bluetooth/mgmt.c
> > +++ b/net/bluetooth/mgmt.c
> > @@ -32,6 +32,8 @@
> >  #define MGMT_VERSION	0
> >  #define MGMT_REVISION	1
> >  
> > +#define INQUIRY_LEN_BREDR 0x08 /* TGAP(100) */
> > +
> 
> Please add an extra tab between the comment and the define. It is too
> easy to get confused otherwise.

Please send a delta patch to this one, since I already applied it. Thanks.

	Gustavo
