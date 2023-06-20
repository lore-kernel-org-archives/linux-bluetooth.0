Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5246EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 15:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjFTPgV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 11:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232030AbjFTPgU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 11:36:20 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD3912C
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 08:36:20 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-62ff6cf5af0so43875666d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 08:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687275379; x=1689867379;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vf8Wo+dyeNzKyPhT9DtgUOC0vCoxo5GM02ZLY6gCel4=;
        b=HDVhkkwGEFD8XwxuAMvc6O8tGt76wODxTgISq9QQoy5u4Za8bUX8zBcd5Q9IT32sm6
         lgG8sqMsTr9kJXsb1uzKArSGjOp9jShLZcfupDXPA8xvKPW08HEC1bJ57WqOqMsPqGdz
         u5VrgALbhhwBaImo/j9sZPbWfFGo/2/ij0CSCobyPdMjTjnvBYdlZMGH3RH9ysEWvw9S
         3STdzHMDzcMEMcMDrKez7oKpsh01jejeLaVcNXsGq27AQbaHfNO08XE6a/LFsFKSMdrj
         N//a4giTYm2TUND5UVe1+UgO1NwAJHuMhSgHT6mUgnRfFgGzw1qjchHc45pt6B+zU/+A
         o9tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687275379; x=1689867379;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vf8Wo+dyeNzKyPhT9DtgUOC0vCoxo5GM02ZLY6gCel4=;
        b=VRah+P+VM7p8tINfyxpqim3z63Gz7CCMFLEBA3k3LrL39mGBJa3E67RlqmM+snCjzE
         CfNhAg8gOAuZsExX7KSkZEV9sOiq9YPzfE5xLz2lEKKC/xyk2pcF7tIPgds7knorNP6M
         xw6eTCAyLworIUGzA4NgLr0WG6XLOIxLCkFRkAz2tPwBsWrto5ANn0UMCC+CH2FKnxUH
         vSzUttPq34kbC1Y+c0tv3kLqVJrt2Wd+MG4KBcPifnrKUa7PM4U6dq0xMzDgDKkiQRzw
         FoFN+r+CU16g6dffzUCoA/Y9qmmiLBCCcHu7gbdjgGhfZIL784FkGhvgRo5omxWpLi8c
         h6Fg==
X-Gm-Message-State: AC+VfDx5fHn3tqO9vVgZjm65SUOadSI6mJ+fS+XhlEfRwP9INnYNEKch
        6mz22SoZpnzMEDkkpt1TvWHq1HRKSMY=
X-Google-Smtp-Source: ACHHUZ7ME+r5QZt+BbERY+k4q6GZhcgzuFNNrSvcdM/6eFJXbVqiTSexVd9MvXE5cyFr2M/hjpUaqw==
X-Received: by 2002:a05:622a:190a:b0:3ff:2f27:12ac with SMTP id w10-20020a05622a190a00b003ff2f2712acmr1729133qtc.66.1687275378822;
        Tue, 20 Jun 2023 08:36:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.13.25])
        by smtp.gmail.com with ESMTPSA id t3-20020ac85303000000b003ff1fcaa5e6sm1224729qtn.27.2023.06.20.08.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 08:36:17 -0700 (PDT)
Message-ID: <6491c771.c80a0220.b41c1.363e@mx.google.com>
Date:   Tue, 20 Jun 2023 08:36:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0112931271148328777=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org
Subject: RE: Bluetooth: hci_sysfs: make bt_class a static const structure
In-Reply-To: <20230620144051.580683-2-gregkh@linuxfoundation.org>
References: <20230620144051.580683-2-gregkh@linuxfoundation.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0112931271148328777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=758732

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
GitLint                       PASS      0.39 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      39.70 seconds
CheckAllWarning               PASS      43.61 seconds
CheckSparse                   PASS      48.89 seconds
CheckSmatch                   PASS      132.08 seconds
BuildKernel32                 PASS      37.98 seconds
TestRunnerSetup               PASS      537.43 seconds
TestRunner_l2cap-tester       PASS      20.26 seconds
TestRunner_iso-tester         PASS      29.62 seconds
TestRunner_bnep-tester        PASS      6.95 seconds
TestRunner_mgmt-tester        PASS      135.86 seconds
TestRunner_rfcomm-tester      PASS      11.08 seconds
TestRunner_sco-tester         PASS      10.03 seconds
TestRunner_ioctl-tester       PASS      11.90 seconds
TestRunner_mesh-tester        PASS      9.03 seconds
TestRunner_smp-tester         PASS      9.92 seconds
TestRunner_userchan-tester    PASS      7.43 seconds
IncrementalBuild              PASS      36.27 seconds



---
Regards,
Linux Bluetooth


--===============0112931271148328777==--
