Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/7] uuid: Add IPSP UUID
Date: Tue, 24 Oct 2017 16:24:56 +0300
Message-Id: <20171024132459.14206-4-luiz.dentz@gmail.com>
In-Reply-To: <20171024132459.14206-1-luiz.dentz@gmail.com>
References: <20171024132459.14206-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds IPSP UUID in string format.
---
 lib/uuid.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index 2c57a3378..71ed3df3b 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -81,6 +81,8 @@ extern "C" {
 #define SENSOR_LOCATION_UUID	"00002a5d-0000-1000-8000-00805f9b34fb"
 #define SC_CONTROL_POINT_UUID	"00002a55-0000-1000-8000-00805f9b34fb"
 
+#define IPSP_UUID		"00001820-0000-1000-8000-00805f9b34fb"
+
 #define RFCOMM_UUID_STR		"00000003-0000-1000-8000-00805f9b34fb"
 
 #define HDP_UUID		"00001400-0000-1000-8000-00805f9b34fb"
-- 
2.13.6

