Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DCFC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 05:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiKSFmo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 00:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbiKSFmn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 00:42:43 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E447C5ADF7
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:42:41 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id p18so4878499qkg.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uOUd817ujzI37zov6xBPCW+pfJ6r1IjLVQMZtQSfspc=;
        b=eIfq3vYYrPbsDsq72hV+tasQf8XR9uk6XEcEjz2/q/0IXccXe0m+NCXJ3k3g2R7/7K
         fcUGVgaYSyd9uX7L1vdiC4ffDME563XLX45YTeXNAHe77I9DQh8RxtmaubFXnWtfFlCK
         0BJR01NBJw6N+7U13/CaJe6k+6hwRlh7MeRMRhqrXOKpbsQYQ8VMtDV9gAg/seJu8vxZ
         P1K1fYr+HW1ivq2vTk9I5H3c6WzkEOnlKS7NHPXrWflU5fDefW7lrJSYp5WsGL8UBEfD
         QGHj2Ib+TH1iaoq/mTdMqlxdCil/SjwfcT0dCYX9jRVCuaSrqNtZBPSgDdCW+9nC871w
         4MSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uOUd817ujzI37zov6xBPCW+pfJ6r1IjLVQMZtQSfspc=;
        b=x5V8B8//KOOzjwNytsyTIFX2wziqV97Ej1TTmz0Z/qtEsAG5eXyJZVmMtukGG32sxh
         7jKCqijXHk1aks82Ytlmg0GMw4qyzu62aU/YaE6ugTjy7XmUCQ18A8ifJy5/7To/4iLk
         mi1GG5B520HnQMkmLi+R7TE81rcNwixkHTAAo+AUL6CDZx18Yc5+lNOvXOs8vC0LHs8+
         CUanUBpSrKvPi00cf3ZaxWb/0wTCWWFVXokyzMOLe6YI9GnZjcTp0J9wtCQB5T64Ty1o
         qKaSH3gVsbifXxUGXoLcNcffjjE6Ma4PSsuVm9OSvMOXP266ca0PH0YnUJhhQnhKXYNf
         a7/Q==
X-Gm-Message-State: ANoB5pmiNZAB+JqKm3R0TWF3IwrsJLq8FKrAPO4nmq+puoGZCt9QFRRY
        ZzvRUijF74ZHkABFKIy4dSG4vbUtwlBHEQ==
X-Google-Smtp-Source: AA0mqf4wj9cdY2QltDcp1M9GsFUXsoM9xRH9epMUREZjf2pLhsFBSaVpHudzhxzsmmuvs2pg477xHA==
X-Received: by 2002:a05:620a:4eb:b0:6fa:4d19:2419 with SMTP id b11-20020a05620a04eb00b006fa4d192419mr8839391qkh.61.1668836560940;
        Fri, 18 Nov 2022 21:42:40 -0800 (PST)
Received: from [172.17.0.2] ([4.227.215.33])
        by smtp.gmail.com with ESMTPSA id d5-20020ac85445000000b0039492d503cdsm3289683qtq.51.2022.11.18.21.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 21:42:40 -0800 (PST)
Message-ID: <63786cd0.c80a0220.35d81.e50b@mx.google.com>
Date:   Fri, 18 Nov 2022 21:42:40 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6705225861930223301=="
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

--===============6705225861930223301==
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
CheckPatch                    FAIL      0.86 seconds
GitLint                       PASS      0.36 seconds
BuildEll                      PASS      27.15 seconds
BluezMake                     PASS      977.78 seconds
MakeCheck                     PASS      11.97 seconds
MakeDistcheck                 PASS      146.44 seconds
CheckValgrind                 PASS      243.65 seconds
bluezmakeextell               PASS      94.94 seconds
IncrementalBuild              PASS      845.80 seconds
ScanBuild                     PASS      1016.37 seconds

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


--===============6705225861930223301==--
