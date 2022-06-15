Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB4AC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Jun 2022 09:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344518AbiFOJLl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Jun 2022 05:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239149AbiFOJLk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Jun 2022 05:11:40 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4C93E0E5
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 02:11:40 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id 187so10868743pfu.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Jun 2022 02:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Ht24mkILtL+BzjJTC35S67/4P9qXayM+19fNntchaLI=;
        b=QrdIU+JF2Rk2qREk/AL+L6neHPQ+evgz96VNaaAa84unfazIxrkuR8Rkk1duSBDz0i
         2BxYZGL+PfcH1KIdtuyJ1TGGsJh7AiqV8UpQuK8KIqLjbsMdvUuSYLIvY1grB2ix6mLN
         Y77sQBNSoNMzmYEuxIEcJVJZXMp80a3aAYX/m5nv4M8HSkuS5+oZymQVcw+Ls9AFrchp
         3S3Tg0ib0ECuF3PJsI9pIxjAGHFLBvl/YzHLrDWf8zDtx8hOc0XidwsL8LCXdK+f71rX
         oKtLPuiXcoUDN3vl9KoL+kKCw7D8GYs8uBZ3zEUn7NN/VJGJgzY96447Y7YQA0Mr2ZwW
         OuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Ht24mkILtL+BzjJTC35S67/4P9qXayM+19fNntchaLI=;
        b=u5xSgX+ea+18LkQHnWvMqkS/I13Lavhkk/I23aLpx2IbH9VQDCDyGlkKTx7t6mhObu
         x0WvN+KXGRf8BvI8TSRy2ToUfXx/J+0ctZEhrq2kJKyOxsVqQQYIaqO30BqE5Obl+X/r
         gGl2vYvpmlWmEEot0CqDn2rFcRYFDVBNO3pWeJ3W11q9Sg2ltwJNhJsOPYmBbf4n3BiF
         NXKVNGBvvymTQ0SgkEGH9IxlA6sCKLRlfMuOCSz1f0kbIIME4qdM0GnXW9xMtOLmuhsn
         bf8Ui49rRkZaBcWrD/3AbmPEr2qUlv9aKpshDSCYN9Bgk0mfOcf3fT1w61zYdMLyegYa
         1oKw==
X-Gm-Message-State: AOAM532bVmVtRpR6zzsLh3tbvCi+sYsB/IuD9BRJ9O5CB3cRA1+ZVjVf
        978jQ5hOU/+HT+lVM7tVCXfhZ83et7s=
X-Google-Smtp-Source: ABdhPJyrjP5pPZb3svfqyi5b7O5kR4RMlqpSD0paVxM8eUPkxKGqTqPZYxjmcpSeJpZax+ttTQPm5Q==
X-Received: by 2002:a63:305:0:b0:3fc:7f18:8d7 with SMTP id 5-20020a630305000000b003fc7f1808d7mr8026085pgd.186.1655284299162;
        Wed, 15 Jun 2022 02:11:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.203.255])
        by smtp.gmail.com with ESMTPSA id b11-20020a1709027e0b00b0015ed003552fsm8763373plm.293.2022.06.15.02.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 02:11:38 -0700 (PDT)
Message-ID: <62a9a24a.1c69fb81.fb467.b214@mx.google.com>
Date:   Wed, 15 Jun 2022 02:11:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2584892098060210607=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dan.carpenter@oracle.com
Subject: RE: Bluetooth: btbcm: Use strreplace() in btbcm_get_board_name()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <YqmXmsTX7dD+5HjN@kili>
References: <YqmXmsTX7dD+5HjN@kili>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2584892098060210607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=650472

---Test result---

Test Summary:
CheckPatch                    PASS      0.81 seconds
GitLint                       PASS      0.44 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      36.37 seconds
BuildKernel32                 PASS      31.72 seconds
Incremental Build with patchesPASS      42.70 seconds
TestRunner: Setup             PASS      537.98 seconds
TestRunner: l2cap-tester      PASS      18.31 seconds
TestRunner: bnep-tester       PASS      7.34 seconds
TestRunner: mgmt-tester       PASS      115.33 seconds
TestRunner: rfcomm-tester     PASS      10.62 seconds
TestRunner: sco-tester        PASS      10.46 seconds
TestRunner: smp-tester        PASS      10.58 seconds
TestRunner: userchan-tester   PASS      7.04 seconds



---
Regards,
Linux Bluetooth


--===============2584892098060210607==--
