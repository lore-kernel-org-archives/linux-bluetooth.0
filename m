Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH 2/6] android: Fetch remote device uuids after pairing
Date: Tue, 5 Nov 2013 11:33:29 +0100
Message-ID: <1383647613-14951-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1383647613-14951-1-git-send-email-marcin.kraglak@tieto.com>
References: <1383647613-14951-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Android framework expects list of bonded device's uuids.
Start sdp query after setting bond state to BOND_STATE_BONBED.
---
 android/adapter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index 027af25..692ffe4 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -382,6 +382,8 @@ static void new_link_key_callback(uint16_t index, uint16_t length,
 
 	send_bond_state_change(&addr->bdaddr, HAL_STATUS_SUCCESS,
 							HAL_BOND_STATE_BONDED);
+
+	fetch_remote_uuids(&addr->bdaddr);
 }
 
 static void pin_code_request_callback(uint16_t index, uint16_t length,
-- 
1.8.4.1

