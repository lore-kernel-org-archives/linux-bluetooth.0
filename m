Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B1BCCA479
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Jun 2022 14:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344753AbiFTOW0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Jun 2022 10:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350194AbiFTOVx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Jun 2022 10:21:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91D8648317
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jun 2022 06:36:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so10333383pjz.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jun 2022 06:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=q2c28c9ycIykB8rvaKzW2SHtPCiH50fTzVxDFaCeLQU=;
        b=S578dw56q7QL7xegVMXvysC7JnxdIKF1si3uGtgxPVC0YsmG0QQgkUwthWlxI3EXqW
         LpCZkoNikDg+JfiHaUdWq9VwTG+jQjdQhO6OfCDQlC9fDQJ2+ZuVnUO4dNKXHVkhgfRy
         Xw7qdgcxU87vdrNdQc9DsvxJCyBkHpyCXWwXf9mPl4HxG/sweltqZ9mpAB/ChuZGApA6
         pjxwrLNZLVp73Ya96Hudw24JlN+gd9hONREVEhI3SX0LSEuyqDTuRf/uQNqp7c5xfOEB
         lgQ912xhEt1hsD+1AHyDFGoEQH4mP2xF+wewxv25hiokqRWCNWX3Tn//4C3aYuRQjPIF
         HoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=q2c28c9ycIykB8rvaKzW2SHtPCiH50fTzVxDFaCeLQU=;
        b=hQAai7r51iFttGq1mLbKP4MbEt4eHmSkkRCTroxpXYmQ3CusvfMPGciwaD02HYJeSB
         UtHPQiIxqLEiAC++v09HAQU+IZywdrYTUwdLbsNZF7xheK+Dpukfm6eM4kew8uOFob3F
         3iIc79pb8zf6DSWCpPD7brvnv7w+EidpRu1DWoPtNyDaNhKcMRJQgxgjqBkhRFvX7SAs
         ji8qf7x2SQ7HYdmslyJ5tE9/Zvx1JT/0kwrsc2b1EKm2lcsa85VfoKs56XM/P8a8q/7q
         H4XqbIcd45SMAPTLGGURG7TWzPApG9Mt7B57iK4lqnZKAcKKbP0Q9OjdCIbx03wYmcxA
         N+Tg==
X-Gm-Message-State: AJIora/KmjOIX8tbP2aB1NEHq6v/mUJqZD031BDyoP7hMKejoqp524Vd
        kBqy5ySKUXK8gDk2jesWK1gr++xWCOo=
X-Google-Smtp-Source: AGRyM1tLn0awd3aOA2aU9nGUpDj64nGd9InQchWqgMNQEhUj3xwTDN1gVhSX9oTih/kzIVXTGW7M4w==
X-Received: by 2002:a17:90a:408f:b0:1e3:23a:2370 with SMTP id l15-20020a17090a408f00b001e3023a2370mr26813833pjg.84.1655732200866;
        Mon, 20 Jun 2022 06:36:40 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.88.83])
        by smtp.gmail.com with ESMTPSA id x6-20020a1709029a4600b0015e8d4eb1d1sm8719948plv.27.2022.06.20.06.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 06:36:40 -0700 (PDT)
Message-ID: <62b077e8.1c69fb81.662ed.c149@mx.google.com>
Date:   Mon, 20 Jun 2022 06:36:40 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8220641837283958859=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hakan.jansson@infineon.com
Subject: RE: Bluetooth: hci_bcm: Improve FW load time on CYW55572
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <acd9e85b1ba82875e83ca68ae2aa62d828bfdfa3.1655723462.git.hakan.jansson@infineon.com>
References: <acd9e85b1ba82875e83ca68ae2aa62d828bfdfa3.1655723462.git.hakan.jansson@infineon.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8220641837283958859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=651965

---Test result---

Test Summary:
CheckPatch                    PASS      3.18 seconds
GitLint                       PASS      1.74 seconds
SubjectPrefix                 FAIL      0.30 seconds
BuildKernel                   PASS      33.93 seconds
BuildKernel32                 PASS      31.21 seconds
Incremental Build with patchesPASS      60.36 seconds
TestRunner: Setup             PASS      509.25 seconds
TestRunner: l2cap-tester      PASS      17.92 seconds
TestRunner: bnep-tester       PASS      6.17 seconds
TestRunner: mgmt-tester       PASS      107.42 seconds
TestRunner: rfcomm-tester     PASS      10.00 seconds
TestRunner: sco-tester        PASS      9.60 seconds
TestRunner: smp-tester        PASS      9.57 seconds
TestRunner: userchan-tester   PASS      6.40 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.30 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============8220641837283958859==--
