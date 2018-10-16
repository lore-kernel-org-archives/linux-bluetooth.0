Return-Path: <SRS0=78jX=M4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B8AC5ACC6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96D7520869
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVUq76rp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96D7520869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbeJQENs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:13:48 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36697 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQENs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Oct 2018 00:13:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id d4-v6so18039991lfa.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Oct 2018 13:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=zsMv1OReyLqDZtRu4eGAL1N0V7ngiXexAvU52nTAEeA=;
        b=mVUq76rpvSxjvF5LbV/lJjm8xdSVuty9JNj2gN9lRM+4nCryckW5U5FNUfUPiQA+03
         tpuSsM+tdcbwB192LQlWOTHiwoeZ9no1K/ESyVgn7j9JuD7QIksMYf5T0uadjqfdOzSR
         nnlH0Xr7+JbIRwZbXgwgl6wVgfYsC9CVQeFots+AVSF0WBCszHQG1nWbLuz7CER5Ybuz
         iV42CsdanBbLiJaN4HE5VlcDMHj6sQ5kIAHuXxzzWfPBWNSrio6W78yNIAnkgvTzV5Du
         wrAbBYQrd3UOozjAvlY+7os1AL1Txchw+PfJLD5imwKKaB9p6YJOjC7SeB8BwSUrtYE2
         RXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zsMv1OReyLqDZtRu4eGAL1N0V7ngiXexAvU52nTAEeA=;
        b=lE2QscmgN32cepHDhTKHZQm0JTm8sMJ9qMZwf+bjNSuGfbrmi0aVGxRCbHTeJY3PcN
         ob23PBXfwpBdErHABJi+3m9W/Ns369UDUGjmP9O+RKyjGOg84mAukZdt3NofyDhIgQ7a
         pdGH2FXhFn0RcP0sBHMhG1HG3CQPsFTBCdAT7f030TxXPVRNbVs/M9lR4JyjVaPN6p1w
         IXxqVoYKKIwj1o6EbO3pYQ8B1rBSugcmHK+/6G//0FSiBEoWmWiTP/QjpQlBFSfFe08g
         olUJ5QWWLD3n1UK33RVFYSmh7DsjZw7mmJ3JBXEB20Rts4P+xymftLwh3FT+nX3grKy6
         Au5A==
X-Gm-Message-State: ABuFfog3V+m2uhAe5Z7Dlr8auqyukJ89zYOUMRuD9OJvbtpC0J3r4Yzt
        CM16a3CnxkQsKNDGzbw7wbP5PYE/044=
X-Google-Smtp-Source: ACcGV63sLQbsnX9HTncGqri9+a1flKgJiXnI+5ZS23gSRzrA77Lmow+pXMTwlDtwKsxUYAtI3bUigw==
X-Received: by 2002:a19:6458:: with SMTP id b24-v6mr5166143lfj.5.1539721300572;
        Tue, 16 Oct 2018 13:21:40 -0700 (PDT)
Received: from Matias-MacBook-Air.local (85-23-86-144.bb.dnainternet.fi. [85.23.86.144])
        by smtp.gmail.com with ESMTPSA id a63-v6sm3507055ljf.54.2018.10.16.13.21.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 13:21:39 -0700 (PDT)
Date:   Tue, 16 Oct 2018 23:25:08 +0300
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 12/12] btmon: fix segfault caused by buffer over-read
Message-ID: <20181016202508.GA85028@Matias-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix segfault caused by buffer over-read in service_rsp function of
monitor/sdp.c.

This bug can be triggered locally reading malformed btmon capture file
and also over the air by sending specifically crafted SDP Search
Attribute response to device running btmon.

Bug was found by fuzzing btmon with AFL.
---
 monitor/sdp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/monitor/sdp.c b/monitor/sdp.c
index 13a8807c7..36708f426 100644
--- a/monitor/sdp.c
+++ b/monitor/sdp.c
@@ -585,6 +585,10 @@ static void service_rsp(const struct l2cap_frame *frame, struct tid_data *tid)
 	}
 
 	count = get_be16(frame->data + 2);
+	if (count * 4 > frame->size) {
+		print_text(COLOR_ERROR, "invalid record count");
+                return;
+	}
 
 	print_field("Total record count: %d", get_be16(frame->data));
 	print_field("Current record count: %d", count);
-- 
2.17.1

