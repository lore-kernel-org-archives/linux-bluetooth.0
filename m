Return-Path: <SRS0=W/a7=NE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB362C004D3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Oct 2018 10:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AE442082F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Oct 2018 10:17:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=codecoup-pl.20150623.gappssmtp.com header.i=@codecoup-pl.20150623.gappssmtp.com header.b="oscO+P7B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AE442082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codecoup.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbeJXSo6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:44:58 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:45927 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeJXSo6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Oct 2018 14:44:58 -0400
Received: by mail-lf1-f45.google.com with SMTP id c24-v6so3502852lfi.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Oct 2018 03:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codecoup-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=7n8uUkkfOZNhwW1HpUfGaniEA9QpgDeil/POotMas2s=;
        b=oscO+P7BMGuR5G7zWzzEdxfljAMBbatckC6ripUNB6tcsQ1AB8raK2rL1PpFXmKscl
         BwAeuWf3uHhXVfYuaiwBZkpUAhDO+0CcxYd/ZuKqqZX/zmWzD/xUfocVUvM0e7wuILdj
         nMU5D68Lhdqv/BO5ojLWi4EzmLv5TjozUX1+vs7ohY+nTfpZkBve3ggUd3XDfS3eMuCY
         F2pWUya4NGVGK/hdiA7WVQCUxUgoDnGYBi+Wt/mZieGCwwfY9jknxhKOo1lLeQPLzGp4
         Fz+uGX/bBXbBXRZlhTdWi33/2C2BI5eD46wzOrEcDM4c3BlYI/c/3h8aboslHSRk9wek
         s95A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7n8uUkkfOZNhwW1HpUfGaniEA9QpgDeil/POotMas2s=;
        b=X6zQ+ZypL09NVENrdCqdeFCKYVhQlMW2MXXR+4906ei9Ij75woTMSOkc/aARoaxx7R
         +TkdVhORSn3A4GwNC70tHPFk45R6c9HDzkXzvlhn9L+tA2WcYktjJOW+LJqNPcrQ0gJ9
         1KFHqKlNXdt35yUafnvk5z6zMZElLADx/KWh4o/boP8q209BV1PQNeoPKLgDDiGgSjao
         w9hgbARpBPzF9qtCKzbpz9L+pCe/owWDxCpUbGgVsciSTnld7fQCx0vKwu4yHNxEmZya
         EqFGMmIiJZAJHqn4VjqJ/chUPUSwDWsKBf9O94qSBlsWunQGWrEiM7dYP587R9AlfQZP
         WChA==
X-Gm-Message-State: ABuFfogXjbZJ3F+tXAgaxcOwzJWgCKLiDG1hh7c+sTbbVUYWHwiGtPYl
        7KufksNiKXDNe9RPIFxAasTfK+trP98=
X-Google-Smtp-Source: ACcGV62CQ2G97Jy4VGuJKjjSeZrixyYLzbOMpCwoNT7IeKjTNzL7OcgBKIhsuK8WkhinCqaU+RtcLw==
X-Received: by 2002:a19:9a0e:: with SMTP id c14-v6mr15828443lfe.11.1540376246571;
        Wed, 24 Oct 2018 03:17:26 -0700 (PDT)
Received: from rymek.cchq ([95.143.243.62])
        by smtp.gmail.com with ESMTPSA id z19-v6sm656416ljk.20.2018.10.24.03.17.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 03:17:25 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
To:     linux-bluetooth@vger.kernel.org
Cc:     =?UTF-8?q?=C5=81ukasz=20Rymanowski?= 
        <lukasz.rymanowski@codecoup.pl>
Subject: [PATCH BlueZ] btmon: Add colors to data status in extended adv report
Date:   Wed, 24 Oct 2018 12:17:18 +0200
Message-Id: <20181024101718.26695-1-lukasz.rymanowski@codecoup.pl>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch gives color indicators to data status in extended
advertising reports. This gives better visibility on which advertising
events were completed or truncated.
---
 monitor/packet.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index cf4a64362..eabd21914 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -9323,6 +9323,7 @@ static void print_ext_adv_report_evt_type(const char *indent, uint16_t flags)
 	uint16_t props = flags;
 	uint8_t data_status;
 	const char *str;
+	const char *color_on;
 	int i;
 
 	print_field("%sEvent type: 0x%4.4x", indent, flags);
@@ -9343,19 +9344,23 @@ static void print_ext_adv_report_evt_type(const char *indent, uint16_t flags)
 	switch (data_status) {
 	case 0x00:
 		str = "Complete";
+		color_on = COLOR_GREEN;
 		break;
 	case 0x01:
 		str = "Incomplete, more data to come";
+		color_on = COLOR_YELLOW;
 		break;
 	case 0x02:
 		str = "Incomplete, data truncated, no more to come";
+		color_on = COLOR_RED;
 		break;
 	default:
 		str = "Reserved";
+		color_on = COLOR_RED;
 		break;
 	}
 
-	print_field("%s  Data status: %s", indent, str);
+	print_field("%s  Data status: %s%s%s", indent, color_on, str, COLOR_OFF);
 
 	if (mask)
 		print_text(COLOR_UNKNOWN_ADV_FLAG,
-- 
2.17.1

