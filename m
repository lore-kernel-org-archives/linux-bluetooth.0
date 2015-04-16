Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 12/13] core/eir: Fix service data parsing
Date: Thu, 16 Apr 2015 17:41:14 +0300
Message-Id: <1429195275-19635-13-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1429195275-19635-1-git-send-email-luiz.dentz@gmail.com>
References: <1429195275-19635-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The UUID type was not being set correctly.
---
 src/eir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/eir.c b/src/eir.c
index 34f6e16..c984fa5 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -191,6 +191,7 @@ static void eir_parse_uuid16_data(struct eir_data *eir, const uint8_t *data,
 	if (len < 2 || len > EIR_SD_MAX_LEN)
 		return;
 
+	service.type = SDP_UUID16;
 	service.value.uuid16 = get_le16(data);
 	eir_parse_sd(eir, &service, data + 2, len - 2);
 }
@@ -203,6 +204,7 @@ static void eir_parse_uuid32_data(struct eir_data *eir, const uint8_t *data,
 	if (len < 4 || len > EIR_SD_MAX_LEN)
 		return;
 
+	service.type = SDP_UUID32;
 	service.value.uuid32 = get_le32(data);
 	eir_parse_sd(eir, &service, data + 4, len - 4);
 }
@@ -216,6 +218,8 @@ static void eir_parse_uuid128_data(struct eir_data *eir, const uint8_t *data,
 	if (len < 16 || len > EIR_SD_MAX_LEN)
 		return;
 
+	service.type = SDP_UUID128;
+
 	for (k = 0; k < 16; k++)
 		service.value.uuid128.data[k] = data[16 - k - 1];
 
-- 
2.1.0

