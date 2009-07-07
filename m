Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Jul 2009 09:13:25 +0200
From: Stefan Seyfried <seife@suse.de>
To: BlueZ devel list <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Fix build with ./configure-bootstrap
Message-ID: <20090707091325.38dec13a@stoetzler>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hciops.c: In function ‘hciops_exit’:
hciops.c:728: error: call to function ‘btd_adapter_cleanup_ops’
              without a real prototype
---
 plugins/hciops.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 659f754..6baed76 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -725,7 +725,7 @@ static int hciops_init(void)
 }
 static void hciops_exit(void)
 {
-	btd_adapter_cleanup_ops(&hci_ops);
+	btd_adapter_cleanup_ops();
 }
 
 BLUETOOTH_PLUGIN_DEFINE(hciops, VERSION,
-- 
1.6.3.2
