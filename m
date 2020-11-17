Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F39CCC388F9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 00:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41642467D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Nov 2020 00:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pteVn80v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbgKQA54 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Nov 2020 19:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgKQA5x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Nov 2020 19:57:53 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F14CC0613CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 16:57:52 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id d28so18945740qka.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Nov 2020 16:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=abfNUsLj1bbabGiRzJqRs2eiUCdj4gBm+5xh6hqbyDM=;
        b=pteVn80vvFEIZYihV99EOI4fQ2ZA6VMXAuVwE1x11pcOQJN/m/Cmo1nLRnt9rFvKsh
         oF6j2hw+scVNIru7k/9DPkyjiQi8EhBvhi2/GRSXxeU1RHow9mAg+MXptrbDbsDbzhkq
         rsvZrwVR3EszBxh7j0fTFAAuLasapZrgoalowJCm7NDUKgOzV2vbTkFdcwlJB/yAVC31
         f6KfRLQbpOlvnLrzHcAiYZ/JSvCqusE0mihmEdrOhftZe5p5411DZNhhYSk0S4hwHNgA
         zPBRfj8drz212YPSDsuGVmsDAKhFGds4Qo3411PUnLT4Wmvp7SxLw+w1oZdZZ68haSz0
         hGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=abfNUsLj1bbabGiRzJqRs2eiUCdj4gBm+5xh6hqbyDM=;
        b=a8qqlOTAFqD7C9WbmNEEeGxZvPStHEhOeWKERhVJti+VTgI39aFdCZZuuUOYJBuM/R
         dvNoCTRVRwRjF8eh9RGrqDDCy52aoq2xvOaAkClsEk45rgQy+4dwIk5lX6VFugg0nc5T
         K5rHRHO1PzM6J8XJN3qm0kFGwqIyB2kEqX7sYpex50qeSOUvkqvqRwp9u58JfamLfULZ
         GKdpD/KqB+HlBFKWeAMuE9tvCtmH/a76iyXEGkVrnSlXMwKlNnwmhPpJmbXnNPBdJzRi
         h0MoLYR6dBB9iaqq4pfJ7kbUHg3KCoxSijR7WN4Mcdpt0JNcPtWA0YHkQ8eBCrJBeNNU
         43dQ==
X-Gm-Message-State: AOAM532SxkiWPb5mSXv0LcMpVUk37y5WuPAeZI4S+iPaNjm/a0zqfgpS
        agRrpZIxXrU0i7vy7Clqd9cXIYXTZ+RNag==
X-Google-Smtp-Source: ABdhPJxw+6h87Lo7BB16+EZP/9Ks2AkomWX9V/AXbRNFAcumKP3fO/f8/FUJxOqHawUZ+9YRjeV7nQ==
X-Received: by 2002:a37:7fc3:: with SMTP id a186mr17104827qkd.170.1605574671453;
        Mon, 16 Nov 2020 16:57:51 -0800 (PST)
Received: from [172.17.0.2] ([20.36.166.186])
        by smtp.gmail.com with ESMTPSA id e10sm14219617qkn.126.2020.11.16.16.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 16:57:51 -0800 (PST)
Message-ID: <5fb3200f.1c69fb81.6f5b1.36b4@mx.google.com>
Date:   Mon, 16 Nov 2020 16:57:51 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3498311224074853104=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ,1/2] avdtp: Fix connecting using streaming mode with signalling channel
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201116233910.4128702-1-luiz.dentz@gmail.com>
References: <20201116233910.4128702-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3498311224074853104==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=385541

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
main.conf: Add option to configure AVDP session/stream channel modes
WARNING:TYPO_SPELLING: 'prefered' may be misspelled - perhaps 'preferred'?
#7: 
This adds a new group AVDTP where platform can confure the prefered

WARNING:STATIC_CONST_CHAR_ARRAY: static const char * array should probably be static const char * const
#101: FILE: src/main.c:141:
+static const char *avdtp_options[] = {

- total: 0 errors, 2 warnings, 150 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] main.conf: Add option to configure AVDP session/stream" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============3498311224074853104==--
