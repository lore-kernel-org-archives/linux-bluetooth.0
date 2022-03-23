Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9B2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 22:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345237AbiCWWcm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 18:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345196AbiCWWck (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 18:32:40 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37458F99B
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:31:10 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q5so2942972plg.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Mar 2022 15:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=LAb7qk/awMZFg9RDyU6A4uZdHQmb0R8ih+iZPmdwcnk=;
        b=XHzF9NPynq2efSM8ZB6VAlDdCsQRvnbsTtfnESpUPxpdmYdJxpU5wfwzrAQXXeL/aa
         ME9f09MFaRhnpWYW/LVfLzTRQu7LQm9YcfNaxbNtVeDJqJNKF15CtZj36jSu6fULTShF
         hWR92ctGCdNCr77n6p79XKZTN+ywyt3FFaVd1ok3GAt4FqK62TYSEqU4sz8xO56bnZlS
         qvA9AWd7pVbDMb9zy77eA2E9ne4o7bd2fiPlC/SoUJSmISOEzmq5dKgJ33HzYRsaUbeG
         IzCZ7OgW1k9oTO6XzEP/iyS04glpacVUQeMy59DTWGHOfiTUtoKwe1kn1CeQF505mY1b
         D6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=LAb7qk/awMZFg9RDyU6A4uZdHQmb0R8ih+iZPmdwcnk=;
        b=cZT9TqwBGrMDquegCJNhXULmDjU6rIwVrWckAX7mesohkyCHAnbmgiM9JVbhCOKFTw
         uS3m1/icNHhjDuKfW9Gm3U8dUXmzNIE7+0uwMh3QyATwabLvmKmXEyk1oyiLY17aTMCx
         YHisbCKzMYerUUQb7Kh0CjYfTlTylXm6dHabIF6/4FMJIzezrxCcc6L2fVGDIU5Gg5jY
         FLGf9dk/27q3NvsEQCSy1fEXDo1zH/Uwd2K1ylFz40OHRNTTDzeFjuP0lvib+JoRrqnx
         Rh3x5fBLCJ2nD3V5MYgPUr85dQFAt5NQXQp6mR8S6NQ6HUqdKllb0YYAhaxjCDoH9Z8O
         FcBg==
X-Gm-Message-State: AOAM5313/a8PLnLImE9aLTDiykiJDixQZ+4+/EvSSm8yq5vJ3+rweIMm
        mEFuOI7lIBP9Sz5dTQrYO4G6WTrPxcY=
X-Google-Smtp-Source: ABdhPJw/Yq7R0gNUTce7drB/udq31lNYcpfbKj0W4yk/W1jG3oaMz5CKkxP2Kv6uy3VhX3cyEBn3kg==
X-Received: by 2002:a17:902:b7c1:b0:153:e971:663e with SMTP id v1-20020a170902b7c100b00153e971663emr2446808plz.78.1648074669996;
        Wed, 23 Mar 2022 15:31:09 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.245.66])
        by smtp.gmail.com with ESMTPSA id 21-20020a630115000000b00382a0895661sm694190pgb.11.2022.03.23.15.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 15:31:09 -0700 (PDT)
Message-ID: <623b9fad.1c69fb81.4240f.2b15@mx.google.com>
Date:   Wed, 23 Mar 2022 15:31:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7567596425581082324=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ] adapter: Introduce BTD_ADAPTER_DBG
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220323205227.3605495-1-luiz.dentz@gmail.com>
References: <20220323205227.3605495-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7567596425581082324==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=625859

---Test result---

Test Summary:
CheckPatch                    FAIL      0.69 seconds
GitLint                       PASS      0.46 seconds
Prep - Setup ELL              PASS      49.83 seconds
Build - Prep                  PASS      0.62 seconds
Build - Configure             PASS      9.65 seconds
Build - Make                  PASS      1651.60 seconds
Make Check                    PASS      13.21 seconds
Make Check w/Valgrind         PASS      525.62 seconds
Make Distcheck                PASS      270.47 seconds
Build w/ext ELL - Configure   PASS      9.85 seconds
Build w/ext ELL - Make        PASS      1716.04 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[RFC,BlueZ] adapter: Introduce BTD_ADAPTER_DBG
ERROR:SPACING: space prohibited before that ',' (ctx:WxW)
#99: FILE: src/adapter.h:28:
+							__func__ , ## arg)
 							         ^

ERROR:SPACING: space prohibited before that ',' (ctx:WxW)
#114: FILE: src/device.h:16:
+							__func__ , ## arg)
 							         ^

/github/workspace/src/12790144.patch total: 2 errors, 0 warnings, 20 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12790144.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7567596425581082324==--
