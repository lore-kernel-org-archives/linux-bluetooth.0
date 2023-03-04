Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACEAC64EC4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Mar 2023 14:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjCDOcF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 4 Mar 2023 09:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCDOcE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 4 Mar 2023 09:32:04 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA2C1EFEB
        for <linux-bluetooth@vger.kernel.org>; Sat,  4 Mar 2023 06:31:43 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id h19so5978705qtk.7
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Mar 2023 06:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677940302;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bPjKvDW4ewXrx0NUfXMFu+Xjvrv4Ldr/O9dQ6bDO4tc=;
        b=FBAJMug7whaUO2qhyr0B/UNuc/gMLZ98W/idKhijSvTQnmPuWSzV8F0Wjqb+L5X7Jp
         Z0cBbSfe50hGtMbNUgG11UgWUAIrz1+t3IZTO51vbA1fuXRCiDPX377uvTWosqwNbx3R
         Z5josoma+HSeqrQ2Cgt0KPrKf3TisbGLeXwOz2QyarsDCp/24VbCSvYVb7pstqn/1DKG
         +SmHpOaar1cyvt98rDXrBYMJbwUcOCGErZqpYZklmkQ26JIzS20/m1PLSJdqL5x8zQJt
         i9OPOkm9/dD85pMfsWt+wpZU6LlOO85SWs0ZjG7HnvGHKnwtaS0AieUzs4RcVbtVMxIq
         y7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677940302;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPjKvDW4ewXrx0NUfXMFu+Xjvrv4Ldr/O9dQ6bDO4tc=;
        b=RLq2UYv5O/f0aAhz7gOjhV/Wkhtz959Uk90to84+jSwpAs04BI82CCO7v/6PEj1PW9
         gVgKB6SQ9TT+X9a05Urfe5PEkf1z2eVv6pkCzB0NMWxHcpXacX3pKcrzq5Mqic52y3VA
         z9WXM0dUwgxDiwHTNWjTl4b+0MLoZGBC/NrTzMa15tnq/O0h1mwH4HvP/PRi8rTkeAmU
         EL0PYxNLxk6FYJEQ6lCPUcdetdGuFPUbMuFGDYFQjOC4xdr2tGpt6ampFyiDpijTKAv8
         /W7HGkivdTysN1LJPI37QYXFVt7MoIy8vr32mVwiikIGT5TShPep84lsKXIe83ikvOTQ
         AUGQ==
X-Gm-Message-State: AO0yUKV8Tj7gYXITMNwKLLe30AizLdFIBq8APLQ72j5WWT0HkU+wXE2x
        tOjMvXSejDDTSKn/+LDPBWQNASdwzl8=
X-Google-Smtp-Source: AK7set9octPdMVxabzPX5Xjv5JGsQQNAqzS8B0vcF3uPqA9HbuMb6GESZUgQCtJJN974366KS6joLg==
X-Received: by 2002:ac8:7f4e:0:b0:3bf:bbcd:c3b0 with SMTP id g14-20020ac87f4e000000b003bfbbcdc3b0mr8717475qtk.41.1677940302681;
        Sat, 04 Mar 2023 06:31:42 -0800 (PST)
Received: from [172.17.0.2] ([40.75.74.32])
        by smtp.gmail.com with ESMTPSA id t14-20020a37aa0e000000b006bb82221013sm3855899qke.0.2023.03.04.06.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 06:31:42 -0800 (PST)
Message-ID: <6403564e.370a0220.c856f.eca3@mx.google.com>
Date:   Sat, 04 Mar 2023 06:31:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4967947742494391588=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lm0963hack@gmail.com
Subject: RE: [v2,1/1] Bluetooth: fix race condition in hci_cmd_sync_clear
In-Reply-To: <20230304135035.6232-1-lm0963hack@gmail.com>
References: <20230304135035.6232-1-lm0963hack@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4967947742494391588==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=726623

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.28 seconds
CheckAllWarning               PASS      34.94 seconds
CheckSparse                   PASS      38.81 seconds
CheckSmatch                   PASS      108.58 seconds
BuildKernel32                 PASS      30.43 seconds
TestRunnerSetup               PASS      436.74 seconds
TestRunner_l2cap-tester       PASS      16.14 seconds
TestRunner_iso-tester         PASS      16.70 seconds
TestRunner_bnep-tester        PASS      5.41 seconds
TestRunner_mgmt-tester        PASS      108.12 seconds
TestRunner_rfcomm-tester      PASS      8.56 seconds
TestRunner_sco-tester         PASS      7.89 seconds
TestRunner_ioctl-tester       PASS      9.25 seconds
TestRunner_mesh-tester        PASS      6.80 seconds
TestRunner_smp-tester         PASS      7.80 seconds
TestRunner_userchan-tester    PASS      5.63 seconds
IncrementalBuild              PASS      28.51 seconds



---
Regards,
Linux Bluetooth


--===============4967947742494391588==--
