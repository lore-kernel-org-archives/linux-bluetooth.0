Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 5/9] android/hal: Print adapter state
Date: Tue, 29 Oct 2013 14:57:35 +0200
Message-Id: <1383051459-29495-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383051459-29495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383051459-29495-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-bluetooth.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 85ccded..4d467ee 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -33,6 +33,8 @@ static void handle_adapter_state_changed(void *buf)
 {
 	struct hal_ev_adapter_state_changed *ev = buf;
 
+	DBG("state: %s", bt_state_t2str(ev->state));
+
 	if (bt_hal_cbacks->adapter_state_changed_cb)
 		bt_hal_cbacks->adapter_state_changed_cb(ev->state);
 }
-- 
1.7.10.4

