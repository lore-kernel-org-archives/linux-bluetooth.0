Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] rejecting or accepting connection request
Message-ID: <11D888B5FA88D9409851B71E8D3206D1016632@doar.commil.com>
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
Date: Thu, 7 Apr 2005 18:56:04 +0200

Here goes,
Regards
Tzahi

--- hci_event.c_orig_060405_auto_accept_incoming_conn	Wed Apr  6
09:47:22 2005
+++ hci_event.c	Wed Apr  6 13:48:42 2005
@@ -478,12 +478,19 @@
 /* Connect Request */
 static inline void hci_conn_request_evt(struct hci_dev *hdev, struct
sk_buff *skb)
 {
+	int IsUserAppPolicy =3D 1;
 	evt_conn_request *cr =3D (evt_conn_request *) skb->data;
 	int mask =3D hdev->link_mode;
=20
 	BT_DBG("%s Connection request: %s type 0x%x", hdev->name,
 			batostr(&cr->bdaddr), cr->link_type);
=20
+	if ( IsUserAppPolicy=3D=3D1 )
+	{
+		BT_DBG("%s Connection request: %s letting the app decide
if to accept or reject", hdev->name);
+		return;
+	}
+	=09
 	mask |=3D hci_proto_connect_ind(hdev, &cr->bdaddr, cr->link_type);
=20
 	if (mask & HCI_LM_ACCEPT) {
@@ -534,9 +541,14 @@
 	hci_dev_lock(hdev);
 =09
 	conn =3D conn_hash_lookup_ba(hdev, cc->link_type, &cc->bdaddr);
-	if (!conn) {
-		hci_dev_unlock(hdev);
-		return;
+	if (!conn)=20
+	{
+		if (!(conn =3D hci_conn_add(hdev, cc->link_type,
&cc->bdaddr)))=20
+		{
+			BT_ERR("No memmory for new connection");
+			hci_dev_unlock(hdev);
+			return;
+		}
 	}
=20
 	if (!cc->status) {=20

-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net
[mailto:bluez-devel-admin@lists.sourceforge.net] On Behalf Of Marcel
Holtmann
Sent: Thursday, April 07, 2005 6:48 PM
To: BlueZ Mailing List
Subject: RE: [Bluez-devel] rejecting or accepting connection request

Hi Tzahi,

> Following are the two functions I modified:

please send a patch (diff -u) for it.

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
