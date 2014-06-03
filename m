Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 3/4] tools/btmgmt: Fix io-cap usage message
Date: Tue, 3 Jun 2014 12:13:35 +0200
Message-ID: <1401790416-30962-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1401790416-30962-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1401790416-30962-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/btmgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 412856d..22fc547 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -2355,7 +2355,7 @@ static void io_cap_rsp(uint8_t status, uint16_t len, const void *param,
 
 static void io_cap_usage(void)
 {
-	printf("Usage: btmgmt [cap]\n");
+	printf("Usage: btmgmt io-cap <cap>\n");
 }
 
 static void cmd_io_cap(struct mgmt *mgmt, uint16_t index,
-- 
1.9.3

