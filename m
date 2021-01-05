Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA9AC433E9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 03:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84C4D22573
	for <linux-bluetooth@archiver.kernel.org>; Tue,  5 Jan 2021 03:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbhAEDNs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jan 2021 22:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbhAEDNs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jan 2021 22:13:48 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2237C061795
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Jan 2021 19:13:07 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id e74so54552235ybh.19
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Jan 2021 19:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=KK6nLKsHQCELPyl1S4Arx6g2G/0sGXXhy1Tvx8l1irY=;
        b=EChvkFSH+/hC+LmKY5AT1KfK/ubaXNHvTiNyATxvqZn9i3i0Dh68FkTCeWxMt8yOqq
         bwupUDv2ffRc/rXg71wfzSZ73UybK6xnBDYzvAl7nlY2Pt2Oz97ZJhRvng1VVwOGzl3B
         jFIo8sLeLP77aEm+vclJtv253n0L5D4Bv4Zd9qEZmuoHUtdmle/Jvj7bsmJYtcVfc5I4
         /7fPlrmQtDCpd9tY4L+FGtUjcdGhSBC99334dNCedbFGybRrIuo+DQNegPDuEJuBWT7F
         ebwTfESJ/woD9EZc45tBhecEgKaJ1v/puD4JnVh9F13HR2zS0++82O5oLwuxCFh446DI
         Jv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=KK6nLKsHQCELPyl1S4Arx6g2G/0sGXXhy1Tvx8l1irY=;
        b=E3+BpDZaRPjpVElFIBfhC2FMG+UsfUjGJgIwWGUqt5QBnuvRWguWPAhY/WBdV/9KOK
         nN56XpNL8GaIVd9m2qWGxm9A/6Ek5H8towVrEfgBB0DQxHYikQVVOUfwsyv/YsdXpkNf
         7Cev7IHi5UzQM1PtDjesN1faVFMt8doriX9pKYIfQ3UTMsORsC4Yagz/yVcC+t1fLdjh
         lMTc0JY3vxK3MYxm3xHNnKl4CKqNGuz87JttCn8qqLwkgEpM3G+9XYEUmeYcs+r9KCiQ
         sKxuss8glVpCkq1U7IuOlHqKi5xllnJ4jv9MOkQFaPfBPCU2vScF7vHerU3qDz8VRMEV
         wASQ==
X-Gm-Message-State: AOAM530nvIJBuJlwwYeXwsxVczQ1E2SDiZUWDrHxxaLH0IbkfvkARYtt
        2Y9XmLs5R+P4yFz3pIgDbNXt9T+FYChvterPvhoWRprpvqMZb4DMPXKSIbnt7eOX9H7sqIlNaq6
        YERbepf4nQWj2KN1c7tqYyCPy2tv3EVD9UxfgwYPsQUk9gjcUjZ9Ah29msO9a8hpCNf7EpeHgnK
        0p59gRQf0cOsw=
X-Google-Smtp-Source: ABdhPJzRAqawhiQH5pKQ1pXiRfTUqx3sBnZlUvk8Y7/25yqJj7VyxmR6nRSZ780oyca/1YNvZGZNdrfUqvcz4e5bVA==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:7789:: with SMTP id
 s131mr111959638ybc.212.1609816386998; Mon, 04 Jan 2021 19:13:06 -0800 (PST)
Date:   Tue,  5 Jan 2021 11:12:54 +0800
Message-Id: <20210105111219.Bluez.v4.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [Bluez PATCH v4 1/4] shared/mgmt: Add supports of parsing mgmt tlv list
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        luiz.dentz@gmail.com
Cc:     mcchou@chromium.org, apusaka@chromium.org, mmandlik@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Response from Read System Default Configuration is a list of mgmt_tlv,
which requires further processing to get the values of each parameters.

This adds APIs for parsing response into mgmt_tlv_list, retrieving
parameter from mgmt_tlv_list.

Reviewed-by: apusaka@chromium.org
---

Changes in v4:
- Simply use free instead of mgmt_tlv_free

Changes in v3:
- Fix CheckBuild error

Changes in v2:
- Fix incompatible pointer type error in mgmt_tlv_list_load_from_buf

 src/shared/mgmt.c | 38 ++++++++++++++++++++++++++++++++++++++
 src/shared/mgmt.h |  6 ++++++
 2 files changed, 44 insertions(+)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 9ea9974f5535..dc8107846668 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -626,6 +626,44 @@ static void mgmt_tlv_to_buf(void *data, void *user_data)
 	*buf_ptr += entry_size;
 }
 
+struct mgmt_tlv_list *mgmt_tlv_list_load_from_buf(const uint8_t *buf,
+								uint16_t len)
+{
+	struct mgmt_tlv_list *tlv_list;
+	const uint8_t *cur = buf;
+
+	if (!len || !buf)
+		return NULL;
+
+	tlv_list = mgmt_tlv_list_new();
+
+	while (cur < buf + len) {
+		struct mgmt_tlv *entry = (struct mgmt_tlv *)cur;
+
+		cur += sizeof(*entry) + entry->length;
+		if (cur > buf + len)
+			goto failed;
+
+		if (!mgmt_tlv_add(tlv_list, entry->type, entry->length,
+								entry->value)) {
+			goto failed;
+		}
+	}
+
+	return tlv_list;
+failed:
+	mgmt_tlv_list_free(tlv_list);
+
+	return NULL;
+}
+
+void mgmt_tlv_list_foreach(struct mgmt_tlv_list *tlv_list,
+				mgmt_tlv_list_foreach_func_t callback,
+				void *user_data)
+{
+	queue_foreach(tlv_list->tlv_queue, callback, user_data);
+}
+
 unsigned int mgmt_send_tlv(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 				struct mgmt_tlv_list *tlv_list,
 				mgmt_request_func_t callback,
diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
index 319beb62f9eb..808bf4c7ff09 100644
--- a/src/shared/mgmt.h
+++ b/src/shared/mgmt.h
@@ -41,6 +41,12 @@ bool mgmt_tlv_add(struct mgmt_tlv_list *tlv_list, uint16_t type, uint8_t length,
 #define mgmt_tlv_add_fixed(_list, _type, _value) \
 	mgmt_tlv_add(_list, _type, sizeof(*(_value)), _value)
 
+struct mgmt_tlv_list *mgmt_tlv_list_load_from_buf(const uint8_t *buf,
+								uint16_t len);
+typedef void (*mgmt_tlv_list_foreach_func_t)(void *data, void *user_data);
+void mgmt_tlv_list_foreach(struct mgmt_tlv_list *tlv_list,
+				mgmt_tlv_list_foreach_func_t callback,
+				void *user_data);
 unsigned int mgmt_send_tlv(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
 				struct mgmt_tlv_list *tlv_list,
 				mgmt_request_func_t callback,
-- 
2.29.2.729.g45daf8777d-goog

