Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] Fix setting Discoverable when adapter is down
Date: Thu, 28 Oct 2010 11:00:57 +0300
Message-Id: <1288252859-10337-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1288252859-10337-1-git-send-email-luiz.dentz@gmail.com>
References: <1288252859-10337-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This cause an error because adapter_up will load the mode from storage
ignoring pending mode which cause modes to mismatch.

To fix this behavior now when attempting to change mode we first store
the new mode and wait DEVUP to complete set the mode stored.
---
 src/adapter.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index f4fc3c1..e5f7730 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -533,6 +533,7 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode,
 			DBusMessage *msg)
 {
 	int err;
+	const char *modestr;
 
 	if (adapter->pending_mode != NULL)
 		return -EALREADY;
@@ -541,6 +542,8 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode,
 		err = adapter_ops->set_powered(adapter->dev_id, TRUE);
 		if (err < 0)
 			return err;
+
+		goto done;
 	}
 
 	if (adapter->up && new_mode == MODE_OFF) {
@@ -576,18 +579,18 @@ static int set_mode(struct btd_adapter *adapter, uint8_t new_mode,
 	}
 
 done:
-	DBG("%s", mode2str(new_mode));
+	modestr = mode2str(new_mode);
+	write_device_mode(&adapter->bdaddr, modestr);
+
+	DBG("%s", modestr);
 
 	if (msg != NULL)
 		/* Wait for mode change to reply */
 		adapter->pending_mode = create_session(adapter, connection,
 							msg, new_mode, NULL);
-	else {
+	else
 		/* Nothing to reply just write the new mode */
-		const char *modestr = mode2str(new_mode);
 		adapter->mode = new_mode;
-		write_device_mode(&adapter->bdaddr, modestr);
-	}
 
 	return 0;
 }
@@ -2600,11 +2603,11 @@ static void set_mode_complete(struct btd_adapter *adapter)
 
 	DBG("%s", modestr);
 
-	/* Only store if the mode matches the pending */
-	if (err == 0)
+	/* restore if the mode doesn't matches the pending */
+	if (err != 0) {
 		write_device_mode(&adapter->bdaddr, modestr);
-	else
 		error("unable to set mode: %s", mode2str(pending->mode));
+	}
 
 	session_unref(pending);
 }
-- 
1.7.1

