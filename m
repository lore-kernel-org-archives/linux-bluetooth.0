Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F1DFC54EE9
	for <linux-bluetooth@archiver.kernel.org>; Sun, 11 Sep 2022 17:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiIKRTF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 11 Sep 2022 13:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiIKRTD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 11 Sep 2022 13:19:03 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2CC638A2
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Sep 2022 10:19:02 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id j10so1904612qtv.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Sep 2022 10:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=6FhWxlSFW/ZOsg46hAxn/akEbsrDmYxkfh635XKU8eg=;
        b=nBfnjo7FkqkwAPVwuCUzQvl3MJ77F0nV0fN1OHmvxncvYyHzeOZnqyTVkZa83QvGRq
         jfFzUSyRVSDpoDxVDdRt1AeJVYag1HWb8o4/nY34blZTFoeI4XGlA+Q/lsIKqBd4O9+3
         QPpnGTVPRrGzoBBI+/yHIwJO36f3gueKJhXDgv6VODc/FbiFUwZyrN441/7aXh+gqvzz
         vboxa6szIV855VSo3OqcOUbrVWPhZhqCngucN0S8krGHtYSM4622+wVZ8GWFla8WBmeb
         WtvCP2MVE31QnKbBIR0MOR8dWf0VFC15tMpouVluO10wWTGE4Vxh6jg9nObnOlXqwXxc
         6MGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=6FhWxlSFW/ZOsg46hAxn/akEbsrDmYxkfh635XKU8eg=;
        b=dACRvgoYXcOz9LGfq79p2ReW7x3xksG463z1IfLWdADiROhWcGSMPVNx0pDzgtMG/Z
         xCy/iFmeOORp2td7Ii5dIuy9G9UPfVkGK34Y0xZdJqQUhDIXuiLrAugQu538+vDqX2jw
         5LqatAqSzoKw/Slkdto8Bbc7bys94+Tk7GxBULnGAgor5FmNph1aoiGApaD4Gkv7lBbh
         tgPim5lojSkP+VasvJ8Qv08iS3Q+IvWZfzbQoTpjX+0kgbMvNcvRQYZvOeZ6lo+qV/a2
         JAXmQ3hZSvQMAbn1q0GcJxeBX8+7kuJu/b2rQhB8xfcELviag503baC0kw28ktRHvfGH
         ejGQ==
X-Gm-Message-State: ACgBeo1Bma9NFi8biAhaIrELapYawIv7ZqrLQXvRMcRWZBGBf6xSauZJ
        NPedX2Y/UPiunvAzK3Jmu1L8NufBA3k=
X-Google-Smtp-Source: AA6agR7Bq8Hc+EsVuH3PglytJgtEG8t7fyZJS2RazX7GsRDJvtuBJGHh3wcHGwwgMUNRQ1EMw1rgRA==
X-Received: by 2002:ac8:5a11:0:b0:35b:a2ec:2b73 with SMTP id n17-20020ac85a11000000b0035ba2ec2b73mr9659947qta.364.1662916741674;
        Sun, 11 Sep 2022 10:19:01 -0700 (PDT)
Received: from [172.17.0.2] ([52.188.163.2])
        by smtp.gmail.com with ESMTPSA id t29-20020a05622a181d00b0031eebfcb369sm2023630qtc.97.2022.09.11.10.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Sep 2022 10:19:01 -0700 (PDT)
Message-ID: <631e1885.050a0220.1d1e4.2b7c@mx.google.com>
Date:   Sun, 11 Sep 2022 10:19:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8457147440867339327=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
Subject: RE: Bluetooth: avoid hci_dev_test_and_set_flag() in mgmt_init_hdev()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <f6de02d1-dcda-0383-739d-27484b4d5c63@I-love.SAKURA.ne.jp>
References: <f6de02d1-dcda-0383-739d-27484b4d5c63@I-love.SAKURA.ne.jp>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8457147440867339327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=676039

---Test result---

Test Summary:
CheckPatch                    PASS      1.76 seconds
GitLint                       PASS      0.95 seconds
SubjectPrefix                 PASS      0.82 seconds
BuildKernel                   PASS      34.17 seconds
BuildKernel32                 PASS      30.91 seconds
Incremental Build with patchesPASS      43.79 seconds
TestRunner: Setup             PASS      513.11 seconds
TestRunner: l2cap-tester      PASS      17.32 seconds
TestRunner: iso-tester        PASS      16.55 seconds
TestRunner: bnep-tester       PASS      6.54 seconds
TestRunner: mgmt-tester       PASS      103.20 seconds
TestRunner: rfcomm-tester     PASS      10.20 seconds
TestRunner: sco-tester        PASS      9.78 seconds
TestRunner: smp-tester        PASS      9.87 seconds
TestRunner: userchan-tester   PASS      6.86 seconds



---
Regards,
Linux Bluetooth


--===============8457147440867339327==--
