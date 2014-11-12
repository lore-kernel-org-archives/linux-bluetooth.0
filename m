Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] android/client: Fix help for bt create_bond() command
Date: Wed, 12 Nov 2014 11:09:21 +0200
Message-Id: <1415783361-11991-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1415783361-11991-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1415783361-11991-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-bt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index f83e148..2b9c455 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -876,7 +876,11 @@ static struct method methods[] = {
 	STD_METHODCH(get_remote_services, "<addr>"),
 	STD_METHOD(start_discovery),
 	STD_METHOD(cancel_discovery),
+#if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
+	STD_METHODCH(create_bond, "<addr> [<transport>]"),
+#else
 	STD_METHODCH(create_bond, "<addr>"),
+#endif
 	STD_METHODCH(remove_bond, "<addr>"),
 	STD_METHODCH(cancel_bond, "<addr>"),
 	STD_METHODCH(pin_reply, "<address> [<pin>]"),
-- 
1.9.1

