Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2DFC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jan 2022 23:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245483AbiAEXqM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jan 2022 18:46:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234791AbiAEXqI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jan 2022 18:46:08 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1291CC061245
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jan 2022 15:46:08 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id c15so276189qtc.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Jan 2022 15:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/oVyTR6WMPUo9z9DId9TIP6J2I08aKYcssSpMIkdaVg=;
        b=TJ2pjwjU4jxg0whohfiZyhxAlatqp9NyBGdi/ZmBosLXfUTRKnTnLMyvPUe8yUGkBP
         zD2g1zh8201e21MsC0ohaL0LtEtE74ZD/WO5DQVgfaVvV8OxZsK6M9d5e9zriIQCq8J6
         CAJpt8rI3axEbHo7mRS49XLrIZ/ffQPa+oWZI9BlFCQfISyODXao6sg9S/ZwAx16fUHI
         yc7K2QtOEld5nrgZzxacm00w9BHyDFQ+d2dYFyfub8xOF+v2SVizEJmcKDhcjtV9SUdM
         uoRW8LjmPMyiK49h/PnYAakDQCVo8s9Pfik8U48ts9i2j7/n/wYxJjJ2MD1nE07P8I//
         hHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/oVyTR6WMPUo9z9DId9TIP6J2I08aKYcssSpMIkdaVg=;
        b=1CesLCkvo8JDFboIoPBeelXYdMOqesjgHNN3IklJkB8UU9YhiJ1tmX1UhoGWhEqBQe
         XPNIHnVZZn9/UpCQl98qkt6pyr0Ap6C96mJ1DdTOYsptG1WPj/823FpqRaUL7j9erC+w
         MdoRG/C8X3LPeLBcnALmW3wYbaRFnigK3HrEfFNYbwKXMnoX5HNmQkdnOUk4sd44txPv
         exQ7rQ7JwFxBZsHzWE5u1uHf9lg+XvJTnGjUEyOoXu6z3E8iRQ/9Ps34pyBFkGxnUXnT
         hgHHd2Qr6Zw5sV2CqVxmVc3L4gHJlp35E3IXrkhSVRNexHD+sgPZsAbiD83ABwMeVvAg
         92Lw==
X-Gm-Message-State: AOAM531lQZRdQduCrao0SWRY1YsIHWtv4R/Bfvig8qX0wzfXtIKD2S7w
        7JDwkurGVq8ULqKnRnA9HkNr1biW6GVReg==
X-Google-Smtp-Source: ABdhPJw5D71scsIeTgrKklWWhoy1bM1JiAja+UxW4ZVr1P9JOHs8TyeCjZR4t2oSkZ3Zr+7X0Cvipw==
X-Received: by 2002:ac8:58ca:: with SMTP id u10mr50519740qta.44.1641426367077;
        Wed, 05 Jan 2022 15:46:07 -0800 (PST)
Received: from [172.17.0.2] ([20.110.122.68])
        by smtp.gmail.com with ESMTPSA id u188sm217693qkh.30.2022.01.05.15.46.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 15:46:06 -0800 (PST)
Message-ID: <61d62dbe.1c69fb81.2987e.0ebf@mx.google.com>
Date:   Wed, 05 Jan 2022 15:46:06 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3766730166490254362=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] configure: Fix use of obsolete macros
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220105222946.3235852-1-luiz.dentz@gmail.com>
References: <20220105222946.3235852-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3766730166490254362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=603033

---Test result---

Test Summary:
CheckPatch                    FAIL      1.58 seconds
GitLint                       FAIL      1.11 seconds
Prep - Setup ELL              PASS      43.34 seconds
Build - Prep                  PASS      0.68 seconds
Build - Configure             PASS      8.63 seconds
Build - Make                  PASS      1436.54 seconds
Make Check                    PASS      11.94 seconds
Make Check w/Valgrind         PASS      451.87 seconds
Make Distcheck                PASS      237.29 seconds
Build w/ext ELL - Configure   PASS      8.83 seconds
Build w/ext ELL - Make        PASS      1406.07 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] configure: Fix use of obsolete macros
WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#86: 
https://www.gnu.org/software/autoconf/manual/autoconf-2.70/html_node/Obsolete-Macros.html

/github/workspace/src/12704810.patch total: 0 errors, 1 warnings, 330 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12704810.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint with rule in .gitlint
Output:
[BlueZ] configure: Fix use of obsolete macros
13: B1 Line exceeds max length (89>80): "https://www.gnu.org/software/autoconf/manual/autoconf-2.70/html_node/Obsolete-Macros.html"




---
Regards,
Linux Bluetooth


--===============3766730166490254362==--
