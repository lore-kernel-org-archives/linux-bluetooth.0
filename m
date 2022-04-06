Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEC8C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 17:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238363AbiDFROy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238459AbiDFROZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Apr 2022 13:14:25 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA354DA28C
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 07:37:19 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id b18so4466421qtk.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Apr 2022 07:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=5inza/b5MvnMOVc/Y1e8COEfJexTZu0TaWXzA7PU0ls=;
        b=M/Wkf57H036+mLKEmW7ixv9VKYuwmFmBns+92SbzN/Xn0WagoFo5Ih0SexicIQhrqY
         g3HKFDNA+7bLOF696NXAe694zKfP2F9LhqyWUK3wDbtRwEp26ZJJ5nq98za6H+AgQehC
         liZsfZQ4zRCfnyGi7d6x7e2FpdlIMvdZLOVcbHoUgW+SRY+icM6/BF6lE3RDY6QKhRXK
         /5odc9sEbuhVHCOGZZTXImdCT+dZaeOhQmwfJ6Fi37SS126emYhtQl7tRDZ1ZK7nHY2s
         SkK6aESyMnnobem+5Nq4HvkQWG+G3cIfhLWgC0w0i8f+gd9CmOCCRnnjmG62laYkkFPX
         jfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=5inza/b5MvnMOVc/Y1e8COEfJexTZu0TaWXzA7PU0ls=;
        b=okxKs+2iLz9XQua6UdlHMniwBDjVTiG8NviWt7vk3+ynoUMLcWQBdZg8DL+g0wcLSb
         4yAc0XTcfyX+xF+PpDmk+Yib4fC8fUncVMXTTN5jLI8bg2e2nMO0QvtTAcV4Mk5KgscU
         2U32Dv50lhy1jTe7imdvrDbJaHCrpdr4FW6pergx+BcJC0gJi3HPzGnmQZpS1+iDmsQR
         eF/CZz1JRE9OBXFOWTKwMSp/PWuBopyoLMiWR5BP2xy6Uxb5OcIMB6j13oTLZP3dVGAY
         RttvjRggee1oYi5hQF1/xiG8meR5a2r9b5d45MnObjMapLOX/kcC+GsTJm3gdOQAR9Oc
         zCyw==
X-Gm-Message-State: AOAM530nIoj7j4ee19sYMO4xrIZRN7bY2czvw0rDLlQ5O9qxgJouUdi8
        HQR7pbIVFXfFNu6pOzgJ5ivtd125Wo7rFg==
X-Google-Smtp-Source: ABdhPJyXhRnTUwgBmO/MlGhnsrFmb7YOFkgihxBhKAqQ9Y2LtgVuyinkJe99aLZsWRAabyHGtRf+EA==
X-Received: by 2002:a05:620a:22f9:b0:67d:1561:f4f4 with SMTP id p25-20020a05620a22f900b0067d1561f4f4mr6093468qki.217.1649255838213;
        Wed, 06 Apr 2022 07:37:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.124.105.73])
        by smtp.gmail.com with ESMTPSA id z6-20020ae9c106000000b0067d3b9ef387sm9828973qki.28.2022.04.06.07.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 07:37:17 -0700 (PDT)
Message-ID: <624da59d.1c69fb81.2e0bd.0aa2@mx.google.com>
Date:   Wed, 06 Apr 2022 07:37:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7845134259466205465=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pelzflorian@pelzflorian.de
Subject: RE: [v2] main: Remove unused main.conf option NameResolving
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220406084357.iai4k6jvg6gnnbyi@pelzflorian.localdomain>
References: <20220406084357.iai4k6jvg6gnnbyi@pelzflorian.localdomain>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7845134259466205465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=629501

---Test result---

Test Summary:
CheckPatch                    FAIL      1.50 seconds
GitLint                       PASS      1.01 seconds
Prep - Setup ELL              PASS      47.85 seconds
Build - Prep                  PASS      0.74 seconds
Build - Configure             PASS      9.70 seconds
Build - Make                  PASS      1374.25 seconds
Make Check                    PASS      11.87 seconds
Make Check w/Valgrind         PASS      462.56 seconds
Make Distcheck                PASS      243.13 seconds
Build w/ext ELL - Configure   PASS      8.86 seconds
Build w/ext ELL - Make        PASS      1328.73 seconds
Incremental Build with patchesPASS      0.00 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[v2] main: Remove unused main.conf option NameResolving
WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '826023de5689', maybe rebased or not pulled?
#49: 
Commit 826023de5689 ("core: Create devices dynamically during

/github/workspace/src/12803348.patch total: 0 errors, 1 warnings, 37 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12803348.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7845134259466205465==--
