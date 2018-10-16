Return-Path: <SRS0=78jX=M4=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1557C5ACC6
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:18:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2F8420869
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Oct 2018 20:18:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oN73pIJk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F8420869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeJQEK3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 Oct 2018 00:10:29 -0400
Received: from mail-lj1-f175.google.com ([209.85.208.175]:35023 "EHLO
        mail-lj1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbeJQEK3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 Oct 2018 00:10:29 -0400
Received: by mail-lj1-f175.google.com with SMTP id o14-v6so22180845ljj.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 16 Oct 2018 13:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fNdJClR6Ab9iwbKgp1tctN1Po5AjI57hcEBwB6Vyr1k=;
        b=oN73pIJkWLUWv1oanIl3zW7U2YAPB/eF99Lsyferk0NICrauM7PkWK5nscEgaL/lto
         VylWYdpIG+AWT3OCro7gHokiq6K3ocGcr0BvCFH0UxwPtD8OtKQnkj8sMlrNPzMyLThb
         gbgPF3rF4F8PLNMGcva0TecJ1uRUzuMV+Kk/wF3muQh/FJzo1Vb0v73onOqPlovB4nDr
         KAB6PDEa9+oNLAfCJghp/gbywEwrNlkQ7ff0drBylqjNo4DM+46Omrt0rvfyI8SGWtW9
         JLq3FXa3YAaCyuvv6ddOLd0iBp5Y22hJF8Djx1vXJhXLNyfO0yc/ZcwqiLreXYAWabAt
         8g1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fNdJClR6Ab9iwbKgp1tctN1Po5AjI57hcEBwB6Vyr1k=;
        b=qTxcBRThIUGh0nS9Aza++5cGOcwxUvg1bY5w0RUN8k+DOMuxpI1IA5BUXuYjodM43P
         iauQZqoikemNrzcCvHkfO1bJQRv7yT5W7EjaOfsKXn4Opl5q6Dps5FijhVHqeWDRxB1y
         a+BwnTbtRdnNeg6Gog9X3gOUI1wtfgyJaTxhwImaRzj3JmeMcqgTg1Lhd8pqSNWSVgqw
         ikanSn1Pb7iEHfLiuo4A+JBaqRxAoOIw3X3xLdPEDUt2rE2Sd1aTFdBKB1BIVTidoRn5
         ELGTuOi8VKHwX7fFVy0GyqOGcUOz4pb8WUxdIZ26XPoxumV5cIF2tvPe9i63XoWypxQa
         Kikg==
X-Gm-Message-State: ABuFfohSlAAB547d/OnPmxCw6T3lrrOfsZqsUUP+M1FOa0ajiASna10K
        h+/x8JZ23DS3DCd/BU5aMl/Y54Yqek0=
X-Google-Smtp-Source: ACcGV63tBb0wvLT1MmXIISLvHGQXz5xudno2JNiGwxT/ESv6RG+VocbojdiRB4PibnKy8cLpQYleSA==
X-Received: by 2002:a2e:580d:: with SMTP id m13-v6mr14186376ljb.177.1539721101803;
        Tue, 16 Oct 2018 13:18:21 -0700 (PDT)
Received: from Matias-MacBook-Air.local (85-23-86-144.bb.dnainternet.fi. [85.23.86.144])
        by smtp.gmail.com with ESMTPSA id x25-v6sm3531316ljb.78.2018.10.16.13.18.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Oct 2018 13:18:21 -0700 (PDT)
Date:   Tue, 16 Oct 2018 23:21:50 +0300
From:   Matias Karhumaa <matias.karhumaa@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/12] btmon: fix stack buffer overflow
Message-ID: <20181016202150.GA85006@Matias-MacBook-Air.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Arbitrary code execution vulnerability was discovered in btmon.
pklg_read_hci function read from file attacker controllable
amount of data which caused stack buffer overflow.

Fixes old and previously unfixed CVE-2016-9799.

Initially this was reported by op7ic:
https://www.spinics.net/lists/linux-bluetooth/msg68898.html

Later this was re-discovered by fuzzing btmon with AFL.

Proof-of-concept exploit that shutowns the machine:
$ python -c 'print "\x00\x00\x0c\x10"+ "\x90"*609 +"\x48\x31\xc0\x48\x31\xd2\x50\x6a\x77\x66\x68\x6e\x6f\x48\x89\xe3\x50\x66\x68\x2d\x68\x48\x89\xe1\x50\x49\xb8\x2f\x73\x62\x69\x6e\x2f\x2f\x2f\x49\xba\x73\x68\x75\x74\x64\x6f\x77\x6e\x41\x52\x41\x50\x48\x89\xe7\x52\x53\x51\x57\x48\x89\xe6\x48\x83\xc0\x3b\x0f\x05"+ "\x90"*847 +"\xb0\xda\xff\xff\xff\x7f\x00\x00"' > exploit
$ ./btmon -r exploit

Proof of concept requires that ASLR is disabled and following CFLAGS are
set: -fno-stack-protector -zexecstack
---
 src/shared/btsnoop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/btsnoop.c b/src/shared/btsnoop.c
index 255775e0d..f367aff55 100644
--- a/src/shared/btsnoop.c
+++ b/src/shared/btsnoop.c
@@ -410,6 +410,11 @@ static bool pklg_read_hci(struct btsnoop *btsnoop, struct timeval *tv,
 		tv->tv_usec = ts & 0xffffffff;
 	}
 
+	if (toread > BTSNOOP_MAX_PACKET_SIZE) {
+                btsnoop->aborted = true;
+                return false;
+        }
+
 	switch (pkt.type) {
 	case 0x00:
 		*index = 0x0000;
-- 
2.17.1

