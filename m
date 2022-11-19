Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90BB5C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 03:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232478AbiKSD71 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 22:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbiKSD7I (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 22:59:08 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C28252A4
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 19:56:06 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id c15so4386076qtw.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 19:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HxONL+zskNjFtN/qbju46leg4qkAclD8bk3+fqwae0k=;
        b=brfZVHsmYxNPek27o6f5a4Ec3iiQ1sdonJ10h8DM2RTaNmkUUUt//GyxAKYRVNupnU
         wxZL/GTyoWF9Qs961lVtb8VwcCKlVkxwWrgH/t+a2zHLF+lRhP12DQODNPC8cj6O//C6
         d+y1TabnLi8SCsGTcaIumQlN1xG66e4o1EpYU7pY/jRzMiwGRjeUQ/KyEv/c706lysQC
         BQuz2mq8jzZt20Q7DrnSg/LjiL87YMjBB9blx5J+02O2mv4ncFKbO8GPyMLx7eRQqoqQ
         cubB175uUftQYB9Cs6btfpcfnBhjsxekZkKpncQzQ0Gp4CkpBQgU0haoCmvTjrmufj9F
         XXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxONL+zskNjFtN/qbju46leg4qkAclD8bk3+fqwae0k=;
        b=k3cbrjm6QrHqaPkz4z/9+o807+4pZ+IyKvukVyocssSeea8oUyQwsymgKUPYuceiw6
         wo4abYlpk7JkmJd5pLzV/vLV+ljfXcy7ZJmgDM1QFYt0xyUOVTkomPPznphRCQ7MmLGI
         2YV+mXrl5pWdkfIWIdJY+EU5FkGfPczBv9WUy07Dbl4pG+z/M+dXtULWFG9lbs59oNlt
         nVmWfmjWb9lLJOxQ0a9NUjy/RRbdOG0bBL1RGlN4/aUaR0qRPIQwWgJDv1v8dfs5tGny
         3finUk289vshw84UgQMcE7XPqaiudVcDJ/wvvSV1dOMDyJFr1VY3S/pKWMZ+ZXMzVsBb
         Q/CQ==
X-Gm-Message-State: ANoB5pm75ar3DFb/DdZC7KtmCd4uT3Ck7ikGsU/qPnhd41jK8MAQp83w
        scwOqEOnl9tHvQGpco9a4JFDkLXxmfbnOw==
X-Google-Smtp-Source: AA0mqf4VKCoj6yv6SxtfOjVRzFmSIpPeNJVBN/fN2p/Kv+z9jj4DTtm0XM2jQCWr7lFMDuVj8eWoCg==
X-Received: by 2002:ac8:4987:0:b0:3a5:274c:611e with SMTP id f7-20020ac84987000000b003a5274c611emr9382915qtq.143.1668830165771;
        Fri, 18 Nov 2022 19:56:05 -0800 (PST)
Received: from [172.17.0.2] ([4.236.134.220])
        by smtp.gmail.com with ESMTPSA id s15-20020a05620a29cf00b006fbbffd08f9sm3732009qkp.87.2022.11.18.19.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:56:05 -0800 (PST)
Message-ID: <637853d5.050a0220.ebf28.224e@mx.google.com>
Date:   Fri, 18 Nov 2022 19:56:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1067738585524902159=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [RFC] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
In-Reply-To: <20221031220205.91975-1-brian.gix@intel.com>
References: <20221031220205.91975-1-brian.gix@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1067738585524902159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690652

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.65 seconds
BuildKernel32                 PASS      30.66 seconds
TestRunnerSetup               PASS      425.34 seconds
TestRunner_l2cap-tester       PASS      16.09 seconds
TestRunner_iso-tester         PASS      15.58 seconds
TestRunner_bnep-tester        PASS      5.55 seconds
TestRunner_mgmt-tester        PASS      106.91 seconds
TestRunner_rfcomm-tester      PASS      9.47 seconds
TestRunner_sco-tester         PASS      8.97 seconds
TestRunner_ioctl-tester       PASS      10.18 seconds
TestRunner_mesh-tester        PASS      7.08 seconds
TestRunner_smp-tester         PASS      8.77 seconds
TestRunner_userchan-tester    PASS      5.83 seconds
IncrementalBuild              PASS      31.51 seconds



---
Regards,
Linux Bluetooth


--===============1067738585524902159==--
