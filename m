Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0 04/10] gap: Add storing Appearance
Date: Wed, 15 Aug 2012 11:20:01 -0300
Message-Id: <1345040407-17767-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1345040407-17767-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch store the Appearance characteristic value read from the
remote device.
---
 profiles/gap/gap.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/profiles/gap/gap.c b/profiles/gap/gap.c
index 0ecadb3..4d21fb6 100644
--- a/profiles/gap/gap.c
+++ b/profiles/gap/gap.c
@@ -69,8 +69,11 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 static void appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
 							gpointer user_data)
 {
+	struct gap *gap = user_data;
 	struct att_data_list *list =  NULL;
+	bdaddr_t src, dst;
 	uint16_t app;
+	uint8_t type;
 	uint8_t *atval;
 
 	if (status != 0) {
@@ -93,6 +96,11 @@ static void appearance_cb(guint8 status, const guint8 *pdu, guint16 plen,
 
 	DBG("Appearance: 0x%04x", app);
 
+	adapter_get_address(device_get_adapter(gap->device), &src);
+	device_get_address(gap->device, &dst, &type);
+
+	write_remote_appearance(&src, &dst, type, app);
+
 done:
 	att_data_list_free(list);
 }
-- 
1.7.8.6

