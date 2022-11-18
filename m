Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323AEC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbiKRFIg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234918AbiKRFId (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:08:33 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123A314019
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:08:32 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id n18so2673385qvt.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nFktZ2FniHjvteAkJB+KW03/kA8/uIWO/xPRYJz13ng=;
        b=hhwoFRJ0q9fwjCngQq7nhWcLGMcZaMp4zAeuaoojCVTgu3Lxl6FrOnxe8tnMGw3EHq
         lopqZxFvov5XP5SPGNdGTeMUoYI68VxfOxu9M5H+G9zBWFdbPTu8Z8lLMJDTON7HZkgJ
         kth4klnfD+McPiet1xzwu0wUDp9LJH8X/4vRwzp2VW+pvlt7Mw7QWmKS9nQ8rz3wq0Vp
         qCI6u1v+Es99t/yg8JZE1HYYjbRbZr66/zPqmdm1oFm06DaWJw7sFEbwDyzGFee4hFOz
         zmbGATfpXdNYemBrLR06uGSZtguDHr1VIhlhzBKQMmjRi8sxfr4I4iopmw5OC/00Hlnw
         F3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFktZ2FniHjvteAkJB+KW03/kA8/uIWO/xPRYJz13ng=;
        b=bppYc7HXI9wWJuP6shE5DinG7ztw9THY9gGpkTQEc8MjY4FZMsssmBD1T/0ELiJTLC
         PH7KJrPkwPqnB7UV6k5RuVT4sN2lJuAyX9XotCLumBoosOwiCek6EZVYUyzfFsV8CD7P
         EWCEiFlxl3OMelw050KvJODzwxQ2Z+mRM791BAVyttg1W5JCTnglRZstJxePtD8QGYs6
         LW3Qu64fLhBPijWPpc2udm/KM71FFmlDtpZufBOPYZ/zAPBpduk935GrSey2iICpOKB0
         58BbrX0e40d2qP2SiYDsWkUYzO5lwsGkq1apjrZpASga2OyO8rhXCKcT0RQ6gpkGTKJR
         rAnQ==
X-Gm-Message-State: ANoB5pkXJ4KINDIYtMzR3MlVwx7X/wWFTfym8R/ty2GyFLxNTQFeHHp1
        LVW3O2ZVVXcExzqvXrOrwinNG9zCJ3sBcg==
X-Google-Smtp-Source: AA0mqf6moqRUfmlgzbJBBCnRRx4M73Ls4GJk5CJM9g8ZU8lUVD3JqUkKckuL7dlSv9r0khQi8WaqRg==
X-Received: by 2002:a05:6214:3905:b0:4c6:73ac:5bd with SMTP id nh5-20020a056214390500b004c673ac05bdmr5400940qvb.54.1668748111093;
        Thu, 17 Nov 2022 21:08:31 -0800 (PST)
Received: from [172.17.0.2] ([20.98.253.15])
        by smtp.gmail.com with ESMTPSA id az42-20020a05620a172a00b006cfaee39ccesm1793268qkb.114.2022.11.17.21.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:08:30 -0800 (PST)
Message-ID: <6377134e.050a0220.f7432.87e7@mx.google.com>
Date:   Thu, 17 Nov 2022 21:08:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3768723348246103405=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] monitor: Decode vendor codecs of BT_HCI_CMD_READ_LOCAL_CODECS_V2
In-Reply-To: <20221116211836.2671441-1-luiz.dentz@gmail.com>
References: <20221116211836.2671441-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3768723348246103405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=696161

---Test result---

Test Summary:
CheckPatch                    FAIL      0.71 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      26.53 seconds
BluezMake                     PASS      752.62 seconds
MakeCheck                     PASS      11.79 seconds
MakeDistcheck                 PASS      145.70 seconds
CheckValgrind                 PASS      238.78 seconds
bluezmakeextell               PASS      93.45 seconds
IncrementalBuild              PASS      606.33 seconds
ScanBuild                     PASS      957.24 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[BlueZ] monitor: Decode vendor codecs of BT_HCI_CMD_READ_LOCAL_CODECS_V2
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#101: FILE: monitor/bt.h:1794:
+} __attribute__ ((packed));

/github/workspace/src/src/13045866.patch total: 0 errors, 1 warnings, 50 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13045866.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3768723348246103405==--
