Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416ABC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 May 2022 20:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446943AbiEGUET (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 May 2022 16:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1447012AbiEGUED (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 May 2022 16:04:03 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E90205EA
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 May 2022 13:00:15 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id t16so8381928qtr.9
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 May 2022 13:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=OXTl7MzrbXGl0DeUdXqG4fZD5OI4oQyNeb28K9vRmv8=;
        b=lhjueL0O73BTzgUfGc348SGRKT1MU2vXaXYbg2vIAHVRvn5RG4+FF7zF8yZEocvYu9
         0PhF38J3WtJCsa7Dfgk2ELQ+echzDpErAm+UkrgbYqsTCSu5LAGWYubf1NcmTZRBp7Y6
         QlbdJEg2nRG5w5DfTXLyQsSg99PxJLma4qC2+eaEht053svoeI8oCk3q2TCsLD6UTbSs
         jy2B9MYpYXo0vddigiNPnWqrFKdmaVIsoN0WtcYSQ9OBgUSqyMGpmZUP+5lYPdnzJTM5
         TFJa8erUj7uLXtns+M2c9W6kMMRpIGvgBrtfPvUpbwFdpvm6NIc2jBGjDAIRrQqBbvOR
         1GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=OXTl7MzrbXGl0DeUdXqG4fZD5OI4oQyNeb28K9vRmv8=;
        b=2W1Kw2kNaY7F1VZZkCR7IyibJWsx2SZ2aXU5oj4a7M5JjifEsS1lTrDJm9vMQK/ZER
         pS6HpS8ZKS0dzwO3lVZPNzFAO98ft+Sft/tXAWBd6/mS23dq9GP0IG3RAjGMd0fppnfo
         qIKooyrnz38KBVPwx3GrCe4Yx6njCoS8y6oShEbCiTqQofb8M809p4YiHw4gUCCDibnT
         753v1tGQtdrlyRN1oHdoZY98X96xIOsK/GxlWF6713hJ/knbdxrLemsOjx4i+ORKyi4h
         jQcmXQ8vPDfSOBpI4RkYCXSfxDaCkev9BBAHQR+uWk/LjuNfsXBerhmdF8+kxhGiyTFs
         qBkw==
X-Gm-Message-State: AOAM532AnfZOKXfiD3bWIzRV+3B3IFuwVf8HJnGoBDSBHE+uBl5QqYJI
        m1ajwfEK1HMSVPYdd+V5gbDavw6PCx6CpA==
X-Google-Smtp-Source: ABdhPJwV4st3NZBqZ/FyboHee/JupWi9ot1sghV5pwe9ketAlcE5AfT1uAikPizgBtioC6uNRRwd9w==
X-Received: by 2002:a05:622a:1208:b0:2f3:99a0:70ef with SMTP id y8-20020a05622a120800b002f399a070efmr8516884qtx.443.1651953614455;
        Sat, 07 May 2022 13:00:14 -0700 (PDT)
Received: from [172.17.0.2] ([20.22.198.238])
        by smtp.gmail.com with ESMTPSA id x74-20020a37634d000000b0069ff51425a2sm4414119qkb.120.2022.05.07.13.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:00:14 -0700 (PDT)
Message-ID: <6276cfce.1c69fb81.36b6e.704d@mx.google.com>
Date:   Sat, 07 May 2022 13:00:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1315138386449286679=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, i.kamaletdinov@omp.ru
Subject: RE: Fix few more bugs found by SVACE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220507170703.29902-2-i.kamaletdinov@omp.ru>
References: <20220507170703.29902-2-i.kamaletdinov@omp.ru>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1315138386449286679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=639427

---Test result---

Test Summary:
CheckPatch                    FAIL      5.66 seconds
GitLint                       PASS      3.95 seconds
Prep - Setup ELL              PASS      42.99 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.64 seconds
Build - Make                  PASS      1360.55 seconds
Make Check                    PASS      11.83 seconds
Make Check w/Valgrind         PASS      444.92 seconds
Make Distcheck                PASS      230.71 seconds
Build w/ext ELL - Configure   PASS      8.64 seconds
Build w/ext ELL - Make        PASS      1380.96 seconds
Incremental Build with patchesPASS      5642.52 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ,1/4] tools: Fix memory leak in hciconfig
ERROR:TRAILING_WHITESPACE: trailing whitespace
#68: FILE: tools/hciconfig.c:84:
+^I$

/github/workspace/src/12842099.patch total: 1 errors, 0 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

/github/workspace/src/12842099.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1315138386449286679==--
