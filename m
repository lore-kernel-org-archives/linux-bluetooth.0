Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH 1/4] telephony-maemo5: Fix D-Bus reply memory leaks
Date: Tue, 06 Dec 2011 20:29:15 +0530
Message-id: <1323183558-26574-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/telephony-maemo5.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index 23801c0..2832062 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -1599,12 +1599,12 @@ static void signal_strength_reply(DBusPendingCall *call, void *user_data)
 		error("Unable to parse signal_strength reply: %s, %s",
 							err.name, err.message);
 		dbus_error_free(&err);
-		return;
+		goto done;
 	}
 
 	if (net_err != 0) {
 		error("get_signal_strength failed with code %d", net_err);
-		return;
+		goto done;
 	}
 
 	update_signal_strength(signals_bar);
@@ -1654,12 +1654,12 @@ static void registration_status_reply(DBusPendingCall *call, void *user_data)
 		error("Unable to parse registration_status_change reply:"
 					" %s, %s", err.name, err.message);
 		dbus_error_free(&err);
-		return;
+		goto done;
 	}
 
 	if (net_err != 0) {
 		error("get_registration_status failed with code %d", net_err);
-		return;
+		goto done;
 	}
 
 	update_registration_status(status, lac, cell_id, operator_code,
-- 
1.7.4.1

