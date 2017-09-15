Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ 2/2] core: Fix potential segfault with
 passive_scanning_timeout
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <d711261f-363f-ced3-ce6d-3624d8631f14@jp.fujitsu.com>
Message-ID: <81798f03-4904-d83e-33c0-273f66affd57@jp.fujitsu.com>
Date: Fri, 15 Sep 2017 17:51:30 +0900
MIME-Version: 1.0
In-Reply-To: <d711261f-363f-ced3-ce6d-3624d8631f14@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Segfault of bluetoothd may occur when register passive_scanning_timeout()
and then detach the bluetooth dongle. This patch removes the event for
just in case when detaching it.
---
 src/adapter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 36562c0..264218d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4415,6 +4415,11 @@ static void adapter_free(gpointer user_data)
 		adapter->pairable_timeout_id = 0;
 	}
 
+	if (adapter->passive_scan_timeout > 0) {
+		g_source_remove(adapter->passive_scan_timeout);
+		adapter->passive_scan_timeout = 0;
+	}
+
 	if (adapter->load_ltks_timeout > 0)
 		g_source_remove(adapter->load_ltks_timeout);
 
-- 
2.7.4

