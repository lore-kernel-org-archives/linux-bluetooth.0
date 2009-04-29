Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH] Exit bluetoothd if adapter_ops registration fails.
Date: Wed, 29 Apr 2009 20:26:46 +0530
Message-Id: <1241017006-4278-1-git-send-email-alok.barsode@azingo.com>
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/adapter.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 0e5d659..0ad5717 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -3112,8 +3112,8 @@ void adapter_ops_setup()
 	int err;
 
 	if (!adapter_ops) {
-		info("No adapter_ops registered.");
-		return;
+		info("adapter_ops registration failed. hciops plugin is not loaded.");
+		exit(1);
 	}
 
 	err = adapter_ops->setup();
-- 
1.5.6.3
