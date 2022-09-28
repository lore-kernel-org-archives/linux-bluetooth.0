Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C370C32771
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Sep 2022 21:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiI1VSR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Sep 2022 17:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234411AbiI1VRx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Sep 2022 17:17:53 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0350106513
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Sep 2022 14:12:27 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 3so8687034qka.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Sep 2022 14:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Xo0KlD0hyAoN1MFD7MzokyPxtNXNPQEkyqgXP+JDzpQ=;
        b=V0VDdTMGm1NXTelwyiZFvhx0qTajx62HV6JO0s2nAK1jFC8FiZejSmrfTo5eyZLf9Z
         rjkkRbVoYdQmNdIpwcQ2kIvKvd5Fftn6zEJOKlEGICb9LNWIF4+n2lu6KC6DeCqQ8ntk
         +5qHKPr5xndsfx+I7Fqeb03IBYHLJowtzR650aXkD+Zzxbbdc+AMWsjTBymOqntjs7qn
         FVqtM+LmiozfgiCLW7fDYBzpo7qSl9eTNfu/H714h+rsU2edZGd8QKLvgpsNmbrB8LD9
         ixkP+qF+XpkpLdkjEUPafa8Iv7ooyY0c9ulM0i/uBpctXG2Zw0YrrxAVg/S+qTPRXBGI
         3Tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Xo0KlD0hyAoN1MFD7MzokyPxtNXNPQEkyqgXP+JDzpQ=;
        b=x70HgAPljCtaV9FO2tsh58zgozz7H6Rs169FbsgBsfFksqbNCDROoarG4WLxMoaKkK
         4Sbks6K/f9dgwuixZ31/4IXa4xvFAQMLFBfSqlRr5/Wo4Tes9/b2W2+K1Qc9a9nlubAJ
         2nhHKVfx4PFhex21pJ61qz4klLQdFKK/NCJEWa7NGJbgwu0LIzHygPfDOWUUMyb/Q+Jz
         5SR7cw5t/Y9ZmjHmr6KNNpMNESPjzbvowL6zqo7YccvZp0F7fxvniqFxLmz1K6QAefQb
         GZVxHk9gj9kakAyKc4Nd2XzwKf80mR8fNt6ftASJGXazFlLU5hwBkTH5A2damEqqcJ8Y
         QYkg==
X-Gm-Message-State: ACrzQf2L1DmXzBPOF4vB1I/Gv1lfPqVrpM02olhOJ1loxjBQn+02fYAH
        vIKescLtMHQLkJmHNhFlb+Ij7oQWDF9E3A==
X-Google-Smtp-Source: AMsMyM68t6NnmZpr9m3y/xAuDkjOLtnQyncc+1FoErBgLsRIb2jmG8IaqncQx+f3tRh5yHyxTqmTrA==
X-Received: by 2002:a05:620a:458a:b0:6ce:be36:a1f8 with SMTP id bp10-20020a05620a458a00b006cebe36a1f8mr23308246qkb.525.1664399546531;
        Wed, 28 Sep 2022 14:12:26 -0700 (PDT)
Received: from [172.17.0.2] ([20.22.188.129])
        by smtp.gmail.com with ESMTPSA id bl18-20020a05620a1a9200b006ce30a5f892sm3767958qkb.102.2022.09.28.14.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 14:12:26 -0700 (PDT)
Message-ID: <6334b8ba.050a0220.f5e48.c453@mx.google.com>
Date:   Wed, 28 Sep 2022 14:12:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5352992977648131718=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhishekpandit@google.com
Subject: RE: [v3] Bluetooth: Prevent double register of suspend
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220928130027.v3.1.Ia168b651a69b253059f2bbaa60b98083e619545c@changeid>
References: <20220928130027.v3.1.Ia168b651a69b253059f2bbaa60b98083e619545c@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5352992977648131718==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=681622

---Test result---

Test Summary:
CheckPatch                    PASS      2.36 seconds
GitLint                       PASS      1.10 seconds
SubjectPrefix                 PASS      1.15 seconds
BuildKernel                   PASS      33.87 seconds
BuildKernel32                 PASS      30.14 seconds
Incremental Build with patchesPASS      44.32 seconds
TestRunner: Setup             PASS      505.43 seconds
TestRunner: l2cap-tester      PASS      16.76 seconds
TestRunner: iso-tester        PASS      15.59 seconds
TestRunner: bnep-tester       PASS      6.35 seconds
TestRunner: mgmt-tester       PASS      100.48 seconds
TestRunner: rfcomm-tester     PASS      9.99 seconds
TestRunner: sco-tester        PASS      9.31 seconds
TestRunner: ioctl-tester      PASS      10.57 seconds
TestRunner: smp-tester        PASS      9.50 seconds
TestRunner: userchan-tester   PASS      6.53 seconds



---
Regards,
Linux Bluetooth


--===============5352992977648131718==--
