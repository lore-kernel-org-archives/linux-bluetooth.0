Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 6/6] shared: Use gcc builtin instead of g_atomic
Date: Mon,  8 Apr 2013 17:56:22 -0300
Message-Id: <1365454582-12781-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1365454582-12781-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1365454582-12781-1-git-send-email-lucas.demarchi@profusion.mobi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_atomic_* end up using G_STATIC_ASSERT, causing gcc 4.8 to yell due to
-Wunused-local-typedefs.

/usr/include/glib-2.0/glib/gmacros.h:162:53: error: typedef ‘_GStaticAssertCompileTimeAssertion_2’ locally defined but not used [-Werror=unused-local-typedefs]
 #define G_STATIC_ASSERT(expr) typedef char G_PASTE (_GStaticAssertCompileTimeAssertion_, __COUNTER__)[(expr) ? 1 : -1]
---
 src/shared/hciemu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/hciemu.c b/src/shared/hciemu.c
index 97ea84e..60a4f47 100644
--- a/src/shared/hciemu.c
+++ b/src/shared/hciemu.c
@@ -308,7 +308,7 @@ struct hciemu *hciemu_ref(struct hciemu *hciemu)
 	if (!hciemu)
 		return NULL;
 
-	g_atomic_int_inc(&hciemu->ref_count);
+	__sync_fetch_and_add(&hciemu->ref_count, 1);
 
 	return hciemu;
 }
@@ -318,7 +318,7 @@ void hciemu_unref(struct hciemu *hciemu)
 	if (!hciemu)
 		return;
 
-	if (g_atomic_int_dec_and_test(&hciemu->ref_count) == FALSE)
+	if (__sync_sub_and_fetch(&hciemu->ref_count, 1) > 0)
 		return;
 
 	g_list_foreach(hciemu->post_command_hooks, destroy_command_hook, NULL);
-- 
1.8.2.1

