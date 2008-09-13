Return-Path: <cyrus@holtmann.org>
Message-ID: <48CC2BEE.7020207@free.fr>
Date: Sat, 13 Sep 2008 23:09:02 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>,
 Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-devel] Sniff mode issues regarding Sony Ericsson	headsets:
 kernel	patch proposal.
References: <48BEE75C.9050008@free.fr> <1220471377.6714.52.camel@californication>
In-Reply-To: <1220471377.6714.52.camel@californication>
Content-Type: multipart/mixed;
 boundary="------------060102010000030708060304"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060102010000030708060304
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

Here are patches against 2.6.27-rc6 and latest bluez git that add 
support for point 1 below.

Please tell me how you feel about them...

Cheers,

Fabien

> 
> Also this is not BlueZ screwing anything up. Where is written that we
> have to get out of sniff mode before we can disconnect a link. What kind
> of hardware are you using? Does BlueZ always have to cleanup after
> broken hardware and f*cked up stacks?
> 
>> Conclusion: to have those bloody Sony Erisson headsets working we have 
>> to change two things in the kernel:
>>   1) Provide a way for a L2CAP socket user to alter sniff mode exit 
>> behaviour
>>   2) Make sure we exit sniff mode before to disconnect
>>
>> Question 1: Are you interested in reviewing then merging my patches if i 
>> try to fix thoses issues ?
>> Question 2: I have the gut feeling that we should change default 
>> behaviour to the behaviour required by those headsets, and provide a 
>> socket option for the bluetooth HID, rather than the other way round. 
>> What do you think ?
>>
>> If we can come on an agreement on the proper way to fix this issue then 
>> i should come with a patch in a 3-4 days timeframe.
> 
> Make it two separate patches. We can send the exit sniff mode command
> that is not a problem. I still don't like it, because it is the job of
> the Link Manager to do this.
> 
> For the sniff mode setting you have to use SOL_BLUETOOTH since I will
> remove all the other SOL_* and consolidate them.
> 
> Regards
> 
> Marcel
> 
> 
> 
> -------------------------------------------------------------------------
> This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
> Build the coolest Linux based applications with Moblin SDK & win great prizes
> Grand prize is a trip for two to an Open Source event anywhere in the world
> http://moblin-contest.org/redirect.php?banner_id=100&url=/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
> 
> 


--------------060102010000030708060304
Content-Type: text/x-patch;
 name="0001-Add-L2CAP_FORCE_ACTIVE_MODE-constant.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Add-L2CAP_FORCE_ACTIVE_MODE-constant.patch"

>From 7fdff17d92d6723de518e5c1bc39bd8fab981757 Mon Sep 17 00:00:00 2001
From: Fabien Chevalier <fabchevalier@free.fr>
Date: Sat, 13 Sep 2008 19:30:04 +0200
Subject: [PATCH] Add L2CAP_FORCE_ACTIVE_MODE constant

---
 include/l2cap.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/include/l2cap.h b/include/l2cap.h
