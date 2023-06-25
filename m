Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CF6EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Sun, 25 Jun 2023 09:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjFYJjD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Jun 2023 05:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFYJjC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Jun 2023 05:39:02 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B60C9
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Jun 2023 02:39:01 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40091911ba8so19747951cf.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Jun 2023 02:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687685940; x=1690277940;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/jOVQzuYGQkb1+Vby55kjCs0dUvrgoi64s7sX37K0vg=;
        b=JCRpXu2hgE38ME5B1P0KB+hcE933+KguChHlf90mFim0FkV7InEzsofkRKw55dF7JK
         MDfQN8UDt0peQywrUnzPERtMRaUMB46GLeOdDfc/l0EbqC3NfwXoiD/oy9mV5T94q3G0
         Gt6Yrx2a8XLZEZZfWm5SBRoNXU09LOxNHM2sU1LMwKU+D885DK9xG0EM2rs/ImP+U6m8
         8v7AmPmAa1Rr11MgEt8UcyPEQSrTOVOZa3urZM8krZWKH//IuoBBYc4Vtn8vI8n/qkeG
         I0Xf/mBMHL1ghrySJYhdr6qng5xXIXJEOHXytVTABKl2uGxlzzX8xBbnlk6mKa3VxBwV
         VgNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687685940; x=1690277940;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/jOVQzuYGQkb1+Vby55kjCs0dUvrgoi64s7sX37K0vg=;
        b=HnrvxsqC69n/agAphswMScVoMTf/6K7hrUf9l2wDdDZDvCY3epVjxIvWi/NKcPqGKW
         MBXcYeIgI70VVGmiegHwTWzx5yw9TmeGhOQZj6H51LfmPE48Jo/EiV4kjEs8xWsv9J2T
         9CzK09xoAN4XA6ioT8BIP86fh5uRAxLql+3GD4rSU5sIJDfLJRmxc1Yz4KeFAcFjH3ql
         5TPisTUdmMOemZ1NVmaiF95B9lLzugvbtILKCyoIJrqrtrshHLutL7OKHQTZ4B68uUew
         AvilVQzpBjky5sc0YIkkiFzihwPUXHg+zTpwK8b1VAPcSaJceXHdNcHfLPAjoHgjdCIr
         onRg==
X-Gm-Message-State: AC+VfDxirJ42ycxrkPdZ6+jpIpVjZoTQe+DzJ+BaRyVPZq2MxyYtdNcQ
        NUdGoFyy0ka/2ffge1fAqyeL3VZr+AM=
X-Google-Smtp-Source: ACHHUZ5ojaLHO0s+VwvpKjvOkhC9mjZNZoXa0+RgQFT1cCHp1eQMfIFGbQ8MGhmC/VgZCf4v08RU6g==
X-Received: by 2002:a05:622a:13cd:b0:3ff:1ef7:9d03 with SMTP id p13-20020a05622a13cd00b003ff1ef79d03mr22664720qtk.63.1687685940437;
        Sun, 25 Jun 2023 02:39:00 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.206.211])
        by smtp.gmail.com with ESMTPSA id d5-20020ac85345000000b003f9ad6acba4sm1705501qto.79.2023.06.25.02.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 02:39:00 -0700 (PDT)
Message-ID: <64980b34.c80a0220.a034c.25bf@mx.google.com>
Date:   Sun, 25 Jun 2023 02:39:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4328676042437292827=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiapeng.chong@linux.alibaba.com
Subject: RE: Bluetooth: hci_conn: Use kmemdup() to replace kzalloc + memcpy
In-Reply-To: <20230625084513.6319-1-jiapeng.chong@linux.alibaba.com>
References: <20230625084513.6319-1-jiapeng.chong@linux.alibaba.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4328676042437292827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=760042

---Test result---

Test Summary:
CheckPatch                    PASS      0.83 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      43.44 seconds
CheckAllWarning               PASS      48.03 seconds
CheckSparse                   PASS      53.73 seconds
CheckSmatch                   PASS      146.70 seconds
BuildKernel32                 PASS      42.48 seconds
TestRunnerSetup               PASS      604.44 seconds
TestRunner_l2cap-tester       PASS      21.55 seconds
TestRunner_iso-tester         FAIL      31.74 seconds
TestRunner_bnep-tester        PASS      7.74 seconds
TestRunner_mgmt-tester        PASS      162.79 seconds
TestRunner_rfcomm-tester      PASS      12.28 seconds
TestRunner_sco-tester         PASS      11.08 seconds
TestRunner_ioctl-tester       PASS      13.28 seconds
TestRunner_mesh-tester        PASS      9.83 seconds
TestRunner_smp-tester         PASS      10.66 seconds
TestRunner_userchan-tester    PASS      8.00 seconds
IncrementalBuild              PASS      40.10 seconds

Details
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 80, Passed: 76 (95.0%), Failed: 4, Not Run: 0

Failed Test Cases
ISO Receive - Success                                Failed       0.272 seconds
ISO Receive Timestamped - Success                    Failed       0.256 seconds
ISO Defer Receive - Success                          Failed       0.260 seconds
ISO 48_2_1 Defer Receive - Success                   Failed       0.264 seconds


---
Regards,
Linux Bluetooth


--===============4328676042437292827==--
