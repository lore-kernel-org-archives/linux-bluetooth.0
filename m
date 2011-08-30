Return-Path: <cyrus@holtmann.org>
From: Peter Hurley <peter@hurleysoftware.com>
To: David Herrmann <dh.herrmann@googlemail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"padovan@profusion.mobi" <padovan@profusion.mobi>, "marcel@holtmann.org"
	<marcel@holtmann.org>
Date: Tue, 30 Aug 2011 09:40:25 -0400
Subject: Re: [RFC] Bluetooth: hidp: Check for valid ACL connection
Message-ID: <1314711625.2232.21.camel@THOR>
References: <1313764878-3091-1-git-send-email-dh.herrmann@googlemail.com>
In-Reply-To: <1313764878-3091-1-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

On Fri, 2011-08-19 at 10:41 -0400, David Herrmann wrote:
> Also I think it would make the code nicer when calling hidp_get_device() =
in
> hidp_add_connection and hidp_setup_input/hid just retrieves the parent-de=
vice
> from session->conn.

What about something like this instead?

This:
1. moves the hidp_get_device out into hidp_add_connection
2. renames hidp_get_device to hidp_find_connection
3. checks for null connection value return
4. performs the connection list access with device lock held
5. bumps the hci connection device hold with device lock held


diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index e02c6a2..f6db935 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -97,8 +97,6 @@ static void __hidp_link_session(struct hidp_session *sess=
ion)
 {
 	__module_get(THIS_MODULE);
 	list_add(&session->list, &hidp_session_list);
-
-	hci_conn_hold_device(session->conn);
 }
=20
 static void __hidp_unlink_session(struct hidp_session *session)
@@ -763,24 +761,26 @@ static int hidp_session(void *arg)
 	return 0;
 }
=20
-static struct device *hidp_get_device(struct hidp_session *session)
+static struct hci_conn *hidp_find_connection(struct hidp_session *session)
 {
 	bdaddr_t *src =3D &bt_sk(session->ctrl_sock->sk)->src;
 	bdaddr_t *dst =3D &bt_sk(session->ctrl_sock->sk)->dst;
-	struct device *device =3D NULL;
+	struct hci_conn *conn;
 	struct hci_dev *hdev;
=20
 	hdev =3D hci_get_route(dst, src);
 	if (!hdev)
 		return NULL;
=20
-	session->conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
-	if (session->conn)
-		device =3D &session->conn->dev;
+	hci_dev_lock_bh(hdev);
+	conn =3D hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
+	if (conn)
+		hci_conn_hold_device(conn);
+	hci_dev_unlock_bh(hdev);
=20
 	hci_dev_put(hdev);
=20
-	return device;
+	return conn;
 }
=20
 static int hidp_setup_input(struct hidp_session *session,
@@ -830,7 +830,7 @@ static int hidp_setup_input(struct hidp_session *sessio=
n,
 		input->relbit[0] |=3D BIT_MASK(REL_WHEEL);
 	}
=20
-	input->dev.parent =3D hidp_get_device(session);
+	input->dev.parent =3D &session->conn->dev;
=20
 	input->event =3D hidp_input_event;
=20
@@ -934,7 +934,7 @@ static int hidp_setup_hid(struct hidp_session *session,
 	strncpy(hid->phys, batostr(&bt_sk(session->ctrl_sock->sk)->src), 64);
 	strncpy(hid->uniq, batostr(&bt_sk(session->ctrl_sock->sk)->dst), 64);
=20
-	hid->dev.parent =3D hidp_get_device(session);
+	hid->dev.parent =3D &session->conn->dev;
 	hid->ll_driver =3D &hidp_hid_driver;
=20
 	hid->hid_get_raw_report =3D hidp_get_raw_report;
@@ -975,6 +975,10 @@ int hidp_add_connection(struct hidp_connadd_req *req, =
struct socket *ctrl_sock,
 		goto failed;
 	}
=20
+	session->conn =3D hidp_find_connection(session);
+	if (!session->conn)
+		goto failed;
+
 	bacpy(&session->bdaddr, &bt_sk(ctrl_sock->sk)->dst);
=20
 	session->ctrl_mtu =3D min_t(uint, l2cap_pi(ctrl_sock->sk)->chan->omtu,
@@ -1000,6 +1004,8 @@ int hidp_add_connection(struct hidp_connadd_req *req,=
 struct socket *ctrl_sock,
 	session->flags   =3D req->flags & (1 << HIDP_BLUETOOTH_VENDOR_ID);
 	session->idle_to =3D req->idle_to;
=20
+	__hidp_link_session(session);
+
 	if (req->rd_size > 0) {
 		err =3D hidp_setup_hid(session, req);
 		if (err && err !=3D -ENODEV)
@@ -1012,8 +1018,6 @@ int hidp_add_connection(struct hidp_connadd_req *req,=
 struct socket *ctrl_sock,
 			goto purge;
 	}
=20
-	__hidp_link_session(session);
-
 	hidp_set_timer(session);
=20
 	if (session->hid) {
@@ -1062,8 +1066,6 @@ int hidp_add_connection(struct hidp_connadd_req *req,=
 struct socket *ctrl_sock,
 unlink:
 	hidp_del_timer(session);
=20
-	__hidp_unlink_session(session);
-
 	if (session->input) {
 		input_unregister_device(session->input);
 		session->input =3D NULL;
@@ -1076,6 +1078,8 @@ unlink:
 	session->rd_data =3D NULL;
=20
 purge:
+	__hidp_unlink_session(session);
+
 	skb_queue_purge(&session->ctrl_transmit);
 	skb_queue_purge(&session->intr_transmit);
=20
--=20

Regards,
Peter Hurley
