Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 08/12] android/scpp: Fix not unregistering on detach
Date: Mon, 30 Jun 2014 16:47:55 +0300
Message-Id: <1404136079-24846-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
References: <1404136079-24846-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/scpp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/scpp.c b/android/scpp.c
index 81d698b..b831680 100644
--- a/android/scpp.c
+++ b/android/scpp.c
@@ -270,6 +270,11 @@ void bt_scpp_detach(struct bt_scpp *scan)
 	if (!scan || !scan->attrib)
 		return;
 
+	if (scan->refresh_cb_id > 0) {
+		g_attrib_unregister(scan->attrib, scan->refresh_cb_id);
+		scan->refresh_cb_id = 0;
+	}
+
 	g_attrib_unref(scan->attrib);
 	scan->attrib = NULL;
 }
-- 
1.9.3

