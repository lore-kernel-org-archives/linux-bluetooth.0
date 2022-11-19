Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCEFC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 03:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiKSDHU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 22:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiKSDHT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 22:07:19 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794B5B8FBD
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 19:07:18 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id s18so3017566qvo.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 19:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4CewA3NjB9zd7d3+6Y14RV2ILYZgDgjiHmhsD3fftB4=;
        b=payp4B0e2OopYbfY1Nvm9MHzDfkKW6L7TDDXEtDK8QLAyqBSluciJltr6AgNiSL7pt
         ekoKS+UEjIwVJR8bSqBxMnpUzfwDfs9Mu2BTcp420pvBnm6Invm4/dwZxKBcL1FAys9i
         TpKgx4hwSR0CgtmVxlg6bXAe+jscJSDordeJLrNISHaQDjuLib9GLSxcy/FjV0UMvOv+
         99mzS+lLSmEKqsyV/hez57VAPIo3uUJzBj6Y7EHAI/9KfmuI1jiAqyWokZIpNUyGmVb/
         Hxbp39sk5lo+dTRYlm/3QWBZMKn7xE1f9rHE9u4rVwjZHRXjkuUel1ApMOcDNM21xkCa
         DXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4CewA3NjB9zd7d3+6Y14RV2ILYZgDgjiHmhsD3fftB4=;
        b=ExpNaj7HddTWWMii6I/ynPlo4qHsQWGKmLIJ2S45INfL1aVoceegLWly1005D1bHba
         giK5jwmgeiizzXcRjrOK96x2a9SDX0EeX3VMoPLI7VFYUmNsf2oEe4rCHukFCqeVF9HW
         8SOU1JGsxNxV4gmCDHluH4PV6jX5ZikDx3W8GKyp3K4uY0rLClgo3lYnXhFuWqGdJdg9
         3PufVHW7mefOgQhtRTitn7M90tJCaU3O4bpVMWLYCrjxO5cYoWU+LXQshSYZuhWVQ9gr
         +o4+GGWDr/5mam2zGRfcrmaUvL85j0u33gjbLtXTld8WLg15xhFUxtGU+uXf/kpfPWLr
         LpZw==
X-Gm-Message-State: ANoB5pl9IAmxVVTP+4tnKn7eZ0FKefH/WzbIk0+OWA7eOWcgxQ93lc9M
        v0lo6W0iVP2xyEUtpEhlSZOeR9xZZxiGzw==
X-Google-Smtp-Source: AA0mqf4X0cJWvXlQy8qq/aiapK0wJnTEW85WhjEpipRusqmUFr7KrDZCprhIlrQMrN3fLvUcQ1MMpw==
X-Received: by 2002:a0c:8f02:0:b0:4bb:5e2e:c739 with SMTP id z2-20020a0c8f02000000b004bb5e2ec739mr9278540qvd.93.1668827237478;
        Fri, 18 Nov 2022 19:07:17 -0800 (PST)
Received: from [172.17.0.2] ([20.14.152.180])
        by smtp.gmail.com with ESMTPSA id ed13-20020a05620a490d00b006eeae49537bsm3486390qkb.98.2022.11.18.19.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:07:17 -0800 (PST)
Message-ID: <63784865.050a0220.1fc9d.14bd@mx.google.com>
Date:   Fri, 18 Nov 2022 19:07:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0547465688158737726=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: Bluetooth: L2CAP: Fix u8 overflow
In-Reply-To: <20221118200145.1741199-1-iam@sung-woo.kim>
References: <20221118200145.1741199-1-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0547465688158737726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=697073

---Test result---

Test Summary:
CheckPatch                    FAIL      0.87 seconds
GitLint                       FAIL      0.52 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.69 seconds
BuildKernel32                 PASS      29.78 seconds
TestRunnerSetup               PASS      417.83 seconds
TestRunner_l2cap-tester       PASS      15.73 seconds
TestRunner_iso-tester         PASS      15.03 seconds
TestRunner_bnep-tester        PASS      5.37 seconds
TestRunner_mgmt-tester        PASS      103.03 seconds
TestRunner_rfcomm-tester      PASS      9.00 seconds
TestRunner_sco-tester         PASS      8.51 seconds
TestRunner_ioctl-tester       PASS      9.72 seconds
TestRunner_mesh-tester        PASS      6.64 seconds
TestRunner_smp-tester         PASS      8.41 seconds
TestRunner_userchan-tester    PASS      5.48 seconds
IncrementalBuild              PASS      30.85 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: L2CAP: Fix u8 overflow
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#83: 
= Note: Linux version 6.1.0-rc2 (x86_64)                               0.264594

total: 0 errors, 1 warnings, 0 checks, 9 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13048756.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: L2CAP: Fix u8 overflow

20: B2 Line has trailing whitespace: "        08 00 01 00 02 01 04 00 01 10 ff ff              ............    "
23: B2 Line has trailing whitespace: "        0a 00 01 00 04 01 06 00 40 00 00 00 00 00        ........@.....  "
33: B2 Line has trailing whitespace: "        08 00 01 00 04 01 04 00 40 00 00 00              ........@...    "


---
Regards,
Linux Bluetooth


--===============0547465688158737726==--
