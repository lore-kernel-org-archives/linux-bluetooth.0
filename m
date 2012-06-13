Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon@janc.net.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon@janc.net.pl>
Subject: [PATCH] mgmtops: Fix clearing of pending_cod_change after adapter powered off
Date: Wed, 13 Jun 2012 18:05:13 +0200
Message-Id: <1339603513-15512-1-git-send-email-szymon@janc.net.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/mgmtops.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index ea1552d..16a97c9 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -350,6 +350,7 @@ static int mgmt_update_powered(struct btd_adapter *adapter,
 		info->pending_uuids = NULL;
 		info->pending_uuid = FALSE;
 		info->pending_class = FALSE;
+		info->pending_cod_change = FALSE;
 		return 0;
 	}
 
-- 
1.7.10.4


