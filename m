Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] android/avrcp: Add list player attributes command
Date: Thu, 27 Feb 2014 11:11:30 +0200
Message-Id: <1393492291-15099-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1393492291-15099-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1393492291-15099-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/avrcp-lib.c | 8 ++++++++
 android/avrcp-lib.h | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/android/avrcp-lib.c b/android/avrcp-lib.c
index 6ae8df8..3db5bda 100644
--- a/android/avrcp-lib.c
+++ b/android/avrcp-lib.c
@@ -304,3 +304,11 @@ int avrcp_get_capabilities(struct avrcp *session, uint8_t param,
 				AVRCP_GET_CAPABILITIES, &param, sizeof(param),
 				func, user_data);
 }
+
+int avrcp_list_player_attributes(struct avrcp *session, avctp_rsp_cb func,
+								void *user_data)
+{
+	return avrcp_send_req(session, AVC_CTYPE_STATUS, AVC_SUBUNIT_PANEL,
+				AVRCP_LIST_PLAYER_ATTRIBUTES, NULL, 0,
+				func, user_data);
+}
diff --git a/android/avrcp-lib.h b/android/avrcp-lib.h
index e6e12c1..7283203 100644
--- a/android/avrcp-lib.h
+++ b/android/avrcp-lib.h
@@ -108,3 +108,5 @@ int avrcp_init_uinput(struct avrcp *session, const char *name,
 
 int avrcp_get_capabilities(struct avrcp *session, uint8_t param,
 					avctp_rsp_cb func, void *user_data);
+int avrcp_list_player_attributes(struct avrcp *session, avctp_rsp_cb func,
+							void *user_data);
-- 
1.8.3.2

