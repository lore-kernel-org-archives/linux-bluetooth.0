Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 02/19] android/tester-ng: Add android-tester-ng
Date: Thu,  3 Jul 2014 18:00:05 +0200
Message-Id: <1404403222-26911-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404403222-26911-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Based on past experience with android-tester, new android tester is
written from scrath with fixed all known bugs and framework
inadvertancies. Once new test case will be added, same one from old
android tester will be removed, until whole test case list will be
replaced.
---
 android/Makefile.am   |  24 +++
 android/tester-main.c | 503 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/tester-main.h |  86 +++++++++
 3 files changed, 613 insertions(+)
 create mode 100644 android/tester-main.c
 create mode 100644 android/tester-main.h

diff --git a/android/Makefile.am b/android/Makefile.am
index 730be2f..0192935 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -163,6 +163,30 @@ android_android_tester_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
 android_android_tester_LDFLAGS = -pthread -ldl
 
+noinst_PROGRAMS += android/android-tester-ng
+
+android_android_tester_ng_SOURCES = emulator/btdev.h emulator/btdev.c \
+				emulator/bthost.h emulator/bthost.c \
+				emulator/smp.c \
+				src/shared/crypto.h src/shared/crypto.c \
+				src/shared/io.h src/shared/io-glib.c \
+				src/shared/queue.h src/shared/queue.c \
+				src/shared/util.h src/shared/util.c \
+				src/shared/mgmt.h src/shared/mgmt.c \
+				src/shared/hciemu.h src/shared/hciemu.c \
+				src/shared/tester.h src/shared/tester.c \
+				src/shared/timeout.h src/shared/timeout-glib.c \
+				monitor/rfcomm.h \
+				android/hardware/hardware.c \
+				android/tester-main.h android/tester-main.c
+
+android_android_tester_ng_CFLAGS = $(AM_CFLAGS) -I$(srcdir)/android \
+				-DPLUGINDIR=\""$(android_plugindir)"\"
+
+android_android_tester_ng_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
+
+android_android_tester_ng_LDFLAGS = -pthread -ldl
+
 noinst_PROGRAMS += android/ipc-tester
 
 android_ipc_tester_SOURCES = emulator/btdev.h emulator/btdev.c \
