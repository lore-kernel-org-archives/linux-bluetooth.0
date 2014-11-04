Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 5/6] android/tester: Use dummy parameter in create_bond()
Date: Tue,  4 Nov 2014 14:24:49 +0200
Message-Id: <1415103890-24375-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415103890-24375-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415103890-24375-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/tester-main.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 515c69e..22224cc 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -19,6 +19,7 @@
 #include "src/shared/util.h"
 #include "emulator/bthost.h"
 #include "tester-main.h"
+#include "hal-msg.h"
 
 #include "monitor/bt.h"
 
@@ -2904,8 +2905,11 @@ void bt_create_bond_action(void)
 		return;
 	}
 
+	/* TODO: take into account transport parameter */
+
 	step->action_status =
-			data->if_bluetooth->create_bond(action_data->addr);
+			data->if_bluetooth->create_bond(action_data->addr,
+							BT_TRANSPORT_UNKNOWN);
 
 	schedule_action_verification(step);
 }
-- 
1.9.1

