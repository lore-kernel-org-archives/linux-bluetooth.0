Return-Path: <SRS0=78jX=M4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D8CC5ACCC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 862AA20869
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4uI3fl7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 862AA20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbeJQENV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:13:21 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:38911 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQENV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Oct 2018 00:13:21 -0400
Received: by mail-lj1-f181.google.com with SMTP id v7-v6so22180158ljg.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Oct 2018 13:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=OAkVuEdTsFPyfIALBKtKzmZimJ0W/He0SIDVf/Oztng=;
        b=l4uI3fl79A8jQlSvNM+U+SvIecyeq1TaoXl219qtQzBGkFcxhSo+HFGGTzK3qNfMIM
         rrAYUSy4YOImKipcvt7SNOSm1enoBDs+SsRsDDOQd0aab4AXPg3FmYWeJ5WXK7PA4epD
         qiG7skhWVNlx4SIle4+dQBLcg6XGF8tGkX8ybbaerekbwBKSWx4JSbb/l8J8VhVjgtDC
         TRoZRf0bO1/Ywqezc56aaL5TJTh5t0FDqOijqriuJLfV+a+hEQqZgura7edu2PLnwEm1
         8f5eJ9Rvl8yNy3LqczRTu19qvMVqeHW/epq08DPTK0TDRUu7PQkkEEe4wl/2yu1a9xyf
         OSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=OAkVuEdTsFPyfIALBKtKzmZimJ0W/He0SIDVf/Oztng=;
        b=MG6oj+0+OKcAHmeiRterNdER3ZRu8pvOrxx1zdtjnHfVXmotvvEJd5RI72Y6GtSK13
         oNfB3HjPcScmGoJrHwntZ2wCrnTx+8z4gawOvVkeQ4rEfeCVD6Fu0Eha0gw8DIZzDpzO
         bzeBCSfxgxv+VzqqqwffcFmbXVCUnpi3ZIlNzR8gtYcXkuwts6o9CV1VYa5ujcSnZQOc
         NH+TTFbF4WmD9zatpPYazxiYrSUs/Pfc2YS+u5VQ/DvHfh3PIL0FO2HA6PhsoI/Kgx3c
         cJQrrGJ4LcuVWAbUDd6qvlaz7GD/IcDr0QWMXKY4/jQopjwGo2hskeYDIeCp0VpzMSrd
         FPTg==
X-Gm-Message-State: ABuFfojyLgpW4WU+5J6n46oY14YKQzgk/XDA+MQw4y9lDKW3kNKPY/L8
        xrPdHl7528sUcVspniokpIEWW5irD2E=
X-Google-Smtp-Source: ACcGV63QiSigI8t0gSGP0AMoj13LI4zgsI3W7fZ9waKQ1gD6WYrIDfNALjo/cNIwBvN1pUglmDw3Bw==
X-Received: by 2002:a2e:8457:: with SMTP id u23-v6mr13159075ljh.154.1539721273668;
        Tue, 16 Oct 2018 13:21:13 -0700 (PDT)
Received: from Matias-MacBook-Air.local (85-23-86-144.bb.dnainternet.fi. [85.23.86.144])
        by smtp.gmail.com with ESMTPSA id w143-v6sm1358149lff.89.2018.10.16.13.21.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 13:21:12 -0700 (PDT)
Date:   Tue, 16 Oct 2018 23:24:41 +0300
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 11/12] btmon: fix segfault caused by integer underflow
Message-ID: <20181016202441.GA85025@Matias-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix segfault caused by integer underflow in decode_data_element function
of monitor/sdp.c.

Fix is to check that elemlen is not bigger than size before subtracting
elemlen from size. Also search_bytes + attr_bytes should not be bigger
than frame->size.

This bug can be triggered locally reading malformed btmon capture file
and also over the air by sending specifically crafted SDP Search
Attribute response to device running btmon.

This bug was found by fuzzing btmon with AFL.
---
 monitor/sdp.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/monitor/sdp.c b/monitor/sdp.c
index df5ccdb71..13a8807c7 100644
--- a/monitor/sdp.c
+++ b/monitor/sdp.c
@@ -309,6 +309,11 @@ static void decode_data_elements(uint32_t position, uint8_t indent,
 		break;
 	}
 
+	if (elemlen > size) {
+		print_text(COLOR_ERROR, "invalid data element size");
+		return;
+	}
+
 	data += elemlen;
 	size -= elemlen;
 
@@ -655,6 +660,11 @@ static void search_attr_req(const struct l2cap_frame *frame,
 				frame->size - search_bytes - 2);
 	print_field("Attribute list: [len %d]", attr_bytes);
 
+	if (search_bytes + attr_bytes > frame->size) {
+		print_text(COLOR_ERROR, "invalid attribute list length");
+		return;
+	}
+
 	decode_data_elements(0, 2, frame->data + search_bytes + 2,
 						attr_bytes, NULL);
 
-- 
2.17.1

