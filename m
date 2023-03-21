Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389D6C6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Mar 2023 12:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbjCUMrJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Mar 2023 08:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjCUMrH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Mar 2023 08:47:07 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439283E091
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 05:46:56 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bn14so1010644pgb.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 05:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679402815;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2A8HlPFsgVZN8ayb8w1LMXH4Fw4pjJDq8/ZZkU4dLBI=;
        b=O7gnRcNkf9LSRKMWbjT2sB9NosBonU1XrMNkv6csNmxOaLsgWgnxXJQxgEvWd3HTPK
         EtQ/SNt33eBZZ2lsFbHXwqm197pmz2yEK030q6iqgPz4z1zqbuPjVQ61anYzInySLkX9
         M3NSBhvnyD0mKEjQ+7mzbx108Wqmhtz2OcZSfOJVrdYR6E2fNnlG6DHYn20QDjqlwaLT
         m3P9ga+c0vMRcsC8OaqY+FzrnO8EE7zaiEkOf1ZnbxqF8DQVX9q+Tks896EOIFklVp6I
         6hwm6PUKUPy8jCOccUVUr2rl0Ee2zMamOznRiR74yPrgBS6QuNZ1i9wlQGfPqK4fYW1l
         u3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679402815;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2A8HlPFsgVZN8ayb8w1LMXH4Fw4pjJDq8/ZZkU4dLBI=;
        b=pvSObKXeJ+hg5BTgApMqX8lVAYuCidW68KTW6r8m5PuVskQneVyqN7ZDf6HOOKKb8h
         Q8kgO2V4WSPUYIdOE+aHrWmvWCJPPk2/rwY33VbNFu/R9Mkqn8EWpa+FQE0BGI/2LtoF
         qAHJagnQzI32J17wwiAn9LAgEkk+Ur36NfVLLuutWwR9xwQ40OHe8dgyv7Gm7ZoFBBkH
         bdxw3lKKUAtDw4zuiyEoxPZaGBY8hrGhJMT9TCwJJ/yzvSSM6n4t0Bsz67CUl9aubfYE
         m3bG23UHG5jo6kC8L4GWdimp58NrS5qolKcu/z71oJ3uqJWN5OywPhUmPjB0yip2chGF
         nH6g==
X-Gm-Message-State: AO0yUKUTO+7abnuQa8CfnQUA9wrIehPJ0DxCgWHkXbMmiQDNt7PTVHe4
        uzFqE9ZTtS8MEF9qgjnmgSF8TtArAec=
X-Google-Smtp-Source: AK7set96WtS6lXr5WHW1fKygn6Y7/y8bVEHH/CVPPak3jJwoGk4lgPobYC4Kq+qxFQyWOOv9bAI8gQ==
X-Received: by 2002:aa7:9578:0:b0:627:f64d:b94e with SMTP id x24-20020aa79578000000b00627f64db94emr2054855pfq.20.1679402815281;
        Tue, 21 Mar 2023 05:46:55 -0700 (PDT)
Received: from [172.17.0.2] ([13.64.213.128])
        by smtp.gmail.com with ESMTPSA id n26-20020aa78a5a000000b006260e5bdd81sm7949242pfa.45.2023.03.21.05.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 05:46:54 -0700 (PDT)
Message-ID: <6419a73e.a70a0220.7e2c0.dd4e@mx.google.com>
Date:   Tue, 21 Mar 2023 05:46:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7303440327487604184=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: [1/1] Bluetooth: btrtl: check for NULL in btrtl_set_quirks()
In-Reply-To: <20230321114826.3544-1-max.chou@realtek.com>
References: <20230321114826.3544-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7303440327487604184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=732307

---Test result---

Test Summary:
CheckPatch                    PASS      0.61 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      42.76 seconds
CheckAllWarning               PASS      46.48 seconds
CheckSparse                   WARNING   51.75 seconds
CheckSmatch                   WARNING   140.61 seconds
BuildKernel32                 PASS      41.67 seconds
TestRunnerSetup               PASS      598.45 seconds
TestRunner_l2cap-tester       PASS      21.26 seconds
TestRunner_iso-tester         PASS      23.67 seconds
TestRunner_bnep-tester        PASS      7.61 seconds
TestRunner_mgmt-tester        PASS      142.76 seconds
TestRunner_rfcomm-tester      PASS      11.92 seconds
TestRunner_sco-tester         PASS      10.86 seconds
TestRunner_ioctl-tester       PASS      13.19 seconds
TestRunner_mesh-tester        PASS      9.47 seconds
TestRunner_smp-tester         PASS      10.67 seconds
TestRunner_userchan-tester    PASS      8.01 seconds
IncrementalBuild              PASS      38.68 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:52:45: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:52:45: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============7303440327487604184==--
