Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21D93CA0EC3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 07:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbjILHCc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 03:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjILHCX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 03:02:23 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C7A10CE
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 00:02:19 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-770ef4d36f2so203974385a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Sep 2023 00:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694502139; x=1695106939; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/vcEjTZcuMXR9yHtnqJp9Cc/8vXBd+Lon31zCo04fBI=;
        b=HJLt9pzEg10rA8y+R0RnclS7r/sPJDt7klAGXsCC281DkFbmCBUXIbp+AJOGNQB7zy
         A31/6I3WISVwk2DASiUU4JpcHIhxcNoyzxNfRBZRmaqb3/G/xQ/qgxAZYoQp5mzkFt1a
         Pp2ZpYcNHSuFdl4jnStXSRa7eQ2oq5gsJPh3ahyIHwYS98LNZvx9nrGEMdQfW8Cb2eVG
         +TDMJruwtl4ChFrcquivqsFoCFY7gq3mzvjRcul9fcPKlJiI/Iv8b7jnuy4HZa0YxBOL
         6lvHoufeiGdKNz+rUdZDhpnc9oLMCc/8sZF+dEeFOpWrRT2DG88oRDpjoV04MKq55GF2
         VBIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502139; x=1695106939;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/vcEjTZcuMXR9yHtnqJp9Cc/8vXBd+Lon31zCo04fBI=;
        b=N/4U0mmWC7xdtYs2UUvQ3EyUsHqGKSsh9M8OwXl5LbzApCEwwDG7fsv7YJQgKHDgKx
         l5pA7VrwDRVtFjwBqGjKrJYtTaKkyLC0+32Mn3jxqU+XUuaNy5ncTLJ/mYaoYWzrPGwX
         jbyObO0jD1OVtj4xymD2ZEE3xxM7qxlkpERQBPTwtjQTZQ+8SEE1uF5RCNX/31WVXMUh
         LBulaPjdPjjzyZbcxHzSSlhvcLwdAjkeu3SmZLozYs3SAmKY+xTC/xdfB/ufGC4wzSVS
         e8EvoDSZRyTserjUEU5KLXbyLb162PyDaKiJEKXeOINsrSaZh7aXIqkKn8KF3RBLYj3T
         pS3A==
X-Gm-Message-State: AOJu0YxydGglH0RNeDUrtYSvPlNqzHTb3GrouOS/DDSt61Kie4DG+2Cd
        yCfp3lrBHGvoBIW8UNrGpcz1N/OF15KwGA==
X-Google-Smtp-Source: AGHT+IHJ+uuKIFIjqU19JkYbIgIWTTmpD/jBVFT96rRy/5qsetuskwFln4qdgeeIACxRZ22oN1b+Vw==
X-Received: by 2002:a05:620a:2846:b0:76c:b3cb:a9e5 with SMTP id h6-20020a05620a284600b0076cb3cba9e5mr14013996qkp.51.1694502138860;
        Tue, 12 Sep 2023 00:02:18 -0700 (PDT)
Received: from [172.17.0.2] ([52.226.123.227])
        by smtp.gmail.com with ESMTPSA id pi27-20020a05620a379b00b0076ee82f7726sm3001359qkn.132.2023.09.12.00.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:02:18 -0700 (PDT)
Message-ID: <65000cfa.050a0220.344dc.c0e0@mx.google.com>
Date:   Tue, 12 Sep 2023 00:02:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3998109539648997676=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: [v3,1/1] Bluetooth: ISO: Set CIS bit only for devices with CIS support
In-Reply-To: <20230912061736.1181699-2-vlad.pruteanu@nxp.com>
References: <20230912061736.1181699-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3998109539648997676==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=783271

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       FAIL      0.58 seconds
SubjectPrefix                 PASS      1.10 seconds
BuildKernel                   PASS      33.73 seconds
CheckAllWarning               PASS      36.94 seconds
CheckSparse                   PASS      41.98 seconds
CheckSmatch                   PASS      114.21 seconds
BuildKernel32                 PASS      32.44 seconds
TestRunnerSetup               PASS      494.07 seconds
TestRunner_l2cap-tester       PASS      28.52 seconds
TestRunner_iso-tester         PASS      51.49 seconds
TestRunner_bnep-tester        PASS      11.20 seconds
TestRunner_mgmt-tester        PASS      224.21 seconds
TestRunner_rfcomm-tester      PASS      17.49 seconds
TestRunner_sco-tester         PASS      20.52 seconds
TestRunner_ioctl-tester       PASS      19.08 seconds
TestRunner_mesh-tester        PASS      14.06 seconds
TestRunner_smp-tester         PASS      15.03 seconds
TestRunner_userchan-tester    PASS      11.81 seconds
IncrementalBuild              PASS      30.97 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v3,1/1] Bluetooth: ISO: Set CIS bit only for devices with CIS support

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
6: B2 Line has trailing whitespace: "or BIS support. In reality, devices that support BIS may not allow that "


---
Regards,
Linux Bluetooth


--===============3998109539648997676==--
