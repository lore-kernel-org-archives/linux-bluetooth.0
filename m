Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/3] core: Remove reference to old "mgmtops" name
Date: Tue, 18 Dec 2012 21:16:15 -0400
Message-Id: <1355879775-5809-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1355879775-5809-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1355879775-5809-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/mgmt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mgmt.c b/src/mgmt.c
index 17518cb..f10bd15 100644
--- a/src/mgmt.c
+++ b/src/mgmt.c
@@ -1155,7 +1155,7 @@ static void read_info_complete(int sk, uint16_t index, void *buf, size_t len)
 	adapter = btd_manager_register_adapter(index,
 					mgmt_powered(info->current_settings));
 	if (adapter == NULL) {
-		error("mgmtops: unable to register adapter");
+		error("mgmt: unable to register adapter");
 		return;
 	}
 
-- 
1.7.9.5

