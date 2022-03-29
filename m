Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B6BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 04:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiC2EZ0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 00:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiC2EZY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 00:25:24 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3617823D478
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 21:23:41 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id i4so14301820qti.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 28 Mar 2022 21:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=RhfFLhJ1ZwBPvrmmTIM/j5wMJelPBmzc9T5074I+aOw=;
        b=hI/VO5ms6XF+zCw9Bsv7RvraVzDvOHqQDEOj6cIc4p+fCfYyJfoDaGnO9kiww6LoLi
         m+FH/InVruioNGnrAiNorXL/epNH4zDBryyfYgroej6NTDaf1wZQsmUxH8oo7Sm+svtV
         WG4vnpudp0Dl9A9IIH94ZmOcVqHn/2zRIhzoNjs0S1pSqDCOfJrHqW8j7XTeDJXSKbKF
         Awmsy0jPX9M8WYBvVGaMUHhwwhhhdoFXOMdnS3NSN4EylGMd4i3Sr48YgFiNhBp0bCoI
         c61Zm5s8l5/f5vEUm61cjaAUJhd3vFB++c0IKkn7bCU3q9Cid4RcD/Bk7G7AXziSOwPV
         jD1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=RhfFLhJ1ZwBPvrmmTIM/j5wMJelPBmzc9T5074I+aOw=;
        b=tJaJUxM6XxW8KBcyTbcan+4j3BroaMKBqJtjCT/2oSw4wlIzvtssqg2jw8dfWfzce6
         STobmBuccWzfz56AVhwXKSNn5mRL6c1cVFI2lG+CweNX4WN36MiXifrNaTjkGY8KTyGD
         uXO1Lbuw7y/v8Ecmq2SBWp4v785GFIwtklOQAudsnAnx4aUau5tFQ/mMOEbBTBQ+OlLD
         7UxpTcb7/HfQqr1nxveB/qdz7y5kRVyh+ZEyjf716svQZ25iHHbG1R94uCvcmJPum6NC
         TjMZtalWsB7ge1V6Inh92Vh0QHIe+4XfURCMmQq5HipUGqcnlwBkhftS8pzvJJVQRAOm
         3j/g==
X-Gm-Message-State: AOAM531fFPwRubCscrtVz+XF6m84UN//1ciRPiHnPRHUCbDK/xNpGMSB
        z046zTmKDe8n35jAjo+Aa+Aqr17mxoQ3KA==
X-Google-Smtp-Source: ABdhPJynBnbsLpmxWffDcEN4xIWdX9TbX5OB7ppAM9y2GAPS6NtAvw3wTXlPoevWsVVEypukNHd3lA==
X-Received: by 2002:a05:622a:28b:b0:2e1:d5f3:1ebb with SMTP id z11-20020a05622a028b00b002e1d5f31ebbmr26020906qtw.106.1648527820001;
        Mon, 28 Mar 2022 21:23:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.228.147.154])
        by smtp.gmail.com with ESMTPSA id p6-20020a05622a00c600b002e1cb5b9b82sm14801073qtw.43.2022.03.28.21.23.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 21:23:39 -0700 (PDT)
Message-ID: <624289cb.1c69fb81.cdf48.b1ae@mx.google.com>
Date:   Mon, 28 Mar 2022 21:23:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0587429609272330395=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangxinpeng@uniontech.com
Subject: RE: [v3] obexd: Fix can't receive small files sent by windows
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220329020247.28885-1-wangxinpeng@uniontech.com>
References: <20220329020247.28885-1-wangxinpeng@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0587429609272330395==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=627050

---Test result---

Test Summary:
CheckPatch                    FAIL      1.48 seconds
GitLint                       PASS      1.07 seconds
Prep - Setup ELL              PASS      55.34 seconds
Build - Prep                  PASS      0.92 seconds
Build - Configure             PASS      10.68 seconds
Build - Make                  PASS      1903.01 seconds
Make Check                    PASS      13.46 seconds
Make Check w/Valgrind         PASS      553.87 seconds
Make Distcheck                PASS      292.66 seconds
Build w/ext ELL - Configure   PASS      10.68 seconds
Build w/ext ELL - Make        PASS      1867.38 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[v3] obexd: Fix can't receive small files sent by windows
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#65: 
that requests the file path has not been processed. This will cause the upper

/github/workspace/src/12794376.patch total: 0 errors, 1 warnings, 20 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12794376.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0587429609272330395==--
