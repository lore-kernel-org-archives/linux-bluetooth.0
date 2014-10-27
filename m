Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 4/7] tools/btgatt-client: Fix off-by-one error.
Date: Mon, 27 Oct 2014 07:35:39 -0700
Message-Id: <1414420542-15336-5-git-send-email-armansito@chromium.org>
In-Reply-To: <1414420542-15336-1-git-send-email-armansito@chromium.org>
References: <1414420542-15336-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes an error in write-long-value command that caused an
extra invalid byte to get sent at the end of the long write value.
---
 tools/btgatt-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
index e7cd31c..ea9acb7 100644
--- a/tools/btgatt-client.c
+++ b/tools/btgatt-client.c
@@ -709,7 +709,7 @@ static void cmd_write_long_value(struct client *cli, char *cmd_str)
 		return;
 	}
 
-	length = argc - 1;
+	length = argc - 2;
 
 	if (length > 0) {
 		if (length > UINT16_MAX) {
-- 
2.1.0.rc2.206.gedb03e5

