Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B39BC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Feb 2023 07:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjBFHiX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Feb 2023 02:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBFHiW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Feb 2023 02:38:22 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720ED15557
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Feb 2023 23:38:20 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h24so11856458qta.12
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Feb 2023 23:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jaiCCjvV9wYt9wQ41eJfJlf9PbNPSIN5HEX6YzFmF5Y=;
        b=oM/E9309L65pTUqOoCGb39OlPT93B5/Jh3cIn8ckyZcGUo21RT2JVjMtuXZypfrWEe
         4qqvfUeDlxWtM40mORY30WRTNYRym0+tGbqc3vZJwwr3Aa3Cn2uf/dmceaue/HVHe2+7
         Tj0bLy53xaC50c7Cofph7TR0iOZDHmnSI1796L16QWw/VEzThD2FH6+jD+/Te+XWBZAz
         GGILyf5gwnuu0QUsCLqE+1fCvAkBpWBH5383EqlRF/WcgdRhybc+UJL4lHgs1qMVlDF2
         MJw6bUFaeh9+nmpKCaPZcotmSie1v8zzPDT6ZCpFDk+2Yge2M4z2lVtFqggYq8IlXDyH
         DhLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jaiCCjvV9wYt9wQ41eJfJlf9PbNPSIN5HEX6YzFmF5Y=;
        b=4n8p8bfRdeZ81IORnDjfThrqRJ881rUR5fg+aXwK81adzMfC87J0olL0HBnlqDK07p
         UxHbw0YJCQ+RkJkzTxmzuhY1OYbl5XI64ZB0wA0fbC7rdItrQanEMYwu8J+uCHyG5xmG
         y+aAjKFO1NjIwF9MGzeG7NKGAngu8r1s2Pinzv/Ihjk9san6SBbXerkTfaiiVOilV9b1
         XQEpcQpNzltBdS6CUlEr9pRwEs7br9jkZn7fTv8OzIV4BmgtAKwZH0WPB6CjnhR3z6Vy
         KEjGFlZOwhzM4M1QvVo73M36hdWdAdX9GfB2JHVwlKmoX+IJW+N49PevBR795+fDyImf
         nlfw==
X-Gm-Message-State: AO0yUKUiWNShI7rgTlBJsDvrXl6G4OcD09r/KMRc3WqIHnPsilOf3NKl
        QrDjT9v2tSbJLCQj1/lBpCjI6FxGrwY=
X-Google-Smtp-Source: AK7set/c0gzK89U9YyKWH3BY/nYt4zvNXVpf2NVslBYxoHU2zksmdzvCJ7r2Mw2rcbhm+p54UFs/sw==
X-Received: by 2002:ac8:5fd1:0:b0:3ba:101e:88c6 with SMTP id k17-20020ac85fd1000000b003ba101e88c6mr17516904qta.48.1675669099262;
        Sun, 05 Feb 2023 23:38:19 -0800 (PST)
Received: from [172.17.0.2] ([52.226.113.33])
        by smtp.gmail.com with ESMTPSA id d23-20020ac800d7000000b003b8238114d9sm6761136qtg.12.2023.02.05.23.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 23:38:19 -0800 (PST)
Message-ID: <63e0ae6b.c80a0220.afda6.19a4@mx.google.com>
Date:   Sun, 05 Feb 2023 23:38:19 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8344322175759297470=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] monitor/intel: Add decoding of PPAG command
In-Reply-To: <20230206063705.19909-1-kiran.k@intel.com>
References: <20230206063705.19909-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8344322175759297470==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=719007

---Test result---

Test Summary:
CheckPatch                    FAIL      1.00 seconds
GitLint                       PASS      0.37 seconds
BuildEll                      PASS      27.78 seconds
BluezMake                     PASS      846.14 seconds
MakeCheck                     PASS      11.32 seconds
MakeDistcheck                 PASS      148.07 seconds
CheckValgrind                 PASS      244.34 seconds
CheckSmatch                   PASS      324.17 seconds
bluezmakeextell               PASS      96.87 seconds
IncrementalBuild              PASS      690.35 seconds
ScanBuild                     PASS      997.41 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v1] monitor/intel: Add decoding of PPAG command
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#69: 
< HCI Command: Intel Configure Per Platform Antenna Gain (0x3f|0x0219) plen 12

/github/workspace/src/src/13129347.patch total: 0 errors, 1 warnings, 43 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13129347.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============8344322175759297470==--
