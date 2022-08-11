Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5147CC19F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 13:33:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbiHKNdP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Aug 2022 09:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiHKNdO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Aug 2022 09:33:14 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E12E8991D
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 06:33:12 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id l24so14603380ion.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 06:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=31aySHJUFv6j4D1ubGE8+KsUy8SilJwhCoavddpd3Zc=;
        b=F15n9UV5OO4oiDCfT1K3HrWMK01YsZmMWrQ6MAgGh6bMKeySq0FPdYOPVuDoHiN0e1
         aqcAVZdi4JVu+kagKRIT8E3mQM79/Cv0KQk8OJzwa8QkwMviMA4GzeJGlD5jQAUlXjyP
         YDTZedlunfLyut/kbDP/al2Ed29XRqzXc13ZKK6LUzxo5SsmOtjRIXJfv1sNFFHUJ2/c
         tClXln5ZfN4UGJ/jG7P2XBHoAhbyAo3MbHZ+8BwEIN5HptwJqLhlmO1L6LfiGBWUgscX
         mUzoAVC+cVT0mioiDQTjiuSA0Enk2/lVqqTVhY0J6Ws48eco/+bB/cMMvgQhXhYw4+B2
         h6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=31aySHJUFv6j4D1ubGE8+KsUy8SilJwhCoavddpd3Zc=;
        b=PTlI65pgd/1D6JRRptAu1KPDXFN+UGOE+BsyaJyIdwHiDLGIPQ+TaNbmpgZqqtsJnP
         fjVTzOWEoFR7Eq1dUWsEanU1NZPNiWnzNWalas5B1GKKm4gSkgvobQBG9TDkIAJUy3oA
         F/mV7oAdUl3spwlHwodDiMjL6NZG5ZNUExr107qfFPfGhk4eoG+zhDdKHoBf7II8FlKx
         gVpcEpZNnreNnbfya+7KPiJIFWnxCK9JDZEhzMdHiwG/eawUHV+S3Sk/wZ7g0C2XblxA
         1JLGZ9avn7/onbNfURcW7pTbDmdav6yh/v8kZFPtrC1QjDWma3mLZTGzWKDQih6Ebbsa
         lDOg==
X-Gm-Message-State: ACgBeo2fdMcU7mQvesrWdpE0P6nqmS9hUl4IZt15GbKM6Mu74t3N0GBI
        bZPHb6LSAgB43vdUXGsevVAz6QmwXks87g==
X-Google-Smtp-Source: AA6agR78KNyfdPM6ZwWwcZWrRHZI8vdj2mlG2llGlp6jvIth5v51iCnhAxGYC5cIISE6MaEwU3oGZg==
X-Received: by 2002:a05:6638:d0b:b0:342:71c4:9725 with SMTP id q11-20020a0566380d0b00b0034271c49725mr14806809jaj.106.1660224791017;
        Thu, 11 Aug 2022 06:33:11 -0700 (PDT)
Received: from [172.17.0.2] ([23.99.226.160])
        by smtp.gmail.com with ESMTPSA id x17-20020a92dc51000000b002dcf927087asm3275943ilq.65.2022.08.11.06.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 06:33:10 -0700 (PDT)
Message-ID: <62f50516.920a0220.6d9bb.45ea@mx.google.com>
Date:   Thu, 11 Aug 2022 06:33:10 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7719618058069580695=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: [v2] Bluetooth: hci_event: Fix vendor (unknown) opcode status handling
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220811120103.47669-1-hdegoede@redhat.com>
References: <20220811120103.47669-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7719618058069580695==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=666875

---Test result---

Test Summary:
CheckPatch                    FAIL      1.29 seconds
GitLint                       PASS      0.79 seconds
SubjectPrefix                 PASS      0.66 seconds
BuildKernel                   PASS      35.33 seconds
BuildKernel32                 PASS      30.56 seconds
Incremental Build with patchesPASS      43.89 seconds
TestRunner: Setup             PASS      506.66 seconds
TestRunner: l2cap-tester      PASS      17.73 seconds
TestRunner: bnep-tester       PASS      6.90 seconds
TestRunner: mgmt-tester       PASS      106.74 seconds
TestRunner: rfcomm-tester     PASS      10.39 seconds
TestRunner: sco-tester        PASS      10.24 seconds
TestRunner: smp-tester        PASS      10.17 seconds
TestRunner: userchan-tester   PASS      7.09 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.29 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v2] Bluetooth: hci_event: Fix vendor (unknown) opcode status handling\ERROR:GIT_COMMIT_ID: Please use git commit description style 'commit <12+ chars of sha1> ("<title line>")' - ie: 'Commit fatal: unsaf ("ace/src' is owned by someone else)")'
#68: 
Commit c8992cffbe74 ("Bluetooth: hci_event: Use of a function table to
handle Command Complete") was (presumably) meant to only refactor things

total: 1 errors, 0 warnings, 0 checks, 26 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12941385.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7719618058069580695==--
