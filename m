Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B28E5C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 19:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbiAYT43 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Jan 2022 14:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiAYT4Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Jan 2022 14:56:25 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0B9C06173B
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 11:56:25 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id t32so19138078pgm.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 11:56:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=DDI++nOy6I2Z/igMQvoJJT5iExFFCBXe3w2TFoW6zGU=;
        b=olvqeKt6Ir9CXsCmPLbjBwTP9B8Uqw8CfPbi1+/9mGDoE3LiUvW1/rbFNO+bXH/j4h
         HpdlF/en/EaT7MIo684PFDGETXNUJXbohf359X7JsADF8dZxtaOuyvLII1cD9jziXS4h
         JtuVMRAMKmRagaNDZnN14gxSxsNziFe7RFke9P6+TZ4o08tEtcIUxHuhHJo4BW2JE0jQ
         2kx1MLQrZB7lzMMHRduxC+cYNskHmyKkLNBXlrf4YH6/w2KQTmZTqhVjPrAtSAol+4Ek
         ewgQJwOD91TXuJj/C7wnxPoQiwE04DdhToaWHGWWn1mhqSH8y/RXjm7WyceGi6ylyMDU
         rjEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=DDI++nOy6I2Z/igMQvoJJT5iExFFCBXe3w2TFoW6zGU=;
        b=kbwOkvL6Q3hOREVNk/6FthRyLbz32ORDXitMVp3CKINIUj/zlvf/gDQYeskiA5ghIy
         WVCCq1PShbA+w5684Sgqwj1vim5m0rSN9ecTPJoH603ZnaZ4MFL5pKZuZd6L7dWQykyN
         f+JnPGR0bKQQqYN4HPgB2i0oPztKK260MJ62PXoEeDiwE9G2VNrRVCpeHbnvmNJEHOr2
         5nVqTsXNnucn5RkexUtCKyFy8Dv7Ny1nBiwq04OFjZ38lJ+Eg2RiE+T3Jk1P3Rmqk5p/
         A+97Lji8hLUtsp3FHN82Ydc88ACt+VG4Civ4wqaprT5RutzO3m0LULpYrAlU7wBuVjVB
         KKkA==
X-Gm-Message-State: AOAM531VY/pBVx2dSLBzYGQB9SNPJRrpxiFS1Q0f28LFtVHvTKR1Iq1E
        TqpYIsxdNXeqt6WPZgn7Pi3HCm8pwAY=
X-Google-Smtp-Source: ABdhPJwUkzHvDx+gtrCCDQgSzgE7GekHqd2aoaRzP0JncQMg2cjAUNDjpoJmMZLzm+Q5hVXQCbfEZA==
X-Received: by 2002:a65:6ab3:: with SMTP id x19mr16323143pgu.416.1643140584448;
        Tue, 25 Jan 2022 11:56:24 -0800 (PST)
Received: from [172.17.0.2] ([40.65.117.176])
        by smtp.gmail.com with ESMTPSA id d8sm1099766pjz.32.2022.01.25.11.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 11:56:24 -0800 (PST)
Message-ID: <61f055e8.1c69fb81.7eadb.3811@mx.google.com>
Date:   Tue, 25 Jan 2022 11:56:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2306323951050645959=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_event: Fix HCI_EV_VENDOR max_len
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220125185305.2419774-1-luiz.dentz@gmail.com>
References: <20220125185305.2419774-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2306323951050645959==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=608383

---Test result---

Test Summary:
CheckPatch                    FAIL      0.93 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 PASS      0.21 seconds
BuildKernel                   PASS      39.46 seconds
BuildKernel32                 PASS      34.88 seconds
Incremental Build with patchesPASS      45.99 seconds
TestRunner: Setup             PASS      609.88 seconds
TestRunner: l2cap-tester      PASS      16.01 seconds
TestRunner: bnep-tester       PASS      7.20 seconds
TestRunner: mgmt-tester       PASS      126.48 seconds
TestRunner: rfcomm-tester     PASS      9.17 seconds
TestRunner: sco-tester        PASS      9.29 seconds
TestRunner: smp-tester        PASS      9.19 seconds
TestRunner: userchan-tester   PASS      7.58 seconds

Details
##############################
Test: CheckPatch - FAIL - 0.93 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: hci_event: Fix HCI_EV_VENDOR max_len\WARNING:TYPO_SPELLING: 'supress' may be misspelled - perhaps 'suppress'?
#83: 
In addition to it this makes use of bt_dev_warn_ratelimited to supress
                                                               ^^^^^^^

total: 0 errors, 1 warnings, 0 checks, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12724153.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============2306323951050645959==--
