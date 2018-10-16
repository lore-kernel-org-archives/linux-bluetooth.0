Return-Path: <SRS0=78jX=M4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 883F0C5ACC6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E48420869
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csPhNRjn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E48420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeJQEJU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:09:20 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38139 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbeJQEJU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Oct 2018 00:09:20 -0400
Received: by mail-lj1-f193.google.com with SMTP id v7-v6so22169931ljg.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Oct 2018 13:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=a3JUq7dYuZMyvSjVxLoa73zcAjR3chYoz/9+Mu9/P9Q=;
        b=csPhNRjnOW5aZKm974KmbLi7yxY0gxrWteplwK+elnxhxBusqFOVqJcjwW1ZpBTMFa
         Xb9YAZK2+rpv+RUqSLHv+j8fEePjFhilFV4jo54nbE7846QxPnM9Tov0ceUmseLk/fOX
         unQQZcHY6FdHVQT2YV+iP+NSNFzxypnOWfLIkpJIMsqJWQJCx+cBaOHc8fyASpB+nQmu
         WP/fdR/Dpz5mAx7BnGKvDsLURvx+btX35WmmGk9KZJKgVQtOPhlfj//0uNBGIb4RMh1N
         Ehi3bHnRKCUrGR72+x4YwFHJrY5hK8LZzH3IE1N7isJaHNrKP1t40MCX4zMg6aGh/E+J
         B5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=a3JUq7dYuZMyvSjVxLoa73zcAjR3chYoz/9+Mu9/P9Q=;
        b=BaYmWxXhUHaTMPWoEStjrs2HNbwvCrpU5pN6GgAYQxzxfUrFAHV48WFOlNsAdixKtV
         qZPKjWlwirU8y+/Cx+nFR2ElybwV71URKsGVA+axx7P3uLVIqt1obnXJtN3t+fnaz/8o
         eM3speSi/G1XeljI0LsECVJEFDvMbr+XwbHhHsijO9/aWP5dc0mFtErZTmWqIi0ESk0E
         o5p7G3vAiuTCOAlpXjjCOQ1A7b9tHOaPfhCaBFR8ZT9VnMdxwuJJSoaA+XTeSNvpuyvO
         cYg5gHmAKIff4MCcT6Yr2sxoWbcqG+KouPEpvtIWAZbBea8rbtUJWyHdmd1NUXSuZSfl
         f0ow==
X-Gm-Message-State: ABuFfoiIIhCD021I6SzRDE32Q6doZYAuOOJ+Qxerei7m9NohCoTh1C2W
        wEIaL5O2aiGBKcr9qag3VByd9iw/VYc=
X-Google-Smtp-Source: ACcGV62DZL19lFvW7QUcmU1c7TfzUq4xwoyYPz9NAJ9z5xlgfrTAPl5VluaaCweWoiVOdXOrO/zAaA==
X-Received: by 2002:a2e:82c9:: with SMTP id n9-v6mr14433104ljh.137.1539721033799;
        Tue, 16 Oct 2018 13:17:13 -0700 (PDT)
Received: from Matias-MacBook-Air.local (85-23-86-144.bb.dnainternet.fi. [85.23.86.144])
        by smtp.gmail.com with ESMTPSA id e21-v6sm2552161lfc.48.2018.10.16.13.17.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 13:17:13 -0700 (PDT)
Date:   Tue, 16 Oct 2018 23:20:40 +0300
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/12] btmon: fix segfault caused by buffer over-read
Message-ID: <20181016202040.GA85000@Matias-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix segfault caused by buffer over-read in packet_hci_scodata function
of monitor/packet.c.

Fix is to check that index is not bigger than MAX_INDEX.

This bug was found by fuzzing with AFL.
---
 monitor/packet.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 3e2a08a1c..fb6d7e46c 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10170,6 +10170,11 @@ void packet_hci_scodata(struct timeval *tv, struct ucred *cred, uint16_t index,
 	uint8_t flags = acl_flags(handle);
 	char handle_str[16], extra_str[32];
 
+	if (index > MAX_INDEX) {
+		print_field("Invalid index (%d).", index);
+		return;
+	}
+
 	index_list[index].frame++;
 
 	if (size < HCI_SCO_HDR_SIZE) {
-- 
2.17.1

