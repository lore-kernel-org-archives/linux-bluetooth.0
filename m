Return-Path: <cyrus@holtmann.org>
From: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Jerzy Kasenberg <jerzy.kasenberg@tieto.com>
Subject: [PATCH 1/8] android/client: Export get_interface_method
Date: Fri, 8 Nov 2013 13:48:23 +0100
Message-ID: <1383914910-2304-2-git-send-email-jerzy.kasenberg@tieto.com>
In-Reply-To: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
References: <1383914910-2304-1-git-send-email-jerzy.kasenberg@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This method will be used outside tab completion.c.
---
 android/client/if-main.h       |    2 ++
 android/client/tabcompletion.c |    2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/client/if-main.h b/android/client/if-main.h
index f638b91..647162c 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -141,6 +141,8 @@ void add_remote_device(const bt_bdaddr_t *addr);
 const struct interface *get_interface(const char *name);
 struct method *get_method(struct method *methods, const char *name);
 struct method *get_command(const char *name);
+const struct method *get_interface_method(const char *iname,
+							const char *mname);
 
 /* Helper macro for executing function on interface and printing BT_STATUS */
 #define EXEC(f, ...) \
diff --git a/android/client/tabcompletion.c b/android/client/tabcompletion.c
index 4a6329f..f965620 100644
--- a/android/client/tabcompletion.c
+++ b/android/client/tabcompletion.c
@@ -30,7 +30,7 @@ typedef struct split_arg {
 } split_arg_t;
 
 /* function returns method of given name or NULL if not found */
-static const struct method *get_interface_method(const char *iname,
+const struct method *get_interface_method(const char *iname,
 							const char *mname)
 {
 	const struct interface *iface = get_interface(iname);
-- 
1.7.9.5

