Return-Path: <SRS0=78jX=M4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396B1C5ACCC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08F220869
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMA5cbZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D08F220869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeJQEJ6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:09:58 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:40637 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbeJQEJ6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Oct 2018 00:09:58 -0400
Received: by mail-lj1-f180.google.com with SMTP id r83-v6so22149246ljr.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Oct 2018 13:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=acrptFLBzjO0oVwkej+JjOlha+nvrm+74hnhLl8BDho=;
        b=FMA5cbZIJUuZwW43iXYvxH/F1uNVXU2IYWE231xegHN6U//IL8SyjVsyiK2J3gkr6P
         8wGCeJvhbmLslDT3GzhB2mX/QmOk2nTkglAuEXSIXgMk/Vo2SiojUEPQCV5XeoTYR+eg
         8cNoO/gvKW5c9EHbHGh2rPanQkL2SToMk79lrG0jMHTTQdlEAoFt92qryEuSJNyPoTbe
         ITBU0fdNnE2qTPDDRGjqPDqe8ekTUasjKAKpCx6sR47rGxirN4votu+L4X/2LRzFTdY8
         sGbPu03AP09OSo/rDid/jc39D15/yGPeG2Nww4lZ0hNCuGd/K0zcla3WfPNfMurdVAWt
         3kCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=acrptFLBzjO0oVwkej+JjOlha+nvrm+74hnhLl8BDho=;
        b=U/LIl0D4Z8tbu1gGeEJ5kK7JinUck3w+Ga4/Y6IX6DIIvSb6c0S//MP38OvQPe2Yu9
         Yrgg8q2jqyl2D2pMXU3tUcTjLiMTtIm7wQgaLuQIlagmNYn2m5tHyFAuPOyS890ZIyJk
         RDZKvsV5+iqLSRGwEvGv7iqWMw73J0NRynenEUu3QTmMOoy51N1qxbvrXL0zu+WgkwPb
         FzMovoS2VPprNzH2ng4r/gKPL11X+8rloXYgYxtKrsyGzzqte+fzE4jlhQYLYSoP9+GG
         GKroHkBu5BtSdgwH+MxdZdak1bC2FaawP4jYMgjdrjuh5z+tWZByhp1c+8V0+qyjvdCr
         7kyw==
X-Gm-Message-State: ABuFfohj8slKqx/b4zFCWGr0YDLoIb7SsSw56cznk6F0l+MJ5vrgshD2
        WAR3mQjqr3DvJbhb0BZZqAM7f9+pDMw=
X-Google-Smtp-Source: ACcGV62lQYrC+jv46xxdbw2hYcQZszzdL8oZI0phA2+gG8uR5jE58fXY0SKAUQbmt5Mc/hm6zIITQg==
X-Received: by 2002:a2e:9f17:: with SMTP id u23-v6mr14586538ljk.53.1539721070808;
        Tue, 16 Oct 2018 13:17:50 -0700 (PDT)
Received: from Matias-MacBook-Air.local (85-23-86-144.bb.dnainternet.fi. [85.23.86.144])
        by smtp.gmail.com with ESMTPSA id 16-v6sm3265844lfs.84.2018.10.16.13.17.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 13:17:50 -0700 (PDT)
Date:   Tue, 16 Oct 2018 23:21:17 +0300
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 04/12] btmon: Fix crash caused by integer underflow
Message-ID: <20181016202117.GA85003@Matias-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Check in packet_ctrl_open that parsed length is not more than buffer size.

Bug was found by fuzzing btmon with AFL.
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index fb6d7e46c..8f7464b1f 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -10246,7 +10246,7 @@ void packet_ctrl_open(struct timeval *tv, struct ucred *cred, uint16_t index,
 		flags = get_le32(data + 3);
 		ident_len = get_u8(data + 7);
 
-		if (ident_len > size) {
+		if ((8 + ident_len) > size) {
 			print_packet(tv, cred, '*', index, NULL, COLOR_ERROR,
                                 "Malformed Control Open packet", NULL, NULL);
 			return;
-- 
2.17.1

