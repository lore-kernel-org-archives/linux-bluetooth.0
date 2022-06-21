Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B69C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 19:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353085AbiFUTzD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 15:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344117AbiFUTzC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 15:55:02 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB8328989
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 12:55:01 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 88so18483884qva.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 12:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=wc6yqoOKy0Dihn6Mg54Z9XFwjzv/oUS0exuqYl16Rwk=;
        b=hDZdlL+O17THoNv5MkmnklmTIKMSxAi7Us1UPrcGhPf4oLFCafEesB95mvO+3ne3Mx
         tBthRsAYwh/UzKbs/0jUJ4O8vfudZ40itCSzeBVRbFVRqcpuvT1uccZ1T5M3zIxZ9PcL
         Q/8KHIMwaVXkwdfB5AH9ly/bev/1mqY++hjbJKGALPlg8OpNILuRZ8I7/3Xrxr297p3+
         /6AHcfIy/RDU8GNRUmHClomNtY+jW2lPcUvnu8fY9oQtnwm2D2G4wT74Pmevd5H3BgtX
         5CiwiButLmkSircoIZZWbB3HnKFCB81wiuYuVX/dUio7nq/j+IgssJzdQe6XVaJYrP7l
         1b+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=wc6yqoOKy0Dihn6Mg54Z9XFwjzv/oUS0exuqYl16Rwk=;
        b=sPHxJtCWyokrbkkjbfvI6O6KQ2rov1nhFzqQPDGuV0Fodfm9WrAnnzwMoXb6v6C76C
         1XCKzDwE7IVxzn8DdFpQK9gcnfi7ttFv0Bsiq8VF3znWb2XDpfvTu9s7Dhcb5DLfTf1/
         RgdW7sxGhi2OpvlF8xgEQa/meqcsk1/yPgxAJMZoYyqMj1mODL/885VG+byOUfQ2Cpil
         gso4iZntbFt9udAIl9FqmsSjbMS84DaWOOs3XkF/ox3P3HsGD8CLPlGCO1WCKZyy/81j
         CscyjWTBr5yobV7DTGwIfIil6IahM6P51pmv7WV1ZbPwuZA7U18e9RuEhF5niK8ZSs/5
         v+Tw==
X-Gm-Message-State: AJIora/h0ngXlzmWJhXK0D/4ubuQqpF9sxFfbrFwSHlGISopOejc6kKq
        vTfuy8dFBECROHCDvX8wjVuWBHD9Jk0iPw==
X-Google-Smtp-Source: AGRyM1sGjczYvweGuHXumlCRDu6CquZcrwhu1bp+wg6U5bK89vXHdYt517Wt7klrKdVw3fMMvO8iBQ==
X-Received: by 2002:a0c:e2c1:0:b0:470:3d22:f9fe with SMTP id t1-20020a0ce2c1000000b004703d22f9femr12682189qvl.83.1655841300257;
        Tue, 21 Jun 2022 12:55:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.122.146.47])
        by smtp.gmail.com with ESMTPSA id m14-20020a05620a290e00b006a6b498e23esm15923727qkp.81.2022.06.21.12.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 12:55:00 -0700 (PDT)
Message-ID: <62b22214.1c69fb81.2b247.f5e4@mx.google.com>
Date:   Tue, 21 Jun 2022 12:55:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2851366229530832743=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RESEND,1/2] Bluetooth: Add bt_status
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220621191031.2160381-1-luiz.dentz@gmail.com>
References: <20220621191031.2160381-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2851366229530832743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=652486

---Test result---

Test Summary:
CheckPatch                    PASS      3.64 seconds
GitLint                       PASS      2.09 seconds
SubjectPrefix                 PASS      1.70 seconds
BuildKernel                   PASS      31.95 seconds
BuildKernel32                 PASS      27.93 seconds
Incremental Build with patchesPASS      43.60 seconds
TestRunner: Setup             PASS      461.87 seconds
TestRunner: l2cap-tester      PASS      16.88 seconds
TestRunner: bnep-tester       PASS      5.87 seconds
TestRunner: mgmt-tester       PASS      97.89 seconds
TestRunner: rfcomm-tester     PASS      9.21 seconds
TestRunner: sco-tester        PASS      9.09 seconds
TestRunner: smp-tester        PASS      9.20 seconds
TestRunner: userchan-tester   PASS      6.08 seconds



---
Regards,
Linux Bluetooth


--===============2851366229530832743==--
