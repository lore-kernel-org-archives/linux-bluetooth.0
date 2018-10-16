Return-Path: <SRS0=78jX=M4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D444C5ACCC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C495121470
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hj4+eJTi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C495121470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbeJQELW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:11:22 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:44174 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbeJQELW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Oct 2018 00:11:22 -0400
Received: by mail-lf1-f42.google.com with SMTP id m18-v6so18009398lfl.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Oct 2018 13:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=/SMxhNdPafmNuFlpdqQ/8guO9enxUPM84bL4Mqb89SE=;
        b=Hj4+eJTi9o7CTqWKBFfD9LoXYRicg8DD+IzO/AiZOmvXfPwWTS1AW1bWi5/tPOdtzh
         KBDsnWNvjEm1Vvo111GkY8tYbrtGqBMXT3twyJGzhqEAH+RKobxPePYEnj/5yj9S2YFv
         qBsQBWBkmsRzJibqz8blEoy5H1YFF/g7sI1V+BOK+/fQNOmka664zVP816qnuvz5g+PR
         7vnymwsmZSGqrwYQJEBNc6jDGiHiuD7aMPY2n1L4k3NpQo1OjttJlA7lVWkKizCprmgF
         hYKIiVQwVkb4LiW5/e5MRRyj5y2Xp7gTg6u+ANx6tpD9mHNSwmeDW5PBFd+Et/C4CHZR
         4x1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=/SMxhNdPafmNuFlpdqQ/8guO9enxUPM84bL4Mqb89SE=;
        b=k44RICl3YJwTJM8fh/mIk0H1ETUA+as/2PgW1Zgz4kjirklckf7QKeCyiBW8cwya7T
         VVKSAe4EfOYsTFV8LVL9x+FapQIOKLM53ijuX83RV4ytt1HWv1Kp1IYlZ0QtZes6lwQk
         38i7aJgMjinUaNcJtwgXT92ywmQYfGibSMtmp0WTmh3FYh97wBz8/ijZPtQ+gBLcs2TP
         fOREb8wo54d+IwF9dL3CEPYKB6ZmsFokvgkvkK+NVurMNpndq1DKeKjFqXawjVarVvPj
         eWwC0iEq/zQJc/QnsLLxi0xGRFW9rhfG+VVx2lYrWp+Y7kU0GgFJYkXTvZ3iugFrYEdH
         kiLw==
X-Gm-Message-State: ABuFfoiB7LytCsnQI2c8YJlOnb2PLs+kS8qMYQmENdTC3qWRXQRjrjYR
        6bP1UXPHPd/0mLYsMMvw5AHfDZzhq7w=
X-Google-Smtp-Source: ACcGV60iQ6LITYfgl4ttK1rE4ljjbxQ0mN7JHpb8O+IA1biYQR5+viGuvYO2V5K3tUtDT4olBNF2AA==
X-Received: by 2002:a19:274b:: with SMTP id n72-v6mr13266831lfn.153.1539721154835;
        Tue, 16 Oct 2018 13:19:14 -0700 (PDT)
Received: from Matias-MacBook-Air.local (85-23-86-144.bb.dnainternet.fi. [85.23.86.144])
        by smtp.gmail.com with ESMTPSA id 2-v6sm3392642ljv.83.2018.10.16.13.19.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 13:19:14 -0700 (PDT)
Date:   Tue, 16 Oct 2018 23:22:42 +0300
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/12] btmon: fix segfault caused by integer underflow
Message-ID: <20181016202242.GA85013@Matias-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix segfault caused by integer underflow in set_event_filter_cmd().
Fix is to check that size is big enough before subtracting to prevent
underflow.

Crash was found by fuzzing btmon with AFL.
---
 monitor/packet.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index abdc18aa2..461f5e84b 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -4726,6 +4726,10 @@ static void set_event_filter_cmd(const void *data, uint8_t size)
 		break;
 
 	case 0x01:
+		if (size < 2) {
+			print_text(COLOR_ERROR, "  invalid parameter size");
+			break;
+		}
 		filter = *((const uint8_t *) (data + 1));
 
 		switch (filter) {
@@ -4765,11 +4769,21 @@ static void set_event_filter_cmd(const void *data, uint8_t size)
 			break;
 		}
 
+		if (size < 2) {
+                        print_text(COLOR_ERROR, "  invalid parameter size");
+                        break;
+                }
+
 		print_field("Filter: %s (0x%2.2x)", str, filter);
 		packet_hexdump(data + 2, size - 2);
 		break;
 
 	default:
+		if (size < 2) {
+                        print_text(COLOR_ERROR, "  invalid parameter size");
+                        break;
+                }
+
 		filter = *((const uint8_t *) (data + 1));
 
 		print_field("Filter: Reserved (0x%2.2x)", filter);
-- 
2.17.1

