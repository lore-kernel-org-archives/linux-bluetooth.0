Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC1A2EE14C3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 22:01:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbjIFWB4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 18:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjIFWBz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 18:01:55 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A5D8172E
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 15:01:52 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1ba5cda3530so240384fac.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Sep 2023 15:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694037711; x=1694642511; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HV8+Zssx8eZCZS+LHCkSvB3tAFJT+HVgXUjoYfvqk7g=;
        b=i+4tDSY2jDJGgad5tfphVou2ZgraRQ3y2c3+rlZ0uyiHDrBusQlNUFxFmr0CmQ9wSM
         V0AhBz9KpmcYX0Uc9NY4bIu132qxWlZH4lvnCbCzf0sCJ7LX7pMrGEddCSK9YcWoQ9aq
         uf+w9xJsdMiHX5GoPdgDC3E+U1JqHDpmrZeSCn8WjTkeISJVthJgJzddz4Nt14Kq+vCM
         LmgFkYJIgDZViqlJrMF2Fe58VAvi9NORdEdz29wnCSQ/p/FTwSPJ7ok2BxQq37CT7kxK
         RdrZIT/VEAlGXKX5RbgJD/PynRYWjZIOhYeB3i054ChLW0Q9srt0nVyDtAbBLciP5swP
         zxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694037711; x=1694642511;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HV8+Zssx8eZCZS+LHCkSvB3tAFJT+HVgXUjoYfvqk7g=;
        b=IJSDxNfOv5yg2EFKC9AQCI2jXlSY4MVXd/E0XAErGsL3feXcaob1X8l0LUmKDkEkHQ
         0UhDvPUYWjsfJo7DoMjCWWSoTrDYDzWDR8O1r2e4WRp46h53mXaNhYSEjbg+SkCu+6SF
         8s5Fu88P7y6bJYUoFFUAvRw2WIeVDlqwWMEWdtJXQE/2Gaji01bAuzUo4oRfaYGD7DlJ
         aMCpITZeJz9HrgEwx3g7NFGqQaKlAJUSgBj3kncrRzjei80iwu0fovnxj7PuCSPb/9zT
         B5+hPV+0j5z8q3OhG50PcKMOTjAVzKU710VHYHSE8vqNp9rNacqHArCuecCL3qETavwk
         h6dw==
X-Gm-Message-State: AOJu0YwJldzuXGlsejdsy4YorSUafxd9MFbopLGIhKuCdLMPNSLAHB3z
        uOve1NTL06zF259Zh0S6/qXuPJLQ4nc=
X-Google-Smtp-Source: AGHT+IE/vly+wX+uSgSzirNDbMtA3bAfTxS4+LqEuJD67tcT9gt6f8V4oB6RBHxvI8mN55VtNnhspw==
X-Received: by 2002:a05:6870:4205:b0:1ba:d044:8a4 with SMTP id u5-20020a056870420500b001bad04408a4mr21321718oac.18.1694037711122;
        Wed, 06 Sep 2023 15:01:51 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.132.55])
        by smtp.gmail.com with ESMTPSA id u7-20020a05687036c700b001cd0f7aeee7sm8173848oak.2.2023.09.06.15.01.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 15:01:50 -0700 (PDT)
Message-ID: <64f8f6ce.050a0220.913d6.16bd@mx.google.com>
Date:   Wed, 06 Sep 2023 15:01:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7130394795150335025=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_core: Remove le_restart_scan work
In-Reply-To: <20230906211335.2124615-1-luiz.dentz@gmail.com>
References: <20230906211335.2124615-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7130394795150335025==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=782088

---Test result---

Test Summary:
CheckPatch                    PASS      1.03 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      33.82 seconds
CheckAllWarning               PASS      37.18 seconds
CheckSparse                   PASS      43.04 seconds
CheckSmatch                   PASS      113.93 seconds
BuildKernel32                 PASS      32.74 seconds
TestRunnerSetup               PASS      490.66 seconds
TestRunner_l2cap-tester       PASS      28.32 seconds
TestRunner_iso-tester         PASS      52.67 seconds
TestRunner_bnep-tester        PASS      11.17 seconds
TestRunner_mgmt-tester        PASS      224.61 seconds
TestRunner_rfcomm-tester      PASS      16.88 seconds
TestRunner_sco-tester         PASS      20.19 seconds
TestRunner_ioctl-tester       PASS      18.75 seconds
TestRunner_mesh-tester        PASS      13.93 seconds
TestRunner_smp-tester         PASS      15.04 seconds
TestRunner_userchan-tester    PASS      11.76 seconds
IncrementalBuild              PASS      31.05 seconds



---
Regards,
Linux Bluetooth


--===============7130394795150335025==--
