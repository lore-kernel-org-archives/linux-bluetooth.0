Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/10] android/main: Free enabled string on exit
Date: Thu, 28 Nov 2013 16:38:00 +0200
Message-Id: <1385649486-19978-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1385649486-19978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1385649486-19978-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/main.c b/android/main.c
index 4dc3061..30792c5 100644
--- a/android/main.c
+++ b/android/main.c
@@ -566,6 +566,7 @@ int main(int argc, char *argv[])
 	__btd_log_init("*", 0);
 
 	if (!set_capabilities()) {
+		__btd_log_cleanup();
 		g_source_remove(signal);
 		return EXIT_FAILURE;
 	}
@@ -574,11 +575,13 @@ int main(int argc, char *argv[])
 							quit_eventloop, NULL);
 	if (bluetooth_start_timeout == 0) {
 		error("Failed to init startup timeout");
+		__btd_log_cleanup();
 		g_source_remove(signal);
 		return EXIT_FAILURE;
 	}
 
 	if (!bt_bluetooth_start(option_index, adapter_ready)) {
+		__btd_log_cleanup();
 		g_source_remove(bluetooth_start_timeout);
 		g_source_remove(signal);
 		return EXIT_FAILURE;
-- 
1.8.3.2

