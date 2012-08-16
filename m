Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v1 04/10] gatt: Add storing Appearance
Date: Thu, 16 Aug 2012 17:13:05 -0300
Message-Id: <1345147991-31320-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
References: <CAKT1EBfp+iJfRSodDfoqtDB4X90BNR1wEJh_zXvw0t6JvnaWuA@mail.gmail.com>
 <1345147991-31320-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch stores the Appearance characteristic value read from the
remote GAP service.
---
 profiles/gatt/gas.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/profiles/gatt/gas.c b/profiles/gatt/gas.c
index 2fb12ce..bf603e8 100644
--- a/profiles/gatt/gas.c
+++ b/profiles/gatt/gas.c
@@ -68,8 +68,11 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
+	struct gas *gas = user_data;
 	struct att_data_list *list =  NULL;
+	bdaddr_t src, dst;
 	uint16_t app;
+	uint8_t type;
 	uint8_t *atval;
 
 	if (status != 0) {
@@ -92,6 +95,11 @@ static void gap_appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 	DBG("GAP Appearance: 0x%04x", app);
 
+	adapter_get_address(device_get_adapter(gas->device), &src);
+	device_get_address(gas->device, &dst, &type);
+
+	write_remote_appearance(&src, &dst, type, app);
+
 done:
 	att_data_list_free(list);
 }
-- 
1.7.8.6

