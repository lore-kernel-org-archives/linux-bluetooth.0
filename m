Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/4] android: Remove useless extra parenthesis
Date: Thu, 23 Jan 2014 17:24:39 -0400
Message-Id: <1390512281-26541-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1390512281-26541-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1390512281-26541-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/android-tester.c |    4 ++--
 android/bluetooth.c      |    2 +-
 android/ipc-tester.c     |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index e4f95ce..ba9137a 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -518,7 +518,7 @@ static void emulator(int pipe, int hci_index)
 	memset(buf, 0, sizeof(buf));
 
 	len = read(fd, buf, sizeof(buf));
-	if (len <= 0 || (strcmp(buf, "bluetooth.start=daemon")))
+	if (len <= 0 || strcmp(buf, "bluetooth.start=daemon"))
 		goto failed;
 
 	close(pipe);
@@ -1985,7 +1985,7 @@ static bool setup(struct test_data *data)
 	data->bluetoothd_pid = pid;
 
 	len = read(signal_fd[0], buf, sizeof(buf));
-	if (len <= 0 || (strcmp(buf, EMULATOR_SIGNAL))) {
+	if (len <= 0 || strcmp(buf, EMULATOR_SIGNAL)) {
 		close(signal_fd[0]);
 		return false;
 	}
diff --git a/android/bluetooth.c b/android/bluetooth.c
index 4849dab..e2bf668 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -68,7 +68,7 @@
 #define DEFAULT_DISCOVERABLE_TIMEOUT 120
 
 #define BASELEN_PROP_CHANGED (sizeof(struct hal_ev_adapter_props_changed) \
-					+ (sizeof(struct hal_property)))
+					+ sizeof(struct hal_property))
 
 #define BASELEN_REMOTE_DEV_PROP (sizeof(struct hal_ev_remote_device_props) \
 					+ sizeof(struct hal_property))
diff --git a/android/ipc-tester.c b/android/ipc-tester.c
index ed0dd10..8d3e44d 100644
--- a/android/ipc-tester.c
+++ b/android/ipc-tester.c
@@ -264,7 +264,7 @@ static void emulator(int pipe, int hci_index)
 	memset(buf, 0, sizeof(buf));
 
 	len = read(fd, buf, sizeof(buf));
-	if (len <= 0 || (strcmp(buf, "ctl.start=bluetoothd")))
+	if (len <= 0 || strcmp(buf, "ctl.start=bluetoothd"))
 		goto failed;
 
 	close(pipe);
-- 
1.7.9.5

