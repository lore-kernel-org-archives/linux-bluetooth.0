Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9061C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 May 2022 21:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241203AbiEXVKG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 May 2022 17:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiEXVKF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 May 2022 17:10:05 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12793ED1B
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 14:10:04 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id i24so17496902pfa.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 May 2022 14:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=vE6wDJCCi1VQOyOPnEHzNVVKZ4eKGhIf6SAJzo8o6Y4=;
        b=ZSumLVLT7T9kvqMtOMIBjX0awmJ/uE0Wc0PUPLxI5pvVZaSDsRghuffxrdpWPhSdXt
         LaOL23W3QkdfWja/VuUkwELwHOCSzuTb311cMnZGpn0WzueO0QOM5LTJJJGee6hBcsSd
         eAzUwn8HMKwdIqwRz/PxIbLtLwy9PYy1EVURW35xhO6Y5FZXpUd8eaec4xFO8oPIrc24
         FJOurXUJJpBdYENRauTctaMvSsIDlcxxPWWEZgbuh47YEoC08aPM31UOnoaXdhibCdLu
         CsJasEY/YlsKJ0q8nJs509E0JI7GYmYTAEoZt6wpvjGrl0mdbV0dvybQuMix4i3T2YRL
         fQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=vE6wDJCCi1VQOyOPnEHzNVVKZ4eKGhIf6SAJzo8o6Y4=;
        b=zxBVzX0hyOr6NEcUJyXn6WHNvmx6zFUWAb/x8RLzgculrt3QeF7JDh3H6WKiznsyL+
         yvCe6arIXcUyCKVRcQ+Gvvm26hPgXnvvWRB0L6DOVGDZdjAOB3/u65tXE0r91t4Td0BI
         5N3hD/AM7oYjMohsCG8vkMWDJ2l/tc4R4T3CBiiKqCKizZcAsuSMYJg0Ybj+9bn2Lkvq
         IVF+uADj6EO773zDV9bu0es9d7/Rw7x0eSlso7ZDE4J6PP6y0UidsK4YRwSVsVTVPaPr
         bBBDu+VT1CcWqNxhjrE21KxKhATIL1bCbzykIxEDMgDz7GA4NZET+Cf9XuAScxEmTAR3
         q2xA==
X-Gm-Message-State: AOAM533irBCgPvVyxRr/MaVRSpDl02eCSbcYQRgS9SFvg6V0Rp6h+CJw
        Tid+CNRBhk2y5zuy30/15h9X+0m0/PA=
X-Google-Smtp-Source: ABdhPJws7RHp1wOTHbqx1p/aZ6qFcw5EK2BHDDdM9kc0kAmf7GXvKnh3QElrDfiEJnWjbEnY1ysC5Q==
X-Received: by 2002:a05:6a00:cc5:b0:518:a5e6:731e with SMTP id b5-20020a056a000cc500b00518a5e6731emr10849113pfv.19.1653426603881;
        Tue, 24 May 2022 14:10:03 -0700 (PDT)
Received: from [172.17.0.2] ([20.228.102.243])
        by smtp.gmail.com with ESMTPSA id p13-20020aa7860d000000b005182e39038csm9731820pfn.38.2022.05.24.14.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 14:10:03 -0700 (PDT)
Message-ID: <628d49ab.1c69fb81.49fcc.7cc3@mx.google.com>
Date:   Tue, 24 May 2022 14:10:03 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6435687123081583462=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: eir: Fix using strlen with hdev->{dev_name,short_name}
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220524202548.3569218-1-luiz.dentz@gmail.com>
References: <20220524202548.3569218-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6435687123081583462==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=644762

---Test result---

Test Summary:
CheckPatch                    PASS      0.92 seconds
GitLint                       PASS      0.46 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      41.43 seconds
BuildKernel32                 PASS      37.39 seconds
Incremental Build with patchesPASS      50.48 seconds
TestRunner: Setup             PASS      635.19 seconds
TestRunner: l2cap-tester      PASS      20.58 seconds
TestRunner: bnep-tester       PASS      7.51 seconds
TestRunner: mgmt-tester       PASS      126.85 seconds
TestRunner: rfcomm-tester     PASS      11.84 seconds
TestRunner: sco-tester        PASS      11.47 seconds
TestRunner: smp-tester        PASS      11.34 seconds
TestRunner: userchan-tester   PASS      7.77 seconds



---
Regards,
Linux Bluetooth


--===============6435687123081583462==--
