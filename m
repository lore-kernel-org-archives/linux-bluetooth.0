Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77E7C4363A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86653207CD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lp53cvzl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731046AbgJ1XsW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgJ1XsW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 19:48:22 -0400
Received: from mail-oo1-xc49.google.com (mail-oo1-xc49.google.com [IPv6:2607:f8b0:4864:20::c49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDED3C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:48:21 -0700 (PDT)
Received: by mail-oo1-xc49.google.com with SMTP id t9so394792oon.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=5ukqu3eD+sBtgJjiHf4OJ2+rkm1jUG9yhNQ5PdOd7KQ=;
        b=lp53cvzlZvlprwJM36+J6rFotTTnggS1qfnDDp5ybCRY1SOJ3wZS6stG79iW1iNT4c
         xdwwYwlseHmE875z6yteCh7+TEkr83lmW99laWrcUCZL8mYnC64V3oiD2xd3yj9cy8k5
         PnHL7BcmzmfTMe7EPXjYNkeE+9ERaSCNdBcrw//aAA95Bjf6QEfdbzomilp2o7mGRp8B
         ylGf88Syduo53m21tuNOhhDDBH3FgPOh33YXIC/DMCjY0cVFNjoz9DBikhiKZD5VO4zg
         BNT+Ow0CTA0M035/RGqw1KjIbJt9/LYXfjgbEjcae4TI5taz5T8alfFgmzsTaeQAIaai
         ItOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=5ukqu3eD+sBtgJjiHf4OJ2+rkm1jUG9yhNQ5PdOd7KQ=;
        b=GQxvcPBQfU4Jj4WZbArWjjBaFDunortXroJwTgujhlhb96m9UetNAthU1pRARw4UGh
         r75jGjouiESwrBjWCV+Zb4AUzDT2Gda/lsv3C8tVSnljCRmOGt0Z2eLvILmXc4AlTqlX
         HuTAeyESSY6JTFS6mB6nUxg+O2gLh9vrErnUII7NDUPRaGaW05Fw49utApJO4VwMXWt9
         ZQv78pTAlPI9jYY0l5Pbo+x+ZCd4qo0qJJVg84m6inGL5UOxurqUf22IzCiABQ1RD8Qg
         7AJVF0bSz+s9mECHWljiWNEpF2wdgdNMxE0b4zuEDTMttwZ0KPxpX5MwLLtfo/Xooxfg
         oiFA==
X-Gm-Message-State: AOAM532cL+Hl9WyG2BjI856r4yZ8q4kEWJE0YjgSOvQ+BvBoY1qJ2clH
        bpjbxABnJTWuLGqzef9EhqU61lBcOxz1lQDJ1H/ftDh8aOX+b13AVotLiEeKMyDJ/yKbE/fPfP4
        6mOPO78sHtDSOsZVVLTYXrsmrobpd3NTAxRT66Yo9tqj8TmiVuFW3nn0e0NUYdt4V5Rvh8tl/GW
        TS9o8Cvng4Iy8=
X-Google-Smtp-Source: ABdhPJysdReBYvsICqx3cSAcj0wL8GFzy3328Ptzu3/uB2N8/cUP4/ib1KorTPP7SEwuYEB/DQNm76gt9WSXipkN7Q==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:d441:: with SMTP id
 m62mr10016672ybf.422.1603885978195; Wed, 28 Oct 2020 04:52:58 -0700 (PDT)
Date:   Wed, 28 Oct 2020 19:52:46 +0800
Message-Id: <20201028195132.BlueZ.v5.1.I2fa28644a012f69c4665977e5816bcf8a51963f5@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [BlueZ PATCH v5 1/2] mgmt: Add support of mgmt TLV API
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     apusaka@chromium.org, mmandlik@chromium.org, alainm@chromium.org,
        luiz.dentz@gmail.com, mcchou@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds API to send multiple TLVs to kernel, it is useful for
mgmt set system config command.
---

Changes in v5:
- Implement mgmt_tlv API in src/shared/mgmt.c

Changes in v4:
- fix type of buf_len

Changes in v3:
- use iovec to fill buffer

Changes in v2:
- fix multiple line dereference issue

 src/shared/mgmt.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/mgmt.h |  9 +++++
 2 files changed, 103 insertions(+)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index b327b4088c6f..9ea9974f5535 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -68,6 +68,11 @@ struct mgmt_notify {
 	void *user_data;
 };
 
+struct mgmt_tlv_list {
+	struct queue *tlv_queue;
+	uint16_t size;
+};
+
 static void destroy_request(void *data)
 {
 	struct mgmt_request *request = data;
@@ -558,6 +563,95 @@ static struct mgmt_request *create_request(uint16_t opcode, uint16_t index,
 	return request;
 }
 
+struct mgmt_tlv_list *mgmt_tlv_list_new(void)
+{
+	struct mgmt_tlv_list *tlv_list = new0(struct mgmt_tlv_list, 1);
+
+	tlv_list->tlv_queue = queue_new();
+	tlv_list->size = 0;
+
+	return tlv_list;
+}
+
+static struct mgmt_tlv *mgmt_tlv_new(uint16_t type, uint8_t length,
+								void *value)
+{
+	struct mgmt_tlv *entry = malloc(sizeof(*entry) + length);
+
+	if (!entry)
+		return NULL;
+
+	entry->type = htobs(type);
+	entry->length = length;
+	memcpy(entry->value, value, length);
+
+	return entry;
+}
+
+static void mgmt_tlv_free(struct mgmt_tlv *entry)
+{
+	free(entry);
+}
+
+void mgmt_tlv_list_free(struct mgmt_tlv_list *tlv_list)
+{
+	queue_destroy(tlv_list->tlv_queue, NULL);
+	free(tlv_list);
+}
+
+bool mgmt_tlv_add(struct mgmt_tlv_list *tlv_list, uint16_t type, uint8_t length,
+								void *value)
+{
+	struct mgmt_tlv *entry = mgmt_tlv_new(type, length, value);
+
+	if (!entry)
+		return false;
+
+	if (!queue_push_tail(tlv_list->tlv_queue, entry)) {
+		mgmt_tlv_free(entry);
+		return false;
+	}
+
+	tlv_list->size += sizeof(*entry) + entry->length;
+	return true;
+}
+
+static void mgmt_tlv_to_buf(void *data, void *user_data)
+{
+	struct mgmt_tlv *entry = data;
+	uint8_t **buf_ptr = user_data;
+	size_t entry_size = sizeof(*entry) + entry->length;
+
+	memcpy(*buf_ptr, entry, entry_size);
+	*buf_ptr += entry_size;
+}
+
+unsigned int mgmt_send_tlv(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
+				struct mgmt_tlv_list *tlv_list,
+				mgmt_request_func_t callback,
+				void *user_data, mgmt_destroy_func_t destroy)
+{
+	uint8_t *buf, *buf_ptr;
+	unsigned int ret;
+
+	if (!tlv_list)
+		return 0;
+
+	buf = malloc(tlv_list->size);
+
+	if (!buf)
+		return 0;
+
+	buf_ptr = buf;
+
+	queue_foreach(tlv_list->tlv_queue, mgmt_tlv_to_buf, &buf_ptr);
+
+	ret = mgmt_send(mgmt, opcode, index, tlv_list->size, (void *)buf,
+						callback, user_data, destroy);
+	free(buf);
+	return ret;
+}
+
 unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 				uint16_t length, const void *param,
 				mgmt_request_func_t callback,
diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
index 6608faa7ed0f..74b8befd87bd 100644
--- a/src/shared/mgmt.h
+++ b/src/shared/mgmt.h
@@ -16,6 +16,7 @@
 typedef void (*mgmt_destroy_func_t)(void *user_data);
 
 struct mgmt;
+struct mgmt_tlv_list;
 
 struct mgmt *mgmt_new(int fd);
 struct mgmt *mgmt_new_default(void);
@@ -33,6 +34,14 @@ bool mgmt_set_close_on_unref(struct mgmt *mgmt, bool do_close);
 typedef void (*mgmt_request_func_t)(uint8_t status, uint16_t length,
 					const void *param, void *user_data);
 
+struct mgmt_tlv_list *mgmt_tlv_list_new(void);
+void mgmt_tlv_list_free(struct mgmt_tlv_list *tlv_list);
+bool mgmt_tlv_add(struct mgmt_tlv_list *tlv_list, uint16_t type, uint8_t length,
+								void *value);
+unsigned int mgmt_send_tlv(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
+				struct mgmt_tlv_list *tlv_list,
+				mgmt_request_func_t callback,
+				void *user_data, mgmt_destroy_func_t destroy);
 unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 				uint16_t length, const void *param,
 				mgmt_request_func_t callback,
-- 
2.29.0.rc2.309.g374f81d7ae-goog

