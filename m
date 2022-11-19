Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D73C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 05:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiKSFCP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 00:02:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKSFCM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 00:02:12 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D97BB9D7
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:02:11 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id a27so4420198qtw.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MB/OInE0TLInF+T1U03VUlc5ovXRYav8Db3+q8dMFEY=;
        b=Y+u2JEjeoR93Gyeo8qvB8tqI/rpNPQ39yrOHaCBOYMeAKkWgaJVavD8xNRPzB6T7Ak
         e6tcBDVRAG0NnjxgK/oJ9OOcAAliMp+3YXyUNx8Rj7Bh9PVBGXNTIeA/dcqJZTr8iGWp
         tudc2nyBkSibuPbkTx+YwHIVqYdhOWBhqA6TnVFtEuIt8OcBi3KLG38sI/BgDWbUM0CT
         vg24MgLmQveubA92xRYW5l/0CVZnw/gUOPCUFCOiiW5Xs+5cRQlM+ZTWcIkuxHRv520P
         XO2EmiW5ojlswABnvQFCvYBtzkRHVZ+9qUTuxlahfuHWe3LWKjaFFR8OqGjVXlC7oEOR
         UsIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MB/OInE0TLInF+T1U03VUlc5ovXRYav8Db3+q8dMFEY=;
        b=OtdiL03bhBVNyY6cw2J1l0upfQDmqZm4INx2/m31iSE5dQp1ZsVRo8oIyo5pIdwMBz
         E9J0JR8UofYbgiTeJUJoxED7CGjBB9NT87tFSzAIOkSFRG0Xk0a2Dd9x0UTLh23zjMBx
         xqnFW63DsbQHdLu+d4glJhlP85AuWz4mlcdf5sskOUBINHV4tmcXjOWv6EDavGArUcKm
         uK3nSiHp+yNf99e28AFrx0ag9MAAcTWoYa4tG+hQ65ZplvpaifhJa0P/aVPxA7+e0yCN
         wsKL/PLRnkd1tohAXqsa5e+O272W16SVk45zw17CmpNFbD35qR7GQjvm5Db3mueU6P4p
         eJbg==
X-Gm-Message-State: ANoB5pnuGpJu7vTES2kBkt7Q/8WaqODOwSX4m3634y+DvygwqPrcOiUC
        zJ3tz7mE4htwoRUKIISGb6yriibm+ktYQg==
X-Google-Smtp-Source: AA0mqf4EcrtclWSYKt+GtRT5vbFQhKXXCQ5Qs96TV+FdTnwzK7g/MZQj4rBq3jFzlK3WWwsc7bOE1g==
X-Received: by 2002:ac8:4808:0:b0:3a5:177d:d9cb with SMTP id g8-20020ac84808000000b003a5177dd9cbmr9648317qtq.64.1668834130724;
        Fri, 18 Nov 2022 21:02:10 -0800 (PST)
Received: from [172.17.0.2] ([20.242.108.64])
        by smtp.gmail.com with ESMTPSA id z63-20020a37b042000000b006fafaac72a6sm3734925qke.84.2022.11.18.21.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 21:02:10 -0800 (PST)
Message-ID: <63786352.370a0220.ef025.1209@mx.google.com>
Date:   Fri, 18 Nov 2022 21:02:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0315321573344635120=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Fix MSFT filter enable
In-Reply-To: <20221102175927.401091-2-brian.gix@intel.com>
References: <20221102175927.401091-2-brian.gix@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0315321573344635120==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691340

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.60 seconds
BuildKernel32                 PASS      29.72 seconds
TestRunnerSetup               PASS      418.21 seconds
TestRunner_l2cap-tester       PASS      15.66 seconds
TestRunner_iso-tester         PASS      15.01 seconds
TestRunner_bnep-tester        PASS      5.32 seconds
TestRunner_mgmt-tester        PASS      103.58 seconds
TestRunner_rfcomm-tester      PASS      9.10 seconds
TestRunner_sco-tester         PASS      8.58 seconds
TestRunner_ioctl-tester       PASS      9.73 seconds
TestRunner_mesh-tester        PASS      6.75 seconds
TestRunner_smp-tester         PASS      8.50 seconds
TestRunner_userchan-tester    PASS      5.53 seconds
IncrementalBuild              PASS      30.94 seconds



---
Regards,
Linux Bluetooth


--===============0315321573344635120==--
