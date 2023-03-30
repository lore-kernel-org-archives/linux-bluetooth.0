Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9547C7619A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 22:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjC3WfT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 18:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjC3WfS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 18:35:18 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89139CC36
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:35:17 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p13-20020a17090a284d00b0023d2e945aebso7328468pjf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 15:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680215717;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kiqTa41MPraPy7GioPrXdcySruS43GWWP/WJhcbSPOY=;
        b=fFVlH9kJJQbJ7rBJbMkhZo9jBJDsR/NmrIm+mtlgwymNnInKhcvPbKeVkS3wBRkIe+
         8He35TSlp0vN5moMuOq8tbyLOYBJkgcWQV1pOjd6nQukFS8zF7OOuQtYj8u/kc2e7QYU
         m21s14tnIGjGkL3cd4TrSP3m5jxUYdOVdIVnUUBRPPpMensfMxQaxHspP7+S+e9bcvCf
         0OiaSdAIqXYABAkOYiwrVMs2kA1K+79Y0weOwA9JcW1ykkwoIxHJKSPDCdDvKAM1HqJk
         1LVRI5YI5Y3mXbP1QYwVUUyM9IIm3AtjBks5Kw3NSXYfmip3PUUBS9AyBS7T/wJn4NLj
         PG3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680215717;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kiqTa41MPraPy7GioPrXdcySruS43GWWP/WJhcbSPOY=;
        b=O3afPZ91hChcdcv0XMBNX/0GtiU/yDQxXjvQQZxjb/ESBN1Dl5v1KCw/eIe0+Bbf3V
         jSCicRluLHJfokk4ojqOf0dzv0A+WgibPg2uVldPAw8iE8SF0FgSCMQJEmo3ZBBda+lu
         5zmCvN3xDziErEo4te9bbXaM+Qm2KuhKYmldK1OfXwMON0DsA81x/34GAYpdO/lFPug4
         5J7YrAyT4lJBoKV9WvaW+MZYZy1kmkjZyGi++FZmmUx0EMxDOkoBYprt9D9XnaiLNt2Y
         v3/srIjM2jGjYT8T3+k+lmcQtL9O3moYQM959Mh7O9M+rnzqlOhsyiYryo3XbAD9aTOE
         qPxw==
X-Gm-Message-State: AAQBX9cVBm0K39cT2cw84NlSrIOza2oFY4/2U8d3H1c9EQAX8U+/boLM
        pQtvKOquEqnPEqZzfTP3UEglnfY7dew=
X-Google-Smtp-Source: AKy350agrcXtjFpKB3ebuz7Rx6Kfj8YDSqhAqyyaA2cwT+r8Z1oWqV6dG0N7z0WRpiNh748W0af/fA==
X-Received: by 2002:a17:903:6c4:b0:1a2:94bb:e104 with SMTP id kj4-20020a17090306c400b001a294bbe104mr2122253plb.39.1680215716773;
        Thu, 30 Mar 2023 15:35:16 -0700 (PDT)
Received: from [172.17.0.2] ([13.73.36.244])
        by smtp.gmail.com with ESMTPSA id az3-20020a170902a58300b001a281063ab4sm194389plb.233.2023.03.30.15.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 15:35:16 -0700 (PDT)
Message-ID: <64260ea4.170a0220.85086.0c37@mx.google.com>
Date:   Thu, 30 Mar 2023 15:35:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7154400036246408784=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/2] Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm
In-Reply-To: <20230330220332.1035910-2-luiz.dentz@gmail.com>
References: <20230330220332.1035910-2-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7154400036246408784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=735600

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       FAIL      0.60 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      37.70 seconds
CheckAllWarning               PASS      40.95 seconds
CheckSparse                   WARNING   45.92 seconds
CheckSmatch                   WARNING   125.20 seconds
BuildKernel32                 PASS      36.44 seconds
TestRunnerSetup               PASS      513.59 seconds
TestRunner_l2cap-tester       PASS      17.98 seconds
TestRunner_iso-tester         PASS      18.34 seconds
TestRunner_bnep-tester        PASS      6.32 seconds
TestRunner_mgmt-tester        PASS      121.86 seconds
TestRunner_rfcomm-tester      PASS      9.78 seconds
TestRunner_sco-tester         PASS      8.97 seconds
TestRunner_ioctl-tester       PASS      10.44 seconds
TestRunner_mesh-tester        PASS      7.75 seconds
TestRunner_smp-tester         PASS      8.86 seconds
TestRunner_userchan-tester    PASS      6.47 seconds
IncrementalBuild              PASS      34.31 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/2] Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (81>80): "[1/2] Bluetooth: SCO: Fix possible circular locking dependency on sco_connect_cfm"
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:149:35: warning: array of flexible structures
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/sco.c: note: in included file:./include/net/bluetooth/hci_core.h:149:35: warning: array of flexible structures


---
Regards,
Linux Bluetooth


--===============7154400036246408784==--
