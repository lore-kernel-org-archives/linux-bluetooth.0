Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF25C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C47E360F00
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240482AbhHMMWL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240473AbhHMMWL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:22:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB05C061756
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:44 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 203-20020a250bd40000b02905933fff7091so9009950ybl.16
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lfuWy/d6aVVzArZ1Xmej6mfM+pd7qIF5AspEN/7glPA=;
        b=ro4c1duCtj43gl/YkGtaykg8j5obORYHcueHCuZ7EyZL3Uit4Ke2CKS63mMBQErngi
         ZcAk9utyX0+PsLfbu20YjcOugDJcdJyk+uROIzQw89FlJSzzMLVGkhc3uDJ1C+ZFvYOX
         2OQJxOD3Mzq+5I8AxY+764paXl2DkZ4Xf9DZP3/y0qJDslM4hUMSA/W3HM7LEBhski+R
         FtKgYBsHagJpZZNp8MwMWk1oY6BpWTfskv4l5Q5MEjmM2XYVz2oYLK0I99XL/lI5dQFg
         T48DWsebK/gDbEDNT9cYDR9JHUdEwYOBaNIvU1Qls09D5ejvQgP59doG0dkfRnZqlHTI
         MANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lfuWy/d6aVVzArZ1Xmej6mfM+pd7qIF5AspEN/7glPA=;
        b=LZ/BqYzLAaiJGOiW2WJ2yHkRv2sbT9wSWGqvAOwiHikVALTNIAPnzz5XvS74R62qzO
         B3+wz7k3i7RxwsiX1hl6Ur2gJS4LwUKk94IDIQ1ZIQLtfeXY2U7CZYgSQl8fQa+/+Zz1
         z3mMV4firKv5L2gxlXn+7C5wLQeVhB7KsqxYHlXnxLgdh3q1XMnzg4TbRimehzG66I7j
         wJ95LQ//7caSRzN02W9HHiYy/yPPtdV8rTqZL63B8ly2Xve+nTVRNWv+IFE9irYSJvPh
         oIY6rjdqG0aqUxT8MmQAMruF8ucIcLe99gquWYOcF3RxOE8teVBDM4UbFMohrIksOq5Y
         SAEA==
X-Gm-Message-State: AOAM5334lSv9UXnbLJCC/8tA3PkTKyu5KWj1LrDaj47XGolT8nU8mNvu
        HISR+LgvqPO1arSTR8JuigHqgIaLEsljiEgABbvrepv0c4W7RpjCaFGYDOxnIUlD+9rSLo5Kdeh
        NhVitThN2LPjmTJMNV1GaOZnPowgL9fvFW5NcJGezrhkx5jJ6ZKHtKydfHxtVpYLh1puBTPEUcQ
        SR
X-Google-Smtp-Source: ABdhPJyOoHadHjvmK8aScbzwZmmj3xZmPfRjbjVUFjwTJFtO37iQl51jwLOY6sEwIWHTYZs7eHHc0yQTyBCW
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a25:be48:: with SMTP id
 d8mr2622922ybm.521.1628857303927; Fri, 13 Aug 2021 05:21:43 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:20 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.35.I7995eea1848784bbc348f968ed7ed6d26161c2b0@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 35/62] tools/parser/avdtp: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central" and "peripheral" are the preferred terms, as reflected in
the BT core spec 5.3.
---

 tools/parser/avdtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/parser/avdtp.c b/tools/parser/avdtp.c
index bb7bbadaba..68a5b370c5 100644
--- a/tools/parser/avdtp.c
+++ b/tools/parser/avdtp.c
@@ -605,7 +605,7 @@ void avdtp_dump(int level, struct frame *frm)
 		nsp = (hdr & 0x0c) == 0x04 ? p_get_u8(frm) : 0;
 		sid = hdr & 0x08 ? 0x00 : p_get_u8(frm);
 
-		printf("AVDTP(s): %s %s: transaction %d nsp 0x%02x\n",
+		printf("AVDTP(p): %s %s: transaction %d nsp 0x%02x\n",
 			hdr & 0x08 ? pt2str(hdr) : si2str(sid),
 			mt2str(hdr), hdr >> 4, nsp);
 
@@ -659,7 +659,7 @@ void avdtp_dump(int level, struct frame *frm)
 		time = p_get_u32(frm);
 		ssrc = p_get_u32(frm);
 
-		printf("AVDTP(m): ver %d %s%scc %d %spt %d seqn %d time %d ssrc %d\n",
+		printf("AVDTP(c): ver %d %s%scc %d %spt %d seqn %d time %d ssrc %d\n",
 			hdr >> 6, hdr & 0x20 ? "pad " : "", hdr & 0x10 ? "ext " : "",
 			hdr & 0xf, type & 0x80 ? "mark " : "", type & 0x7f, seqn, time, ssrc);
 		break;
-- 
2.33.0.rc1.237.g0d66db33f3-goog

