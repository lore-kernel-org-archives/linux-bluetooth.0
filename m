Return-Path: <SRS0=78jX=M4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03366C5ACCC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:16:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B590B20869
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SD1rjHqZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B590B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbeJQEIR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:08:17 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39095 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbeJQEIR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Oct 2018 00:08:17 -0400
Received: by mail-lf1-f66.google.com with SMTP id n14-v6so6150878lfe.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Oct 2018 13:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=XkHx5Yw7DiXomXJfjcn3zqiYJqwNQMfVd1F/FmcUQx4=;
        b=SD1rjHqZcUGwcImHS1fLXYgnu1fW5TJBxjzVEhPQTKXr1FsR6kciNZOx2AWTJzQdTn
         A4LTyJBd8VhKaa00LBqyR39X0IdxRCtf6A0k2/9g3ObvejosP55sdn2qa2W/b5L7iLM+
         /trkuWknxF0+NS3D2p9f456QN52jaEKGS6QI2GcxVE2S60sqp+zDloGftZUMRT6M2W4p
         O5mic5ofq1942/rmoG3xQFAanSo/Q7NxOGrJN0OHlmsad3yzLcMweHNX0IN8QadBgEbS
         fChJ5nPv+KxopcitEgGCXhHCrUJC0t0qkPMJGpYPSsV5f0DuoGxYPMXo+tt9dtJfYDF9
         rIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XkHx5Yw7DiXomXJfjcn3zqiYJqwNQMfVd1F/FmcUQx4=;
        b=a3+bnb64qbzjUmR43yOcxE36Qy/G2jZb1IYfgST4CRgTFV+j3cfre5Tj2u1OyVRiqF
         M0tOCy5/wfxw04KOmuPdUXpjZm9DM0kbrBJYSPzjW/pP+y+CXKOuLUjh/a58rx+FsxWr
         L7enGcpTmGJ1qEYjb26/x8cKhKk4kt5CJUCP6FDIDJgxPyf920ngy1YkMGwQ+Cej7bBz
         zOGdIG7l0wSUsN67jq5hSydYOyfFRFtc0K5g7IuDRnBACXqE6wB2Gs2C7rdpQkbA2IUN
         gZEun3cAXNE78tvVgbBoNklRY/UQEt2IzT7n39PUkqiKrSYN566qgGA9YgNwPUtLYRtO
         DSWg==
X-Gm-Message-State: ABuFfohTaPSywU2X0MVE1bBtz1ehcKrXn+lmQspj6wDIP9W1pPy06nAx
        KDEBLAE3U2O4mU5pgUfQQIy+zXIz1gE=
X-Google-Smtp-Source: ACcGV63uSXd8RZQ1cN1sty2ytvXelAEqCkqi2Hw+4yBLsasgpBil6LF4Vmv4mnJxUDznvK7PGIN31g==
X-Received: by 2002:a19:8f45:: with SMTP id r66mr1102648lfd.9.1539720970773;
        Tue, 16 Oct 2018 13:16:10 -0700 (PDT)
Received: from Matias-MacBook-Air.local (85-23-86-144.bb.dnainternet.fi. [85.23.86.144])
        by smtp.gmail.com with ESMTPSA id f1-v6sm3415269ljf.5.2018.10.16.13.16.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 13:16:10 -0700 (PDT)
Date:   Tue, 16 Oct 2018 23:19:38 +0300
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/12] btmon: fix segfault caused by buffer over-read
Message-ID: <20181016201938.GA84988@Matias-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix segfault caused by buffer over-read. Check that index is not
bigger than MAX_INDEX.

This bug was found by fuzzing with AFL.

Program received signal SIGSEGV, Segmentation fault.
0x0000000000420bb8 in print_packet (tv=<optimized out>, cred=<optimized out>, ident=<optimized out>, index=<optimized out>, channel=<optimized out>, color=<optimized out>,
    label=<optimized out>, text=<optimized out>, extra=<optimized out>) at monitor/packet.c:317
warning: Source file is more recent than executable.
317					index_list[index].frame != last_frame) {
(gdb) bt
 #0  0x0000000000420bb8 in print_packet (tv=<optimized out>, cred=<optimized out>, ident=<optimized out>, index=<optimized out>, channel=<optimized out>, color=<optimized out>,
    label=<optimized out>, text=<optimized out>, extra=<optimized out>) at monitor/packet.c:317
 #1  0x000000000041a8c3 in packet_new_index (tv=<optimized out>, index=<optimized out>, name=0x7fffffffda68 "rsion 4.18.0-matias-patch2 (x86_64)", label=<optimized out>,
    type=<optimized out>, bus=<optimized out>) at monitor/packet.c:9818
 #2  packet_monitor (tv=0x7fffffffda50, cred=<optimized out>, index=<optimized out>, opcode=<optimized out>, data=0x7fffffffda60, size=<optimized out>) at monitor/packet.c:3881
 #3  0x000000000040e177 in control_reader (path=<optimized out>, pager=true) at monitor/control.c:1462
 #4  0x0000000000403b00 in main (argc=<optimized out>, argv=<optimized out>) at monitor/main.c:243
---
 monitor/packet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index cecb295bd..64faceca1 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -313,7 +313,7 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
 			ts_pos += n;
 			ts_len += n;
 		}
-	} else if (index != HCI_DEV_NONE &&
+	} else if (index != HCI_DEV_NONE && index < MAX_INDEX &&
 				index_list[index].frame != last_frame) {
 		if (use_color()) {
 			n = sprintf(ts_str + ts_pos, "%s", COLOR_FRAME_LABEL);
-- 
2.17.1

