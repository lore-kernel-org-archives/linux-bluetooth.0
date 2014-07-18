Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/6] android/core: Remove unneeded assignment
Date: Fri, 18 Jul 2014 16:28:27 +0300
Message-Id: <1405690111-27097-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405690111-27097-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587306-20020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1405690111-27097-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/bluetooth.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index a2ab445..5b72a36 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -291,7 +291,6 @@ static void load_adapter_config(void)
 	if (gerr) {
 		adapter.discoverable_timeout = DEFAULT_DISCOVERABLE_TIMEOUT;
 		g_error_free(gerr);
-		gerr = NULL;
 	}
 
 	g_key_file_free(key_file);
-- 
1.9.1

