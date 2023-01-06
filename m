Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACFEC4708E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Jan 2023 02:06:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjAFCGF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Jan 2023 21:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjAFCGC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Jan 2023 21:06:02 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F79B7D2
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jan 2023 18:06:01 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id v14so1086594qtq.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jan 2023 18:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=07P3xVxDXSfrA5Nn5cM4sfzldPSmJJiDYOepp1SZC6E=;
        b=A+sCWAgUmO2kfQ4HnyJFRPCf/RlD5e/KvcaUOfiaQDEqz+pGF6mlNdRBAOKJPYkM78
         xXXJC6xUMocYwwJlI8beButZkTbk7mXhHGEqK45eMP/eK8fLU/3UF5vGb28vrtQVv9bV
         a+DzeB480exVms+s8e+xiv4g0qM4A+DC0Ak9BfdtXleKQIKir5GbvEJVAs59oWXgGXZV
         /ntHllY2PnXixBhkEfSwJJYhxpo4ItJ0rgih0b7H/tXwXzZ5kgsBgeezT89wEVJ605K9
         A26iMmyYYVDIUYAMs3qpjIghaWjLcTsd9BZ6+OnpWUNXkXNo68/mGE21ZZhpCIdflnst
         YnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=07P3xVxDXSfrA5Nn5cM4sfzldPSmJJiDYOepp1SZC6E=;
        b=8JambWyEBvOVIprRnKxc3pyQ02XdEaUAkNcHP6kpJFcrJsQ7OadVDq2ic3eMA/jiSn
         MC+B+gNuw54sbO6ihzNw5flYVtm/szlPvHBe2i0w9cUfM7C7H57u4bcxoDIM7skhHhDF
         MVVOgJ8r1+2ABX2gLlgSbTrpRzXBwut8wZa7VCaPG5fR9BSxuHX6GSvMiFoIdTHM3ubP
         iRZDTWeT2MnqH8M5DLAqUiY+DsHZREfthgpCzQBxW+CzgJE5gNy30y8tGHUksO5AAUAj
         ktcwqGQoH1AkqOT94i5/G6JycK3hGIeprX3mG4xre3YrhflrDSY0m5DYpCo3a95a1Lmp
         GLRQ==
X-Gm-Message-State: AFqh2krMQM7JGS4wbPt3eZkiWRSbPCLIOOaGWK6FuozuCHF0fLKGCuCk
        0zZ3A+SmAoKKKY6WeeNu2+Z64wiNPVB7yw==
X-Google-Smtp-Source: AMrXdXuGHjvw2tjSMoSGk+CXXIvUpEZCn95/7cE0ov6AwdUMwWg2Z3hq7jIfoOtpuuLEnEAwVX0g0A==
X-Received: by 2002:a05:622a:4d0f:b0:3a8:661:251 with SMTP id fd15-20020a05622a4d0f00b003a806610251mr80841416qtb.64.1672970760950;
        Thu, 05 Jan 2023 18:06:00 -0800 (PST)
Received: from [172.17.0.2] ([104.45.200.34])
        by smtp.gmail.com with ESMTPSA id d18-20020ac847d2000000b0039cc82a319asm22185975qtr.76.2023.01.05.18.06.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 18:06:00 -0800 (PST)
Message-ID: <63b78208.c80a0220.db170.fb63@mx.google.com>
Date:   Thu, 05 Jan 2023 18:06:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2800935796902112951=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/gatt-client: Fix smatch warnings
In-Reply-To: <20230106003729.2526075-1-luiz.dentz@gmail.com>
References: <20230106003729.2526075-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2800935796902112951==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=709359

---Test result---

Test Summary:
CheckPatch                    FAIL      0.77 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      27.44 seconds
BluezMake                     PASS      875.24 seconds
MakeCheck                     PASS      11.99 seconds
MakeDistcheck                 PASS      148.79 seconds
CheckValgrind                 PASS      241.83 seconds
CheckSmatch                   PASS      322.74 seconds
bluezmakeextell               PASS      96.36 seconds
IncrementalBuild              PASS      708.63 seconds
ScanBuild                     PASS      980.23 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] shared/gatt-client: Fix smatch warnings
WARNING:EMAIL_SUBJECT: A patch subject line should describe the change not the tool that found it
#69: 
Subject: [PATCH BlueZ] shared/gatt-client: Fix smatch warnings

/github/workspace/src/src/13090718.patch total: 0 errors, 1 warnings, 64 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13090718.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2800935796902112951==--
