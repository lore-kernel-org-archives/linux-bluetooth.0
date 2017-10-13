Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH V2 BLueZ 1/3] android: Skip key loading for LE only devices.
To: linux-bluetooth@vger.kernel.org
From: Martin Fuzzey <mfuzzey@parkeon.com>
Date: Fri, 13 Oct 2017 16:02:06 +0200
Message-ID: <20171013140206.19524.46398.stgit@localhost>
In-Reply-To: <20171013140204.19524.68439.stgit@localhost>
References: <20171013140204.19524.68439.stgit@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Key loading is not supported for LE only devices.
---
 android/bluetooth.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 51a31fe..c3ad5ce 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3265,7 +3265,11 @@ static void load_devices_info(bt_bluetooth_ready cb)
 	load_irks(irks);
 	g_slist_free_full(irks, g_free);
 
-	load_link_keys(keys, cb);
+	if (adapter.supported_settings & MGMT_SETTING_BREDR)
+		load_link_keys(keys, cb);
+	else
+		cb(0, &adapter.bdaddr);
+
 	g_slist_free_full(keys, g_free);
 
 	g_strfreev(devs);

