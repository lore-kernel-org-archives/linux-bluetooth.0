Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 03/11] android/gatt: Fix memory leak
Date: Wed, 18 Jun 2014 16:33:46 +0300
Message-Id: <1403098434-28193-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1403098434-28193-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1402905472-17643-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1403098434-28193-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes clang warnings:
...
android/gatt.c:2823:1: warning: Potential leak of memory pointed to by
'cb_data'
...
---
 android/gatt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 5a13afa..626a65d 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2888,7 +2888,8 @@ static void handle_client_write_characteristic(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	if (cmd->write_type != GATT_WRITE_TYPE_NO_RESPONSE) {
+	if (cmd->write_type != GATT_WRITE_TYPE_NO_RESPONSE &&
+				cmd->write_type != GATT_WRITE_TYPE_SIGNED) {
 		cb_data = create_char_op_data(cmd->conn_id, &srvc->id, &ch->id,
 						cmd->srvc_id.is_primary);
 		if (!cb_data) {
-- 
1.8.3.2

