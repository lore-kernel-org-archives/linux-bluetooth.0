Return-Path: <cyrus@holtmann.org>
From: Anupam Roy <anupam.r@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com, Anupam Roy <anupam.r@samsung.com>
Subject: [PATCH] MyPAtch
Date: Tue, 21 Jul 2015 07:14:39 -0400
Message-id: <1437477279-23335-1-git-send-email-anupam.r@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Anupam Roy <anupam.r@samsung.com>
---
 file.patch | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 file.patch

diff --git a/file.patch b/file.patch
new file mode 100644
index 0000000..f689afe
--- /dev/null
+++ b/file.patch
@@ -0,0 +1,54 @@
+>------- Original Message -------
+>Sender : Anupam Roy<anupam.r@samsung.com> Chief Engineer/SRI-Delhi-SWC Group/Samsung Electronics
+>Date : Jun 26, 2015 22:05 (GMT+09:00)
+>Title : [PATCH] tools/obex-client-tool.c: Fix memory leak in obex-client-tool
+>
+>GOptionContext object should be freed in case socket connection
+>fails and program execution is terminated.
+>
+>==12968== HEAP SUMMARY:
+>==12968==     in use at exit: 2,895 bytes in 14 blocks
+>==12968==   total heap usage: 23 allocs, 9 frees, 36,669 bytes allocated
+>==12968==
+>==12968== 624 (88 direct, 536 indirect) bytes in 1 blocks are definitely lost in loss record 13 of 14
+>==12968==    at 0x4C2CC70: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
+>==12968==    by 0x4E85668: g_malloc0 (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
+>==12968==    by 0x4E89D22: g_option_context_new (in /lib/x86_64-linux-gnu/libglib-2.0.so.0.4002.0)
+>==12968==    by 0x402BAB: main (obex-client-tool.c:428)
+>==12968==
+>==12968== LEAK SUMMARY:
+>==12968==    definitely lost: 88 bytes in 1 blocks
+>==12968==    indirectly lost: 536 bytes in 2 blocks
+>==12968==      possibly lost: 0 bytes in 0 blocks
+>==12968==    still reachable: 2,271 bytes in 11 blocks
+>==12968==         suppressed: 0 bytes in 0 blocks
+>---
+>tools/obex-client-tool.c | 5 ++++-
+>1 file changed, 4 insertions(+), 1 deletion(-)
+>
+>diff --git a/tools/obex-client-tool.c b/tools/obex-client-tool.c
+>index 4f931f6..d0ba8a6 100644
+>--- a/tools/obex-client-tool.c
+>+++ b/tools/obex-client-tool.c
+>@@ -432,6 +432,7 @@ int main(int argc, char *argv[])
+>if (err != NULL) {
+>g_printerr("%s\n", err->message);
+>g_error_free(err);
+>+ g_option_context_free(context);
+>exit(EXIT_FAILURE);
+>}
+>
+>@@ -445,8 +446,10 @@ int main(int argc, char *argv[])
+>else
+>io = unix_connect(transport);
+>
+>- if (io == NULL)
+>+ if (io == NULL) {
+>+ g_option_context_free(context);
+>exit(EXIT_FAILURE);
+>+ }
+>
+>memset(&sa, 0, sizeof(sa));
+>sa.sa_handler = sig_term;
+>-- 
+>1.9.1
-- 
1.9.1

