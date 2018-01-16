Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH 2/2] shared/btp: Use bdaddr_t for storing address
Date: Tue, 16 Jan 2018 15:03:33 +0100
Message-Id: <20180116140333.10745-2-szymon.janc@codecoup.pl>
In-Reply-To: <20180116140333.10745-1-szymon.janc@codecoup.pl>
References: <20180116140333.10745-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is more convenient as it allows to use common helpers for address
comparison and convertion.
---
 src/shared/btp.c  |  1 +
 src/shared/btp.h  | 30 +++++++++++++++---------------
 tools/btpclient.c |  4 ++--
 3 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/src/shared/btp.c b/src/shared/btp.c
index d981621a8..77622671c 100644
--- a/src/shared/btp.c
+++ b/src/shared/btp.c
@@ -28,6 +28,7 @@
 
 #include <ell/ell.h>
 
+#include "lib/bluetooth.h"
 #include "src/shared/btp.h"
 
 #define BTP_MTU 512
diff --git a/src/shared/btp.h b/src/shared/btp.h
index 7b1f48817..0b605be18 100644
--- a/src/shared/btp.h
+++ b/src/shared/btp.h
@@ -97,7 +97,7 @@ struct btp_gap_read_index_rp {
 
 #define BTP_OP_GAP_READ_COTROLLER_INFO		0x03
 struct btp_gap_read_info_rp {
-	uint8_t address[6];
+	bdaddr_t address;
 	uint32_t supported_settings;
 	uint32_t current_settings;
 	uint8_t cod[3];
@@ -190,13 +190,13 @@ struct btp_gap_start_discovery_cp {
 #define BTP_OP_GAP_CONNECT			0x0e
 struct btp_gap_connect_cp {
 	uint8_t address_type;
-	uint8_t address[6];
+	bdaddr_t address;
 } __packed;
 
 #define BTP_OP_GAP_DISCONNECT			0x0f
 struct btp_gap_disconnect_cp {
 	uint8_t address_type;
-	uint8_t address[6];
+	bdaddr_t address;
 } __packed;
 
 #define BTP_GAP_IOCAPA_DISPLAY_ONLY		0x00
@@ -213,26 +213,26 @@ struct btp_gap_set_io_capa_cp {
 #define BTP_OP_GAP_PAIR				0x11
 struct btp_gap_pair_cp {
 	uint8_t address_type;
-	uint8_t address[6];
+	bdaddr_t address;
 } __packed;
 
 #define BTP_OP_GAP_UNPAIR			0x12
 struct btp_gap_unpair_cp {
 	uint8_t address_type;
-	uint8_t address[6];
+	bdaddr_t address;
 } __packed;
 
 #define BTP_OP_GAP_PASSKEY_ENTRY_RSP		0x13
 struct btp_gap_passkey_entry_rsp_cp {
 	uint8_t address_type;
-	uint8_t address[6];
+	bdaddr_t address;
 	uint32_t passkey;
 } __packed;
 
 #define BTP_OP_GAP_PASSKEY_CONFIRM_RSP		0x14
 struct btp_gap_passkey_confirm_rsp_cp {
 	uint8_t address_type;
-	uint8_t address[6];
+	bdaddr_t address;
 	uint8_t match;
 } __packed;
 
@@ -247,7 +247,7 @@ struct btp_new_settings_ev {
 
 #define BTP_EV_GAP_DEVICE_FOUND			0x81
 struct btp_device_found_ev {
-	uint8_t address[6];
+	bdaddr_t address;
 	uint8_t address_type;
 	int8_t rssi;
 	uint8_t flags;
@@ -258,41 +258,41 @@ struct btp_device_found_ev {
 #define BTP_EV_GAP_DEVICE_CONNECTED		0x82
 struct btp_gap_device_connected_ev {
 	uint8_t address_type;
-	uint8_t address[6];
+	bdaddr_t address;
 } __packed;
 
 #define BTP_EV_GAP_DEVICE_DISCONNECTED		0x83
 struct btp_gap_device_disconnected_ev {
 	uint8_t address_type;
-	uint8_t address[6];
+	bdaddr_t address;
 } __packed;
 
 #define BTP_EV_GAP_PASSKEY_DISPLAY		0x84
 struct btp_gap_passkey_display_ev {
 	uint8_t address_type;
-	uint8_t address[6];
+	bdaddr_t address;
 	uint32_t passkey;
 } __packed;
 
 #define BTP_EV_GAP_PASSKEY_REQUEST		0x85
 struct btp_gap_passkey_req_ev {
 	uint8_t address_type;
-	uint8_t address[6];
+	bdaddr_t address;
 } __packed;
 
 #define BTP_EV_GAP_PASSKEY_CONFIRM		0x86
 struct btp_gap_passkey_confirm_ev {
 	uint8_t address_type;
-	uint8_t address[6];
+	bdaddr_t address;
 	uint32_t passkey;
 } __packed;
 
 #define BTP_EV_GAP_IDENTITY_RESOLVED		0x87
 struct btp_gap_identity_resolved_ev {
 	uint8_t address_type;
-	uint8_t address[6];
+	bdaddr_t address;
 	uint8_t identity_address_type;
-	uint8_t identity_address[6];
+	bdaddr_t identity_address;
 } __packed;
 
 struct btp;
diff --git a/tools/btpclient.c b/tools/btpclient.c
index 4d4475a07..8d5545015 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -177,7 +177,7 @@ static void btp_gap_read_info(uint8_t index, const void *param, uint16_t length,
 		goto failed;
 
 
-	if (str2ba(str, (bdaddr_t *)rp.address) < 0)
+	if (str2ba(str, &rp.address) < 0)
 		goto failed;
 
 	if (!l_dbus_proxy_get_property(adapter->proxy, "Name", "s", &str)) {
@@ -670,7 +670,7 @@ static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 	int16_t rssi;
 
 	if (!l_dbus_proxy_get_property(proxy, "Address", "s", &str) ||
-						str2ba(str, (bdaddr_t *)ev.address) < 0)
+						str2ba(str, &ev.address) < 0)
 		return;
 
 	if (!l_dbus_proxy_get_property(proxy, "AddressType", "s", &str))
-- 
2.14.3

