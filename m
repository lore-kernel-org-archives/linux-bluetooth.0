Return-Path: <cyrus@holtmann.org>
From: Keng-Yu Lin <kengyu@ubuntu.com>
To: linux-bluetooth@vger.kernel.org
Cc: Keng-Yu Lin <kengyu@ubuntu.com>
Subject: [RFC] Bluez: Fix the adapter is not initialised after resume
Date: Thu, 13 Oct 2011 09:35:12 +0800
Message-Id: <1318469712-6639-1-git-send-email-kengyu@ubuntu.com>
In-Reply-To: <CADXHx7Z=9EFEweZ+LouXWdRePu6OBrj36uGA78=BMKjo0oMEJQ@mail.gmail.com>
References: <CADXHx7Z=9EFEweZ+LouXWdRePu6OBrj36uGA78=BMKjo0oMEJQ@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

init_adapter() is not called due to missing HCI commands of
read_bd_addr, read_local_version, read_local_features,
and read_local_name on some machines.
---
 plugins/hciops.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

 Please see the links of the bug in different distros:
   https://bugzilla.redhat.com/show_bug.cgi?id=727106
   http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=614929
   https://launchpad.net/bugs/824144
   https://launchpad.net/bugs/824633
   https://launchpad.net/bugs/823467
   https://launchpad.net/bugs/822705

 It is confirmed that this patch fixes for Dell Latutude 2120
 and EeePC 1001PXD.

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 9fb28c8..5f339c1 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -2502,8 +2502,8 @@ static void device_devup_setup(int index)
 	hci_send_cmd(dev->sk, OGF_HOST_CTL, OCF_READ_STORED_LINK_KEY,
 					READ_STORED_LINK_KEY_CP_SIZE, &cp);
 
-	if (!dev->pending)
-		init_adapter(index);
+	DBG("dev->pending=%d", dev->pending);
+	init_adapter(index);
 }
 
 static void init_pending(int index)
-- 
1.7.5.4

