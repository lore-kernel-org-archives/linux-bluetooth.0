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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D59C48BE5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Jun 2021 00:53:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 609FF61159
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Jun 2021 00:53:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhFQA4E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Jun 2021 20:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhFQA4D (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Jun 2021 20:56:03 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F7EC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jun 2021 17:53:56 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id m133-20020a37a38b0000b02903adaf1dd081so823142qke.14
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Jun 2021 17:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IV5fU8L1u4KGETor9hcG26C/t67/z8BNghTVJSa60ws=;
        b=BIZ6fJofqcslifr4HOCMqdnewhm7OYjzLwHJ5oBwQ3GB0FT7wpXdpI5OoBvcRQuj9Y
         SU5CWD4VRedqe9HqvwoOeVPbQQV87KJ37tn5ZLeKxoQVprp4NfyZbkNB59Q8fBQtIOi/
         /Vm0of92HoDXLWhTWPAF6Rxl/IgZ8SGT6KBtI3gwZi4bE5LCdE3oK1uHXQEKJSU/1cCv
         mtSMim2waokjLGodq0aiKYVJABmoR7oKvKCDOrPnKVBPFAhjXLXnwMfi2dWPKViKv0Vo
         oTU1GUxiWwUQqnr63QdKGMj39WG/xbbXHkeqYg5Fd5wj20KFJxb6sMgrEow0XygPoAlh
         /S6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IV5fU8L1u4KGETor9hcG26C/t67/z8BNghTVJSa60ws=;
        b=EYn5TM3Q90l6ge4hqVv3ZclCL7evTraEBfywuyedhtHH7S8vP+cNuKRxEo7+tQ+TPt
         xKwd9byBQDDZHS9lZ/j/d1XUEojyeE0AUAyX028xC5bQKPLvyCqlIsZRiYDSsgj7QmA4
         O0yHvgD8lZVYe2myIvZM0u9bE8oOiWrQPaA5ge1NDCijgvbLTQ3P5UO2gQsWyHx7t2K+
         kD+JsqTLu4ye/EQJliI0dUhRW05E8U8NQ3QKJlKQhEV+FPy4gK7CxefkF+VDGWeY9BCc
         LiT7dmUWuFGFZ+rMqE77Upbh4MYU1W0HQuNAI999mUS/s3X030Jz0D6QWamhmWPhJsZL
         MBHg==
X-Gm-Message-State: AOAM530Kj/+hiLNlaraI4H1NJaobUsv3Lnq8GQuUj4EBnc4OcOrMHvgJ
        Q2sO+G8/ykJOOJBSOOVXHkWg9zgyRz1EMJ7OoNDTtX78agpD35Ov3SIAHipv/5cHN4Z2tAoDX46
        mm6KNzLt9/7pzKqP3+gfwgNt69vZEFRHKwykmDMGtpzKbVBW4j1HE1tt217yHfzIyRRG2y49DgT
        9m
X-Google-Smtp-Source: ABdhPJwfVSJ8fwOqsqz0VmqChhS/Bkm/atr3xmhtr/LUatz0taWdXlFllT72QoSdNL88GWcuo127DW5JgtuB
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:bad3:2a68:722e:8bc5])
 (user=apusaka job=sendgmr) by 2002:ad4:4d44:: with SMTP id
 m4mr3090537qvm.14.1623891235216; Wed, 16 Jun 2021 17:53:55 -0700 (PDT)
Date:   Thu, 17 Jun 2021 08:53:34 +0800
Message-Id: <20210617085321.Bluez.1.Ibf5dbfc72abf7d12ffbf18219832e19d965ba024@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [Bluez PATCH] avdtp: Fix parsing capabilities
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

This patch fixes size comparison and variable misassignment.

Reviewed-by: Alain Michaud <alainm@chromium.org>
Reviewed-by: Michael Sun <michaelfsun@google.com>
---

 profiles/audio/avdtp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index c7bf99f429..5d13104c10 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1323,7 +1323,7 @@ static GSList *caps_to_list(uint8_t *data, size_t size,
 
 		cap = (struct avdtp_service_capability *)data;
 
-		if (sizeof(*cap) + cap->length >= size) {
+		if (sizeof(*cap) + cap->length > size) {
 			error("Invalid capability data in getcap resp");
 			break;
 		}
@@ -1345,7 +1345,7 @@ static GSList *caps_to_list(uint8_t *data, size_t size,
 		switch (cap->category) {
 		case AVDTP_MEDIA_CODEC:
 			if (codec)
-				*codec = cap;
+				*codec = cpy;
 			break;
 		case AVDTP_DELAY_REPORTING:
 			if (delay_reporting)
-- 
2.32.0.272.g935e593368-goog