index 0c22d48..78ddcb4 100644
--- a/include/l2cap.h
+++ b/include/l2cap.h
@@ -66,6 +66,8 @@ struct l2cap_conninfo {
 #define L2CAP_LM_RELIABLE	0x0010
 #define L2CAP_LM_SECURE		0x0020
 
+#define L2CAP_FORCE_ACTIVE_MODE 0x04
+
 /* L2CAP command codes */
 #define L2CAP_COMMAND_REJ	0x01
 #define L2CAP_CONN_REQ		0x02
-- 
1.5.6.5


--------------060102010000030708060304
Content-Type: text/x-patch;
 name="0002-Set-L2CAP_FORCE_ACTIVE_MODE-on-for-incoming-and-outg.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0002-Set-L2CAP_FORCE_ACTIVE_MODE-on-for-incoming-and-outg.pa";
 filename*1="tch"

>From 3146919310fdb65da55c62c353a96b9593b714de Mon Sep 17 00:00:00 2001
From: Fabien Chevalier <fabchevalier@free.fr>
Date: Sat, 13 Sep 2008 19:30:26 +0200
Subject: [PATCH] Set L2CAP_FORCE_ACTIVE_MODE on for incoming and outgoing AVDTP/AVRCP channels

---
 audio/avdtp.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/audio/avdtp.c b/audio/avdtp.c
index 4ba94ad..4af19df 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -1532,6 +1532,7 @@ static void l2cap_connect_cb(GIOChannel *chan, int err, const bdaddr_t *src,
 	socklen_t len;
 	int sk;
 	char address[18];
+	uint32_t force_active_mode;
 
 	if (!g_slist_find(sessions, session)) {
 		debug("l2cap_connect_cb: session got removed");
@@ -1565,6 +1566,16 @@ static void l2cap_connect_cb(GIOChannel *chan, int err, const bdaddr_t *src,
 		goto failed;
 	}
 
+	force_active_mode = 1;
+	if (setsockopt(sk, SOL_BLUETOOTH, L2CAP_FORCE_ACTIVE_MODE, &force_active_mode,
+				sizeof(force_active_mode)) < 0) {
+		err = -errno;
+		info("setsockopt L2CAP_FORCE_ACTIVE_MODE failed, some headsets may "
+		"take longer than needed to reconnect");
+		/* Continue even in case of failure, as this option is not 
+		 * mandatory to support */
+	}
+	
 	if (session->state == AVDTP_SESSION_STATE_CONNECTING) {
 		struct audio_device *dev;
 
@@ -2748,6 +2759,7 @@ static void avdtp_server_cb(GIOChannel *chan, int err, const bdaddr_t *src,
 	struct l2cap_options l2o;
 	struct avdtp *session;
 	char address[18];
+	uint32_t force_active_mode;
 
 	if (err < 0) {
 		error("accept: %s (%d)", strerror(-err), -err);
@@ -2779,6 +2791,16 @@ static void avdtp_server_cb(GIOChannel *chan, int err, const bdaddr_t *src,
 		goto drop;
 	}
 
+	force_active_mode = 1;
+	if (setsockopt(sk, SOL_BLUETOOTH, L2CAP_FORCE_ACTIVE_MODE, &force_active_mode,
+				sizeof(force_active_mode)) < 0) {
+		err = -errno;
+		info("setsockopt L2CAP_FORCE_ACTIVE_MODE failed, some headsets may "
+		"take longer than needed to reconnect");
+		/* Continue even in case of failure, as this option is not 
+		 * mandatory to support */
+	}
+
 	session->mtu = l2o.imtu;
 	session->sock = sk;
 
-- 
1.5.6.5


--------------060102010000030708060304
Content-Type: text/x-patch;
 name="0001-Port-sniff-mode-fixes-from-2.6.27-rc5.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Port-sniff-mode-fixes-from-2.6.27-rc5.patch"

>From 623078406e581c1ca79baf430ddf83219f6aa9ca Mon Sep 17 00:00:00 2001
From: Fabien Chevalier <fabchevalier@free.fr>
Date: Sat, 13 Sep 2008 16:11:33 +0200
Subject: [PATCH] Port sniff mode fixes from 2.6.27-rc5

---
 include/net/bluetooth/hci_core.h |    1 +
 include/net/bluetooth/l2cap.h    |    2 ++
 net/bluetooth/hci_conn.c         |    6 +++++-
 net/bluetooth/l2cap.c            |   25 +++++++++++++++++++++++++
 4 files changed, 33 insertions(+), 1 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 46a43b7..352c4ce 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -170,6 +170,7 @@ struct hci_conn {
 	__u32		 link_mode;
 	__u8             auth_type;
 	__u8             power_save;
+	__u8             force_active_mode;
 	unsigned long	 pend;
 
 	unsigned int	 sent;
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 73e115b..917fa6b 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -62,6 +62,8 @@ struct l2cap_conninfo {
 #define L2CAP_LM_RELIABLE	0x0010
 #define L2CAP_LM_SECURE		0x0020
 
+#define L2CAP_FORCE_ACTIVE_MODE	0x04
+
 /* L2CAP command codes */
 #define L2CAP_COMMAND_REJ 0x01
 #define L2CAP_CONN_REQ    0x02
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b700242..7df1f4a 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -214,6 +214,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	conn->state = BT_OPEN;
 
 	conn->power_save = 1;
+	conn->force_active_mode = 0;
 
 	switch (type) {
 	case ACL_LINK:
@@ -479,7 +480,10 @@ void hci_conn_enter_active_mode(struct hci_conn *conn)
 	if (test_bit(HCI_RAW, &hdev->flags))
 		return;
 
-	if (conn->mode != HCI_CM_SNIFF || !conn->power_save)
+	if (conn->mode != HCI_CM_SNIFF)
+		goto timer;
+
+	if (!conn->power_save && !conn->force_active_mode)
 		goto timer;
 
 	if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend)) {
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 9610a9c..9925bdc 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -1148,6 +1148,20 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 		l2cap_pi(sk)->link_mode = opt;
 		break;
 
+	case L2CAP_FORCE_ACTIVE_MODE:
+		if (sk->sk_state != BT_CONNECTED) {
+			err = -ENOTCONN;
+			break;
+		}
+
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+
+		l2cap_pi(sk)->conn->hcon->force_active_mode = opt;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -1204,6 +1218,17 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 
 		break;
 
+	case L2CAP_FORCE_ACTIVE_MODE:
+		if (sk->sk_state != BT_CONNECTED) {
+			err = -ENOTCONN;
+			break;
+		}
+
+		if (put_user(l2cap_pi(sk)->conn->hcon->force_active_mode,
+				 (u32 __user *) optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
-- 
1.5.6.5


--------------060102010000030708060304--
