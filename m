Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B00D3C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 08:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbiKRIgs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 03:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241559AbiKRIgd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 03:36:33 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5269B
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 00:35:53 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id k2so1735470qvo.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 00:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WUZlOPCbzYv5EuD1bbpj6pDWNU3oAqBww84IIyGP4s0=;
        b=mHSaJ9Ru/Y0YfPqYQ6ZFoLFkXIy1eUZXDELSFIVrlkltA3gJ2Tzzb7/su3klDpDtgc
         PYxbwJvivAvANphwi0erj7uimtE0tww7twsL84S9qb74TI37Rfc/j1gDRU0KJ5oMo277
         aHG3uT+dd2JfOn4kmSKhLG8feFTopZepJn8w5mNeV3tglgjI9bjPKNvjYIooobZrvLc8
         odJoPHtTNUULI1vZUlTiookPZrAcvw3E3uJk8AIlCvRFuukuGMpm3y+8Sta9SV8a0Rty
         8T2ErKOwQnlLCAuDMBQ5IwntLT/18o1PovZag2z6cX+wseX90EdR0FpkBqaRvFedozgC
         wYOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WUZlOPCbzYv5EuD1bbpj6pDWNU3oAqBww84IIyGP4s0=;
        b=RTq7h36MUqR0QzqyB2dPTauRw1a4P4Hz7jOgF5WyBkw8EOfR/F9xwUx62parstzwK8
         fIMKBu17zZxrfd1pI+80yKi8+UG2yeTnn+ifNa7wGKR0tSLPJXZNsRFP8ulmeYn8Y3RI
         osoIKx3akMcc64dJjj9/T1863wSZAlTKdZL2T/ZvXIloXd1uIyz8MC1ol21azKNbPSYb
         X5ebbiHx1i+JgG/L018YSMm/pqw0SBXMLDmqk7+Pauy+yn81ZOBXuxAnIVyA4pJGRXYj
         D9P3tJpRCjDsTsycwkEKGU7EuD44PCEuYSrpm9uM5kaNB5r0LPRgJ13iAzGy6PuMVJrj
         PF6g==
X-Gm-Message-State: ANoB5pmLisEUdYr0VOe8ZJws4oYznDVbIGu6RUMGpBcJRTLRDbhXY9dH
        xWT4NQaJrk4hThosqFt28Lfy+cB9Gb1WVA==
X-Google-Smtp-Source: AA0mqf4UNoijC0DYmUtvJo1l3qcCv5AUdioWRuSy5UnuPYIxj/3nqsSUr6Asdjveeofd8X0qP85LZw==
X-Received: by 2002:ad4:4d53:0:b0:4bb:63ed:152e with SMTP id m19-20020ad44d53000000b004bb63ed152emr5813302qvm.131.1668760552483;
        Fri, 18 Nov 2022 00:35:52 -0800 (PST)
Received: from [172.17.0.2] ([20.124.226.220])
        by smtp.gmail.com with ESMTPSA id fy11-20020a05622a5a0b00b003a4f435e381sm1702372qtb.18.2022.11.18.00.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 00:35:52 -0800 (PST)
Message-ID: <637743e8.050a0220.a4bb3.807e@mx.google.com>
Date:   Fri, 18 Nov 2022 00:35:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1871277112596871335=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: btusb: Fix enable failure for a CSR BT dongle
In-Reply-To: <1666868760-4680-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1666868760-4680-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1871277112596871335==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=689388

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       PASS      0.38 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      40.46 seconds
BuildKernel32                 PASS      36.13 seconds
TestRunnerSetup               PASS      499.62 seconds
TestRunner_l2cap-tester       PASS      17.88 seconds
TestRunner_iso-tester         PASS      18.09 seconds
TestRunner_bnep-tester        PASS      6.41 seconds
TestRunner_mgmt-tester        PASS      120.42 seconds
TestRunner_rfcomm-tester      PASS      11.05 seconds
TestRunner_sco-tester         PASS      10.12 seconds
TestRunner_ioctl-tester       PASS      11.56 seconds
TestRunner_mesh-tester        PASS      7.97 seconds
TestRunner_smp-tester         PASS      9.74 seconds
TestRunner_userchan-tester    PASS      6.82 seconds
IncrementalBuild              PASS      38.24 seconds



---
Regards,
Linux Bluetooth


--===============1871277112596871335==--
