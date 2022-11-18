Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98303C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 02:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiKRCcc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 21:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiKRCcb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 21:32:31 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7EE58BDD
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 18:32:28 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-12c8312131fso4475617fac.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 18:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zAzFXXp3oiF2+2K1xEFSWnmkZLq4JwTTARPnbjEkOAk=;
        b=GLw5YRYX7HcZTNvxxDTc6fcseG7cLbLG6JruuuMDsX/KDqm7YISxq5ZxcKs9ElpAGU
         MfRm5fcQ5wdK1I0edty5y3xr46x+F+4TJkBmMN7dgKGT5l8lqYh0W25g5W+WqGZ/HD8S
         gPK5vRU4RA9yWwzt77l4/v7U4IJdTe4G25GLB3XuYnExTk9heq7wFVm6SHTtQ2sk9Hgx
         u1PHUnQL0xBw5omXBx3URGatuQ0mWs+SlGSpnsYbAfa9zXOkNmKcvzLoac4TizMlGejY
         //b4pWqTVaAS4zi6grNJKRA+4glQk9T1jTCry6kEb9mRuun0vV6iGms0vJSvLgFgi1mg
         T5pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zAzFXXp3oiF2+2K1xEFSWnmkZLq4JwTTARPnbjEkOAk=;
        b=W5aS9bw2gW/AE3kqUK/OUb8aqHN4uaQWfErldNqlJeBlsScy8zhNWBputcWH9RsWre
         LH1zjxVhDiU/ngnisJX5YICJBk3/aBL8RxI5EBQXgKvkCu2gGj22s0I6I+gAqRiNbRN3
         +/sU/VkzIukK2VmxPN02GOphUJpGC+aNTayAIpMAGSz9LXxD+l+YwftWaSc1KpyKXJ6o
         d5oDKyzbAUQGkFSRTVE56PosT/UgmFTG9vexKbM5/ZkEqcQo6cpwEKYZnPSiB/eL4njz
         b/VDhBcwzWAJQFzIxpLIQUGCA/KdkZ+faIPGRnZC/kaygMOy7FVA2SK6WobfJay0BdC+
         DRqw==
X-Gm-Message-State: ANoB5pk8zXw4AYMfEJstTGjaMZWF1KM0vCkiOyHsFhddSIBDoxOJbeKs
        moVkUr12eFHUbwA5NU6K+xlN7XFK9aI=
X-Google-Smtp-Source: AA0mqf76HlGCtutkLQrKJ5TIsdE0gnlAcNamAptB5kyuuOq/RlyUjB9m1azIorW9d47kqDN5kHfJrQ==
X-Received: by 2002:a05:6870:8927:b0:13d:51fe:3404 with SMTP id i39-20020a056870892700b0013d51fe3404mr2875743oao.183.1668738747704;
        Thu, 17 Nov 2022 18:32:27 -0800 (PST)
Received: from [172.17.0.2] ([20.165.38.226])
        by smtp.gmail.com with ESMTPSA id m25-20020a9d4c99000000b00661a1a48079sm1054330otf.7.2022.11.17.18.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 18:32:27 -0800 (PST)
Message-ID: <6376eebb.9d0a0220.8dd24.4e39@mx.google.com>
Date:   Thu, 17 Nov 2022 18:32:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3419221969706607039=="
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

--===============3419221969706607039==
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
CheckPatch                    FAIL      0.69 seconds
GitLint                       PASS      0.30 seconds
BuildEll                      PASS      33.63 seconds
BluezMake                     PASS      1146.21 seconds
MakeCheck                     PASS      12.50 seconds
MakeDistcheck                 PASS      183.27 seconds
CheckValgrind                 PASS      305.33 seconds
bluezmakeextell               PASS      122.15 seconds
IncrementalBuild              PASS      957.70 seconds
ScanBuild                     PASS      1331.93 seconds

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


--===============3419221969706607039==--
