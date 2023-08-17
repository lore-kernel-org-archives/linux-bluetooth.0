Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F94FC2FC14
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 12:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350932AbjHQMod (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 08:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350942AbjHQMoE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 08:44:04 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342BB2D7E
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 05:43:58 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-1bff2d2c141so4483231fac.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 05:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692276237; x=1692881037;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SBu6ULX5H2M5lH1W/vbA9CJyYGxndLSHiO8OwYjPATs=;
        b=SZeyZDl0X559mrZyq9u5daR6ota22RFugnfNdtEM3oXIR4yWs9i8U4IV8DstOdCLrf
         HAA7S9ElA4EfqAH13/zxGHfH/PPHZFXU3kSElwU3zsVqR8Jj8fzMV7UZf9S7Rtj+N0M/
         Z9/4aTd4XuATlHJdNccRyY8Io2AGmod0rARt79VpQMTO7xWxCe3i0/js2vdeZRKhe3IZ
         ds1eMCBPECd118QqDUtGlw05SsllFsdKrrmV7heQsBDUCU7f9D7YeTaHp+xR6z64AkcB
         RAZAGudIdqNebi2Mt+Q45/fCFiciQBnyBJzABM91D+Uj5OGYPRwqMI+VWFEA815jz6/1
         Yvag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692276237; x=1692881037;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBu6ULX5H2M5lH1W/vbA9CJyYGxndLSHiO8OwYjPATs=;
        b=YNc/zzJ8iueZ4YPVr7IyTuxEDeqobENZ2Ju9PpChm65+0EKO31nZsV7LsxhVsscl0o
         9FaIQy6FH9w2z1VW9LBtO/LTJvpH2YkRNmAvOYEHXiiCUAaBJxuRM3eSNs9engjMWBQL
         n261XCbBv1ZGzPES9Hc+yTWvOhEjJv57K4qYW5fpaJjLTNn/6RhfeNd/TynvN9kddJqd
         6c9TdIIbw7cIfPKWOsrj5Mksirwdqy4abN3HT/CXpcPBeY9m6UQmx/b5VHXgKZBgU4lm
         Ea7BMaSkMwjkXy1VE0YRVrKlhwufgVxpNHoLpVJZAx9G9mTlVQCnTMWnvfOJbzdu61jP
         Cgog==
X-Gm-Message-State: AOJu0YxMpTR05w1IDBp9+G/NIRNxBqwRCSuPqyon3VQk+UycrJB0Oft6
        nk9aUOhwlSCOUqBU8ij5DTeKeTdw58w=
X-Google-Smtp-Source: AGHT+IGEbPduADTtZWVuaDwQWf61iKkqeKFf5N9jQhQQBf+keWHHSupqFysAdUZlkNtkNjWuB7vS4Q==
X-Received: by 2002:a05:6870:2406:b0:1b0:e98:163b with SMTP id n6-20020a056870240600b001b00e98163bmr5687415oap.21.1692276237194;
        Thu, 17 Aug 2023 05:43:57 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.11.82])
        by smtp.gmail.com with ESMTPSA id o5-20020a05687072c500b001bb9d01fe3dsm8534260oak.5.2023.08.17.05.43.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 05:43:57 -0700 (PDT)
Message-ID: <64de160d.050a0220.9bac9.0f0a@mx.google.com>
Date:   Thu, 17 Aug 2023 05:43:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8368408254595672110=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lokendra.singh@intel.com
Subject: RE: [v3] Bluetooth: btintel: Send new command for PPAG
In-Reply-To: <20230817114249.75827-1-lokendra.singh@intel.com>
References: <20230817114249.75827-1-lokendra.singh@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8368408254595672110==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=776954

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      33.09 seconds
CheckAllWarning               PASS      36.40 seconds
CheckSparse                   PASS      40.87 seconds
CheckSmatch                   PASS      114.62 seconds
BuildKernel32                 PASS      31.92 seconds
TestRunnerSetup               PASS      490.73 seconds
TestRunner_l2cap-tester       PASS      27.61 seconds
TestRunner_iso-tester         PASS      48.87 seconds
TestRunner_bnep-tester        PASS      10.89 seconds
TestRunner_mgmt-tester        PASS      223.91 seconds
TestRunner_rfcomm-tester      PASS      16.38 seconds
TestRunner_sco-tester         PASS      19.49 seconds
TestRunner_ioctl-tester       PASS      18.42 seconds
TestRunner_mesh-tester        PASS      13.59 seconds
TestRunner_smp-tester         PASS      14.64 seconds
TestRunner_userchan-tester    PASS      11.41 seconds
IncrementalBuild              PASS      32.62 seconds



---
Regards,
Linux Bluetooth


--===============8368408254595672110==--
