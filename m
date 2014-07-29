Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv4 02/12] android/core: Use g_clear_error instead of free and assignment
Date: Tue, 29 Jul 2014 17:20:51 +0300
Message-Id: <1406643661-29323-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1406643661-29323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587306-20020-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
 <1406643661-29323-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

g_clear_error() frees err and set it to NULL. This fixes dead code
warnings from analyzers.
---
 android/bluetooth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index a2ab445..52d816f 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -290,8 +290,7 @@ static void load_adapter_config(void)
 				"General", "DiscoverableTimeout", &gerr);
 	if (gerr) {
 		adapter.discoverable_timeout = DEFAULT_DISCOVERABLE_TIMEOUT;
-		g_error_free(gerr);
-		gerr = NULL;
+		g_clear_error(&gerr);
 	}
 
 	g_key_file_free(key_file);
-- 
1.9.1

