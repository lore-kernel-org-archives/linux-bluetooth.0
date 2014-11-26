Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/client: Fix no closing bt, audio dev on exit
Date: Wed, 26 Nov 2014 12:43:49 +0100
Message-Id: <1417002229-3354-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1417002229-3354-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1417002229-3354-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Audio, bt hw devices should be closed on exit.

On exit we get:
==696== 80 bytes in 1 blocks are definitely lost in loss record 6 of 13
==696==    at 0x4C2745D: malloc (in
/usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==696==    by 0x6B3E683: open_bluetooth (hal-bluetooth.c:1079)
==696==    by 0x4051C3: init_p (if-bt.c:374)
==696==    by 0x4020F8: process_line (haltest.c:310)
==696==    by 0x401919: main (haltest.c:423)
==696==
==696== 272 bytes in 1 blocks are possibly lost in loss record 10 of 13
==696==    at 0x4C291D4: calloc (in
/usr/lib64/valgrind/vgpreload_memcheck-amd64-linux.so)
==696==    by 0x4011C24: _dl_allocate_tls (in /usr/lib64/ld-2.18.so)
==696==    by 0x534480A: pthread_create@@GLIBC_2.2.5 (in
/usr/lib64/libpthread-2.18.so)
==696==    by 0x5D192AE: audio_open (hal-audio.c:1541)
==696==    by 0x411683: init_p (audio.h:655)
==696==    by 0x4020F8: process_line (haltest.c:310)
==696==    by 0x401907: main (haltest.c:421)
==696==
==696== LEAK SUMMARY:
==696==    definitely lost: 80 bytes in 1 blocks
==696==    indirectly lost: 0 bytes in 0 blocks
==696==      possibly lost: 272 bytes in 1 blocks
==696==    still reachable: 6,236 bytes in 18 blocks
==696==         suppressed: 0 bytes in 0 blocks
---
 android/client/haltest.c |  7 +++++++
 android/client/if-bt.c   | 15 ++++++++++++---
 android/client/if-main.h |  1 +
 3 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/android/client/haltest.c b/android/client/haltest.c
index f19e671..c62be75 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -34,6 +34,8 @@
 #include "pollhandler.h"
 #include "history.h"
 
+static void process_line(char *line_buffer);
+
 const struct interface *interfaces[] = {
 	&audio_if,
 	&sco_if,
@@ -172,6 +174,11 @@ static void help_p(int argc, const char **argv)
 /* quit/exit execution */
 static void quit_p(int argc, const char **argv)
 {
+	char cleanup_audio[] = "audio cleanup";
+
+	close_hw_bt_dev();
+	process_line(cleanup_audio);
+
 	exit(0);
 }
 
diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 22f3f4c..250f826 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -22,6 +22,7 @@
 #include "../hal-msg.h"
 #include "../hal-utils.h"
 
+static hw_device_t *bt_device;
 const bt_interface_t *if_bluetooth;
 
 #define VERIFY_PROP_TYPE_ARG(n, typ) \
@@ -162,6 +163,15 @@ static void add_remote_device_from_props(int num_properties,
 	}
 }
 
+bool close_hw_bt_dev(void)
+{
+	if (!bt_device)
+		return false;
+
+	bt_device->close(bt_device);
+	return true;
+}
+
 static void adapter_state_changed_cb(bt_state_t state)
 {
 	haltest_info("%s: state=%s\n", __func__, bt_state_t2str(state));
@@ -363,7 +373,6 @@ static void init_p(int argc, const char **argv)
 {
 	int err;
 	const hw_module_t *module;
-	hw_device_t *device;
 
 	err = hw_get_module(BT_HARDWARE_MODULE_ID, &module);
 	if (err) {
@@ -371,14 +380,14 @@ static void init_p(int argc, const char **argv)
 		return;
 	}
 
-	err = module->methods->open(module, BT_HARDWARE_MODULE_ID, &device);
+	err = module->methods->open(module, BT_HARDWARE_MODULE_ID, &bt_device);
 	if (err) {
 		haltest_error("module->methods->open returned %d\n", err);
 		return;
 	}
 
 	if_bluetooth =
-		    ((bluetooth_device_t *) device)->get_bluetooth_interface();
+		((bluetooth_device_t *) bt_device)->get_bluetooth_interface();
 	if (!if_bluetooth) {
 		haltest_error("get_bluetooth_interface returned NULL\n");
 		return;
diff --git a/android/client/if-main.h b/android/client/if-main.h
index 96409aa..6a620e4 100644
--- a/android/client/if-main.h
+++ b/android/client/if-main.h
@@ -154,6 +154,7 @@ const char *enum_devices(void *v, int i);
 const char *interface_name(void *v, int i);
 const char *command_name(void *v, int i);
 void add_remote_device(const bt_bdaddr_t *addr);
+bool close_hw_bt_dev(void);
 
 const struct interface *get_interface(const char *name);
 struct method *get_method(struct method *methods, const char *name);
-- 
1.9.3

