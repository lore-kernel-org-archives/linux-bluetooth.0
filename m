Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD6E7C761AF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 06:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjC3Gg3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 02:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjC3Gg3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 02:36:29 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBB2526F
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 23:36:27 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id s12so13898953qtx.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Mar 2023 23:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680158186;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LCQRjS8UA/MdG3F2J94zjUyl6RgjIlt9B915Joo0oaA=;
        b=klxQ9KovTrTF3t9TuPJ85eRavKk83/JZcprm25zUgYTC2EZ/RLHB5zn9IDhZM5LlwW
         0fSKqEAlyoAUpAE/PQj9AkytTlMfMZTJ4DYkRDxEKZ6xGdLZY4ln3nL06Tefetdy6gSF
         o2kworrFtDeB2Bcv+cVSDj9hLhW1cVtmXU5T5ftkhiJqh8U0eBYYbouTXbM8qOaqBRVP
         5REJ+OEK1QeZSRqFJFPlpadUw74MFKaABMxnT3rEjniMJujgZ78gVtw2ffOuW/I7dPw+
         11oIjnrqpOCIYpU2Cz5XcnE1XSYfyEplAmxscAMg1BU3ET/ZcqanHSoL5EBReCbFThoc
         Plfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680158186;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LCQRjS8UA/MdG3F2J94zjUyl6RgjIlt9B915Joo0oaA=;
        b=EU0+BDlYX9JzCWLwIThgmohAlRNLCUoJUPHO8RqJU+ZVvZO9uV/N3vRiPmC2tK9yky
         88pz85BeHjvU/AfHR98/ZCYEK/T9Dm1Hd4B+mRrOj6DojlI3qCmaEtfaaDi6rN5zj0hg
         2uef3UG0CFhEf9V4VPmzxMh6dBAmbmGlJqtINZhtIGsj9WqjwaJUCivo/GxatulLmoAv
         LXCxLi6fsv/yXM4TDKnRlCVmSn/7lnnA1X1B60DGAvxMHOCp0SJ9JqgVkuyDTg6rHsM0
         LIYfIRo/hxYj22g3VDK06spp0WE8ckJb/7vaFBws1JvmtNRYhx+ChqSSS6SGbljmeYka
         VWmQ==
X-Gm-Message-State: AO0yUKWI+AmPhSR9NmDIPu0szlVEyjyeCebjNSDhVcSo1cDhR8XB72H+
        1PSAmU6EzNjsCaTrIUND5YP66mqgaRA=
X-Google-Smtp-Source: AK7set/MQL1b/GfJvcNX4lB8iUmAAyQxygRM2x0BrEDXIzJzaFkWquoMrqvtp28JCJE2DPSbYB4CQQ==
X-Received: by 2002:a05:622a:1195:b0:3e4:9f9a:54c5 with SMTP id m21-20020a05622a119500b003e49f9a54c5mr40017712qtk.54.1680158186765;
        Wed, 29 Mar 2023 23:36:26 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.193.179])
        by smtp.gmail.com with ESMTPSA id w23-20020ac87197000000b003e4dab0776esm4109523qto.40.2023.03.29.23.36.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 23:36:26 -0700 (PDT)
Message-ID: <64252dea.c80a0220.2ab0f.051f@mx.google.com>
Date:   Wed, 29 Mar 2023 23:36:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7516129693261468160=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [v12,1/4] Bluetooth: Add support for hci devcoredump
In-Reply-To: <20230329230447.v12.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
References: <20230329230447.v12.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7516129693261468160==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=735223

---Test result---

Test Summary:
CheckPatch                    FAIL      5.20 seconds
GitLint                       PASS      1.33 seconds
SubjectPrefix                 PASS      0.49 seconds
BuildKernel                   PASS      32.04 seconds
CheckAllWarning               PASS      34.89 seconds
CheckSparse                   PASS      40.08 seconds
CheckSmatch                   PASS      108.57 seconds
BuildKernel32                 PASS      30.79 seconds
TestRunnerSetup               PASS      438.85 seconds
TestRunner_l2cap-tester       PASS      16.13 seconds
TestRunner_iso-tester         PASS      16.03 seconds
TestRunner_bnep-tester        PASS      5.28 seconds
TestRunner_mgmt-tester        PASS      105.46 seconds
TestRunner_rfcomm-tester      PASS      8.45 seconds
TestRunner_sco-tester         PASS      7.76 seconds
TestRunner_ioctl-tester       PASS      9.06 seconds
TestRunner_mesh-tester        PASS      6.62 seconds
TestRunner_smp-tester         PASS      7.68 seconds
TestRunner_userchan-tester    PASS      5.49 seconds
IncrementalBuild              PASS      45.71 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v12,1/4] Bluetooth: Add support for hci devcoredump
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#167: 
new file mode 100644

total: 0 errors, 1 warnings, 0 checks, 706 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13193418.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7516129693261468160==--