diff --git a/android/tester-main.c b/android/tester-main.c
new file mode 100644
index 0000000..8f52286
--- /dev/null
+++ b/android/tester-main.c
@@ -0,0 +1,503 @@
+/*
+ * Copyright (C) 2014 Intel Corporation
+ *
+ * Licensed under the Apache License, Version 2.0 (the "License");
+ * you may not use this file except in compliance with the License.
+ * You may obtain a copy of the License at
+ *
+ *      http://www.apache.org/licenses/LICENSE-2.0
+ *
+ * Unless required by applicable law or agreed to in writing, software
+ * distributed under the License is distributed on an "AS IS" BASIS,
+ * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
+ * See the License for the specific language governing permissions and
+ * limitations under the License.
+ *
+ */
+
+#include "tester-main.h"
+
+static char exec_dir[PATH_MAX + 1];
+
+static gint scheduled_cbacks_num;
+
+#define EMULATOR_SIGNAL_TIMEOUT 2 /* in seconds */
+#define EMULATOR_SIGNAL "emulator_started"
+
+static gboolean check_callbacks_called(gpointer user_data)
+{
+	/*
+	 * Wait for all callbacks scheduled in current test context to execute
+	 * in main loop. This will avoid late callback calls after test case has
+	 * already failed or timed out.
+	 */
+
+	if (g_atomic_int_get(&scheduled_cbacks_num) == 0) {
+		tester_teardown_complete();
+		return FALSE;
+	} else if (scheduled_cbacks_num < 0) {
+		tester_warn("Unscheduled callback called!");
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static void check_daemon_term(void)
+{
+	int status;
+	pid_t pid;
+	struct test_data *data = tester_get_data();
+
+	if (!data)
+		return;
+
+	pid = waitpid(data->bluetoothd_pid, &status, WNOHANG);
+	if (pid != data->bluetoothd_pid)
+		return;
+
+	data->bluetoothd_pid = 0;
+
+	if (WIFEXITED(status) && (WEXITSTATUS(status) == EXIT_SUCCESS)) {
+		g_idle_add(check_callbacks_called, NULL);
+		return;
+	}
+
+	tester_warn("Unexpected Daemon shutdown with status %d", status);
+}
+
+static gboolean signal_handler(GIOChannel *channel, GIOCondition cond,
+							gpointer user_data)
+{
+	struct signalfd_siginfo si;
+	ssize_t result;
+	int fd;
+
+	if (cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP))
+		return FALSE;
+
+	fd = g_io_channel_unix_get_fd(channel);
+
+	result = read(fd, &si, sizeof(si));
+	if (result != sizeof(si))
+		return FALSE;
+
+	switch (si.ssi_signo) {
+	case SIGCHLD:
+		check_daemon_term();
+		break;
+	}
+
+	return TRUE;
+}
+
+static guint setup_signalfd(void)
+{
+	GIOChannel *channel;
+	guint source;
+	sigset_t mask;
+	int fd;
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGCHLD);
+
+	if (sigprocmask(SIG_BLOCK, &mask, NULL) < 0)
+		return 0;
+
+	fd = signalfd(-1, &mask, 0);
+	if (fd < 0)
+		return 0;
+
+	channel = g_io_channel_unix_new(fd);
+
+	g_io_channel_set_close_on_unref(channel, TRUE);
+	g_io_channel_set_encoding(channel, NULL, NULL);
+	g_io_channel_set_buffered(channel, FALSE);
+
+	source = g_io_add_watch(channel,
+				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+				signal_handler, NULL);
+
+	g_io_channel_unref(channel);
+
+	return source;
+}
+
+static void test_post_teardown(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	hciemu_unref(data->hciemu);
+	data->hciemu = NULL;
+
+	g_source_remove(data->signalfd);
+	data->signalfd = 0;
+}
+
+static void bluetoothd_start(int hci_index)
+{
+	char prg_name[PATH_MAX + 1];
+	char index[8];
+	char *prg_argv[5];
+
+	snprintf(prg_name, sizeof(prg_name), "%s/%s", exec_dir, "bluetoothd");
+	snprintf(index, sizeof(index), "%d", hci_index);
+
+	prg_argv[0] = prg_name;
+	prg_argv[1] = "-i";
+	prg_argv[2] = index;
+	prg_argv[3] = "-d";
+	prg_argv[4] = NULL;
+
+	if (!tester_use_debug())
+		fclose(stderr);
+
+	execve(prg_argv[0], prg_argv, NULL);
+}
+
+static void emulator(int pipe, int hci_index)
+{
+	static const char SYSTEM_SOCKET_PATH[] = "\0android_system";
+	char buf[1024];
+	struct sockaddr_un addr;
+	struct timeval tv;
+	int fd;
+	ssize_t len;
+
+	fd = socket(PF_LOCAL, SOCK_DGRAM | SOCK_CLOEXEC, 0);
+	if (fd < 0)
+		goto failed;
+
+	tv.tv_sec = EMULATOR_SIGNAL_TIMEOUT;
+	tv.tv_usec = 0;
+	setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, (char *)&tv, sizeof(tv));
+
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	memcpy(addr.sun_path, SYSTEM_SOCKET_PATH, sizeof(SYSTEM_SOCKET_PATH));
+
+	if (bind(fd, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
+		perror("Failed to bind system socket");
+		goto failed;
+	}
+
+	len = write(pipe, EMULATOR_SIGNAL, sizeof(EMULATOR_SIGNAL));
+	if (len != sizeof(EMULATOR_SIGNAL))
+		goto failed;
+
+	memset(buf, 0, sizeof(buf));
+
+	len = read(fd, buf, sizeof(buf));
+	if (len <= 0 || strcmp(buf, "bluetooth.start=daemon"))
+		goto failed;
+
+	close(pipe);
+	close(fd);
+	return bluetoothd_start(hci_index);
+
+failed:
+	close(pipe);
+
+	if (fd >= 0)
+		close(fd);
+}
+
+static void mgmt_debug(const char *str, void *user_data)
+{
+	const char *prefix = user_data;
+
+	tester_print("%s%s", prefix, str);
+}
+
+static void read_info_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct mgmt_rp_read_info *rp = param;
+	char addr[18];
+	uint16_t manufacturer;
+	uint32_t supported_settings, current_settings;
+
+	tester_print("Read Info callback");
+	tester_print("  Status: 0x%02x", status);
+
+	if (status || !param) {
+		tester_pre_setup_failed();
+		return;
+	}
+
+	ba2str(&rp->bdaddr, addr);
+	manufacturer = btohs(rp->manufacturer);
+	supported_settings = btohl(rp->supported_settings);
+	current_settings = btohl(rp->current_settings);
+
+	tester_print("  Address: %s", addr);
+	tester_print("  Version: 0x%02x", rp->version);
+	tester_print("  Manufacturer: 0x%04x", manufacturer);
+	tester_print("  Supported settings: 0x%08x", supported_settings);
+	tester_print("  Current settings: 0x%08x", current_settings);
+	tester_print("  Class: 0x%02x%02x%02x",
+			rp->dev_class[2], rp->dev_class[1], rp->dev_class[0]);
+	tester_print("  Name: %s", rp->name);
+	tester_print("  Short name: %s", rp->short_name);
+
+	if (strcmp(hciemu_get_address(data->hciemu), addr)) {
+		tester_pre_setup_failed();
+		return;
+	}
+
+	tester_pre_setup_complete();
+}
+
+static void index_added_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	tester_print("Index Added callback");
+	tester_print("  Index: 0x%04x", index);
+
+	data->mgmt_index = index;
+
+	mgmt_send(data->mgmt, MGMT_OP_READ_INFO, data->mgmt_index, 0, NULL,
+					read_info_callback, NULL, NULL);
+}
+
+static void index_removed_callback(uint16_t index, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	tester_print("Index Removed callback");
+	tester_print("  Index: 0x%04x", index);
+
+	if (index != data->mgmt_index)
+		return;
+
+	mgmt_unregister_index(data->mgmt, data->mgmt_index);
+
+	mgmt_unref(data->mgmt);
+	data->mgmt = NULL;
+
+	tester_post_teardown_complete();
+}
+
+static void read_index_list_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	tester_print("Read Index List callback");
+	tester_print("  Status: 0x%02x", status);
+
+	if (status || !param) {
+		tester_pre_setup_failed();
+		return;
+	}
+
+	mgmt_register(data->mgmt, MGMT_EV_INDEX_ADDED, MGMT_INDEX_NONE,
+					index_added_callback, NULL, NULL);
+
+	mgmt_register(data->mgmt, MGMT_EV_INDEX_REMOVED, MGMT_INDEX_NONE,
+					index_removed_callback, NULL, NULL);
+
+	data->hciemu = hciemu_new(data->hciemu_type);
+	if (!data->hciemu) {
+		tester_warn("Failed to setup HCI emulation");
+		tester_pre_setup_failed();
+		return;
+	}
+
+	tester_print("New hciemu instance created");
+}
+
+static void test_pre_setup(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	data->signalfd = setup_signalfd();
+	if (!data->signalfd) {
+		tester_warn("Failed to setup signalfd");
+		tester_pre_setup_failed();
+		return;
+	}
+
+	data->mgmt = mgmt_new_default();
+	if (!data->mgmt) {
+		tester_warn("Failed to setup management interface");
+		tester_pre_setup_failed();
+		return;
+	}
+
+	if (!tester_use_debug())
+		fclose(stderr);
+	else
+		mgmt_set_debug(data->mgmt, mgmt_debug, "mgmt: ", NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_READ_INDEX_LIST, MGMT_INDEX_NONE, 0,
+				NULL, read_index_list_callback, NULL, NULL);
+}
+
+static bt_callbacks_t bt_callbacks = {
+	.size = sizeof(bt_callbacks),
+	.adapter_state_changed_cb = NULL,
+	.adapter_properties_cb = NULL,
+	.remote_device_properties_cb = NULL,
+	.device_found_cb = NULL,
+	.discovery_state_changed_cb = NULL,
+	.pin_request_cb = NULL,
+	.ssp_request_cb = NULL,
+	.bond_state_changed_cb = NULL,
+	.acl_state_changed_cb = NULL,
+	.thread_evt_cb = NULL,
+	.dut_mode_recv_cb = NULL,
+	.le_test_mode_cb = NULL
+};
+
+static bool setup_base(struct test_data *data)
+{
+	const hw_module_t *module;
+	hw_device_t *device;
+	int signal_fd[2];
+	char buf[1024];
+	pid_t pid;
+	int len;
+	int err;
+
+	if (pipe(signal_fd))
+		return false;
+
+	pid = fork();
+
+	if (pid < 0) {
+		close(signal_fd[0]);
+		close(signal_fd[1]);
+		return false;
+	}
+
+	if (pid == 0) {
+		if (!tester_use_debug())
+			fclose(stderr);
+
+		close(signal_fd[0]);
+		emulator(signal_fd[1], data->mgmt_index);
+		exit(0);
+	}
+
+	close(signal_fd[1]);
+	data->bluetoothd_pid = pid;
+
+	len = read(signal_fd[0], buf, sizeof(buf));
+	if (len <= 0 || strcmp(buf, EMULATOR_SIGNAL)) {
+		close(signal_fd[0]);
+		return false;
+	}
+
+	close(signal_fd[0]);
+
+	err = hw_get_module(BT_HARDWARE_MODULE_ID, &module);
+	if (err)
+		return false;
+
+	err = module->methods->open(module, BT_HARDWARE_MODULE_ID, &device);
+	if (err)
+		return false;
+
+	data->device = device;
+
+	data->if_bluetooth = ((bluetooth_device_t *)
+					device)->get_bluetooth_interface();
+	if (!data->if_bluetooth)
+		return false;
+
+	if (!(data->steps = queue_new()))
+		return false;
+
+
+	return true;
+}
+
+static void setup(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	bt_status_t status;
+
+	if (!setup_base(data)) {
+		tester_setup_failed();
+		return;
+	}
+
+	status = data->if_bluetooth->init(&bt_callbacks);
+	if (status != BT_STATUS_SUCCESS) {
+		data->if_bluetooth = NULL;
+		tester_setup_failed();
+		return;
+	}
+
+	tester_setup_complete();
+}
+
+static void teardown(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	queue_destroy(data->steps, NULL);
+	data->steps = NULL;
+
+	if (data->if_bluetooth) {
+		data->if_bluetooth->cleanup();
+		data->if_bluetooth = NULL;
+	}
+
+	data->device->close(data->device);
+
+	if (!data->bluetoothd_pid)
+		tester_teardown_complete();
+}
+
+#define test_bredr(data, test_setup, test, test_teardown) \
+	do { \
+		struct test_data *user; \
+		user = g_malloc0(sizeof(struct test_data)); \
+		if (!user) \
+			break; \
+		user->hciemu_type = HCIEMU_TYPE_BREDR; \
+		user->test_data = data; \
+		tester_add_full(data->title, data, test_pre_setup, \
+					test_setup, test, test_teardown, \
+					test_post_teardown, 3, user, g_free); \
+	} while (0)
+
+#define test_bredrle(data, test_setup, test, test_teardown) \
+	do { \
+		struct test_data *user; \
+		user = g_malloc0(sizeof(struct test_data)); \
+		if (!user) \
+			break; \
+		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
+		user->test_data = data; \
+		tester_add_full(data->title, data, test_pre_setup, \
+					test_setup, test, test_teardown, \
+					test_post_teardown, 3, user, g_free); \
+	} while (0)
+
+static void tester_testcases_cleanup(void)
+{
+}
+
+int main(int argc, char *argv[])
+{
+	snprintf(exec_dir, sizeof(exec_dir), "%s", dirname(argv[0]));
+
+	tester_init(&argc, &argv);
+
+	tester_add_full("Init", NULL, test_pre_setup, setup, NULL, teardown,
+					test_post_teardown, 0, NULL, NULL);
+
+	if (tester_run())
+		return 1;
+
+	tester_testcases_cleanup();
+
+	return 0;
+}
diff --git a/android/tester-main.h b/android/tester-main.h
new file mode 100644
index 0000000..da87c8b
--- /dev/null
+++ b/android/tester-main.h
@@ -0,0 +1,86 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Intel Corporation. All rights reserved.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdlib.h>
+#include <stdbool.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <limits.h>
+
+#include <glib.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <sys/wait.h>
+#include <libgen.h>
+#include <sys/signalfd.h>
+
+#include "lib/bluetooth.h"
+#include "lib/mgmt.h"
+
+#include "src/shared/tester.h"
+#include "src/shared/hciemu.h"
+#include "src/shared/mgmt.h"
+#include "src/shared/queue.h"
+
+#include <hardware/hardware.h>
+#include <hardware/bluetooth.h>
+
+#define get_test_case_step_num(tc) (sizeof(tc) / sizeof(struct step))
+
+struct test_data {
+	struct mgmt *mgmt;
+	struct hw_device_t *device;
+	struct hciemu *hciemu;
+	enum hciemu_type hciemu_type;
+
+	const bt_interface_t *if_bluetooth;
+
+	const void *test_data;
+	struct queue *steps;
+
+	guint signalfd;
+	uint16_t mgmt_index;
+	pid_t bluetoothd_pid;
+};
+
+struct test_case {
+	struct step *step;
+	char *title;
+	uint16_t step_num;
+};
+
+/*
+ * Struct of data to check within step action.
+ */
+struct bt_action_data {
+	uint8_t status;
+};
+
+/*
+ * Step structure contains expected step data and step
+ * action, which should be performed before step check.
+ */
+struct step {
+	void (*action)(void);
+	struct bt_action_data action_result;
+};
-- 
1.9.3

