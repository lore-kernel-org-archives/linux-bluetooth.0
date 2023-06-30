Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64E8EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 14:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjF3OBl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 10:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbjF3OBe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 10:01:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E9E2118
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 07:01:33 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6687096c6ddso1216451b3a.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 07:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688133693; x=1690725693;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Fwurf5oC1hssQoOSIwRzjCIzecsThnrDPkDcfSn/QVI=;
        b=HCMGNWca9f5rTPZ4o7znS3wO1wc7kNoIQRPo6QTdeVvNhewZKHcmUKxBsXfUMruHfW
         t3NB0cE1SvvQzdDBecnxCCoE9mE/sBwqTnRbSjWP331WpD9OEGy3ccmHFNTduObZrLuV
         wLzO+qHyauMNSYsCek8jWxWCEFBpSkMtJRbrmHJvI5abnebJ+NkLBz719Y+/TI+wYj95
         EzdGHWbBEYS6YEUxG41wwIz2+777iYIENF8IQJ22saR6ABRukVkLr7gix1WNoMovFB6U
         jgpGFs1ryHOg3Awv/6TIeYaaCMTCa6ngnBv4BLfPQDOZ7pBv1ZpR63B/awzBZNmCH0Ht
         lWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688133693; x=1690725693;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fwurf5oC1hssQoOSIwRzjCIzecsThnrDPkDcfSn/QVI=;
        b=hKD6XtQstx1yexkiZ8TmdUq+r5BWI3U8gkdma4k9Xq4uD1t2cgvJC6u5Y2Iyvw0vHy
         AdRODGU+qzEZKj9HQ5PYWHs5Uugqo8QsGIMZbAyh6KYx6lfi2xKMOCz0CAluclXlpzYN
         72KRg/+pvsw3dSuxn28hz8XgRrJt6gQQxuU8omvOKgcwfPxb1K1rZOmtj7/+7OAQzF7e
         hxlIP39V2Y7wVhcMOsz2+GucKZ+5LT+qxtEUNk4UFPE++x3v+RgD8icSxvg8K3WpXGTg
         GXrZUcLhgv9JBf5CGOb7sdRAtALXXlhS9mwfnbEsL7kr2qIW2DO/SAH7WIhwnudYtIJj
         y5gQ==
X-Gm-Message-State: ABy/qLa5dkQA+ubdk/oYJT9g10M+E3WZPy5pleIi3TR4wwzrAJ6Vp32k
        jY5nbQJm++7VdPnZ+nVojMrzrGsBaPw=
X-Google-Smtp-Source: APBJJlH3A4i6GSxgiFWI/4QGziCQ4suEbOAKHJiYQ0gX6j+xWx5FnRurOSqrkbT5oVAx1jJ0nyvIFw==
X-Received: by 2002:a05:6a00:1355:b0:644:d775:60bb with SMTP id k21-20020a056a00135500b00644d77560bbmr3198339pfu.20.1688133692571;
        Fri, 30 Jun 2023 07:01:32 -0700 (PDT)
Received: from [172.17.0.2] ([4.154.90.97])
        by smtp.gmail.com with ESMTPSA id h9-20020a62b409000000b00658670ebe7dsm10042989pfn.119.2023.06.30.07.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 07:01:32 -0700 (PDT)
Message-ID: <649ee03c.620a0220.bde1d.3ba2@mx.google.com>
Date:   Fri, 30 Jun 2023 07:01:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2876465131280407538=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [RESEND,v2,1/1] Bluetooth: btusb: Add a new VID/PID 0489/e0f6 for MT7922
In-Reply-To: <242298f784e2bba8eb6d8c9a993ca7c0b9ca802b.1688008770.git.chris.lu@mediatek.com>
References: <242298f784e2bba8eb6d8c9a993ca7c0b9ca802b.1688008770.git.chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2876465131280407538==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761559

---Test result---

Test Summary:
CheckPatch                    PASS      0.58 seconds
GitLint                       PASS      0.22 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      38.36 seconds
CheckAllWarning               PASS      41.85 seconds
CheckSparse                   PASS      47.32 seconds
CheckSmatch                   PASS      126.34 seconds
BuildKernel32                 PASS      36.06 seconds
TestRunnerSetup               PASS      527.52 seconds
TestRunner_l2cap-tester       PASS      15.21 seconds
TestRunner_iso-tester         PASS      29.20 seconds
TestRunner_bnep-tester        PASS      6.59 seconds
TestRunner_mgmt-tester        PASS      153.73 seconds
TestRunner_rfcomm-tester      PASS      10.77 seconds
TestRunner_sco-tester         PASS      11.94 seconds
TestRunner_ioctl-tester       PASS      11.64 seconds
TestRunner_mesh-tester        PASS      8.40 seconds
TestRunner_smp-tester         PASS      9.36 seconds
TestRunner_userchan-tester    PASS      6.98 seconds
IncrementalBuild              PASS      34.75 seconds



---
Regards,
Linux Bluetooth


--===============2876465131280407538==--
