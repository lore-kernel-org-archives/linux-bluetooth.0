Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4313C46CA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Sep 2023 21:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbjIRVW3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Sep 2023 17:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjIRVW2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Sep 2023 17:22:28 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4CF8E
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Sep 2023 14:22:22 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68fb79ef55eso4535534b3a.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Sep 2023 14:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695072142; x=1695676942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=im+os3Mo6S4wfMCi1pNrwf/gRient0FWc/dzcrjnrhg=;
        b=KNTovDSlugQ3sGcg5GdHH33WfdiIRnZN/PvFwCXImfNU2YeAftGOCoKw2232wuUhNQ
         E7mWs+iR+eDaF8hPW+gzXwbUOdIkHNj8BAvHWHLDv87Iw938egGt22dRZh/ZpedMimv6
         nyLz3yfCi6rrYjPOYQqDj/BOVwW8Ih8O4pWnnnwSQAe22BrOMArAun4UXB/q4b7Ahvbf
         1AuLpvuSX8paimskvPScVWF4yvSy8tQPMiqtpKvaJd4GTAKHlMq/ADuNlJSdzzqnUoP4
         M/X+mdDTXB9N/FYiaMqh1EIPms6EWqAOSJVQGYDLojV0KiXZ9l5kAEoDFpaJeUl50x3k
         gXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695072142; x=1695676942;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=im+os3Mo6S4wfMCi1pNrwf/gRient0FWc/dzcrjnrhg=;
        b=KC5LRKXjjKCTOB2AJGhoWJfo6OCa0HN4qao0eAoo/16bCuNPe4bMIo/efoHQLd5aQe
         +ffe0pccGq83pcK9v9JxDpI2JxOg0mlmS9/AlQCJQi4DDRdzIGB0Bxc6xnREo4q+sB5p
         31pDcAlFTLNuIaPwg9wGD9azyftXj+TgYki0VbvL6Glvf8TCua4OG94PK3P77VwsJfGk
         DeqAE6cMIH18EHbuk9CKgDZkJY1IVDTjyW8uG4u/BVQX4h6mNTlJhMNRhblCRjQwvn+2
         20tFLpd1nNHdz+OhfTldPKu5pMvT5h6cRRB3YQxPp+5LJMrRsxE8C2WRURfCX3Rk0OJW
         KCiQ==
X-Gm-Message-State: AOJu0YxBo1Q6WzHH88OEiWLZ7PhbXGLMkIRNGNhkyDocfVyDOCERwI+C
        aU6HZinob8a9anxO9r2GA5ODmI217GM=
X-Google-Smtp-Source: AGHT+IGFbe49E43Brhv3IdO5AlRzvQkv+vmXf3aTDbqgPoNGkZQF5vx9fbgoNBw5i2Y6+TFRgkLr8A==
X-Received: by 2002:a05:6a20:8420:b0:132:2f7d:29ca with SMTP id c32-20020a056a20842000b001322f7d29camr13168451pzd.24.1695072141615;
        Mon, 18 Sep 2023 14:22:21 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b0068be348e35fsm7533502pfm.166.2023.09.18.14.22.20
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 14:22:20 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/log: Fix not checking vasprintf return
Date:   Mon, 18 Sep 2023 14:22:19 -0700
Message-ID: <20230918212219.190667-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

It seems like some implementation of vasprintf set the content of the
str to NULL rather then returning -1 causing the following errors:

=================================================================
==216204==ERROR: AddressSanitizer: attempting free on address which
was not malloc()-ed: 0x55e787722cf0 in thread T0
      #0 0x55e784f75872 in __interceptor_free.part.0 asan_malloc_linux.cpp.o
      #1 0x55e7850e55f9 in bt_log_vprintf
/usr/src/debug/bluez-git/bluez-git/src/shared/log.c:154:2
      #2 0x55e78502db18 in monitor_log
/usr/src/debug/bluez-git/bluez-git/src/log.c:40:2
      #3 0x55e78502dab4 in info
/usr/src/debug/bluez-git/bluez-git/src/log.c:52:2
      #4 0x55e78502e314 in __btd_log_init
/usr/src/debug/bluez-git/bluez-git/src/log.c:179:2
      #5 0x55e78502aa63 in main
/usr/src/debug/bluez-git/bluez-git/src/main.c:1388:2
      #6 0x7f1d5fe27ccf  (/usr/lib/libc.so.6+0x27ccf) (BuildId:
316d0d3666387f0e8fb98773f51aa1801027c5ab)
      #7 0x7f1d5fe27d89 in __libc_start_main
(/usr/lib/libc.so.6+0x27d89) (BuildId:
316d0d3666387f0e8fb98773f51aa1801027c5ab)
      #8 0x55e784e88084 in _start
(/usr/lib/bluetooth/bluetoothd+0x36084) (BuildId:
19348ea642303b701c033d773055becb623fe79a)
  Address 0x55e787722cf0 is a wild pointer inside of access range of
size 0x000000000001.
  SUMMARY: AddressSanitizer: bad-free asan_malloc_linux.cpp.o in
__interceptor_free.part.0
  ==216204==ABORTING
сен 18 13:10:02 archlinux systemd[1]: bluetooth.service: Main process
exited, code=exited, status=1/FAILURE
---
 src/shared/log.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/log.c b/src/shared/log.c
index 3f18e803d8e9..22b9850f6f11 100644
--- a/src/shared/log.c
+++ b/src/shared/log.c
@@ -135,7 +135,7 @@ int bt_log_vprintf(uint16_t index, const char *label, int level,
 	int len;
 
 	len = vasprintf(&str, format, ap);
-	if (len < 0)
+	if (len < 0 || !str)
 		return errno;
 
 	len = strlen(str);
-- 
2.41.0

