Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] rejecting or accepting connection request
Message-ID: <11D888B5FA88D9409851B71E8D3206D1016630@doar.commil.com>
From: "Tzahi Efrati" <tzah@commil.com>
To: <bluez-devel@lists.sourceforge.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 7 Apr 2005 18:29:35 +0200

Hi Marcel,

Following are the two functions I modified:

Regards,
Tzahi

/* Connect Request */
static inline void hci_conn_request_evt(struct hci_dev *hdev, struct
sk_buff *skb)
{
	int IsUserAppPolicy =3D 1;
	evt_conn_request *cr =3D (evt_conn_request *) skb->data;
	int mask =3D hdev->link_mode;

	BT_DBG("%s Connection request: %s type 0x%x", hdev->name,
			batostr(&cr->bdaddr), cr->link_type);

	if ( IsUserAppPolicy=3D=3D1 )
	{
		BT_DBG("%s Connection request: %s letting the app decide
if to accept or reject", hdev->name);
		return;
	}
	=09
	mask |=3D hci_proto_connect_ind(hdev, &cr->bdaddr, cr->link_type);

	if (mask & HCI_LM_ACCEPT) {
		/* Connection accepted */
		struct hci_conn *conn;
		accept_conn_req_cp ac;

		hci_dev_lock(hdev);
		conn =3D conn_hash_lookup_ba(hdev, cr->link_type,
&cr->bdaddr);
		if (!conn) {
			if (!(conn =3D hci_conn_add(hdev, cr->link_type,
&cr->bdaddr))) {
				BT_ERR("No memmory for new connection");
				hci_dev_unlock(hdev);
				return;
			}
		}
		conn->state =3D BT_CONNECT;
		hci_dev_unlock(hdev);

		bacpy(&ac.bdaddr, &cr->bdaddr);
=09
		if (lmp_rswitch_capable(hdev) && (mask & HCI_LM_MASTER))
			ac.role =3D 0x00; /* Become master */
		else
			ac.role =3D 0x01; /* Remain slave */

		hci_send_cmd(hdev, OGF_LINK_CTL, OCF_ACCEPT_CONN_REQ,=20
				ACCEPT_CONN_REQ_CP_SIZE, &ac);
	} else {
		/* Connection rejected */
		reject_conn_req_cp rc;

		bacpy(&rc.bdaddr, &cr->bdaddr);
		rc.reason =3D 0x0f;
		hci_send_cmd(hdev, OGF_LINK_CTL, OCF_REJECT_CONN_REQ,
				REJECT_CONN_REQ_CP_SIZE, &rc);
	}
}

/* Connect Complete */
static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct
sk_buff *skb)
{
	evt_conn_complete *cc =3D (evt_conn_complete *) skb->data;
	struct hci_conn *conn =3D NULL;

	BT_DBG("%s", hdev->name);

	hci_dev_lock(hdev);
=09
	conn =3D conn_hash_lookup_ba(hdev, cc->link_type, &cc->bdaddr);
	if (!conn)=20
	{
		if (!(conn =3D hci_conn_add(hdev, cc->link_type,
&cc->bdaddr)))=20
		{
			BT_ERR("No memmory for new connection");
			hci_dev_unlock(hdev);
			return;
		}
	}

	if (!cc->status) {
		conn->handle =3D __le16_to_cpu(cc->handle);
		conn->state  =3D BT_CONNECTED;

		if (test_bit(HCI_AUTH, &hdev->flags))
			conn->link_mode |=3D HCI_LM_AUTH;
	=09
		if (test_bit(HCI_ENCRYPT, &hdev->flags))
			conn->link_mode |=3D HCI_LM_ENCRYPT;


		/* Set link policy */
		if (conn->type =3D=3D ACL_LINK && hdev->link_policy) {
			write_link_policy_cp lp;
			lp.handle =3D cc->handle;
			lp.policy =3D __cpu_to_le16(hdev->link_policy);
			hci_send_cmd(hdev, OGF_LINK_POLICY,
OCF_WRITE_LINK_POLICY,
				WRITE_LINK_POLICY_CP_SIZE, &lp);
		}

		/* Set packet type for incomming connection */
		if (!conn->out) {
			change_conn_ptype_cp cp;
			cp.handle =3D cc->handle;
			cp.pkt_type =3D (conn->type =3D=3D ACL_LINK) ?=20
				__cpu_to_le16(hdev->pkt_type &
ACL_PTYPE_MASK):
				__cpu_to_le16(hdev->pkt_type &
SCO_PTYPE_MASK);

			hci_send_cmd(hdev, OGF_LINK_CTL,
OCF_CHANGE_CONN_PTYPE,
				CHANGE_CONN_PTYPE_CP_SIZE, &cp);
		}
	} else
		conn->state =3D BT_CLOSED;

	if (conn->type =3D=3D ACL_LINK) {
		struct hci_conn *sco =3D conn->link;
		if (sco) {
			if (!cc->status)
				hci_add_sco(sco, conn->handle);
			else {
				hci_proto_connect_cfm(sco, cc->status);
				hci_conn_del(sco);
			}
		}
	}

	hci_proto_connect_cfm(conn, cc->status);
	if (cc->status)
		hci_conn_del(conn);

	hci_dev_unlock(hdev);
}=20

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Thursday, April 07, 2005 1:32 PM
To: BlueZ Mailing List
Subject: RE: [Bluez-devel] rejecting or accepting connection request

Hi Tzahi,

> Thanks for the answer. I changed hci_conn_request_evt() to simply=20
> return without doing anything, and hci_conn_complete_evt() to allocate

> (using
> hci_add_conn()) the hci_conn struct. So far it seems to work with no=20
> side-effects.

show me your patch and the daemon you use in userspace.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide Read honest & candid
reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
