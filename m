Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8186C25B08
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 05:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239853AbiHWFZj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Aug 2022 01:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238497AbiHWFZh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Aug 2022 01:25:37 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146F25C9C3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 22:25:37 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id j6so9513224qkl.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 22:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=dbB9JaGmzlCsZIARY8TyONhhN4HFfsIkbYNDo87G8p0=;
        b=qFYEQH7p8soppZ4yuk5C2F4774wQzwXibxenFA0DsqFYtoKDMNOdHGWtjpiqh5AHaZ
         q0K7bgKUpA5dlwZJ71l4I3TkMgMbTBwHDn5+T8RFFImlmGW2aSLDVWMSupP3VU89dwP8
         FVEfK9eTEAandlYfn9TfmXPw6D1rxEZfstS2Em9fZyrxdmFicmvpZmEUE/D4JHTlU24D
         Mtd6pN9GvldjyKmlAY0r7y/R7EnNiC8AWCs2TFROKdDg+OFVkM8SQtWbRVABMkQVh0AL
         ekO5fFhBflHcMp60qpL0tLC4lVKSxVJyCcZ7HoLqQlkaIV/ZCIXtU1NkS09BjAHs69hx
         3RCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=dbB9JaGmzlCsZIARY8TyONhhN4HFfsIkbYNDo87G8p0=;
        b=HDyoBqFIf2A/tWJnSTDrtPAmYotDHALB1ZgSzswmwD1CAZEkZZCcuXhbzRHZNNXKyH
         GrUfpIOM/yfH5gAyZG0XFlQ0nEN/c9XaKjdbbRE7J5k1Rn97xzWCmaGw3OHaAOdMVqbx
         TcLuVS/oZiNracB3mttuHoI7G3hpVaYcfPDfAkJVq2I6ZE+xRUz5/H7k5Q5g66j+PvfE
         stQr0yDXCNstsO4lbVvSydf2hvoWkRCuHOPo0JurT2KmiknEiqQMP5BV0sjVjHaj/Y6+
         Uu37h81xS/fz54g+v8jvh8MO/sC9fFMsfwMNrLqd71hbq4wDcuD5yeyeo775JHtq8973
         DZ1g==
X-Gm-Message-State: ACgBeo3clxQdNb5WNaf+fd/Y2R0kruUEw2WoZOUkh73rnIlflkG1JUdQ
        oC4J2ooAsmZeqYkXX6G7BV++FpHHZJM3OQ==
X-Google-Smtp-Source: AA6agR6S8fwILrJ7Q0YXeL4di71TiDifQ4Hsfjn3b1RwnhFxjQRw4Qy6OJrp8383FmggRPHSI/updw==
X-Received: by 2002:a05:620a:2491:b0:6bb:8982:8f66 with SMTP id i17-20020a05620a249100b006bb89828f66mr14789066qkn.665.1661232335989;
        Mon, 22 Aug 2022 22:25:35 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.47.39])
        by smtp.gmail.com with ESMTPSA id h13-20020a05620a284d00b006bbdcb3fff7sm9308308qkp.69.2022.08.22.22.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Aug 2022 22:25:35 -0700 (PDT)
Message-ID: <630464cf.050a0220.32b45.40b9@mx.google.com>
Date:   Mon, 22 Aug 2022 22:25:35 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5568120722572820268=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, zhoujie@nfschina.com
Subject: RE: bluetooth/btbcm: Remove goto in btbcm_patchram function
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220823034110.8295-1-zhoujie@nfschina.com>
References: <20220823034110.8295-1-zhoujie@nfschina.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5568120722572820268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=669998

---Test result---

Test Summary:
CheckPatch                    PASS      1.73 seconds
GitLint                       PASS      0.99 seconds
SubjectPrefix                 FAIL      0.87 seconds
BuildKernel                   PASS      34.20 seconds
BuildKernel32                 PASS      29.57 seconds
Incremental Build with patchesPASS      43.12 seconds
TestRunner: Setup             PASS      495.12 seconds
TestRunner: l2cap-tester      PASS      17.51 seconds
TestRunner: bnep-tester       PASS      6.77 seconds
TestRunner: mgmt-tester       PASS      104.44 seconds
TestRunner: rfcomm-tester     PASS      10.22 seconds
TestRunner: sco-tester        PASS      10.08 seconds
TestRunner: smp-tester        PASS      9.97 seconds
TestRunner: userchan-tester   PASS      7.01 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.87 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============5568120722572820268==--
