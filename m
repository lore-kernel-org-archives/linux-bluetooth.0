Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?=
	<frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] mgmt: fix DBG string format
Date: Tue, 17 May 2011 11:04:38 +0200
Message-Id: <1305623078-15115-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/mgmtops.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/mgmtops.c b/plugins/mgmtops.c
index 5e89046..95de3d1 100644
--- a/plugins/mgmtops.c
+++ b/plugins/mgmtops.c
@@ -501,7 +501,7 @@ static int mgmt_pincode_reply(int index, bdaddr_t *bdaddr, const char *pin,
 	char addr[18];
 
 	ba2str(bdaddr, addr);
-	DBG("index %d addr %s pinlen %lu", index, addr, pin_len);
+	DBG("index %d addr %s pinlen %zu", index, addr, pin_len);
 
 	memset(buf, 0, sizeof(buf));
 
-- 
1.7.1

