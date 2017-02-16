Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Felipe F. Tonello" <eu@felipetonello.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 6/7] src/adapter: Store Slave Connection Interval Range
Date: Thu, 16 Feb 2017 18:03:14 +0000
Message-Id: <20170216180315.30531-7-eu@felipetonello.com>
In-Reply-To: <20170216180315.30531-1-eu@felipetonello.com>
References: <20170216180315.30531-1-eu@felipetonello.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is important to store and load the connection parameters before the
connection actually take place, so the appropriate parameters are used.
---
 src/adapter.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index b63883e3cae5..df4288b0ef29 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -5709,6 +5709,28 @@ static void update_found_devices(struct btd_adapter *adapter,
 	if (bdaddr_type != BDADDR_BREDR)
 		device_set_flags(dev, eir_data.flags);
 
+	/* 0xffff indicates no specific min/max */
+	if (eir_data.le_min_conn_interval == 0xffff)
+		eir_data.le_min_conn_interval = 6;
+
+	if (eir_data.le_max_conn_interval == 0xffff)
+		eir_data.le_max_conn_interval = 3200;
+
+	if (eir_data.le_min_conn_interval <= eir_data.le_max_conn_interval &&
+	    eir_data.le_min_conn_interval >= 6 &&
+	    eir_data.le_max_conn_interval <= 3200) {
+		adapter_store_conn_param(adapter, bdaddr, bdaddr_type,
+				eir_data.le_min_conn_interval,
+				eir_data.le_max_conn_interval,
+				/* these are default values from the kernel*/
+				0x0000, 0x002a);
+		adapter_load_conn_param(adapter, bdaddr, bdaddr_type,
+				eir_data.le_min_conn_interval,
+				eir_data.le_max_conn_interval,
+				/* these are default values from the kernel*/
+				0x0000, 0x002a);
+	}
+
 	eir_data_free(&eir_data);
 
 	/*
-- 
2.11.1

