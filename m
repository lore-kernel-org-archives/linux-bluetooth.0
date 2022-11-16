Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218C7C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 21:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbiKPVGT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 16:06:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233519AbiKPVFt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 16:05:49 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688CE6828D
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 13:05:00 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id o13so9817796ilc.7
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 13:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S5TnVVuL6GVdlXlPnrL11DJaafpUf2KZacQxh7hJyRU=;
        b=Rrip4ywTeU9/HmJSr38uVIsAU/i5IrSbW/ApVRO+vDJoal35KllbNnCEBEEGcXs3VA
         zpy+ya0QWo5KvlwEhczec1L67EBotZnoKMx9UZR+HAu8+mPjELW7gP5e3gXGXHWJkIgU
         E/k4Yo1m6vd7cTcJKETKLYZhN/7sPp20kMMKlRtQq3ox1U2uXAglmb/K7ri5HEn+91kA
         W6vRL9bMcvgxQl79+8em7zyx8g01ShdLQXsTrwJhh+uJR9cA5Y55zXpxwCnvaAMDO0zm
         g3j28dlwjryUKJMZqXT7TImwX+g8rM++CSx77JpR3uyLZKVhaGm2wYtkUtsF86wtFRTp
         egCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5TnVVuL6GVdlXlPnrL11DJaafpUf2KZacQxh7hJyRU=;
        b=5i1qM9goewm5uZFRh/34YIhm/3BOWL4wTK6prIynk5iVwuNhG910Y3PbRmMTtntOlQ
         KkuwGeSyCekOWRBZNi7ksm3cuKwwHK6/TCPQlemDJZgLxsrj08xF1jg6R1D4BwEJx9cU
         M9+NTEHfwAdNvjbtefBwHreCjgy4RrDAegcwJpHpC/DUV8+V4DwfcMkjhu8yWbOBTG0W
         IGmCZarBappQEgJol44dpYOq907nx9uGLI1gyH7MVmRAj/obOyIGfrZhrhQ/l4XK0JnL
         TDyvvqtv9NAYMFPxKYDaapHuvwKyJ1tE3iERPLUJArBAThINepz9LQNXuS8Laj4P8UQs
         Wh/Q==
X-Gm-Message-State: ANoB5plTLngHC+g9e9ecs+aI/J8RrI4f0fWqJtZXBpowj6/rO0npJhoD
        dwAHAqpX02zVXJq4d5h4rSyH3uzXTo4=
X-Google-Smtp-Source: AA0mqf4ZhKqrZQyNxQyEcYf5trO2HeJ17TdHvA9aNEPFmpLOywMp8qO4ba2mX9xh4jNv5LNxsPKSaw==
X-Received: by 2002:a05:6e02:1d8b:b0:302:504e:e289 with SMTP id h11-20020a056e021d8b00b00302504ee289mr9373337ila.129.1668632699257;
        Wed, 16 Nov 2022 13:04:59 -0800 (PST)
Received: from [172.17.0.2] ([20.29.87.232])
        by smtp.gmail.com with ESMTPSA id o3-20020a056e02068300b003025c5868bcsm3994025ils.15.2022.11.16.13.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 13:04:59 -0800 (PST)
Message-ID: <6375507b.050a0220.bea41.6ce2@mx.google.com>
Date:   Wed, 16 Nov 2022 13:04:59 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6358846854130046017=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mat.jonczyk@o2.pl
Subject: RE: Bluetooth: silence a dmesg error message in hci_request.c
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221116202856.55847-1-mat.jonczyk@o2.pl>
References: <20221116202856.55847-1-mat.jonczyk@o2.pl>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6358846854130046017==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=696145

---Test result---

Test Summary:
CheckPatch                    FAIL      1.33 seconds
GitLint                       FAIL      0.82 seconds
SubjectPrefix                 PASS      0.62 seconds
BuildKernel                   PASS      34.06 seconds
BuildKernel32                 PASS      30.56 seconds
Incremental Build with patchesPASS      45.40 seconds
TestRunner: Setup             PASS      510.92 seconds
TestRunner: l2cap-tester      PASS      17.45 seconds
TestRunner: iso-tester        PASS      16.50 seconds
TestRunner: bnep-tester       PASS      6.56 seconds
TestRunner: mgmt-tester       PASS      106.15 seconds
TestRunner: rfcomm-tester     PASS      10.48 seconds
TestRunner: sco-tester        PASS      9.87 seconds
TestRunner: ioctl-tester      PASS      11.07 seconds
TestRunner: mesh-tester       PASS      7.99 seconds
TestRunner: smp-tester        PASS      9.72 seconds
TestRunner: userchan-tester   PASS      6.74 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.33 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: silence a dmesg error message in hci_request.c\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#78: 
commit 771c035372a0 ("deprecate the '__deprecated' attribute warnings entirely and for good")

total: 0 errors, 1 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/13045717.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 0.82 seconds
Run gitlint with rule in .gitlint
Bluetooth: silence a dmesg error message in hci_request.c
7: B3 Line contains hard tab characters (\t): "	Bluetooth: hci0: HCI_REQ-0xfcf0"
21: B1 Line exceeds max length (93>80): "commit 771c035372a0 ("deprecate the '__deprecated' attribute warnings entirely and for good")"
26: B1 Line exceeds max length (92>80): "Link: https://lore.kernel.org/lkml/beb8dcdc3aee4c5c833aa382f35995f17e7961a1.camel@intel.com/"




---
Regards,
Linux Bluetooth


--===============6358846854130046017==--
