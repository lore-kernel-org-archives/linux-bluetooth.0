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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09071C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 11:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D42FC229C5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 11:35:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbgL1LfS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 06:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbgL1LfR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 06:35:17 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70524C061798
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 03:34:37 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id g17so17930619ybh.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Dec 2020 03:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=D6yQ0aeiUTF84rpACa7tV0EEPiv+8c73o+8fQ16hv50=;
        b=DON27MLoCDLCsJFbTf51DMjkvUbLoK87r8WSuIUp+tymFX3tLE1SipNYsjfK9UPrtJ
         QEI/jHkuntSq8SEEdaIUe+kIg5feZRWlGz4Z4kbQA1VG7EgNQeRAl8od679KG5snkYl9
         ORER+yo51+mG7gV1DMP9YSl/8JF0PYfmuXrq1BNkocemZMtyzJ9n+hZg/yIP4g6ZOBwR
         DLBtIHVwjuW2Osc6k0PkWFaDVT39Qr9qp/d0H5anQLcKWknklZmgu9luJaZXdjpqWb3S
         CF94845spOA/CaiKhbM7xui7nKmG7wvE1lgukswysudUThgGAi9fIhyHCBJNZWY1rH09
         H5Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D6yQ0aeiUTF84rpACa7tV0EEPiv+8c73o+8fQ16hv50=;
        b=ZPawr6lHbwOxWW8M0NrnbvP7mRGEJTlxNM1ootR4wHdImKCdO+e+ZNZ9pM8SbIChgE
         5W4aGl6MjwC8xXqv4Ay47fetYIaSSwjsIVOJsSP9n2krE09w3B9SWIA1B4JGOvbjRHfw
         /6OPtsBV2Rx57PhyOSSA2U9I7rd1GUjeR1+WOLgYMBQxcHlOYBUVihozJK+O2bW2j5h5
         mqwFxDjzPD+LhOLDrjf6kRGbaqAVGRQvg8E94yrs7Zl/u2cs7H2dELBt+Dn15PV/FH5W
         eNVz8b0poKnsDjU33poa8hG3Rgus8ab39cnQy4mGANKxixD+7k3vC9gnNRfOPyK+E43t
         PO6g==
X-Gm-Message-State: AOAM530Nc8VFRKPNqn9KXnLdH2nh8zBSV5Bz2Ecd/h6kL2oMFfH6p7ZY
        w5bjwwwg5FijoFtmI4VWF7rPLiFaIR7jJbCbEZ5X0UuFRRxfeLOXskw4tLfw36b/jKjja2zRhA/
        AXQHXnvMTf5f+svj0PXLBlEq2ypMqaYHCq6eiwRy9cRMqNBftUnQKlJiwB/lb6PrBB/iuYo4Uaj
        SZglCEJIZt1Ko=
X-Google-Smtp-Source: ABdhPJzXp1AQgvSZVHLR3o5TvRqXC/OcYSfi+Wu0w3H3EYWD+P15juQfjif2C/Gn/0Iuej9iZq2inYy9OZHibed0Hg==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:aa88:: with SMTP id
 t8mr62078374ybi.292.1609155276643; Mon, 28 Dec 2020 03:34:36 -0800 (PST)
Date:   Mon, 28 Dec 2020 19:34:20 +0800
In-Reply-To: <20201228193351.Bluez.v3.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
Message-Id: <20201228193351.Bluez.v3.4.I43884adadc00a5095dd03d2261a71dc2ba80d986@changeid>
Mime-Version: 1.0
References: <20201228193351.Bluez.v3.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [Bluez PATCH v3 4/4] shared/mgmt: Fix memory leak in mgmt_tlv_list
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        luiz.dentz@gmail.com
Cc:     mcchou@chromium.org, mmandlik@chromium.org, apusaka@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch freed the mgmt_tlv properly in mgmt_tlv_list_free.

Reviewed-by: apusaka@chromium.org
Reviewed-by: mcchou@chromium.org
---

(no changes since v2)

Changes in v2:
- Fix incompatible pointer type error of mgmt_tlv_free

 src/shared/mgmt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index dc8107846668..0d0c957709d7 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -588,14 +588,15 @@ static struct mgmt_tlv *mgmt_tlv_new(uint16_t type, uint8_t length,
 	return entry;
 }
 
-static void mgmt_tlv_free(struct mgmt_tlv *entry)
+static void mgmt_tlv_free(void *data)
 {
+	struct mgmt_tlv *entry = data;
 	free(entry);
 }
 
 void mgmt_tlv_list_free(struct mgmt_tlv_list *tlv_list)
 {
-	queue_destroy(tlv_list->tlv_queue, NULL);
+	queue_destroy(tlv_list->tlv_queue, mgmt_tlv_free);
 	free(tlv_list);
 }
 
-- 
2.29.2.729.g45daf8777d-goog

