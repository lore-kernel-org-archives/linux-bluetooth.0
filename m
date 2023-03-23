Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7594DC6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 02:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbjCWCbH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Mar 2023 22:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjCWCbG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Mar 2023 22:31:06 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08FB29171
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 19:31:00 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id bo10so15194684oib.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 19:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679538660;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uEtVai+kZPJoHonWEbZOMcXezyW2R5l9jqjdo8M5vAc=;
        b=aPBba51gO3suAJIRRsyN2lPoxDYdd6h7LGcPc9XU3Z5YLVUfbn5Rinf5JOdvDceg37
         tlxJgE79CCjtXv3hLVxFW59lDCVfTbGOpzpYx/9iPX1aSMFHOiB6szHnmvrRiPkMqYsk
         D64Ne03f3z5dxtOu7eGOQ3O1jdr/6Su1F8jnT8J+KTUZ8a3LtgkLdMlLwcMHRzT2NhIK
         vE06VooDIUZqj4Egh9Bxiew3W3dkrjZGXiu0zzzeal0NxQRGA9VARZJuBLeZBfa2dBif
         Dp7X07+kjzxgj1m76Ri1Skv5a2iDwqGZwv8UbGAUvWW5WBs5CEFHr14F7RbI3BgPMaug
         AR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679538660;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uEtVai+kZPJoHonWEbZOMcXezyW2R5l9jqjdo8M5vAc=;
        b=qbM461+b65WHAjgnxnK5uIZXNUxyZnvXNyC2gW6hdQdM2+Q/CkH6oY5MdknxmmWyWy
         YIj8eiTNXzWZmSLW1/2uvOTw24ykWVhk2Fvp+krmNPwzmlB3HVwWXoY8x6DFl4KqATTf
         PFO5D85ldCimjQXswfazkcJwGDaZAqBcV2WSI3v7PGAkPZYGOvzk6otlIX5s/oW1fK39
         mkAD5avb6G3rr4e0la8LrIbumXzi9+SKDKXNcjr5+10L4lvsPZZTPaug/cVM2QPSgccY
         JarknDmlGoq/pxjr/7sR+xSiKMdEm16MaFA8JtiTi2SU9HgeYfPUZDrzRdxIBcfwUV6G
         p4oQ==
X-Gm-Message-State: AO0yUKU8D3t/UcNK1TUVDpGaGurI/rGyGS+z0PFFy0oKmpjVOTrhfGwH
        0awhrzR7/71kV9ms3NekeYUBlCxt+O4=
X-Google-Smtp-Source: AK7set8Lydjwn4Y+SLXFesOV3uM2nq9856AfFs2q5bFw5l2oKw+sweNXciCXFyhq9MaeghalOv2wYw==
X-Received: by 2002:a05:6808:a10:b0:387:1e1e:bd2c with SMTP id n16-20020a0568080a1000b003871e1ebd2cmr2265555oij.48.1679538658645;
        Wed, 22 Mar 2023 19:30:58 -0700 (PDT)
Received: from [172.17.0.2] ([65.52.35.23])
        by smtp.gmail.com with ESMTPSA id vh22-20020a0568710d1600b00177c21c3ae1sm5789448oab.54.2023.03.22.19.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 19:30:58 -0700 (PDT)
Message-ID: <641bb9e2.050a0220.4989d.b63d@mx.google.com>
Date:   Wed, 22 Mar 2023 19:30:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3183625871149866985=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, Larry.Finger@lwfinger.net
Subject: RE: Bluetooth: Two additional devices
In-Reply-To: <20230323005203.19749-2-Larry.Finger@lwfinger.net>
References: <20230323005203.19749-2-Larry.Finger@lwfinger.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3183625871149866985==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=732932

---Test result---

Test Summary:
CheckPatch                    FAIL      1.81 seconds
GitLint                       PASS      0.64 seconds
SubjectPrefix                 FAIL      0.47 seconds
BuildKernel                   PASS      41.73 seconds
CheckAllWarning               PASS      46.79 seconds
CheckSparse                   PASS      51.99 seconds
CheckSmatch                   PASS      137.37 seconds
BuildKernel32                 PASS      41.32 seconds
TestRunnerSetup               PASS      577.92 seconds
TestRunner_l2cap-tester       PASS      20.25 seconds
TestRunner_iso-tester         PASS      21.83 seconds
TestRunner_bnep-tester        PASS      7.02 seconds
TestRunner_mgmt-tester        PASS      132.10 seconds
TestRunner_rfcomm-tester      PASS      11.65 seconds
TestRunner_sco-tester         PASS      10.87 seconds
TestRunner_ioctl-tester       PASS      11.96 seconds
TestRunner_mesh-tester        PASS      8.82 seconds
TestRunner_smp-tester         PASS      9.52 seconds
TestRunner_userchan-tester    PASS      6.91 seconds
IncrementalBuild              PASS      45.16 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[2/2] bluetooth: Add device 13d3:3571 to device tables
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#86: 
This device is part of a Realtek RTW8852BE chip. The device table is as follows:

total: 0 errors, 1 warnings, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13184800.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============3183625871149866985==--
