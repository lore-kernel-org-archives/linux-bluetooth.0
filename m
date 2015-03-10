Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] shared/att: Add bt_att_has_crypto
Date: Tue, 10 Mar 2015 15:31:37 +0200
Message-Id: <1425994298-2883-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1425994298-2883-1-git-send-email-luiz.dentz@gmail.com>
References: <1425994298-2883-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the possibility to check if bt_att has crypto enabled.
---
 src/shared/att.c | 8 ++++++++
 src/shared/att.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 7671d67..422cc2c 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -1426,3 +1426,11 @@ bool bt_att_set_remote_key(struct bt_att *att, uint8_t sign_key[16],
 
 	return sign_set_key(&att->remote_sign, sign_key, func, user_data);
 }
+
+bool bt_att_has_crypto(struct bt_att *att)
+{
+	if (!att)
+		return false;
+
+	return att->crypto ? true : false;
+}
diff --git a/src/shared/att.h b/src/shared/att.h
index a440aaf..fb6247e 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -90,3 +90,4 @@ bool bt_att_set_local_key(struct bt_att *att, uint8_t sign_key[16],
 			bt_att_counter_func_t func, void *user_data);
 bool bt_att_set_remote_key(struct bt_att *att, uint8_t sign_key[16],
 			bt_att_counter_func_t func, void *user_data);
+bool bt_att_has_crypto(struct bt_att *att);
-- 
2.1.0

