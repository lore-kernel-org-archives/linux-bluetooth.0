Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A544CC19F28
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Aug 2022 18:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236336AbiHCSJa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 14:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbiHCSJ3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 14:09:29 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A1B491C8
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 11:09:23 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id u12so13259056qtk.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Aug 2022 11:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=g9jmbEzRvWt5BAb8z61znxNJarghR3NslQMjogNvH3s=;
        b=eQl0WxUOIjaFCLDwk04DoBzBTW74x+NDaHKybl86fYnpb5zi6XaetzGJQ2zxc1+zKk
         icU9GSYhYMjPAGpDtOXsA36AKnI9Jgb6DeHHFqCI/FVeSRr9j8qrMymxfK+Wc8Z45mcG
         LqDOIJ5THyox5NK/ogT55eekoL0I3KQjeAAC0XjhT6qM6wBkPOPMaHlhdMa80OnRlhk5
         5wQHPhEp6SxmQJzrBaQyalx45ssroeT30L5zU/OZsGboLVdmh4IpBWHl/6nSJbUs/ZjH
         SWx+y3jK/Pttdo4thoMAYqh4aE9TOlEqOy1gHkdh5bz4oSxx9vIeAdRAfvEof7UhqfX8
         KYIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=g9jmbEzRvWt5BAb8z61znxNJarghR3NslQMjogNvH3s=;
        b=AsW+HHm+5PLP2y8ipUbZDH5TRwnoQbSccRfDcUKeoj9TO7M4IWwYM+w76zW9T7namz
         kSVzWTQ5J6+XD7vhjfw8eSfDG3C7tnZTLkxS2KlbTlKlvHEpozPet9ahqp5ob9miztz4
         PXBIGF/IF7Cc4c15BE7P4NSSz+Ye+6xZWHgcNZsT75ZWnMSWz2BJRVUIO7Y7cCmLKSVT
         Ltt887Ud4UHicseRVE4i/oZZsaYMmSVyf1+hIJLkREDVX0SFmvI0GWG7zGRWM+PHj898
         dKYENxsaqDI0hvJ8BQj1dUEWvKH922ya8gF36wDOvf52M/KITiPp2gT/zqLsIw29gtsW
         /Ahw==
X-Gm-Message-State: AJIora9FZ6mqFZSmWGp0zKX/VyFy40MuFQRliIBNmGNAnMacJuNw/wI8
        zBW4Z6JPgIgk8tbHSi/xBKXZwm4uwKk=
X-Google-Smtp-Source: AGRyM1uaTyUcdikOBB2Nu/j/3k6SGR+toXrbsn1dL6HgcXiw9LGLRvSkkDKHRgj+PW7VXA7C0X6cAw==
X-Received: by 2002:ac8:5d49:0:b0:31f:aa:e632 with SMTP id g9-20020ac85d49000000b0031f00aae632mr23153196qtx.427.1659550162809;
        Wed, 03 Aug 2022 11:09:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.122.86.57])
        by smtp.gmail.com with ESMTPSA id cc18-20020a05622a411200b0031ea2328edcsm11299222qtb.82.2022.08.03.11.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 11:09:22 -0700 (PDT)
Message-ID: <62eab9d2.050a0220.9278.f875@mx.google.com>
Date:   Wed, 03 Aug 2022 11:09:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3712755102612878994=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: ISO: Fix iso_sock_getsockopt for BT_DEFER_SETUP
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220803172006.2951684-1-luiz.dentz@gmail.com>
References: <20220803172006.2951684-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3712755102612878994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=665135

---Test result---

Test Summary:
CheckPatch                    PASS      1.69 seconds
GitLint                       PASS      1.04 seconds
SubjectPrefix                 PASS      0.86 seconds
BuildKernel                   PASS      32.87 seconds
BuildKernel32                 PASS      28.42 seconds
Incremental Build with patchesPASS      41.15 seconds
TestRunner: Setup             PASS      477.39 seconds
TestRunner: l2cap-tester      PASS      17.13 seconds
TestRunner: bnep-tester       PASS      6.41 seconds
TestRunner: mgmt-tester       PASS      98.63 seconds
TestRunner: rfcomm-tester     PASS      9.64 seconds
TestRunner: sco-tester        PASS      9.45 seconds
TestRunner: smp-tester        PASS      9.38 seconds
TestRunner: userchan-tester   PASS      6.53 seconds



---
Regards,
Linux Bluetooth


--===============3712755102612878994==--
