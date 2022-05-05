Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F45BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 02:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbiEECtI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 22:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiEECsw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 22:48:52 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291A6131
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 19:45:14 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id dv4so2144368qvb.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 May 2022 19:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=RKE/R74ZWOWOmflJK+33td/wFCYZYlbUueb1trZ0Q2k=;
        b=a5fPx4Jy9CxGHRxNWFoFaLuDCml+WveDw6NTTjA5PrNXjr1lZ4e0B1OPFALKom6oIQ
         qqxt+1KJBTnTkcnCUEADO0PKaVEU2V1EJsCiHQrdI34iFq527y0HEZiXJmUNrG4LcoWh
         Pxmo6nE1wFk9H6xIIT4tKtmNJaTZBA6nR/67H31XKa2oZVTJATlbzj1f6nJlGMXFp8Z6
         xBgy8/+tGKljwXkGjwRrKb/5fNsgWuymlLg8R6Vya9N3NfB77Qp5dzPw/Noid7ffbakv
         3ODdoPrsPKbbk1DtiscI3+rWBkx/iOaNoFREiG1P8LG0mUyjoZ58rUMN60Gs72PYK6e5
         o+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=RKE/R74ZWOWOmflJK+33td/wFCYZYlbUueb1trZ0Q2k=;
        b=AuMH+m6TPB56ccET3+0wJytL8gJEMU3bzUHyrjhh9gFH+WKBFvU1dOFoIEpTQeOrx1
         BHxDwsg4CBt3PZWqmb8PKsqyJZpye1zevNk9CYncwWN8r0sXKIvMet9c7o7ARnJ9Aljc
         zaxf6uPfi1WohLdH3J8lLvDGBDC0Ms3uv3FSG6VXe24K3uxtJNSmueyyFKsr9wWuFgR4
         BQUlcQ317+iC8k9JxdEig6UyHwHklbxirmxZzRy8ocwk8hvlVNoJ0EOH+dyiWCSaYOp5
         y7EUeTheHjAK1bsndewIZvdZCTRQFkoGu5PRcyeLafURShG2a7GoJxuTM+PvZhIwF3bw
         CF9A==
X-Gm-Message-State: AOAM532PBooW/qsYwC88NxytHf9lScTK9j0xo5VGWfgcep9VeEeXn2cC
        WHtQi4L7mUXc0vMeNTaUCebiXG9V8/viug==
X-Google-Smtp-Source: ABdhPJyuBI92xJvXAQqzA38RT5bZcyEiO3FhqtR/pPWVNssHZjkz2tbXlYNYh6PAnHB4DO57fIOgUQ==
X-Received: by 2002:a05:6214:29e6:b0:45a:7df3:f27d with SMTP id jv6-20020a05621429e600b0045a7df3f27dmr18085170qvb.22.1651718713231;
        Wed, 04 May 2022 19:45:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.231.65.5])
        by smtp.gmail.com with ESMTPSA id x8-20020ac87a88000000b002f39b99f6b1sm149794qtr.75.2022.05.04.19.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 19:45:12 -0700 (PDT)
Message-ID: <62733a38.1c69fb81.13c1f.0c7b@mx.google.com>
Date:   Wed, 04 May 2022 19:45:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6372155126317930036=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/2] Bluetooth: Add bt_status
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220505000629.2903297-1-luiz.dentz@gmail.com>
References: <20220505000629.2903297-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6372155126317930036==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=638502

---Test result---

Test Summary:
CheckPatch                    PASS      3.43 seconds
GitLint                       PASS      2.05 seconds
SubjectPrefix                 PASS      1.78 seconds
BuildKernel                   PASS      31.76 seconds
BuildKernel32                 PASS      28.77 seconds
Incremental Build with patchesPASS      44.42 seconds
TestRunner: Setup             PASS      469.08 seconds
TestRunner: l2cap-tester      PASS      17.42 seconds
TestRunner: bnep-tester       PASS      6.15 seconds
TestRunner: mgmt-tester       PASS      101.62 seconds
TestRunner: rfcomm-tester     PASS      9.60 seconds
TestRunner: sco-tester        PASS      9.39 seconds
TestRunner: smp-tester        PASS      9.47 seconds
TestRunner: userchan-tester   PASS      6.38 seconds



---
Regards,
Linux Bluetooth


--===============6372155126317930036==--
