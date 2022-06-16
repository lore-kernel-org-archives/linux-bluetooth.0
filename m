Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094ECC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jun 2022 10:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359830AbiFPKGc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jun 2022 06:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376269AbiFPKG2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jun 2022 06:06:28 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4755D5F2
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 03:06:25 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id mh16-20020a17090b4ad000b001e8313301f1so5032546pjb.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 03:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=kTCTuScGxOSV5yar5Bw1bpdMMYcIFlh5UtR4+Q1tuvA=;
        b=p8pYrSyIDZ4QGwbY9UKvkADM1TQI3k2XXIcgVYsq0EY2lih6FDgKzQX5AjNM4uhBAM
         I6QwN93lenVIJermoKYVEEJYSeEo3ma7ZAyZ/vSG56x/sflq8xmcNDz5NB/oEmc0fNkv
         YM+LvonftrxKRBemOBJYnvDLa/wDw/hIlD9Nqv6QJi2EihlAnmtrUWOHtYSBz8h1EKUG
         wgdeb9D8jyi6bU30R5kMwDF5l4XNwzOh0ohB7eaYeWY1NhuKp0f1XSY7UKk53dg0sU/O
         RxI3QZGIjriFv/7ljy2a7k2G+iB3zHhohJ+TYCP/tzyIu9x7tdOrChgW6TxVwxJTr3y8
         a0qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=kTCTuScGxOSV5yar5Bw1bpdMMYcIFlh5UtR4+Q1tuvA=;
        b=OFm9R5gn+0aXv1YaSNxbp2Ap2Lg3S5LppwaWKhrMMxjr/iDvyAYB/0C4sO5poUqcaz
         xK7H5JaiYRfgqwlpq1jwvwKAaZeYTy8eVkZ1aNxJcf4qLiv80M+m+riW/3N6eKvE/8ZN
         scpoBJnAerEL168VVOns9eWnBeSA3ssupQT3dvOCaava9YtCoS7xAVGjjOtBLIIBpNNC
         DAvnqpguSLj0jAZPAAQWrqcHIE2n5Er/v4j+7CCeQcfsnmOknZLqp0jxPoAMEze0Rxt+
         ht6nnh7kokmClHW2iMoPQ3ASbUlXhjJMvmdQiZHNanduBEE2bsyVoGmhEXUi9GkFMQ/b
         5k9g==
X-Gm-Message-State: AJIora/n16TLpJqQ91+A1VsEUL6dE/3QfBLyLtM9AnFpHz9WlvP5soAE
        Y7LgRUYFahjR7xoqmqFMfN/jxTWeuKg=
X-Google-Smtp-Source: AGRyM1smuRadPN0KwmQMk/JlLiEeS8or0MWQEpBr6IrZ8XiM9Gd+/ZGsCRhHMe1P4hBEjFMZQRGHVQ==
X-Received: by 2002:a17:90b:4c8a:b0:1e3:60f:58c3 with SMTP id my10-20020a17090b4c8a00b001e3060f58c3mr4190604pjb.230.1655373984567;
        Thu, 16 Jun 2022 03:06:24 -0700 (PDT)
Received: from [172.17.0.2] ([20.245.14.152])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902b69200b0015ee24acf38sm1221855pls.212.2022.06.16.03.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 03:06:24 -0700 (PDT)
Message-ID: <62ab00a0.1c69fb81.285a1.1af2@mx.google.com>
Date:   Thu, 16 Jun 2022 03:06:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0127421641728898243=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, stephan.gerhold@kernkonzept.com
Subject: RE: [v2] Bluetooth: btqcomsmd: Fix command timeout after setting BD address
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220616093936.1294824-1-stephan.gerhold@kernkonzept.com>
References: <20220616093936.1294824-1-stephan.gerhold@kernkonzept.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0127421641728898243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=650946

---Test result---

Test Summary:
CheckPatch                    PASS      0.90 seconds
GitLint                       FAIL      0.47 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      36.72 seconds
BuildKernel32                 PASS      33.63 seconds
Incremental Build with patchesPASS      45.84 seconds
TestRunner: Setup             PASS      577.07 seconds
TestRunner: l2cap-tester      PASS      19.73 seconds
TestRunner: bnep-tester       PASS      6.61 seconds
TestRunner: mgmt-tester       PASS      118.63 seconds
TestRunner: rfcomm-tester     PASS      11.13 seconds
TestRunner: sco-tester        PASS      10.79 seconds
TestRunner: smp-tester        PASS      10.38 seconds
TestRunner: userchan-tester   PASS      7.18 seconds

Details
##############################
Test: GitLint - FAIL - 0.47 seconds
Run gitlint with rule in .gitlint
[v2] Bluetooth: btqcomsmd: Fix command timeout after setting BD address
32: B1 Line exceeds max length (101>80): "v1: https://lore.kernel.org/linux-bluetooth/20220613110745.3778356-1-stephan.gerhold@kernkonzept.com/"




---
Regards,
Linux Bluetooth


--===============0127421641728898243==--
