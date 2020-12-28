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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D6CC433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 10:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3804B229C4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 10:06:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgL1KFs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 05:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgL1KFr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 05:05:47 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78100C061794
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 02:05:07 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id v9so5096349qtw.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 02:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=5IY1P928LNisrCvz2O0RipAgV64DbONq524mIao+F9M=;
        b=N9G9W+f9J8bK97YqALbb8POIwecntpsDCOiEnWFnrrC9gerAtUNxzwbHz3u3KUN3oW
         bbkM33uE07ZYHxC1LFLMcQGqQOKI1jqgWCk19J3zXE4Y05PioOaUrjuQTR3TXdsqzYG2
         QV4YqUFSTYMt4rVzyJzGVzdHM4+18ds18jEdQEr6zbY8gl/CHZv3iOzwmG6e2aIjjIza
         UBnG8JpuIL54P9/SJfGZUyHO7nvVN14Va/+JSICoO52rt56qxnWrL2PlCZuyvNZqj9de
         lv/TkX2a45Rc6xyDnHLIqHEH2r1Zwak9niCSp1bNbNcjBRdILXuG/yVu2zfWm08TKA9q
         rTBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=5IY1P928LNisrCvz2O0RipAgV64DbONq524mIao+F9M=;
        b=qxGp64eQakMH67DQ6uF2rvYjOZOx+Y3F31pBuNIPlV7OMycW4DH/noOKKzgW1Xj3rN
         VCcGpCcSzgpyLSduqcqcf/xeI54vxrfe6n5MZ6527RqM12RdwI2h3sM6DSlw4t2qeqCc
         z3RX0+OEDuw3cQREJVnqUjrBEhPvE0MWuRqSL7HyhpxiOrs6+HPwsr6Vf+zUNqcQlzLY
         dsgA9KwLPn9QNyq0OL9DA72kXue2a3jwmsthx94XecMkCtv6C9z7yqBlrwoiZrNer2Am
         3s4ntDTevjROPBtHCgA6XxTm4ODhk4FcckqqE0miM1G5CQ8/+iDnrz9KPud4ybJRN3s1
         DXWw==
X-Gm-Message-State: AOAM533iLkCmyqjdmbEvTMb13vcAyE44TDR9h80VV20oLQEftRKYOBPs
        MKixjH9seMna/+avBjXzkE2DVGsX3TuR9Cs5BG5RTxBw8RNiVrtbgrnej+zn7sXZa1QEmw1FsjB
        ipNIjqvFzWHoAjCIQsWUWMzhoCyWnf0eB3TNnuIogzOYL39Tcro1Kuo4hRF/z7fUbFs/KwswUKI
        6P1K+FFD6zN3E=
X-Google-Smtp-Source: ABdhPJyBSMAMNfm8+80WvQMdORzrkNpT+E8k6aYXdw1K09f5Etszt4Zdg15KaGp3HNXLFVcp0uHLIP0I69HRGZDcig==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:ad4:4ee7:: with SMTP id
 dv7mr46258220qvb.43.1609149906509; Mon, 28 Dec 2020 02:05:06 -0800 (PST)
Date:   Mon, 28 Dec 2020 18:04:55 +0800
Message-Id: <20201228180429.Bluez.v2.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [Bluez PATCH v2 1/4] shared/mgmt: Add supports of parsing mgmt tlv list
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

