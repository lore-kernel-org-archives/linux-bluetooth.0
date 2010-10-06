Return-Path: <cyrus@holtmann.org>
From: Lukasz Pawlik <lucas.pawlik@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Pawlik <lucas.pawlik@gmail.com>
Subject: [PATCH] Fix problem with invalid read from array
Date: Wed,  6 Oct 2010 14:52:46 +0200
Message-Id: <1286369566-1453-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fix problem with reading data from out of the array range in
function used to create EIR response.
---
 src/adapter.c      |    2 +-
 src/sdpd-service.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 73ea6e4..bf32e19 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -205,7 +205,7 @@ static void dev_info_free(struct remote_dev_info *dev)
 
 static void update_ext_inquiry_response(struct btd_adapter *adapter)
 {
-	uint8_t data[240];
+	uint8_t data[242];
 	struct hci_dev *dev = &adapter->dev;
 	int ret;
 
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index 26ab9a5..67dd9af 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -204,7 +204,7 @@ static void eir_generate_uuid128(sdp_list_t *list,
 		for (i = 0; i < index; i++) {
 			for (k = 0; k < SIZEOF_UUID128; k++) {
 				if (uuid128[i * SIZEOF_UUID128 + k] !=
-					uuid128_data[SIZEOF_UUID128 - k])
+					uuid128_data[SIZEOF_UUID128 - 1 - k])
 					break;
 			}
 			if (k == SIZEOF_UUID128)
-- 
1.7.0.4

