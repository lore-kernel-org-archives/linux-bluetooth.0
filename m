Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 3/3] core: adapter: Fix device name setting
Date: Wed, 14 Jan 2015 19:52:15 -0800
Message-Id: <1421293935-24092-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1421293935-24092-1-git-send-email-armansito@chromium.org>
References: <1421293935-24092-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes adapter.c:connected_callback so that it only sets the
device name based on the complete local name EIR data, if the device
already has a known name.
---
 src/adapter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/adapter.c b/src/adapter.c
index d7e2550..1839286 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6672,6 +6672,7 @@ static void connected_callback(uint16_t index, uint16_t length,
 	struct eir_data eir_data;
 	uint16_t eir_len;
 	char addr[18];
+	bool name_known;
 
 	if (length < sizeof(*ev)) {
 		error("Too small device connected event");
@@ -6704,7 +6705,9 @@ static void connected_callback(uint16_t index, uint16_t length,
 
 	adapter_add_connection(adapter, device, ev->addr.type);
 
-	if (eir_data.name != NULL) {
+	name_known = device_name_known(device);
+
+	if (eir_data.name && (eir_data.name_complete || !name_known)) {
 		device_store_cached_name(device, eir_data.name);
 		btd_device_device_set_name(device, eir_data.name);
 	}
-- 
2.2.0.rc0.207.ga3a616c

