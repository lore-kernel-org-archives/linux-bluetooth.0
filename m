Return-Path: <cyrus@holtmann.org>
Message-ID: <486A6392.6080008@access-company.com>
Date: Tue, 01 Jul 2008 19:04:18 +0200
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_Dalleau?= <frederic.dalleau@access-company.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <48075B6A.2060308@access-company.com>	<1209058941.12684.37.camel@violet.holtmann.net>	<48355289.7070906@access-company.com>	<5D487EED-A2B2-4AEA-AA7B-9EC8681157C0@holtmann.org>
	<48357D9C.9080009@access-company.com>
In-Reply-To: <48357D9C.9080009@access-company.com>
Content-Type: multipart/mixed; boundary="------------010103000302050103000407"
Subject: Re: [Bluez-devel] [patch] BNEP/PAN Qualification issues
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------010103000302050103000407
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Marcel, Luiz

>>> A part of the patch si to move handling of incoming setup_conn_req  
>>> in kernel. In order to keep pan working with older kernel, some  
>>> differenciation must be done. How to achieve this ?
>>>     
>>>       
>> I don't know yet. Can we first fix the issues that don't need  
>> modifications within the kernel. I prefer not modifying the kernel at  
>> all at the moment. 
>>     
>
> I understand.
> My problem is that some tests require grouping several messages into 
> one. In particular, the setup_conn_req can be sent together with a 
> control extension TP/BNEP/CTRL/BV-19-C.
> The current extension processing is to skip everything and I'm not sure 
> the control message can be handled at application level.
>   

I wake up this thread,

I'm working at making this easier to integrate but it will makes a bunch 
of patches.
Let's start with the small and self contained.

Resend patch for bluez-utils, and network service timeout  (after 
SETUP_CONN_REQ is sent and no answer for  30 sec, disconnect)

Other patch adds a parameter to bnep module for disabling header 
compression.

Let me know what you think.
Regards,

Frédéric DALLEAU



--------------010103000302050103000407
Content-Type: text/x-diff;
	name="0006-Add-compress-parameter-to-bnep-module.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0006-Add-compress-parameter-to-bnep-module.patch"

>>From 3aad408454114436898ea668377a44745e9cad52 Mon Sep 17 00:00:00 2001
From: fred <fred@fred-laptop.(none)>
Date: Tue, 1 Jul 2008 15:44:24 +0200
Subject: [PATCH] Add compress parameter to bnep module

---
 net/bluetooth/bnep/core.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index d494b0b..84b00d3 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -62,6 +62,7 @@
 #endif
 
 #define VERSION "1.3"
+static unsigned int compress = 0x03;
 
 static LIST_HEAD(bnep_session_list);
 static DECLARE_RWSEM(bnep_session_sem);
@@ -593,10 +594,10 @@ static inline int bnep_tx_frame(struct bnep_session *s, struct sk_buff *skb)
 	iv[il++] = (struct kvec) { &type, 1 };
 	len++;
 
-	if (!compare_ether_addr(eh->h_dest, s->eh.h_source))
+	if ((compress & 0x01) && !compare_ether_addr(eh->h_dest, s->eh.h_source))
 		type |= 0x01;
 
-	if (!compare_ether_addr(eh->h_source, s->eh.h_dest))
+	if ((compress & 0x02) && !compare_ether_addr(eh->h_source, s->eh.h_dest))
 		type |= 0x02;
 
 	if (type)
@@ -898,6 +899,9 @@ static void __exit bnep_exit(void)
 module_init(bnep_init);
 module_exit(bnep_exit);
 
+module_param(compress, uint, 0644);
+MODULE_PARM_DESC(compress, "Compress BNEP headers before sending (0x01 src, 0x02 dst, 0x03 both)");
+
 MODULE_AUTHOR("David Libault <david.libault@inventel.fr>, Maxim Krasnyansky <maxk@qualcomm.com>");
 MODULE_DESCRIPTION("Bluetooth BNEP ver " VERSION);
 MODULE_VERSION(VERSION);
-- 
1.5.3.GIT


--------------010103000302050103000407
Content-Type: text/x-diff;
	name="utils-0001-Add-30s-timeout-to-setup-connection-phase.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="utils-0001-Add-30s-timeout-to-setup-connection-phase.patch"

>>From 157045ed03558efb120e5ed30e0d334c0ef9b598 Mon Sep 17 00:00:00 2001
From: fred <fred@fred-laptop.(none)>
Date: Tue, 1 Jul 2008 18:30:47 +0200
Subject: [PATCH] Add 30s timeout to setup connection phase

---
 network/connection.c |    6 ++++++
 pand/bnep.c          |    6 ++++++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/network/connection.c b/network/connection.c
index d2fd85c..5b9c293 100644
--- a/network/connection.c
+++ b/network/connection.c
@@ -152,6 +152,7 @@ static gboolean bnep_connect_cb(GIOChannel *chan, GIOCondition cond,
 	int sk;
 	DBusMessage *reply;
 	const char *pdev;
+	struct timeval t = { 0, 0 };
 
 	if (cond & G_IO_NVAL)
 		return FALSE;
@@ -198,6 +199,8 @@ static gboolean bnep_connect_cb(GIOChannel *chan, GIOCondition cond,
 
 	sk = g_io_channel_unix_get_fd(chan);
 
+	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
+
 	if (bnep_connadd(sk, BNEP_SVC_PANU, nc->dev)) {
 		error("%s could not be added", nc->dev);
 		goto failed;
@@ -241,6 +244,7 @@ static int bnep_connect(struct network_conn *nc)
 	unsigned char pkt[BNEP_MTU];
 	GIOChannel *io;
 	int err = 0;
+	struct timeval t = { 30, 0 };
 
 	/* Send request */
 	req = (void *) pkt;
@@ -251,6 +255,8 @@ static int bnep_connect(struct network_conn *nc)
 	s->dst = htons(nc->id);
 	s->src = htons(BNEP_SVC_PANU);
 
+	setsockopt(nc->sk, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
+
 	io = g_io_channel_unix_new(nc->sk);
 	g_io_channel_set_close_on_unref(io, FALSE);
 
diff --git a/pand/bnep.c b/pand/bnep.c
index 604ed55..88c1184 100644
--- a/pand/bnep.c
+++ b/pand/bnep.c
@@ -259,6 +259,7 @@ int bnep_create_connection(int sk, uint16_t role, uint16_t svc, char *dev)
 	struct __service_16 *s;
 	unsigned char pkt[BNEP_MTU];
 	int r;
+	struct timeval t = { 30, 0 };
 
 	/* Send request */
 	req = (void *) pkt;
@@ -269,6 +270,8 @@ int bnep_create_connection(int sk, uint16_t role, uint16_t svc, char *dev)
 	s->dst = htons(svc);
 	s->src = htons(role);
 
+	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
+
 	if (send(sk, pkt, sizeof(*req) + sizeof(*s), 0) < 0)
 		return -1;
 
@@ -278,6 +281,9 @@ receive:
 	if (r <= 0)
 		return -1;
 
+	t.tv_sec = 0;
+	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &t, sizeof(t));
+
 	errno = EPROTO;
 
 	if (r < sizeof(*rsp))
-- 
1.5.3.GIT


--------------010103000302050103000407
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
--------------010103000302050103000407
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------010103000302050103000407--
