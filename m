Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B63EC874B
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 19:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237896AbjIGTFm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 15:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjIGTFk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 15:05:40 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5177492
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 12:05:37 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76dc77fd024so75993585a.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Sep 2023 12:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694113536; x=1694718336; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HfU4tv1H9RXqwmOwcSVZ1rcooj2a3eyFS6wrMHIv0wE=;
        b=RaKPOJhc/aAD/SkYMqxz45jBp97mEiYxi+0OmlE4bWJ87lYm7nBUwnowz+49OXDKNw
         d2wv5tksSHQ7ywYQeZbo/jOYS54C7o9k+rzuPSV59/gG5DyYHsUrnYPpFAE6ZGgF/9H2
         zV/jSTeTT/oWB+rQ3Zl48BXACGvJJanHGSC8Q+uLmPJgFPNDtCt4/irPOLGSM4ziIG74
         yRvSqAFgqyXm4CNcbCXgM+u5l5y/l71VivRt2GAnyDDCNU5LUItbAbkItkW4Ck2veNyZ
         Fzgt0aoRT+8SdWD88RRWxH6RsO2zHjIJs9g0w1rBaqbwIZR8MWFF6o3thCbMol9kQdW4
         i8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694113536; x=1694718336;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfU4tv1H9RXqwmOwcSVZ1rcooj2a3eyFS6wrMHIv0wE=;
        b=aKxXAzxBvkyhvlVopwhAevETXAhtWKKgDA/OGjV2QGmSf7hekWvmLKN2Xc+y6I7BC+
         +78iDwBnfAM4cwRu7A39UtvzzjZhyuJLfYTH5eT59Cq86ybsPnqFLPqS+D1abCNJ188i
         TVBKNJdoNNRoj7MlGybNIqtw0Y5Y1DVdncGkWsmbnMGEdJ1KkzzI2kGXKewfYt9CoPJL
         hhzLk/CjUyTuI+YWjlwU0UjmJLCVdMJnhK5u6mtQSRACu9sg+Ql28rn03us1WILJRo/y
         +IRAVnu9ZxvTWU/8HmFi6Y/KwVXs+0hulqnh5nWTod6KMC2NuTHTGBYhA4/WwlwRDa+2
         fuUA==
X-Gm-Message-State: AOJu0YwxaOEb/GHsSlS49FEAX8c/55gM+3dV1qZ7vcXjQyyJHerO3QpP
        cnUaD09CVf9L7tm9p99rJxXas9UUTSc=
X-Google-Smtp-Source: AGHT+IFn4lDYhmbsX9LMFtetoXXXc8zgq5GymsAOb1S8xd4lzlAAtoKTHKABNj5ojkaZc8iy80lXHQ==
X-Received: by 2002:a05:620a:2218:b0:76f:1dd4:101f with SMTP id m24-20020a05620a221800b0076f1dd4101fmr263842qkh.39.1694113536318;
        Thu, 07 Sep 2023 12:05:36 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.8.243])
        by smtp.gmail.com with ESMTPSA id h19-20020ac85493000000b003f6ac526568sm60081qtq.39.2023.09.07.12.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 12:05:36 -0700 (PDT)
Message-ID: <64fa1f00.c80a0220.d9733.0568@mx.google.com>
Date:   Thu, 07 Sep 2023 12:05:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3027839876065489981=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, william.xuanziyang@huawei.com
Subject: RE: Bluetooth: Fix sleeping function called from invalid context in hci_cmd_sync_submit()
In-Reply-To: <20230907122234.146449-1-william.xuanziyang@huawei.com>
References: <20230907122234.146449-1-william.xuanziyang@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3027839876065489981==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=782320

---Test result---

Test Summary:
CheckPatch                    PASS      1.26 seconds
GitLint                       FAIL      0.69 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      40.08 seconds
CheckAllWarning               PASS      42.91 seconds
CheckSparse                   PASS      49.03 seconds
CheckSmatch                   PASS      132.91 seconds
BuildKernel32                 PASS      38.10 seconds
TestRunnerSetup               PASS      572.79 seconds
TestRunner_l2cap-tester       PASS      31.53 seconds
TestRunner_iso-tester         PASS      73.02 seconds
TestRunner_bnep-tester        PASS      12.11 seconds
TestRunner_mgmt-tester        PASS      247.10 seconds
TestRunner_rfcomm-tester      PASS      20.03 seconds
TestRunner_sco-tester         PASS      22.58 seconds
TestRunner_ioctl-tester       PASS      21.66 seconds
TestRunner_mesh-tester        PASS      16.07 seconds
TestRunner_smp-tester         PASS      16.94 seconds
TestRunner_userchan-tester    PASS      14.02 seconds
IncrementalBuild              PASS      34.24 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Fix sleeping function called from invalid context in hci_cmd_sync_submit()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (85>80): "Bluetooth: Fix sleeping function called from invalid context in hci_cmd_sync_submit()"


---
Regards,
Linux Bluetooth


--===============3027839876065489981==--
