Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B7DC388F7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 21:59:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E268324724
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 21:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHGS67W6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgJ1V62 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 17:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728437AbgJ1V60 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 17:58:26 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936BBC0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 14:58:26 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 133so565183pfx.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGPSL9aFJNhVVpzPkljmMKxozX2IqfXjyxtoms8pTTM=;
        b=DHGS67W6y7WyBwvtmG7qEX/4Fs/H4ZmEIqmogoMZd0GhhE2SGFOvO8S9P3MGj/U0G2
         XzQnCOPlbQqQudaQ+/bOznKPS1PqTua9dhAITTvD/IU1+urQ5fdZ5+fs8XuM4KtHKlvN
         cmqozdSovG5PV+V30UBFeatkrUyH10c2I3b6dUh4X/Vd7xQIBolNE7CNGvBouB+svoDC
         CLMxWAFaIQNyOOswQ0mHkB4jS1x5t9uX1joQFeidWFMzvb+Cd9VYA0MqSIHETN2SJpTj
         giiWWs7NDniYXcpfMvjAEDprvGH+RYuG22+4jLGp6i/05kUdSIzVDx4m2/kqiR09D1Tb
         KoYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mGPSL9aFJNhVVpzPkljmMKxozX2IqfXjyxtoms8pTTM=;
        b=Ml9so42Dwmmyhs6hUeMY5kWXrUps4Sm5h6G4wBJHgjK/wn/wXyN7tM+8Tnpiqtft+v
         W4rSubhoKDi97UZE7a7Q59suGWeqDgX1QkjWN86KPh86F4VPKK2BtZthf+zttKateAHM
         n6LZYKrUALuTpLt6vUBO8MuJBI3NQu6KxzBTfpvyX+vqighVdQVCZFN0n49TJqey1rie
         FJ6gtA9u6RSI/AjdP86z/RNLRut7fAUCoDN4Upv3V2if9TdoVQAZCoqn3F/8Y2LXDXpb
         2+zJJPbLJMHLHI85uuvf118Db4wYbI06+zI1oOuijXMJ7njXcSbceP5qdkSaVzBapHaC
         oVug==
X-Gm-Message-State: AOAM5302THQECZk5dZ2bNhw/ks1jXG+BRYeF8941D1m1jt8HoyY7U4E1
        xX6DbPsBnFxoVqv6t3WYIJ6nlwg3yBZwSw==
X-Google-Smtp-Source: ABdhPJwMaGmOvZwWMCCxBythYFDjoAKNRvrj1GMudRZPGUo9sXmc3zd/ACgnwlR7NPxj3E2pwXNnMQ==
X-Received: by 2002:a17:90b:14e:: with SMTP id em14mr962172pjb.186.1603922305728;
        Wed, 28 Oct 2020 14:58:25 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id m13sm355290pjl.45.2020.10.28.14.58.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 14:58:25 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/5] mgmt: Add support of mgmt TLV API
Date:   Wed, 28 Oct 2020 14:58:20 -0700
Message-Id: <20201028215824.608794-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Howard Chung <howardchung@google.com>

This adds API to send multiple TLVs to kernel, it is useful for
mgmt set system config command.
---
 src/shared/mgmt.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/mgmt.h |  9 +++++
 2 files changed, 103 insertions(+)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index b327b4088..9ea9974f5 100644
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
index 6608faa7e..74b8befd8 100644
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
2.26.2

