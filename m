Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE49C04A6A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 15:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbjHBPjG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 11:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjHBPip (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 11:38:45 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7392103
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 08:37:53 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-76ad8892d49so602788485a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Aug 2023 08:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690990673; x=1691595473;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DEoPaPS6o2ith/6lHdPXvtAXHWzJ2k+p6qPTvXqu3lk=;
        b=p8iXZtJ1Vasu8zA4JLv/WK1ZPSsK3cEAIrpY8FDqD4nQYGm94Ec3kBZluNqGjkTRc5
         xIYb4KOaKgKHZTTS4CRUyzqPwuL9wj075oJ8TGx++QbBuQgLLcAqA2cMCqgmOuSgL23F
         29aUjOhxsgfHG/CfP55h2kX3rFJlCjQbFAvuUvb23k70LHNeg+MY3v7oL43A7QryXo1U
         pHBMJhiAtiuBIz/85q21XsTvBXAwGxYuJ/0XMQL6y8Cp6x5tPSP6oAaa06/3Y6tcOgxE
         2j67Iiya21TbZhsOMBxMgwF1LA8gpwMZN/EEbrJ+y5dzrNIsnyKSJ2vCdDHeuatJSE1w
         zvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690990673; x=1691595473;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEoPaPS6o2ith/6lHdPXvtAXHWzJ2k+p6qPTvXqu3lk=;
        b=LTBybNXr1vP+oslVC3vXaH5iNpFZHnRU2uIE8em4wC9DS3qKXYsogk4F7oo4LJrufA
         cz+NsRcJTHd9F4PVN4Kn/QJEkmCAhMlm6Jx2b8TlANHh5B/eAgVrxHxWVmueKdtRv0pE
         LXRUdchi//eFYnWDa3VykLAZPrjfnbM4hlgfhrVGxO/01botzHWkLvv1dmUeq3QEfDfp
         KpFMQHvmDvPUM3tFH+aHm4mnl6SIB6/+cLNEKpHSrflQddWgfjt+TqyoFLqSeqRiJ7r4
         0UCPgD1JnBuV268Juq3JfmfCAFhKrVzwk1aYflusLZFE8LQYdCweNssL1mSlHq221gZK
         f69A==
X-Gm-Message-State: ABy/qLYDg2xrNUolKIH9uDaA5VK4wIXiFzW70UBRMibcA/sd2aT7hOXy
        pWr1yaeAk0MSKeeETOh8tIqRhkNNmdY=
X-Google-Smtp-Source: APBJJlHQyxK0Bb5K6TVTld/ERg6xSGUxRBirSMK0mFaBZYaa+93wB0kSy5XxILSHaeuUikbGwxOzcA==
X-Received: by 2002:a05:620a:2491:b0:76c:7f5e:3888 with SMTP id i17-20020a05620a249100b0076c7f5e3888mr21629080qkn.50.1690990672720;
        Wed, 02 Aug 2023 08:37:52 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.217.73])
        by smtp.gmail.com with ESMTPSA id p13-20020ae9f30d000000b0076816153dcdsm5094836qkg.106.2023.08.02.08.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Aug 2023 08:37:52 -0700 (PDT)
Message-ID: <64ca7850.e90a0220.423f2.3eee@mx.google.com>
Date:   Wed, 02 Aug 2023 08:37:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0352237535021686161=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync
In-Reply-To: <20230802143638.59945-2-iulia.tanasescu@nxp.com>
References: <20230802143638.59945-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0352237535021686161==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=772203

---Test result---

Test Summary:
CheckPatch                    PASS      1.76 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      35.51 seconds
CheckAllWarning               PASS      38.48 seconds
CheckSparse                   WARNING   47.22 seconds
CheckSmatch                   WARNING   119.44 seconds
BuildKernel32                 PASS      35.52 seconds
TestRunnerSetup               PASS      550.36 seconds
TestRunner_l2cap-tester       PASS      26.39 seconds
TestRunner_iso-tester         PASS      53.22 seconds
TestRunner_bnep-tester        PASS      11.45 seconds
TestRunner_mgmt-tester        PASS      229.97 seconds
TestRunner_rfcomm-tester      PASS      17.11 seconds
TestRunner_sco-tester         PASS      17.59 seconds
TestRunner_ioctl-tester       PASS      19.09 seconds
TestRunner_mesh-tester        PASS      14.52 seconds
TestRunner_smp-tester         PASS      15.87 seconds
TestRunner_userchan-tester    PASS      12.33 seconds
IncrementalBuild              PASS      35.53 seconds

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


--===============0352237535021686161==--
