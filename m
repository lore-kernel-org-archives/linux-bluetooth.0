Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C84EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 22:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbjF3W7I (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 18:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjF3W7G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 18:59:06 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C01335AB
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:59:05 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1b7f223994fso17635505ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688165944; x=1690757944;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t0gQzzn4aStAe+o+NdDF5aqcWg+kDa9qDaHW5hEQvu0=;
        b=myRTUoHoBqHXmsyE4qrtasFKmo2cyniAokCSe/8E5A9YLjMiRVumzfpzVqFLIAaXXy
         eV9Ye5H8VEP2sxgf0IrQD48B6kB4Ww+ctAmRU8MWUcn86TWVtn8JS9NCtdoGD5GcD/N/
         sHsUm/ux85MMd3Du/GTWU0tanZySTk2RXjJ3Vi2ftQsPHVBZBmTx2ElybpZluwWkwmPZ
         TauckACnK/g0QJ004snbbT7x+bKt4m7QcJ312rb9XeBO22FosyuGBcIUUKBU33205wVC
         lbDUCYk9Z3Bz3zoGjG8A0xjDKIS94tDMSJjp/5cbIfzq/Gm6gI+t/P/fJwHUNNAvob25
         o/4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688165944; x=1690757944;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0gQzzn4aStAe+o+NdDF5aqcWg+kDa9qDaHW5hEQvu0=;
        b=HP8vjQMQuippP5rIMmIxg4kBbXjd7dtAR4YtgdpsaX4r4pAjb4m0f4Yee7ZgSaCMmz
         TFWhMKBYlQ9V8yxooCM9Sjqx3ZW7lZaKXr/pRwYuv2wecjjVlsORzghis5M5vHf3/DlJ
         0attw6/Rji1V9HTy8IAMc37Wo8YvOyBeyLyaiwQo3vIZN//Mf7gsVdm6lUjP9Gy9S1YH
         Et1wbhA4kQXEQHucC8kKK6QpcM/RktqlZ78nydN2QK6jegZ3+zvD0zvJEK1v7uM6jXRg
         7FilGn1E/oM6zS+NnT/uqaCdubjtL1Z0Lo+h8d/x+qB1Qgy+fgZIK32tHOqWnzaBLSMx
         zv6Q==
X-Gm-Message-State: ABy/qLYSn68E0aN9mvwJOgPhoF6r8s01hgO0F9SGh8znUU4sC2RYLewM
        k43LOzbIQ+Ufsi3A7tlYIhl0gpp5UBc=
X-Google-Smtp-Source: APBJJlFQQL22WFsXQEr61VjWUzb13RokSnDABfA9A4HhtLM7RO//VaApl6eycr7CWPsTDBE1fpTglA==
X-Received: by 2002:a17:902:d2cd:b0:1b1:a7d8:a3a1 with SMTP id n13-20020a170902d2cd00b001b1a7d8a3a1mr4319203plc.21.1688165944230;
        Fri, 30 Jun 2023 15:59:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.171.49.54])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090282c500b001b7ebb6a2d4sm10523859plz.163.2023.06.30.15.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 15:59:04 -0700 (PDT)
Message-ID: <649f5e38.170a0220.6a5f7.574a@mx.google.com>
Date:   Fri, 30 Jun 2023 15:59:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8981422737557084466=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dianders@chromium.org
Subject: RE: [v3,1/2] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()
In-Reply-To: <20230630153315.v3.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
References: <20230630153315.v3.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8981422737557084466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761691

---Test result---

Test Summary:
CheckPatch                    PASS      1.10 seconds
GitLint                       FAIL      0.77 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      32.78 seconds
CheckAllWarning               PASS      35.74 seconds
CheckSparse                   PASS      40.37 seconds
CheckSmatch                   PASS      112.19 seconds
BuildKernel32                 PASS      31.17 seconds
TestRunnerSetup               PASS      447.30 seconds
TestRunner_l2cap-tester       PASS      13.11 seconds
TestRunner_iso-tester         PASS      23.69 seconds
TestRunner_bnep-tester        PASS      5.58 seconds
TestRunner_mgmt-tester        PASS      132.56 seconds
TestRunner_rfcomm-tester      PASS      9.05 seconds
TestRunner_sco-tester         PASS      10.42 seconds
TestRunner_ioctl-tester       PASS      9.73 seconds
TestRunner_mesh-tester        PASS      7.02 seconds
TestRunner_smp-tester         PASS      8.21 seconds
TestRunner_userchan-tester    PASS      5.80 seconds
IncrementalBuild              PASS      35.20 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,1/2] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (86>80): "[v3,1/2] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()"


---
Regards,
Linux Bluetooth


--===============8981422737557084466==--
