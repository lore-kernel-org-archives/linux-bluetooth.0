Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63551C00A8F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Oct 2023 11:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjJXLgT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Oct 2023 07:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbjJXLgO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Oct 2023 07:36:14 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88218AC
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Oct 2023 04:36:12 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66d0169cf43so29261766d6.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Oct 2023 04:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698147371; x=1698752171; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7ci0lUb+Lht/Ns6V8CFrCJ+SgvnOIk3+YvXiC63jiVc=;
        b=iZwyj2CwH3K9YSjB9x9vRHPWq/a5B3Ug5y6vNY1BGFmxSpEwOChS9AT8VRzENAKjom
         ibLyG8LZVMwdHncXQR77I16SutrN996yvU52aK34fiLcgUKNq4MDXLAmXdcq80WV/SaL
         t2PX0msj+sedA+BXff3NisDeQBgXWRDlCI/Vi6mThPdsshK3ALvf53aRr59pz0EYGimb
         VURDUXTmzRUI+ZTN7tHvabJFhn8RREa5fvu0nNhvEY+yCo30wSOPzLlSym+T+lYydHVu
         QPZV3Wzxm54jPWKOngwo4oeUn4SmjoMiuEpCvOV5DGBZ7JmRScb0jk2HC/cXeKzW4lER
         Vu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698147371; x=1698752171;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ci0lUb+Lht/Ns6V8CFrCJ+SgvnOIk3+YvXiC63jiVc=;
        b=do+knJZjMYEd7BkYNwemPCKd2/l1ZXg97TOXLn+PixQzjpvY8O4FUMqIZoNeeAaDSd
         H52pI2ak9qHmGB71XtJqmnoy0n8pdTysM9VVCIGPGcay4dn32T61+/Bylr0CWQW9/ygM
         a/8AUHLY2zIT+EgtQrk64H0EoVdTkoF2MquKLiGFTrJukbVTS50L+6C0rIW1q0qpx0yA
         QQ8J9o1s18glIQnP9V5XM2bSiLRotg32MILABEmIPHK7PvuN6HZ9NEEftE3N6PW95Nap
         cVH25zAMfhejGxYFzEWJt+YDYbAXLkr1pTCmXU+cki4HGtB5kjQY7t66hxLCxqpAPXJZ
         AC7g==
X-Gm-Message-State: AOJu0YzK5UJR0fA86kdggMBaLp8Uno4RWSfzO8tJVgSPw3eePi5UfvuH
        VGDSBHyQnTK8XJY5vCZI1tQSMdAaXGk=
X-Google-Smtp-Source: AGHT+IFDA4e7Rq9YYCrIVzcvVX8idcdQffuDQlckewFZwzNVX5Dnyz8NIixN0VEYjg9Se8U2pDJXYg==
X-Received: by 2002:a05:6214:500a:b0:66d:1ff3:31ed with SMTP id jo10-20020a056214500a00b0066d1ff331edmr13103158qvb.52.1698147371580;
        Tue, 24 Oct 2023 04:36:11 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.214.57])
        by smtp.gmail.com with ESMTPSA id y18-20020ad457d2000000b00655d711180dsm3579576qvx.17.2023.10.24.04.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 04:36:11 -0700 (PDT)
Message-ID: <6537ac2b.d40a0220.5c89a.d142@mx.google.com>
Date:   Tue, 24 Oct 2023 04:36:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1897343673911961835=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Allow binding a PA sync socket
In-Reply-To: <20231024105735.3216-2-iulia.tanasescu@nxp.com>
References: <20231024105735.3216-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1897343673911961835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=795975

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      34.16 seconds
CheckAllWarning               PASS      37.40 seconds
CheckSparse                   PASS      43.43 seconds
CheckSmatch                   PASS      115.73 seconds
BuildKernel32                 PASS      32.94 seconds
TestRunnerSetup               PASS      515.77 seconds
TestRunner_l2cap-tester       PASS      31.09 seconds
TestRunner_iso-tester         PASS      51.02 seconds
TestRunner_bnep-tester        PASS      10.45 seconds
TestRunner_mgmt-tester        PASS      213.20 seconds
TestRunner_rfcomm-tester      PASS      16.04 seconds
TestRunner_sco-tester         PASS      19.47 seconds
TestRunner_ioctl-tester       PASS      18.69 seconds
TestRunner_mesh-tester        PASS      13.23 seconds
TestRunner_smp-tester         PASS      14.29 seconds
TestRunner_userchan-tester    PASS      11.09 seconds
IncrementalBuild              PASS      31.23 seconds



---
Regards,
Linux Bluetooth


--===============1897343673911961835==--
