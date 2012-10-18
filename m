Return-Path: <cyrus@holtmann.org>
From: Ludek Finstrle <luf@pzkagis.cz>
To: linux-bluetooth@vger.kernel.org
Cc: Ludek Finstrle <luf@pzkagis.cz>
Subject: [RFC] attrib: Fix memleak if att_data_list_alloc fails
Date: Thu, 18 Oct 2012 10:39:21 +0200
Message-Id: <1350549561-16424-1-git-send-email-luf@pzkagis.cz>
In-Reply-To: <CAJdJm_NiL522WPLrV-RiaJKBZeOBBgo_vSzQCwTdZwLZLTw88A@mail.gmail.com>
References: <CAJdJm_NiL522WPLrV-RiaJKBZeOBBgo_vSzQCwTdZwLZLTw88A@mail.gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fix for memory leak which was introduced in commit f8619bef3406a2134082dc41c208105fe028c09f.
I tested it with older bluez and rebase for git. Please review it.

---
 src/attrib-server.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index ea27b13..4489edc 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -490,9 +490,11 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 	length = g_slist_length(groups);
 
 	adl = att_data_list_alloc(length, last_size + 4);
-	if (adl == NULL)
+	if (adl == NULL) {
+		g_slist_free_full(groups, g_free);
 		return enc_error_resp(ATT_OP_READ_BY_GROUP_REQ, start,
 					ATT_ECODE_UNLIKELY, pdu, len);
+	}
 
 	for (i = 0, l = groups; l; l = l->next, i++) {
 		uint8_t *value;
@@ -577,9 +579,11 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 	length += 2;
 
 	adl = att_data_list_alloc(num, length);
-	if (adl == NULL)
+	if (adl == NULL) {
+		g_slist_free(types);
 		return enc_error_resp(ATT_OP_READ_BY_TYPE_REQ, start,
 					ATT_ECODE_UNLIKELY, pdu, len);
+	}
 
 	for (i = 0, l = types; l; i++, l = l->next) {
 		uint8_t *value;
@@ -655,9 +659,11 @@ static uint16_t find_info(struct gatt_channel *channel, uint16_t start,
 	}
 
 	adl = att_data_list_alloc(num, length + 2);
-	if (adl == NULL)
+	if (adl == NULL) {
+		g_slist_free(info);
 		return enc_error_resp(ATT_OP_FIND_INFO_REQ, start,
 					ATT_ECODE_UNLIKELY, pdu, len);
+	}
 
 	for (i = 0, l = info; l; i++, l = l->next) {
 		uint8_t *value;
-- 
1.7.1

