Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39945C77B73
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Apr 2023 13:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232728AbjDXNh0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Apr 2023 09:37:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjDXNhL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Apr 2023 09:37:11 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A1E9767
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Apr 2023 06:36:27 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-541f4ee6f89so1610295eaf.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Apr 2023 06:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682343386; x=1684935386;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PIRT6x093PKP52mk0IIh3s1wFYOaZB1UNMIVLeSKQh4=;
        b=h7DXkIv5ZM+ejs3p9hX6rEgduN41E4eQpPseqN2rma/2PGEF/YL2cIjfa6OsevS499
         0C+5nH+f/DuW3+HGWMaSU9IY8Av0rVchgXNTaToM00VTbJFCbJyCauVSd5pMwKByimUm
         pLGw6f9cMsxepK4IAYK9X54R0tr8FF+Wm3RMb/LgID9crcn2Ve1x9UE4ZXTYkVkCZg00
         vl72VCFjzOCnO1lGcCDz9w0lETUgjgYFMkvk1WYBY9NWveim2W14PuA3wKCHgDxeAj4a
         lRpIM5Dn9zR2cBhj5mftZB8ewKT5SYlE8cLcGBx+Xe44LpO8zS9o5QxmlBxkwoMrbKpJ
         Z/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682343386; x=1684935386;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PIRT6x093PKP52mk0IIh3s1wFYOaZB1UNMIVLeSKQh4=;
        b=DV5WMju9kF3CAjpWiSPetKIjitVbT0DwyxQS8s3g+NYFvtgHQvgdAtnVchcJCYMmSI
         vd0eulR3GfIZaI5Bp4B1Tg59eHEkcEbibLKMDk7UqQzQ7z8FQsPL2fNdja5joPPbdh+q
         A11I2EKWognxjIiQU1WtA7szUfkcyFkcIiyntt+4+d2hR9B9uMBqYGboW4H94K1w+rtx
         RC6a3MGpzgrYA3YY0Ia9MUTXGhG1eYaYQS61apiyHPK2/Y0fhZb+TF1HsyeFF6XA2hkb
         YcB17oT8tGhZzXNo5q6ZKivmNRurJzCZm4M1DaFBcCXHLReXFO8rY6tbT16Kt3VG2Eyt
         pjxg==
X-Gm-Message-State: AAQBX9dJoIdrme7bS6bGwrS96KvDJ5XOEOWYicGaRDybs2ddc5KvW2D9
        DMumZffdVNwuBt/qd1S8/h7iRLQmjK0=
X-Google-Smtp-Source: AKy350ZdvB09Rn9lkn0LgylQ9nGEcXkAq2Uu8kAyGqDw2tCq4bgXEoyoDx18dYgajDji3jLd1nhb9w==
X-Received: by 2002:a4a:e715:0:b0:547:6a95:2d79 with SMTP id y21-20020a4ae715000000b005476a952d79mr3903502oou.1.1682343386370;
        Mon, 24 Apr 2023 06:36:26 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.171.55])
        by smtp.gmail.com with ESMTPSA id s129-20020a4a5187000000b005252e5b6604sm4860583ooa.36.2023.04.24.06.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 06:36:26 -0700 (PDT)
Message-ID: <644685da.4a0a0220.27052.33fb@mx.google.com>
Date:   Mon, 24 Apr 2023 06:36:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4075841095069294893=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, johan+linaro@kernel.org
Subject: RE: Bluetooth: fix debugfs registration
In-Reply-To: <20230424124852.12625-2-johan+linaro@kernel.org>
References: <20230424124852.12625-2-johan+linaro@kernel.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4075841095069294893==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=742711

---Test result---

Test Summary:
CheckPatch                    FAIL      1.78 seconds
GitLint                       FAIL      0.88 seconds
SubjectPrefix                 PASS      0.20 seconds
BuildKernel                   PASS      30.05 seconds
CheckAllWarning               PASS      35.30 seconds
CheckSparse                   PASS      41.82 seconds
CheckSmatch                   PASS      100.62 seconds
BuildKernel32                 PASS      30.81 seconds
TestRunnerSetup               PASS      451.65 seconds
TestRunner_l2cap-tester       PASS      16.97 seconds
TestRunner_iso-tester         PASS      20.91 seconds
TestRunner_bnep-tester        PASS      5.13 seconds
TestRunner_mgmt-tester        PASS      110.17 seconds
TestRunner_rfcomm-tester      PASS      8.35 seconds
TestRunner_sco-tester         PASS      7.75 seconds
TestRunner_ioctl-tester       PASS      9.15 seconds
TestRunner_mesh-tester        PASS      6.65 seconds
TestRunner_smp-tester         PASS      7.59 seconds
TestRunner_userchan-tester    PASS      5.46 seconds
IncrementalBuild              PASS      33.05 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/2] Bluetooth: fix debugfs registration
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#81: 
	debugfs: File 'quirk_simultaneous_discovery' in directory 'hci0' already present!

total: 0 errors, 1 warnings, 0 checks, 16 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13222096.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/2] Bluetooth: fix debugfs registration

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
12: B3 Line contains hard tab characters (\t): "	debugfs: File 'features' in directory 'hci0' already present!"
13: B3 Line contains hard tab characters (\t): "	debugfs: File 'manufacturer' in directory 'hci0' already present!"
14: B3 Line contains hard tab characters (\t): "	debugfs: File 'hci_version' in directory 'hci0' already present!"
15: B3 Line contains hard tab characters (\t): "	..."
16: B1 Line exceeds max length (82>80): "	debugfs: File 'quirk_simultaneous_discovery' in directory 'hci0' already present!"
16: B3 Line contains hard tab characters (\t): "	debugfs: File 'quirk_simultaneous_discovery' in directory 'hci0' already present!"
[2/2] Bluetooth: hci_qca: fix debugfs registration

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
10: B3 Line contains hard tab characters (\t): "	debugfs: Directory 'ibs' with parent 'hci0' already present!"
15: B3 Line contains hard tab characters (\t): "Cc: stable@vger.kernel.org	# 4.20"


---
Regards,
Linux Bluetooth


--===============4075841095069294893==--
