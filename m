Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/10] telephony-ofono: fix not setting originating when status property changes
Date: Wed,  5 Jan 2011 17:59:40 +0200
Message-Id: <1294243187-1849-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
References: <1294243187-1849-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/telephony-ofono.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-ofono.c b/audio/telephony-ofono.c
index 4f69673..720b32d 100644
--- a/audio/telephony-ofono.c
+++ b/audio/telephony-ofono.c
@@ -834,6 +834,7 @@ static gboolean handle_vc_property_changed(DBusConnection *conn,
 					"callsetup", EV_CALLSETUP_ALERTING);
 			vc->status = CALL_STATUS_ALERTING;
 			DBG("vc status is CALL_STATUS_ALERTING");
+			vc->originating = TRUE;
 		} else if (g_str_equal(state, "incoming")) {
 			/* state change from waiting to incoming */
 			telephony_update_indicator(ofono_indicators,
@@ -842,6 +843,7 @@ static gboolean handle_vc_property_changed(DBusConnection *conn,
 						NUMBER_TYPE_TELEPHONY);
 			vc->status = CALL_STATUS_INCOMING;
 			DBG("vc status is CALL_STATUS_INCOMING");
+			vc->originating = FALSE;
 		}
 	}
 
-- 
1.7.1

