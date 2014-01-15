Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/4] android: Add simple rotation of snoop file
Date: Wed, 15 Jan 2014 22:01:36 +0100
Message-Id: <1389819699-12055-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Already existing snoop file is renamed by adding ".old" suffix before
new one is created. This is useful in case phone is restarted so logs
are not overwritten and for this reason it's only applied in case
default snoop file name is used.
---
 android/bluetoothd-snoop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/bluetoothd-snoop.c b/android/bluetoothd-snoop.c
index 02f44e9..23e0bfd 100644
--- a/android/bluetoothd-snoop.c
+++ b/android/bluetoothd-snoop.c
@@ -206,6 +206,9 @@ int main(int argc, char *argv[])
 
 	mainloop_set_signal(&mask, signal_callback, NULL, NULL);
 
+	if (!strcmp(DEFAULT_SNOOP_FILE, path))
+		rename(DEFAULT_SNOOP_FILE, DEFAULT_SNOOP_FILE ".old");
+
 	if (open_monitor(path) < 0) {
 		printf("Failed to start bluetoothd_snoop\n");
 		return EXIT_FAILURE;
-- 
1.8.5.2

