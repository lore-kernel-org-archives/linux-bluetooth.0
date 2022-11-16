Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F26C43217
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 22:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234935AbiKPWYt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 17:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiKPWYd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 17:24:33 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D6C1F2DD
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 14:24:32 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id cg5so34911qtb.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 14:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KkKPcM22g6BJdpf+++ohPDnQcio5AiEd08kLrBfmmmw=;
        b=MX3pd7Lh/MSNxZzffWWdPWJ24lhKCt/D5wQTAsRPzF3mLaXu+kpuU9fiTWiPfg47sB
         MhDwKYcJWZ/0yzzha+P89C2ykObeYEfW52mF3xLGRwtfbvYV3YQyD/1+O4Xbj0D8/Zdb
         Wp1QmGXc7hwQo4czW7taZmeLp7V5lXZ65DQy/wRje//FINFgUdPLMKqH7zaWrQLCJTfc
         zaGFr3S2OqaqBL/Zi3LfBfd1S2xGAZULdhTA6piV6fpeTZLWNPywvxDtloZcb0OQ8ON8
         ji9GDf+uqo9x19SxUF8o4zdbbLGb/4o68qRcKL+6Wt51JGK+GHvw8kuvcETqMPpycvKk
         XhVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KkKPcM22g6BJdpf+++ohPDnQcio5AiEd08kLrBfmmmw=;
        b=Z6Ro5MvS/2Mgml7pnPYYsopJyxJiOn1reyNh4dnvRXSLOkP0Ln354vDMHXvM/MXIkT
         xd2AhF9+Cou4qBUkaYDPiLXURIZu0rO2DwRjEgJHEBAhPGf5PKq0YhhRjVjp3uk8gDBM
         e0dZyjCSmvpRyabsXUABJGg/uvCnP2LoaUkkCcTeoGRFnCuiTqyyEL8bnm5C6FcpDmrU
         4sbh9xcltEiX7iWXTBuodOLLWM0wZat/Pjnrxpnn9tOtWw2jXwACqA29ZpVvemJkpo8M
         z93PItHisBrgUwzO3R1mwGjmPNnZsY/QK1Ik9cpSdNsxtAY4sAoP0Xg2qblC3b5KdoT1
         A5yA==
X-Gm-Message-State: ANoB5plwbUGkoSmv0j9ue+bRm+jg56F6S6UUs+3Sf+6QR9FMR+epg2yA
        RG46kay0lt4Mszl0Wkp9tbd2MQJ9cvLkZQ==
X-Google-Smtp-Source: AA0mqf6GD6eFhLWUNIFgI+ZNaqe6U0VZX7tsFE3Rbodk5MS2W7XtqL/oZ6GutcAjwAO1HitV95+Jlg==
X-Received: by 2002:a05:622a:4119:b0:3a5:17ac:1d30 with SMTP id cc25-20020a05622a411900b003a517ac1d30mr23248159qtb.482.1668637470949;
        Wed, 16 Nov 2022 14:24:30 -0800 (PST)
Received: from [172.17.0.2] ([4.246.181.130])
        by smtp.gmail.com with ESMTPSA id l23-20020ac848d7000000b0039a372fbaa5sm9328051qtr.69.2022.11.16.14.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:24:30 -0800 (PST)
Message-ID: <6375631e.c80a0220.62d8f.2506@mx.google.com>
Date:   Wed, 16 Nov 2022 14:24:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6190668430711663549=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] monitor: Decode vendor codecs of BT_HCI_CMD_READ_LOCAL_CODECS_V2
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221116211836.2671441-1-luiz.dentz@gmail.com>
References: <20221116211836.2671441-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6190668430711663549==
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
CheckPatch                    FAIL      1.69 seconds
GitLint                       PASS      1.13 seconds
Prep - Setup ELL              PASS      27.68 seconds
Build - Prep                  PASS      0.87 seconds
Build - Configure             PASS      8.80 seconds
Build - Make                  PASS      1003.75 seconds
Make Check                    PASS      12.36 seconds
Make Check w/Valgrind         PASS      299.43 seconds
Make Distcheck                PASS      246.94 seconds
Build w/ext ELL - Configure   PASS      9.15 seconds
Build w/ext ELL - Make        PASS      87.64 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      702.42 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script with rule in .checkpatch.conf
Output:
[BlueZ] monitor: Decode vendor codecs of BT_HCI_CMD_READ_LOCAL_CODECS_V2
WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
#101: FILE: monitor/bt.h:1794:
+} __attribute__ ((packed));

/github/workspace/src/13045866.patch total: 0 errors, 1 warnings, 50 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/13045866.patch has style problems, please review.

NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============6190668430711663549==--
