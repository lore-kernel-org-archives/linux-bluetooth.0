Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBC9C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 11:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B69AB229C5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 11:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbgL1LfH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727326AbgL1LfG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 06:35:06 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DE3C061794
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 03:34:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id o8so2661216ybq.22
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 03:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=9+Ok8zSmlezPRnyzRhNvndhpVlA8+TsAwmdpm3q9p2A=;
        b=Q66faswxutm9FPnqP/QeVfjxOEsP5VUXAL/eWgXNnftbDuhssGiTe5KMn+tFVn6LpE
         frk++JLTPNE1yPs3N+l6QIfz6e+2zYtZN0isrXxZuHpt0GZ90r5NvIq2eaOQx0CKzpsB
         z6YqGLAThfMAcUl0uRK91wskRcwKGeIWSM0Y15vq129MBGGXHN0XQOaYOOhiXtetXJH+
         FrfyTq9vDkJQ2OGYTuxvjbzf9IvRbjZh3Qg7sLxgbXIR75E0Qwoj5HQdtULQYIHbQjq9
         oCEUBaKDwPn28yXyKZeEq+vjDk/0Sndf6k2pvjLdjR+CeS5BwwqDuIgmVvRKI+DIoH+6
         mZ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=9+Ok8zSmlezPRnyzRhNvndhpVlA8+TsAwmdpm3q9p2A=;
        b=i41TXSXjVHHHPMRy6D0BF5pQ/qnLubFUhyC6cuRUCC4UcigFG4wSCJH3aQqbWcgKZX
         NUKm+3HEmrOVvcn0NbX6iKpQsYYrOPqGmauPK16gwTwkR2PEygLMC0PnXmL3hQg1ATKO
         XdwdibCUvCwmf0B0Mt+OS8t4NG1KQwE4oH2FtvnJTef14M5MUqJtWjDNC7cRVCEz6PA4
         E1cSpqPn1Vw9gUm9w+CYWukLO/gsB7uEJ7WOCf75QpptXI/SOtft31Y17LOUqcjdUB6a
         RxOLehS9vFW0YfdXF6QgqK9Ba4dpktAXLb4z5tH+ny+GgXXrUSGCQJ9ddTSpsFNbsgp4
         80wQ==
X-Gm-Message-State: AOAM532D5C7ZIaWPG68tzkCAX3pII7J2DAQwF2oLiGQx5DXvsEoDeRKW
        DBYWygOGkdTulTxOwSxw8Cy6oPpHruLNpHpfRyi4PPV2IRuCybKMAc/nYWTSoMWX75BmcNAYh8D
        r1ecIi/h2LISB7q92EDRpMmarns0E/FEif88gyQp6Bl6AIaRGi0erInFGqH6XYlnuiVGN9pSvUd
        9Y7EhNQ2wUnPc=
X-Google-Smtp-Source: ABdhPJzeuw+1BG8LcaoB9eieMGOyVQkEnzN+tnHSZBSgZtr0ggg5sQal9zMHPll1olJ1PLtplcXsQ96diCz7D3Fqgw==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:42cc:: with SMTP id
 p195mr63071571yba.59.1609155265399; Mon, 28 Dec 2020 03:34:25 -0800 (PST)
Date:   Mon, 28 Dec 2020 19:34:17 +0800
Message-Id: <20201228193351.Bluez.v3.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [Bluez PATCH v3 1/4] shared/mgmt: Add supports of parsing mgmt tlv list
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        luiz.dentz@gmail.com
Cc:     mcchou@chromium.org, mmandlik@chromium.org, apusaka@chromium.org,
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

