Return-Path: <cyrus@holtmann.org>
Date: Wed, 13 Oct 2010 15:10:23 +0300
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Marcel Holtmann <marcel@holtmann.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 3/7] Bluetooth: LE disconnection and connect cancel
 support
Message-ID: <20101013121023.GB15050@null>
References: <1286390535-27462-1-git-send-email-ville.tervo@nokia.com>
 <1286390535-27462-4-git-send-email-ville.tervo@nokia.com>
 <1286449467.6145.97.camel@aeonflux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286449467.6145.97.camel@aeonflux>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Thu, Oct 07, 2010 at 01:04:27PM +0200, ext Marcel Holtmann wrote:
> Hi Ville,
> 
> > Add supprt to cancel and disconnet connections.
> > 
> > Signed-off-by: Ville Tervo <ville.tervo@nokia.com>
> > ---
> >  include/net/bluetooth/hci.h      |    5 ++---
> >  include/net/bluetooth/hci_core.h |    3 +++
> >  net/bluetooth/hci_conn.c         |   30 ++++++++++++++++++++++++++++++
> >  3 files changed, 35 insertions(+), 3 deletions(-)
> > 
> > diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> > index b326240..d04ecea 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -191,6 +191,8 @@ enum {
> >  
> >  #define LMP_EV4		0x01
> >  #define LMP_EV5		0x02
> > +#define LMP_NO_BR	0x20
> > +#define LMP_LE		0x40
> 
> Keep these in sync with the constants we use in userspace.

I changed these to match userspace ones.

> >  #define LMP_SNIFF_SUBR	0x02
> >  #define LMP_EDR_ESCO_2M	0x20
> > @@ -627,9 +629,6 @@ struct hci_cp_le_create_conn {
> >  } __packed;
> >  
> >  #define HCI_OP_LE_CREATE_CONN_CANCEL	0x200e
> > -struct hci_cp_le_create_conn_cancel {
> > -	__u8     status;
> > -} __packed;
> >  
> >  #define HCI_OP_LE_SET_ADVERTISE_ENABLE	0x200a
> >  	#define LE_ADVERTISE_ENABLED	0x01
> > diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
> > index 89f4b10..a430a57 100644
> > --- a/include/net/bluetooth/hci_core.h
> > +++ b/include/net/bluetooth/hci_core.h
> > @@ -455,10 +455,13 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
> >  #define lmp_rswitch_capable(dev)   ((dev)->features[0] & LMP_RSWITCH)
> >  #define lmp_encrypt_capable(dev)   ((dev)->features[0] & LMP_ENCRYPT)
> >  #define lmp_sniff_capable(dev)     ((dev)->features[0] & LMP_SNIFF)
> > +#define lmp_br_capable(dev)        (!((dev)->features[4] & LMP_NO_BR))
> 
> This makes no sense to me. And leave this out for now. This is more
> complicated when running on LE only.

ok

> > +#define lmp_le_capable(dev)        ((dev)->features[4] & LMP_LE)
> 
> I would just add this at the end of the list and not intermix it with
> sniff and sniffsubr defines.
> 
> >  #define lmp_sniffsubr_capable(dev) ((dev)->features[5] & LMP_SNIFF_SUBR)
> >  #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
> >  #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
> >  
> > +
> >  /* ----- HCI protocols ----- */
> >  struct hci_proto {
> >  	char		*name;
> > diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> > index cb41d64..50f8973 100644
> > --- a/net/bluetooth/hci_conn.c
> > +++ b/net/bluetooth/hci_conn.c
> > @@ -66,6 +66,31 @@ void hci_le_connect(struct hci_conn *conn)
> >  	hci_send_cmd(hdev, HCI_OP_LE_CREATE_CONN, sizeof(cp), &cp);
> >  }
> >  
> > +static void hci_le_connect_cancel(struct hci_conn *conn)
> > +{
> > +	struct hci_dev *hdev = conn->hdev;
> > +
> > +	BT_DBG("%p", conn);
> > +
> > +	if (!lmp_le_capable(hdev))
> > +		return;
> 
> This should not be needed. We should not have tried to establish a LE
> link if we don't support LE in the first place.

ok

> > +
> > +	hci_send_cmd(conn->hdev, HCI_OP_LE_CREATE_CONN_CANCEL, 0, NULL);
> > +}
> > +
> > +void hci_le_disconn(struct hci_conn *conn, __u8 reason)
> > +{
> > +	struct hci_cp_disconnect cp;
> > +
> > +	BT_DBG("%p", conn);
> > +
> > +	conn->le_state = BT_DISCONN;
> > +
> > +	cp.handle = cpu_to_le16(conn->handle);
> > +	cp.reason = reason;
> > +	hci_send_cmd(conn->hdev, HCI_OP_DISCONNECT, sizeof(cp), &cp);
> > +}
> 
> When just using conn->state, then this becomes obsolete and we can use
> the generic one.

I removed whole function.

> > +
> >  void hci_acl_connect(struct hci_conn *conn)
> >  {
> >  	struct hci_dev *hdev = conn->hdev;
> > @@ -221,6 +246,8 @@ static void hci_conn_timeout(unsigned long arg)
> >  	case BT_CONNECT2:
> >  		if (conn->type == ACL_LINK && conn->out)
> >  			hci_acl_connect_cancel(conn);
> > +		if (conn->type == LE_LINK && conn->out)
> > +			hci_le_connect_cancel(conn);
> 
> This should be redone with as this:
> 
> 	if (conn->out) {
> 		if (ACL_LINK)
> 			...
> 		else if (LE_LINK)
> 			...
> 	}

Done

> >  		break;
> >  	case BT_CONFIG:
> >  	case BT_CONNECTED:
> > @@ -397,6 +424,9 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
> >  	BT_DBG("%s dst %s", hdev->name, batostr(dst));
> >  
> >  	if (type == LE_LINK) {
> > +		if (!lmp_le_capable(hdev))
> > +			return NULL;
> > +
> >  		le = hci_conn_hash_lookup_ba(hdev, LE_LINK, dst);
> >  
> >  		if (!le)
> 
> We might need to move that lmp_le_capable check into L2CAP. Since
> otherwise we can not give a proper return value if someone tries to use
> LE on a BR/EDR only controller.

Check removed from from here. However I left lmp_le_capable() to code so it can
be used in l2cap patches.


-- 
Ville
