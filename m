Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B27C46CA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 Sep 2023 10:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbjIRKCH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 Sep 2023 06:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241169AbjIRKBv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 Sep 2023 06:01:51 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF90130
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Sep 2023 03:01:37 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-34fcd1b9892so6390985ab.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 18 Sep 2023 03:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695031296; x=1695636096; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dpfWpHBxPHKLhD8bTAkc8G3LtIPtaIcmw4U00puKrCc=;
        b=RIG7p3SbscWKDM+JungzIhu6wLrJxQGrCLzdUDpwUtS0Hrk1RfajpV8JJh0btygfGx
         ukqewny+giLzJ9lV8yAMrNxX2aNSatV9YSkQv4lwHhMZFbDTZwegx65+PM4HzmoTUu7q
         +9IjlFPUieYraZoHH5GNg/sMaSsspYVNOieFF1n1aEtvpSWVsTmZnFMt40/W73EzKGgb
         hnnQVnwX1loZKG0JG4AyUyNgNT7IWEY0HGym1li1VqnUhyQe0q899RY9SrBMK3SmMvyC
         RfPT0QlzpCriB21hUbL7fOGlCtAt7F0vDTKpSlEy5fAUXQjghpxXxeflqD7INbP9gL2l
         kZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695031296; x=1695636096;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dpfWpHBxPHKLhD8bTAkc8G3LtIPtaIcmw4U00puKrCc=;
        b=JHVYc0EBhNnt+h9hBATSCk+b5uN4Jh50jQTsf+uEpba8cBwMDGw6mlhXiPzMYu08Q7
         I3IclTiw3bz2yxVDj9EFloS18n1eWaYlmH062hntfG4bJBEfPE8aYWxjqbvER9wLpdM5
         tesx6stq2QJCO/T46hwDWRgUVnt/64aNdIXM44VhcoP2TkCf21m3AD2pSR1eXYqKDfzr
         10IitbJTMg9+AncqnXUQDOB6Hm1nc+D+iV53f+J9WVNOK+csmGsbMvD/Vswn6iAxyfw9
         l+rDyUpTL6NOHyyRKtChzmN1e4YMYB7bxMYoPajusqYRizTrP3ZYAEQxZGSr3EaV1QPp
         DrdQ==
X-Gm-Message-State: AOJu0Yy0HZQxdQiV9QMQp5NWCVCH+CsUM5ErkfeNmpiNAU2tqU6cVfaV
        7p9uIa+o0Eh22sZgvv1NnYBO66n9phw=
X-Google-Smtp-Source: AGHT+IHZ0TrpMpvBQrrY3eZpguhw1Ok38Bpcd6Pq4eOu4Ev4xgOSwE1TMu0lFXPztsLYEDECpDaAGg==
X-Received: by 2002:a05:6e02:11aa:b0:34c:ceaf:b627 with SMTP id 10-20020a056e0211aa00b0034cceafb627mr9199322ilj.29.1695031296534;
        Mon, 18 Sep 2023 03:01:36 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.3.141])
        by smtp.gmail.com with ESMTPSA id b3-20020a920b03000000b0034f4f8e43d8sm993149ilf.36.2023.09.18.03.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 03:01:36 -0700 (PDT)
Message-ID: <65082000.920a0220.d48f7.0c1d@mx.google.com>
Date:   Mon, 18 Sep 2023 03:01:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6744616086401562018=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1] Bluetooth: Release memory allocated to store supported codecs
In-Reply-To: <20230918093517.2163899-1-kiran.k@intel.com>
References: <20230918093517.2163899-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6744616086401562018==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=785156

---Test result---

Test Summary:
CheckPatch                    PASS      0.63 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      36.67 seconds
CheckAllWarning               PASS      37.35 seconds
CheckSparse                   PASS      41.66 seconds
CheckSmatch                   PASS      115.95 seconds
BuildKernel32                 PASS      32.01 seconds
TestRunnerSetup               PASS      493.63 seconds
TestRunner_l2cap-tester       PASS      30.20 seconds
TestRunner_iso-tester         PASS      49.75 seconds
TestRunner_bnep-tester        PASS      9.83 seconds
TestRunner_mgmt-tester        PASS      211.84 seconds
TestRunner_rfcomm-tester      PASS      15.13 seconds
TestRunner_sco-tester         PASS      18.48 seconds
TestRunner_ioctl-tester       PASS      17.17 seconds
TestRunner_mesh-tester        PASS      12.75 seconds
TestRunner_smp-tester         PASS      13.56 seconds
TestRunner_userchan-tester    PASS      10.38 seconds
IncrementalBuild              PASS      31.00 seconds



---
Regards,
Linux Bluetooth


--===============6744616086401562018==--
