Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB65C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 06:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240969AbiKRG1G (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 01:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232004AbiKRG1F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 01:27:05 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1DA92B77
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 22:27:04 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id x13so2776829qvn.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 22:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R6fc0HMgm1/ZO+K+YPZUndsUzSDMS9M3+iDX76NZSdU=;
        b=Mr6u/oo8weK/za1iC67bp241wNn+qwpQVuypLIxJ/AxhxFOcV6VXg6DQb/e+iy9kur
         EsA2HCb0MZh+z5CjUBYooqItku23S72vj96sbs7flOlDQkxEUCuoccWUDiKnaml86vL+
         tedzMFKrdquIg+Olqyzm7RsZuLIZFixBx6+fUSEsenlFRYvPE6QLFNBvQRf0/FrGFJ1h
         CM85zY2HLgA2Nq0T0sR9IaAJkH+ikRIG5O+C8M1nPkc5HpfZZLgVDV3VQhfd7Qeop0w9
         F6VRnX8NyAtEBJ1iFiSYIlcoPBYccnT+cA5c0Q1CEepwSfImZ40aSyf2y20uUQ78vvB0
         DX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R6fc0HMgm1/ZO+K+YPZUndsUzSDMS9M3+iDX76NZSdU=;
        b=vzT+InFIZcLl+ziadYoNIfgZZwtwPtzDwuOsDHcP8LG+MR31Vq3dyI8LTMs9M+Fsnr
         RacSa/CjNR4LibP2SyOq6kfzh3nz27Y8qQ5H0OiSRAm1OYsIV5G7u5D0wUmgKGEeXmcY
         KL6yeCmk2JS0cXwWQA36AdZpmu/aYUDuZTzdHIw0l+/N6gx9QMcpUrFTIgqFhGDUb/lC
         +cbzU85ZSiNcvRkd74cZyudxls9/Oq6Tm5LgE0P2ocZxsUefRWDkViAbO0MM32PyoZvS
         O3DkDBgH7ySLKAuTkCjueo+090vdYo9Xj/EGmwBxuXJGQKjJUId9XK9yWS7QP6dlCDcb
         dKyw==
X-Gm-Message-State: ANoB5pnfdyUgBe1q/7/c2/owdKM0MchYjSzx4YDToITD0H3QghV/lQPn
        03WypwDryW5HcQdhNh1eizfhH5/f8OkYKg==
X-Google-Smtp-Source: AA0mqf650LpJb9Fy41dmEuSFjSWvXeOkOpIQvYglCaJyAuqMlhoFCXTNLaJq/EM/txqeju4d5yqemw==
X-Received: by 2002:a05:6214:184f:b0:4bb:7d40:2078 with SMTP id d15-20020a056214184f00b004bb7d402078mr5518773qvy.125.1668752823405;
        Thu, 17 Nov 2022 22:27:03 -0800 (PST)
Received: from [172.17.0.2] ([20.10.129.79])
        by smtp.gmail.com with ESMTPSA id r2-20020ae9d602000000b006cebda00630sm1875742qkk.60.2022.11.17.22.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:27:03 -0800 (PST)
Message-ID: <637725b7.e90a0220.92b90.9209@mx.google.com>
Date:   Thu, 17 Nov 2022 22:27:03 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5141996642689329795=="
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

--===============5141996642689329795==
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
CheckPatch                    FAIL      0.70 seconds
GitLint                       PASS      0.35 seconds
BuildEll                      PASS      27.04 seconds
BluezMake                     PASS      757.89 seconds
MakeCheck                     PASS      11.59 seconds
MakeDistcheck                 PASS      146.75 seconds
CheckValgrind                 PASS      237.55 seconds
bluezmakeextell               PASS      93.17 seconds
IncrementalBuild              PASS      605.94 seconds
ScanBuild                     PASS      961.57 seconds

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


--===============5141996642689329795==--
