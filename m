Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 2/2] Bluetooth: remove l2cap_load() hack
Date: Wed,  9 Feb 2011 15:17:51 -0200
Message-Id: <1297271871-7458-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1297271871-7458-1-git-send-email-padovan@profusion.mobi>
References: <1297271871-7458-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

l2cap_load() was added to trigger l2cap.ko module loading from the RFCOMM
and BNEP modules. Now that L2CAP module is gone, we don't need it anymore.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/bnep/core.c   |    2 --
 net/bluetooth/l2cap_core.c  |    8 --------
 net/bluetooth/rfcomm/core.c |    2 --
 3 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
index 5868597..03d4d12 100644
--- a/net/bluetooth/bnep/core.c
+++ b/net/bluetooth/bnep/core.c
@@ -708,8 +708,6 @@ static int __init bnep_init(void)
 {
 	char flt[50] = "";
 
-	l2cap_load();
-
 #ifdef CONFIG_BT_BNEP_PROTO_FILTER
 	strcat(flt, "protocol ");
 #endif
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 6f054d9..bd88641 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -3855,13 +3855,5 @@ void l2cap_exit(void)
 	l2cap_cleanup_sockets();
 }
 
-void l2cap_load(void)
-{
-	/* Dummy function to trigger automatic L2CAP module loading by
-	 * other modules that use L2CAP sockets but don't use any other
-	 * symbols from it. */
-}
-EXPORT_SYMBOL(l2cap_load);
-
 module_param(disable_ertm, bool, 0644);
 MODULE_PARM_DESC(disable_ertm, "Disable enhanced retransmission mode");
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 6b83776..c997393 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -2154,8 +2154,6 @@ static int __init rfcomm_init(void)
 {
 	int err;
 
-	l2cap_load();
-
 	hci_register_cb(&rfcomm_cb);
 
 	rfcomm_thread = kthread_run(rfcomm_run, NULL, "krfcommd");
-- 
1.7.4

