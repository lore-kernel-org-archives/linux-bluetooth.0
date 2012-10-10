Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 5/6] attrib: Fix not checking if att_data_list_alloc fails
Date: Wed, 10 Oct 2012 20:35:02 -0300
Message-Id: <1349912103-663-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1349912103-663-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1349912103-663-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that this function may fail in more usual situations (invalid
input), we have to check its return value.
---
 attrib/att.c        | 6 ++++++
 src/attrib-server.c | 9 +++++++++
 2 files changed, 15 insertions(+)

diff --git a/attrib/att.c b/attrib/att.c
index f262bb6..0ed4178 100644
--- a/attrib/att.c
+++ b/attrib/att.c
@@ -211,6 +211,8 @@ struct att_data_list *dec_read_by_grp_resp(const uint8_t *pdu, size_t len)
 	elen = pdu[1];
 	num = (len - 2) / elen;
 	list = att_data_list_alloc(num, elen);
+	if (list == NULL)
+		return NULL;
 
 	ptr = &pdu[2];
 
@@ -441,6 +443,8 @@ struct att_data_list *dec_read_by_type_resp(const uint8_t *pdu, size_t len)
 	elen = pdu[1];
 	num = (len - 2) / elen;
 	list = att_data_list_alloc(num, elen);
+	if (list == NULL)
+		return NULL;
 
 	ptr = &pdu[2];
 
@@ -825,6 +829,8 @@ struct att_data_list *dec_find_info_resp(const uint8_t *pdu, size_t len,
 	ptr = (void *) &pdu[2];
 
 	list = att_data_list_alloc(num, elen);
+	if (list == NULL)
+		return NULL;
 
 	for (i = 0; i < num; i++) {
 		memcpy(list->data[i], ptr, list->len);
diff --git a/src/attrib-server.c b/src/attrib-server.c
index ec4ecc3..7117fbe 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -490,6 +490,9 @@ static uint16_t read_by_group(struct gatt_channel *channel, uint16_t start,
 	length = g_slist_length(groups);
 
 	adl = att_data_list_alloc(length, last_size + 4);
+	if (adl == NULL)
+		return enc_error_resp(ATT_OP_READ_BY_GROUP_REQ, start,
+					ATT_ECODE_UNLIKELY, pdu, len);
 
 	for (i = 0, l = groups; l; l = l->next, i++) {
 		uint8_t *value;
@@ -574,6 +577,9 @@ static uint16_t read_by_type(struct gatt_channel *channel, uint16_t start,
 	length += 2;
 
 	adl = att_data_list_alloc(num, length);
+	if (adl == NULL)
+		return enc_error_resp(ATT_OP_READ_BY_TYPE_REQ, start,
+					ATT_ECODE_UNLIKELY, pdu, len);
 
 	for (i = 0, l = types; l; i++, l = l->next) {
 		uint8_t *value;
@@ -649,6 +655,9 @@ static uint16_t find_info(struct gatt_channel *channel, uint16_t start,
 	}
 
 	adl = att_data_list_alloc(num, length + 2);
+	if (adl == NULL)
+		return enc_error_resp(ATT_OP_FIND_INFO_REQ, start,
+					ATT_ECODE_UNLIKELY, pdu, len);
 
 	for (i = 0, l = info; l; i++, l = l->next) {
 		uint8_t *value;
-- 
1.7.12.3

