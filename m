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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87920C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 06:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A638207BC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 06:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbgL1GrF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 01:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbgL1GrF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 01:47:05 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA10FC061794
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Dec 2020 22:46:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id g67so16776550ybb.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Dec 2020 22:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=RYhpAf+NP/aVS5zt+P6Vcn8Y/nE+I/qnyuAeKN2+35Y=;
        b=vZRsC6QkLbNN+AO9CHe/roMDBhL0vWFY2XlLhAkFVkjIH67AU/e85XfzNq+j+GTJeN
         m6XCtXbKuK+i7gl5DIULFg56eTLszZD4r1xO+ISaKYG7YrVdHpAcwWYOWXS5pY67c/f5
         AZhccmls5fMiN0K/x96apZpxTLC959q3M7mQcG36+mWZSJh9k8UMeI6fI9tO2eSQ5YQY
         5Ox/6MTar6CoM+e5g2/SJNnPyNo2+a27+vKxtbrXWGXInN5SCJon8U+IZp7JuHwqg4Gw
         fApoI3QJKETvdLw8siMVeTDeuZrWESI972BtsRAh20QYmp/3uNTNtrFMDPCVMqTgxGeX
         MhoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=RYhpAf+NP/aVS5zt+P6Vcn8Y/nE+I/qnyuAeKN2+35Y=;
        b=UJu8/GhNLkL7wD/FLBdGJscE8eEq/tbOC9qrkBVV6Y0DP4J5p0pO4GoxykMjo/8N6Z
         x3WutkXHjNU7ctdWMpuiwsWGtmKbzDUEEh2TrU0h1Z6cTFBbZy/WdDXctXKHF5EThxIx
         aBDv0a/mN0+28qMrS7YIrdar12tCERXMeexY70icnkybeDsEDS91NhiW7vGp2Gai9bTW
         PZJNhFkJfpuKmcSHUJGYBdcUAr2hoV0EkfO66fSM20CSVPMD0PPDpOjip3OroCbk8Nx9
         /xKrhpCrogznmVN7bIQYmprtcqZYYbz1neKsI+9/dRFtOjxQER4Z/6FnjrppqgWVqt77
         Pa7A==
X-Gm-Message-State: AOAM530Dr5G0HXNm5himIeckYubJ/s94kLKTNs3LXAUcCfLgGd11fQKX
        ACix1+RqJeTZiZw6A7lCjUG3uLW8RHLyKgcQGClFeKP7/aCDOreWBBl+fGv/z8lcwgrbut0Hv9p
        hPbs2u0nZ/IBgtgw9Hc8G9a1Z/CG3do3iNA52fEjphRK2Br8YwxF5QHhByMFZw6TnGRXsBIWdx0
        3+uwZtn8wGDs4=
X-Google-Smtp-Source: ABdhPJxIRrHvKZXqz5/q9j+jV4zCETHhrIOgPYY+T3/HuOhnL3LM8EJl92Xml2NwUjtppA9GkFSg8D0MkIGUd5m/vA==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:3741:: with SMTP id
 e62mr62070623yba.298.1609137983834; Sun, 27 Dec 2020 22:46:23 -0800 (PST)
Date:   Mon, 28 Dec 2020 14:46:10 +0800
Message-Id: <20201228144543.Bluez.v1.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [Bluez PATCH v1 1/4] shared/mgmt: Add supports of parsing mgmt tlv list
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        luiz.dentz@gmail.com
Cc:     mmandlik@chromium.org, mcchou@chromium.org, apusaka@chromium.org,
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

 src/shared/mgmt.c | 38 ++++++++++++++++++++++++++++++++++++++
 src/shared/mgmt.h |  6 ++++++
 2 files changed, 44 insertions(+)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 9ea9974f5535..bdc4bdd9e66b 100644
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
+		struct mgmt_tlv *entry = cur;
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

