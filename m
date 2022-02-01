Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298ADC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Feb 2022 21:00:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242674AbiBAVAw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Feb 2022 16:00:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242667AbiBAVAv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Feb 2022 16:00:51 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B39C06173B
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Feb 2022 13:00:51 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id v5so15569648qto.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 01 Feb 2022 13:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=VoCRSAgSciVlpTRzcLOZwMX3cqeOBgvgl+vCcWQwQlU=;
        b=FRL0NuNmlashv7mB1ZrAJFWWPwwH+moRlrb+UOm8qjeNDx+rHXi0TLO1Tc/yG6x9C6
         dfxE5ovWmd6l9r8GIarXC1PN9I7kWb+X/DY6tPCYXuf3zvg4/lQmJBLyQRoWm5D291Kj
         00ewfk6Zdgl7JBt1iRIXxaeeUbe0o/U3dHyD0Zi84JlmuycTDzHyVqyZdjUmBkYibIJ6
         63846gJslpNvDtyDRO2NBQ0N7vy5X1xTJTjDl56hNIAhXpsysBKIJuVe73x94kblfB/6
         +WpniLY2CERZx48YdY16jYPKolsZxQR7KZNwDwae8zqviv6SVpkLPodXvz73WCuhr8pz
         UL+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=VoCRSAgSciVlpTRzcLOZwMX3cqeOBgvgl+vCcWQwQlU=;
        b=n2L8fkGnNQT4s9hO6h1/benaqqHp5GMY6Nndt1lMrlGFKs3mal1uGkLNRzNo0HXAx2
         adkWx+GGZHaFK78OkMU2SUwEPxGbma/F/sftLNcK16WQP1kiCcdDZHREno+kGM2Whp8V
         tY97z/MJb7wcCyn1kS6Rmj1iJyW9/K1CiCozs6dzEpJbUt/Fq5E3DyT+pemo3OvdsC8S
         FX9Z29QH+l3WNIt+30fnK9DDR3RloXxN5y6PInZvy9RtrpH54gv6aHpYl2ilyaMPtJId
         uWpoGU1KRks/2JdvmJu3e7s9RS4jYnW4NV3Va+JpfETjddGJS7j6V3f8Id8b1RlJMSeA
         n4Bw==
X-Gm-Message-State: AOAM532yuifDrD0eHtEbIPvKoU6zmkjEpEYkP4Bpj7MIW2l1cXpEYWk+
        jSMtiR/vSXE/6qbsC/Aj7xZw+z5nYm7s/A==
X-Google-Smtp-Source: ABdhPJzaNNQlqtrCoFc9dnHbNsYZZTWOyOfFOPlgfu7g4bSZhg9g9EftyeWz20aML9G0OqjWvHqrhw==
X-Received: by 2002:a05:622a:1111:: with SMTP id e17mr8108509qty.229.1643749250178;
        Tue, 01 Feb 2022 13:00:50 -0800 (PST)
Received: from [172.17.0.2] ([104.46.119.27])
        by smtp.gmail.com with ESMTPSA id g21sm8168996qtb.70.2022.02.01.13.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 13:00:49 -0800 (PST)
Message-ID: <61f99f81.1c69fb81.c83b4.3c24@mx.google.com>
Date:   Tue, 01 Feb 2022 13:00:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4151261914609526638=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, rad@semihalf.com
Subject: RE: Bluetooth: Fix skb handling in net/bluetooth/mgmt.c
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220201201033.1332733-2-rad@semihalf.com>
References: <20220201201033.1332733-2-rad@semihalf.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4151261914609526638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=610483

---Test result---

Test Summary:
CheckPatch                    PASS      3.42 seconds
GitLint                       FAIL      0.97 seconds
SubjectPrefix                 PASS      1.62 seconds
BuildKernel                   PASS      30.41 seconds
BuildKernel32                 PASS      26.95 seconds
Incremental Build with patchesPASS      49.00 seconds
TestRunner: Setup             PASS      472.42 seconds
TestRunner: l2cap-tester      PASS      13.35 seconds
TestRunner: bnep-tester       PASS      6.15 seconds
TestRunner: mgmt-tester       PASS      104.64 seconds
TestRunner: rfcomm-tester     PASS      7.53 seconds
TestRunner: sco-tester        PASS      7.62 seconds
TestRunner: smp-tester        PASS      7.61 seconds
TestRunner: userchan-tester   PASS      6.44 seconds

Details
##############################
Test: GitLint - FAIL - 0.97 seconds
Run gitlint with rule in .gitlint
[v3,1/2] Bluetooth: Fix skb allocation in mgmt_remote_name() & mgmt_device_connected()
1: T1 Title exceeds max length (86>80): "[v3,1/2] Bluetooth: Fix skb allocation in mgmt_remote_name() & mgmt_device_connected()"




---
Regards,
Linux Bluetooth


--===============4151261914609526638==--
