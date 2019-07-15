Return-Path: <SRS0=pDNe=VM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EB7C7618F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 08:52:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B3E214DA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jul 2019 08:52:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hX52xV7D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbfGOIwi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jul 2019 04:52:38 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:42568 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729289AbfGOIwi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jul 2019 04:52:38 -0400
Received: by mail-io1-f67.google.com with SMTP id e20so2509856iob.9
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jul 2019 01:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=qwXt3i6bEf4W6a7/+EiN/zhZ+gnDAxQDoWvT+s7bWEU=;
        b=hX52xV7DEyPACVr1QfWy7RGMlyVrgG60OznnnpVJ7pQkLQr5R/9iTMJdpdePwzymtq
         /OKUbAwNHDPiBW/5U68TtGJHs9DyJx7nSHfhfVkQo9eM/KVeijIxvIaTRp5THkNiXV/E
         WMCdL/wdypJa/NXKnCpMabsdwdKzpprG1WAqqpL+4LMQbfFUagX1wt9atoIM2Q6OLvj3
         SB/cu8dis7WYSFR8BkZX86KqdzSHwMRJ+jtlASm06c1wi3vwKEoYpBTn+jHBZBaUDRDl
         EgjFl62o8+3/D7YuI5Riq5X/8miJ6uhpSkMLcgviTsP5PzXj0qxT+TM043ka3DSUZ9DC
         aHIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=qwXt3i6bEf4W6a7/+EiN/zhZ+gnDAxQDoWvT+s7bWEU=;
        b=JX2qOdt7IPnKLOWbZCNWycXXDYCaXBIP2mBMZjzaPRB2H7HjMS8ylBl+CXJaCtvC1r
         spsfMYrcjIJkAc5cwQmbbQtv5qhNajQApKa6S023OMd0Y+DcIcCDNVir5qzVm206r/cj
         Hmm1CJhtJ6RHmrG4/m2DtnV+SB8DGOiszelbu1VzWYpgdtHyomQiRyM9TQph14m1FjLR
         /I7YPz7aMjTAVWj0yKJdcsVUZkUHKJArnX0SuxMAuNTIaYy4458EFTU2ETmAz+UzGR5k
         qIe9LTDMJRWC3jmczvSSpAExqBVb9ucmNPuOqa1NLVE3Ka1g17s34KopZmauV01bE+WN
         r3eA==
X-Gm-Message-State: APjAAAWAH4c+4u0S6AMwMX5yoyfn8hIFrXgg8DlQDg9nvMoR5mVHPMcl
        o/SE2W/zh4Mzb+d9hGrMdnF8CqmO5ozFH0cR960eAFHK
X-Google-Smtp-Source: APXvYqwPhLvBQL4Mb2Ubo2czrsKUY56DmsidqkyUk44KuFzgUesv9Qg+H91F6i8vDrm4DY+xdoOZOwpE5fl+6AeYwyA=
X-Received: by 2002:a6b:c90c:: with SMTP id z12mr22471528iof.11.1563180757335;
 Mon, 15 Jul 2019 01:52:37 -0700 (PDT)
MIME-Version: 1.0
From:   =?UTF-8?B?6auY5qmL5rW3?= <www.carrotsoft@gmail.com>
Date:   Mon, 15 Jul 2019 17:52:25 +0900
Message-ID: <CAJpXGC2ZGK2--tEZkqAAvh-Ef-MLSn+AWK=S9Uni_F06tXLSKQ@mail.gmail.com>
Subject: [PATCH BlueZ 1/1] tools/hciconfig: Check device name (hci0 etc.)
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Check device name length given to argv.
If the length of device name is shorter than 4,
that's an error.
---
 tools/hciconfig.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/hciconfig.c b/tools/hciconfig.c
index ddc17c4b5..aad37dd56 100644
--- a/tools/hciconfig.c
+++ b/tools/hciconfig.c
@@ -2027,7 +2027,13 @@ int main(int argc, char *argv[])
         exit(0);
     }

-    di.dev_id = atoi(argv[0] + 3);
+    if (strlen(argv[0]) > 3) {
+        di.dev_id = atoi(argv[0] + 3);
+    } else {
+        fprintf(stderr, "Invalid device name: %s\n", argv[0]);
+        exit(1);
+    }
+
     argc--; argv++;

     if (ioctl(ctl, HCIGETDEVINFO, (void *) &di)) {
-- 
2.17.1
