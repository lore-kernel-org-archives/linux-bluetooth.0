Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1158313465.5233.3.camel@localhost>
References: <3f5a9ba20609132122ue951876kcdfaacae30110f66@mail.gmail.com>
	<Pine.LNX.4.63.0609141101160.22339@redbean.intranet.gw-instruments.de>
	<450940DC.5080809@infitsrl.com>
	<Pine.LNX.4.63.0609141354070.22339@redbean.intranet.gw-instruments.de>
	<45094871.7010003@infitsrl.com>
	<Pine.LNX.4.63.0609141423350.22339@redbean.intranet.gw-instruments.de>
	<1158313465.5233.3.camel@localhost>
Content-Type: multipart/mixed; boundary="=-EnYsN8xSiAwSKR4DfDK7"
Date: Tue, 26 Sep 2006 23:09:08 +0200
Message-Id: <1159304948.800.39.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] About concurrency sdp_connect
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-EnYsN8xSiAwSKR4DfDK7
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Peter,

> my last attempt to make this work actually failed, but I didn't put much
> energy into it. Feel free to come up with a working version. The path
> how to handle this is clear.

forget whatever I told you to handle this inside L2CAP. It is nearly
impossible to get the locking for this right. I crashed my Quad G5
multiple times today.

So I went back to fix this inside the HCI layer. You can apply the
attached patch on top of 2.6.18-mh3 and it should give you concurrent
connect support for all protocols.

Regards

Marcel


--=-EnYsN8xSiAwSKR4DfDK7
Content-Disposition: attachment; filename=patch
Content-Type: text/x-patch; name=patch; charset=utf-8
Content-Transfer-Encoding: 7bit

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index df22efc..0ace40b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -289,6 +289,22 @@ static inline struct hci_conn *hci_conn_
 	return NULL;
 }
 
+static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
+					__u8 type, __u16 state)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct list_head *p;
+	struct hci_conn  *c;
+
+	list_for_each(p, &h->list) {
+		c = list_entry(p, struct hci_conn, list);
+		if (c->type == type && c->state == state)
+			return c;
+	}
+	return NULL;
+}
+
+void hci_acl_connect(struct hci_conn *conn);
 void hci_acl_disconn(struct hci_conn *conn, __u8 reason);
 void hci_add_sco(struct hci_conn *conn, __u16 handle);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 90e3a28..8d0c7e7 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -51,7 +51,7 @@ #undef  BT_DBG
 #define BT_DBG(D...)
 #endif
 
-static void hci_acl_connect(struct hci_conn *conn)
+void hci_acl_connect(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct inquiry_entry *ie;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index d5693ef..b1b9f12 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -414,9 +414,12 @@ static inline void hci_cs_create_conn(st
 
 	if (status) {
 		if (conn && conn->state == BT_CONNECT) {
-			conn->state = BT_CLOSED;
-			hci_proto_connect_cfm(conn, status);
-			hci_conn_del(conn);
+			if (status != 0x0c) {
+				conn->state = BT_CLOSED;
+				hci_proto_connect_cfm(conn, status);
+				hci_conn_del(conn);
+			} else
+				conn->state = BT_CONNECT2;
 		}
 	} else {
 		if (!conn) {
@@ -728,7 +731,7 @@ static inline void hci_conn_request_evt(
 static inline void hci_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	struct hci_ev_conn_complete *ev = (struct hci_ev_conn_complete *) skb->data;
-	struct hci_conn *conn;
+	struct hci_conn *conn, *pend;
 
 	BT_DBG("%s", hdev->name);
 
@@ -782,6 +785,10 @@ static inline void hci_conn_complete_evt
 		}
 
 		hci_conn_put(conn);
+
+		pend = hci_conn_hash_lookup_state(hdev, ACL_LINK, BT_CONNECT2);
+		if (pend)
+			hci_acl_connect(pend);
 	} else
 		conn->state = BT_CLOSED;
 

--=-EnYsN8xSiAwSKR4DfDK7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--=-EnYsN8xSiAwSKR4DfDK7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-EnYsN8xSiAwSKR4DfDK7--
