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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA6E8C433E9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 06:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36C2207BC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 28 Dec 2020 06:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgL1GrU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 28 Dec 2020 01:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgL1GrT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 28 Dec 2020 01:47:19 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C67C061798
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Dec 2020 22:46:39 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id w8so16705215ybj.14
        for <linux-bluetooth@vger.kernel.org>; Sun, 27 Dec 2020 22:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=EyC5xIrBqlSQLTjiRSrDM2FtzhrjMO/QlB5tdJsMwFo=;
        b=Ea9TNGe+6udK0VenKGDFdt7HfSAxnSq9AkO8jQCvYXO1dDQFntSXmaZ3XpLzjPJhK7
         S1SqZ78WIjaUGRFwLJC6kJKUfgNP73ft8wzNYaNtbBYN1l13Eg1Aucd1XNXoTNBBzE+U
         5qskxxWmuXJKnM7DfpfGTSBlkUdOLDJWfHg9YGf0xh8DLZ1XMABINkJ9CK4xPFXXp4T6
         RiZZ2/GYsVQrMfbTmx2aIxdPy5gJroWbh4gdqk7Ls8tB5H2LIZJ+DDAw6i4ZSszKmzSw
         LpWLdblZxAK0NWFQm81qqhZ4KqdpxlF0LA4Dg8x5g3sAIrN2DAHvpLHKlrirHx+skml7
         T/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EyC5xIrBqlSQLTjiRSrDM2FtzhrjMO/QlB5tdJsMwFo=;
        b=m2TMVAtvLFeDs3yOomatF0VlzTZV3q6sF16+WLlJ9OlytkWdgduSbtYBgVJO2V+SML
         c5OVTNHzJJJvcVTBmXCKhpa76sdjZ2HuoYWXs5DEJhrolQ18l6OPF7OXgWv+8oyck+P1
         tqsC5k+MQW7Sfs7fU7Do9lGXKoQhT2dGx5M3Q4J/C45QwYr0uKzoZq8BfBSL7LJMgPOo
         Iwe1yIlzHs/Iwyy6599FE5KMFJyhi+QZWXboZZ8uXyj6k5Cdu2wOBbQ10w35xatuQymk
         9Hdk4UAhs4DT0ZFjsTo1Nz2M6qbpiKRgMJKxY3hjLAP7Oy4rK+7BMr9VOfJrB8OzMQYp
         bYqg==
X-Gm-Message-State: AOAM533QMJE9wsppZA6nKrBkBumXSF/cuIE6YlBWHkUYWkWPehOT0378
        UTswfd3+97HmDSZ1dN0EQjbCefErONffrRK435U/DjU3LjmRXP2/VFo63kIQBcFD2vUQ7qIoMk2
        r+xLYGqKzDyTDnK9/1kCnz+pv4ytTYRJ9V45rDFPA8VtEwcDj0cJ7GaiRAJcSZb2wY6/Yy3EGkT
        5OpPOIWvj+Z7E=
X-Google-Smtp-Source: ABdhPJyQcHvcDiRzfvkqJ7btVG6Wbf8wsOfIKpp1AcSS3Re4HJKDFdCHOjYILECfwWVRAqhKDvTJtlxPCWjXRCxRFg==
Sender: "howardchung via sendgmr" 
        <howardchung@howardchung-p920.tpe.corp.google.com>
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:f693:9fff:fef4:4e45])
 (user=howardchung job=sendgmr) by 2002:a25:8050:: with SMTP id
 a16mr38915877ybn.146.1609137998689; Sun, 27 Dec 2020 22:46:38 -0800 (PST)
Date:   Mon, 28 Dec 2020 14:46:13 +0800
In-Reply-To: <20201228144543.Bluez.v1.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
Message-Id: <20201228144543.Bluez.v1.4.I43884adadc00a5095dd03d2261a71dc2ba80d986@changeid>
Mime-Version: 1.0
References: <20201228144543.Bluez.v1.1.Ie32770d0eed2e7739ce9d17d920766fb6aee8583@changeid>
X-Mailer: git-send-email 2.29.2.729.g45daf8777d-goog
Subject: [Bluez PATCH v1 4/4] shared/mgmt: Fix memory leak in mgmt_tlv_list
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        luiz.dentz@gmail.com
Cc:     mmandlik@chromium.org, mcchou@chromium.org, apusaka@chromium.org,
        Howard Chung <howardchung@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch freed the mgmt_tlv properly in mgmt_tlv_list_free.

Reviewed-by: apusaka@chromium.org
Reviewed-by: mcchou@chromium.org
---

 src/shared/mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index bdc4bdd9e66b..19b5466f9071 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -595,7 +595,7 @@ static void mgmt_tlv_free(struct mgmt_tlv *entry)
 
 void mgmt_tlv_list_free(struct mgmt_tlv_list *tlv_list)
 {
-	queue_destroy(tlv_list->tlv_queue, NULL);
+	queue_destroy(tlv_list->tlv_queue, mgmt_tlv_free);
 	free(tlv_list);
 }
 
-- 
2.29.2.729.g45daf8777d-goog

