Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 3/4] android/client: Add AVRCP_CTRL interface to haltest init
Date: Mon, 17 Nov 2014 14:59:16 +0200
Message-Id: <1416229157-10128-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1416229157-10128-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1416229157-10128-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adding AVRCP_CTRL interface to haltest interfaces initialization.
if-rc.c has init() for avrcp target, so defined ctrl_init for avrcp
controller target (Reason behind comparing interface name(rc-ctrl)
to get_interface_method).
---
 android/client/haltest.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/android/client/haltest.c b/android/client/haltest.c
index c8cfdc4..2c71124 100644
--- a/android/client/haltest.c
+++ b/android/client/haltest.c
@@ -51,6 +51,7 @@ const struct interface *interfaces[] = {
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 	&hf_client_if,
 	&mce_if,
+	&ctrl_rc_if,
 #endif
 	NULL
 };
@@ -399,6 +400,7 @@ static void init(void)
 #if ANDROID_VERSION >= PLATFORM_VER(5, 0, 0)
 		BT_PROFILE_HANDSFREE_CLIENT_ID,
 		BT_PROFILE_MAP_CLIENT_ID,
+		BT_PROFILE_AV_RC_CTRL_ID,
 #endif
 	};
 	const struct method *m;
@@ -421,7 +423,12 @@ static void init(void)
 
 	/* Init what is available to init */
 	for (i = 2; i < NELEM(interfaces) - 1; ++i) {
-		m = get_interface_method(interfaces[i]->name, "init");
+		if (!strcmp(interfaces[i]->name, "rc-ctrl"))
+			m = get_interface_method(interfaces[i]->name,
+								"ctrl_init");
+		else
+			m = get_interface_method(interfaces[i]->name, "init");
+
 		if (m != NULL)
 			m->func(2, argv);
 	}
-- 
2.1.0

