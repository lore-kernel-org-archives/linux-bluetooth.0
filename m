Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 15/15] android/client-audio: Fix getting audio module on Android
Date: Thu, 30 Jan 2014 12:23:21 +0100
Message-Id: <1391081001-30723-16-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1391081001-30723-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Getting audio module results with -EADDRINUSE on socket binding when
running on Android. Therefore we need to stop mediaserver for
successfull connection.
---
 android/client/if-audio.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/android/client/if-audio.c b/android/client/if-audio.c
index 66f8364..71f9dad 100644
--- a/android/client/if-audio.c
+++ b/android/client/if-audio.c
@@ -99,6 +99,9 @@ static void init_p(int argc, const char **argv)
 	int err;
 	const hw_module_t *module;
 	audio_hw_device_t *device;
+	int timeout = 1500; /* in ms */
+	int t = 300;
+
 
 	err = hw_get_module_by_class(AUDIO_HARDWARE_MODULE_ID,
 					AUDIO_HARDWARE_MODULE_ID_A2DP, &module);
@@ -107,8 +110,27 @@ static void init_p(int argc, const char **argv)
 		return;
 	}
 
+init_audio:
 	err = audio_hw_device_open(module, &device);
 	if (err) {
+		if (err == -EADDRINUSE && t < timeout) {
+			int err2;
+
+			/* We need to Stop media server to bind to socket. */
+			haltest_info("Trying to stop media server...\n");
+
+			err2 = system("/system/bin/setprop ctl.stop media");
+			if (err2) {
+				haltest_error("audio_hw_device_open returned",
+								" %d\n", err);
+				return;
+			}
+
+			usleep(t);
+			t += t;
+			goto init_audio;
+		}
+
 		haltest_error("audio_hw_device_open returned %d\n", err);
 		return;
 	}
@@ -358,6 +380,9 @@ static void cleanup_p(int argc, const char **argv)
 	}
 
 	if_audio = NULL;
+
+	/* get the media server back up and running */
+	err = system("/system/bin/setprop ctl.start media");
 }
 
 static void suspend_p(int argc, const char **argv)
-- 
1.8.5.2

