Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E16C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Feb 2022 06:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbiBJGJT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Feb 2022 01:09:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235071AbiBJGJS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Feb 2022 01:09:18 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED961E6
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Feb 2022 22:09:19 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id w20so939377plq.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Feb 2022 22:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5HYK5DYizP6Nv1Iv9FoR5LRDFbWxhVScfHYFFmYT4Ag=;
        b=iFHxnGNdK5X8MW9MGDfGSy+8+TXUxsW2xfGi42fTtWFJ03qMitQ6tvaxsRCWRG4y5u
         7IedgnbEGAqeyaiPGoyC+mx1yn0HgR3sob1aZzrpIoCyc1MAa9K4aS+HLHEw7mFEX9SF
         r4RjMh974A4qvF1/DQB7C/z472pX10zX/2IyX8qrZEFPMc241u9H+fBV7tMSSgxtTwLC
         YX5IzxJj2Y0GcJqRjVWAz7Y9xFOarfFT4lFH1vDO8aaqyReVy98y+vJpTtSpgl3joYKs
         hqFhF7xhN/7aegXuXeXivphIwduZbDrXtXh/FwONVl+/Bq9NjD04R7uLN/H0mLBA/J0V
         zg/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5HYK5DYizP6Nv1Iv9FoR5LRDFbWxhVScfHYFFmYT4Ag=;
        b=ptBXsBbNqmKONmLwqvNjQq44DSLi7n9LnY09niBX5FLqeKPO57O3XOI3NlCfGPL6K6
         5X+7En8bd7OQachIRlPOjVNUBhEbVv/UzF9Wo1kUBWpZH0b4FK2CL9r43NA5MqEuzpph
         Gg7J2jMJjVCdIj3mqhvMZnGGcvTsy4l8zX0MmLLY6GFXuveglR8c7SARdsBO+Vusv/9k
         KMGFCqGQFP4eJHfSMoOfBE5JAR9adSYR6YeDledqB54tUudr7aIFY9YQD/mbIsYy/CJH
         0azSfMtyXDubt6mLKnrFpwowqDNBh8rdBUpUtG8gSZW16t2WFkTq9A0B/BMU6xnLioNZ
         oJQA==
X-Gm-Message-State: AOAM5315LF5e47S8iz1Kto06idzNQXmG78ZUWmxZyc6toJKq7OJeC5Mp
        sGNYI7fcWNa5aJAfoad5XzXmJ/8G6bI=
X-Google-Smtp-Source: ABdhPJykUBRKiHY2voImefLjrt5fpn9Ukqc6tKvNgsHvkR/ttq6z7CAvotZpYBmYCRUIkLkm+TarCg==
X-Received: by 2002:a17:902:b190:: with SMTP id s16mr6005088plr.119.1644473358788;
        Wed, 09 Feb 2022 22:09:18 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830::169b])
        by smtp.gmail.com with ESMTPSA id j185sm20383919pfd.85.2022.02.09.22.09.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 22:09:18 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] monitor/sdp: Fixes out-of-bounds array access
Date:   Wed,  9 Feb 2022 22:09:17 -0800
Message-Id: <20220210060917.50156-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch fixes the out-of-bounds array access caught by the ASAN.

monitor/sdp.c:497:19: runtime error: index 8 out of bounds for type 'cont_data [8]'
=================================================================
==4180==ERROR: AddressSanitizer: global-buffer-overflow on address 0x7fe2d271a542 at pc 0x7fe2d174a57d bp 0x7ffc6dcac1d0 sp 0x7ffc6dcab978
WRITE of size 9 at 0x7fe2d271a542 thread T0
    #0 0x7fe2d174a57c  (/lib/x86_64-linux-gnu/libasan.so.5+0x9b57c)
    #1 0x7fe2d23bae85 in search_attr_rsp monitor/sdp.c:692
    #2 0x7fe2d23be3f1 in sdp_packet monitor/sdp.c:771
    #3 0x7fe2d23b004c in l2cap_frame monitor/l2cap.c:3247
    #4 0x7fe2d23b3d9c in l2cap_packet monitor/l2cap.c:3312
    #5 0x7fe2d237d5c3 in packet_hci_acldata monitor/packet.c:11638
    #6 0x7fe2d2381876 in packet_monitor monitor/packet.c:3967
    #7 0x7fe2d230b285 in data_callback monitor/control.c:973
    #8 0x7fe2d2447029 in mainloop_run src/shared/mainloop.c:106
    #9 0x7fe2d2449306 in mainloop_run_with_signal src/shared/mainloop-notify.c:188
    #10 0x7fe2d230324a in main monitor/main.c:290
    #11 0x7fe2d0b440b2 in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x270b2)
    #12 0x7fe2d2303b7d in _start (/home/han1/work/dev/bluez/monitor/btmon+0x1dbb7d)

0x7fe2d271a542 is located 30 bytes to the left of global variable 'tid_list' defined in 'monitor/sdp.c:43:24' (0x7fe2d271a560) of size 384
0x7fe2d271a542 is located 2 bytes to the right of global variable 'cont_list' defined in 'monitor/sdp.c:424:25' (0x7fe2d271a400) of size 320
SUMMARY: AddressSanitizer: global-buffer-overflow (/lib/x86_64-linux-gnu/libasan.so.5+0x9b57c)
...
==4180==ABORTING
---
 monitor/sdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/sdp.c b/monitor/sdp.c
index 10bc0a121..daf9a9da8 100644
--- a/monitor/sdp.c
+++ b/monitor/sdp.c
@@ -494,7 +494,7 @@ static void handle_continuation(struct tid_data *tid, bool nested,
 		cont_list[n].data = NULL;
 		cont_list[n].size = 0;
 	} else
-		memcpy(cont_list[i].cont, data + bytes, data[bytes] + 1);
+		memcpy(cont_list[n].cont, data + bytes, data[bytes] + 1);
 }
 
 static uint16_t common_rsp(const struct l2cap_frame *frame,
-- 
2.25.1

