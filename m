Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC05C76196
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 16:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbjCaQkS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 12:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjCaQj6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 12:39:58 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9582727023
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 09:36:00 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id y19so13768404pgk.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 09:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680280558;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nL0fkgMdxcim9h4oaURUxzgAMPg+g54QTGPcDkrBTjI=;
        b=BuUQW34yhJESPNfNvQ7Q9K4lS95BoPSyM/7cwzlyiMlfDZnmhIV+oVqomUg60YCAlt
         4K30XJeIRuz+Ae4F5riiDom7gWp2hfjXUpJllIgRD+LQLDNeBsUIWaT4E5gtCsk1t76C
         kXN3/Hy+wAxgRQYpXF/5TRhVmna2M/O96K9WeDK/EGHIfqDCgEwCTa+AjxRmCSIPBhJU
         s3mT4l5L3HnySN9Uutq1z+8XB/Oxwd0jKlE/2S7+FVU0KnZCBT/NGv+uVPtD6s0uZ5zP
         tlVcnWGVliwmWH158eVYTyVUtQ188pKfbyv6e9iM+GsW0cMrV2Azp8+fFiorI8DcRPRR
         Ofng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680280558;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nL0fkgMdxcim9h4oaURUxzgAMPg+g54QTGPcDkrBTjI=;
        b=UYt6/DkV1dPW+2Uq8rGE8wNt3AG8Q+6ZK1A2Cqg2zIqOss58eriVbS5OmYPAdqD5lR
         IM/BMYu++jVEhUOfFOCBM1YX3x465bALfXsi/Q7iny1clUPDvXmlpNZDm7w+lXP58vNB
         tB/AZKOPaH9p2+OXoy5HMSnk+BreycilL8iUe0hsBm52NGwbdhQ+hOx5njWecT7eBpCu
         DEUjySfNxzy5OjhUWBGzcZhVIyrzlVOgK/+MysJirHY2Ho0yGMyJkSwRsES1GFLaGipK
         sLCIjXbzoLVpxLMc2aPhLscOiNParwnuj3jQqv3EJiKb0EWcYpCjNeUwAAaHxcgrJOdl
         Gxuw==
X-Gm-Message-State: AAQBX9eAnbhfxgiJcz52DNDiiFxvfw/avbdfVttjjK23q0uzVHFYfSAS
        ZaBA1ljBqks7bkCyzxCHutJ8fCq/8vk=
X-Google-Smtp-Source: AKy350Y6OTeFNmObTMIbfItfvFdMwPr3mUpEOrPGIykj1CLN+0kQCWjU8DdERvWU+xJon1tzZJYx0Q==
X-Received: by 2002:a62:5254:0:b0:625:febb:bc25 with SMTP id g81-20020a625254000000b00625febbbc25mr25291834pfb.11.1680280557955;
        Fri, 31 Mar 2023 09:35:57 -0700 (PDT)
Received: from [172.17.0.2] ([13.64.10.197])
        by smtp.gmail.com with ESMTPSA id h12-20020aa786cc000000b0062d7c0ccb3asm2027431pfo.103.2023.03.31.09.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 09:35:57 -0700 (PDT)
Message-ID: <64270bed.a70a0220.e894a.4b70@mx.google.com>
Date:   Fri, 31 Mar 2023 09:35:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7597007556741201157=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: Split bt_iso_qos into dedicated structures
In-Reply-To: <20230331153801.35290-2-iulia.tanasescu@nxp.com>
References: <20230331153801.35290-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7597007556741201157==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=735874

---Test result---

Test Summary:
CheckPatch                    PASS      1.61 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      35.28 seconds
CheckAllWarning               PASS      37.88 seconds
CheckSparse                   WARNING   42.58 seconds
CheckSmatch                   WARNING   116.58 seconds
BuildKernel32                 PASS      33.78 seconds
TestRunnerSetup               PASS      479.35 seconds
TestRunner_l2cap-tester       PASS      17.18 seconds
TestRunner_iso-tester         PASS      17.30 seconds
TestRunner_bnep-tester        PASS      5.71 seconds
TestRunner_mgmt-tester        PASS      116.12 seconds
TestRunner_rfcomm-tester      PASS      9.00 seconds
TestRunner_sco-tester         PASS      8.30 seconds
TestRunner_ioctl-tester       PASS      9.48 seconds
TestRunner_mesh-tester        PASS      7.38 seconds
TestRunner_smp-tester         PASS      8.22 seconds
TestRunner_userchan-tester    PASS      5.96 seconds
IncrementalBuild              PASS      31.74 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):


---
Regards,
Linux Bluetooth


--===============7597007556741201157==--
