Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28669C2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 21:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D933B2240A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Nov 2020 21:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqe4Aqh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbgKTV0x (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 16:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbgKTV0x (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 16:26:53 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F6CC0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 13:26:51 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id a15so5386159qvk.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 13:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=bf74ole4nP4ijqL8JHLyityAaebgZdOSfUKFZeAUqaU=;
        b=iqe4Aqh1u2XQ/+1EbR8Lc/aWTGqTHzrUAi5KkeNfMQkr2Rr7jGYEJvp4ZCthgr/4Bn
         t236wT2q/w3h1LKQ75ANFoqNpodYU7NgYwr8+U4VVaonHqRxBHv97Powhjv2LGT7o87D
         FWzwWNaVYhNAlobuIIfVyRhOFt5isz4v1+e5Oa7UqOAO2934eUkm+6eE8qU5YY5BZIkQ
         ZMwrpLcN5Fdl8HWRi6D0pCOWs4emIrUdb8as1/HZsvdUPATW45IyGROrL93OhdnYTHxj
         QVHdFecoWermYJiZw1/ovH8sKjx0BSZoOBkGzsL6FaqZxo7NQ38fBkcg2zB6EAUYioeW
         rR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=bf74ole4nP4ijqL8JHLyityAaebgZdOSfUKFZeAUqaU=;
        b=N2dq9J6SXLA/GHWMYoWiiQUHDdb5RHGoX0SGodu/LYOOmJMXt6SMiWcoZEmB6P7V1w
         BoNmxRBZ5okW8iKp0kEVGE9fZYPis1ldWMRpJ31Fp+i27zsCJCGp9+/35QoCDZd4rY4S
         xnn5zqtwvjF16ML4GEHzFRF845kxX0haQeGIv014KVqAcdnSPIV310E8fCog6ckUrtsb
         2LL67Gr7rbCPThx7T6XZJjyEesG07P3doFdC52gtEw0CzrNybR/wzeq5PGPRu5C7qPSf
         m/sK+3M7Id/memk//rENnWz3nelPMo0FZzMtlbwHqKfHypYR7k0ttLmFWVUx4NF1Wamp
         jOvw==
X-Gm-Message-State: AOAM5337OY0N1Im5jJBwVbDYxQdt5JhciVtpSQB/spXRTSQuCzCyhiG4
        F8aXitprVwB3c7ac+xs7/OPahwnGlRM8OQ==
X-Google-Smtp-Source: ABdhPJy+qG+8izM/SQK76lD46g5ReEQyBXCD1ZcvdxrkS+EE7gULdUA2tYTzHfokTeoTZ4A7j6aVgA==
X-Received: by 2002:a0c:eb91:: with SMTP id x17mr18886532qvo.36.1605907610357;
        Fri, 20 Nov 2020 13:26:50 -0800 (PST)
Received: from [172.17.0.2] ([40.70.11.158])
        by smtp.gmail.com with ESMTPSA id g18sm2718693qtv.79.2020.11.20.13.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 13:26:49 -0800 (PST)
Message-ID: <5fb83499.1c69fb81.6e77f.22e1@mx.google.com>
Date:   Fri, 20 Nov 2020 13:26:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3693229940282547716=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ,v3,1/7] battery: Add the internal Battery API
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201120205728.339325-1-sonnysasaka@chromium.org>
References: <20201120205728.339325-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3693229940282547716==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=388695

---Test result---

##############################
Test: CheckPatch - FAIL
Output:
battery: Add the internal Battery API
ERROR:INITIALISED_STATIC: do not initialise statics to NULL
#71: FILE: src/battery.c:38:
+static struct queue *batteries = NULL;

- total: 1 errors, 0 warnings, 215 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] battery: Add the internal Battery API" has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

test: Add test app for Battery Provider API
ERROR:EXECUTE_PERMISSIONS: do not set execute permissions for source files
#12: FILE: test/example-battery-provider

- total: 1 errors, 0 warnings, 230 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

"[PATCH] test: Add test app for Battery Provider API" has style problems, please review.

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


--===============3693229940282547716==--
