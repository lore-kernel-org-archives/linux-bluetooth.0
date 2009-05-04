Return-Path: <cyrus@holtmann.org>
From: alokbarsode@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.com, Alok Barsode <alok.barsode@azingo.com>
Subject: [PATCH 1/3] Do not exit if adapter_ops setup fails.
Date: Mon,  4 May 2009 20:38:12 +0530
Message-Id: <1241449694-17135-1-git-send-email-alok.barsode@azingo.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Alok Barsode <alok.barsode@azingo.com>

---
 src/adapter.c |   15 ++++++++++-----
 src/main.c    |    5 +----
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index df85f6b..7ac361b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -406,9 +406,11 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 	scan_enable = mode2scan(new_mode);
 
 	if (!adapter->up && scan_enable != SCAN_DISABLED) {
-		err = adapter_ops->start(adapter->dev_id);
-		if (err < 0)
-			return err;
+		if (adapter_ops) {
+			err = adapter_ops->start(adapter->dev_id);
+			if (err < 0)
+				return err;
+		}
 	}
 
 	dd = hci_open_dev(adapter->dev_id);
@@ -3095,13 +3097,16 @@ int btd_register_adapter_ops(struct btd_adapter_ops *btd_adapter_ops)
 
 void btd_adapter_cleanup_ops()
 {
-	adapter_ops->cleanup();
+	if (adapter_ops)
+		adapter_ops->cleanup();
 }
 
 int adapter_ops_setup()
 {
-	if (!adapter_ops)
+	if (!adapter_ops) {
+		error("Unable to initialize adapter operations");
 		return -EINVAL;
+	}
 
 	return adapter_ops->setup();
 }
diff --git a/src/main.c b/src/main.c
index 884257f..8dd2cee 100644
--- a/src/main.c
+++ b/src/main.c
@@ -412,10 +412,7 @@ int main(int argc, char *argv[])
 
 	event_loop = g_main_loop_new(NULL, FALSE);
 
-	if (adapter_ops_setup() < 0) {
-		error("adapter_ops_setup failed");
-		exit(1);
-	}
+	adapter_ops_setup();
 
 	starting = FALSE;
 
-- 
1.5.6.3

