Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C2FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Oct 2022 09:19:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiJEJTV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Oct 2022 05:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbiJEJTU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Oct 2022 05:19:20 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7BB656A
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Oct 2022 02:19:19 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id d22-20020a4a5216000000b0047f740d5847so1163004oob.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Oct 2022 02:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=umkKlpCWJ7eiUXwONOj1ulEJlrhnG5OW2poM3HB8+Jw=;
        b=TXo3ha/Au0Mqj8YNOgO3YvYhQlEHyNz8g1qnTmHOqC1XwwUtnIVTy9HiLD5g/SCM5e
         3DMo1tX3Q79zcM1Bl1yHKpi0wqcxhHjUFBaSKv3uYMfb30sh4H9+1gfEq/rIhWBXg1Aw
         trgHJTY3aGaIV+ev2wendg/Iqjwhyb398EkU124ikfcmYU4x04PsuaQdN4yceOF+UsL+
         bCR6oAj95ABCqA5AcXvkRiaQHZAp97K+LG8VBBHXwpxMp0KjIjy8VgmAmrm/w/jcF5sO
         ImxnEdTnXGxEAt0RUgHmA2o/66NbsbtvvI8XU/jA9bapjdKvhGsoD+wOYUikznf6d7uM
         Narg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=umkKlpCWJ7eiUXwONOj1ulEJlrhnG5OW2poM3HB8+Jw=;
        b=LsmHAbsyt7QBtaPpGknQCo6d6ZhDbk/FsEwbcyhEHDyCvT7fi3LM7ceRKjRZYXlcOV
         rJ8DEWOHZS9GVC4ooevLhpKtdTA/4imZ4upqXtYuome8Vt6bzqEugUY1ehZQVZXX7+rU
         tTobPBMicXPJLdyqNADYxaCaCtxv2ZJ5R0y6VfMbFuPMMm2L9j1mBAHIPG8onINxbimX
         4JQVzPg9gGYSH/xAAo1B2DbqHmTeWXxmhqr6/3IVB/vqXN5VmMXxJqvqfmx4CmOXmx98
         xyyKwgkla2aMCB9nYZ3NRDM4/HmLu04HCYdUo1lkEipYy6nyg497whxV6B0EMycWIWJU
         XFVA==
X-Gm-Message-State: ACrzQf31CiUT6jnrecNXV3eca4GRuZWzD6b8Aq70hOTWGefnCo2zsao6
        +i9aTUQ78wuUWd+hAx2pC5QkJVU9bU0=
X-Google-Smtp-Source: AMsMyM4SsUz5+jEPoofWOxNxvbC5OUpeLQwTLp0agXbha91coP1HWo7PFnULJOf4Pyyk3IsAk9ywow==
X-Received: by 2002:a05:6830:10a:b0:656:a5fe:d7b4 with SMTP id i10-20020a056830010a00b00656a5fed7b4mr11628072otp.275.1664961558340;
        Wed, 05 Oct 2022 02:19:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.61.98])
        by smtp.gmail.com with ESMTPSA id a18-20020a544e12000000b00339befdfad0sm4002106oiy.50.2022.10.05.02.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 02:19:18 -0700 (PDT)
Message-ID: <633d4c16.540a0220.78492.b49d@mx.google.com>
Date:   Wed, 05 Oct 2022 02:19:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7544297312603836201=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: Bluetooth: Add btrealtek data struct and improve SCO sound quality of RTK chips
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221005084331.1001-2-hildawu@realtek.com>
References: <20221005084331.1001-2-hildawu@realtek.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7544297312603836201==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683169

---Test result---

Test Summary:
CheckPatch                    PASS      3.08 seconds
GitLint                       FAIL      1.68 seconds
SubjectPrefix                 PASS      1.21 seconds
BuildKernel                   PASS      39.08 seconds
BuildKernel32                 PASS      35.06 seconds
Incremental Build with patchesPASS      58.68 seconds
TestRunner: Setup             PASS      581.82 seconds
TestRunner: l2cap-tester      PASS      19.08 seconds
TestRunner: iso-tester        PASS      19.65 seconds
TestRunner: bnep-tester       PASS      7.43 seconds
TestRunner: mgmt-tester       PASS      118.61 seconds
TestRunner: rfcomm-tester     PASS      11.81 seconds
TestRunner: sco-tester        PASS      10.97 seconds
TestRunner: ioctl-tester      PASS      12.64 seconds
TestRunner: smp-tester        PASS      10.99 seconds
TestRunner: userchan-tester   PASS      7.79 seconds

Details
##############################
Test: GitLint - FAIL - 1.68 seconds
Run gitlint with rule in .gitlint
[v4,2/2] Bluetooth: btusb: Ignore zero length of USB packets on ALT 6 for specific chip
1: T1 Title exceeds max length (87>80): "[v4,2/2] Bluetooth: btusb: Ignore zero length of USB packets on ALT 6 for specific chip"




---
Regards,
Linux Bluetooth


--===============7544297312603836201==--
