Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6FCC001E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 10 Aug 2023 14:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjHJOg0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 10 Aug 2023 10:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjHJOgZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 10 Aug 2023 10:36:25 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4C82684
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Aug 2023 07:36:23 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-79093c0c68bso34446739f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 10 Aug 2023 07:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691678183; x=1692282983;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tX0P+Ep1uYRWnU4x0bu5olKyC344zDXhG/WShZYoo/0=;
        b=T+eVudjrgmNaKHHhBhm1CtdvoFU0KYkO+T+tbpkXCLeldP0/aOdvMWQaDS1Ym+HinK
         +PSwq6vuzmPJXV4wZChAtV0WIda08/92jTseYSAdKW/Lfoevyj1xW2eZJnW3vPF7uQZJ
         v/vTD0jFRhYsCL2u8wveVayrtWvtM2W8GNcRzRb7gvnKoNAwuEGHI3tyVKQzTrVd3Zdt
         IT8qqNEVf4THydvaAGZuuLwUILI5aC+TNR8fWBOSo0EoFKGHDBfZ420VJxUXizoyVvcT
         4hnuYWLvjqTlsvHkIlE/z7l041+F8jznh9Q5E+hRPOxw2xlSjZScQ7A+j7B/5cR6Na5h
         LNVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691678183; x=1692282983;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tX0P+Ep1uYRWnU4x0bu5olKyC344zDXhG/WShZYoo/0=;
        b=XzZfT/yGy2m+Znbdcn6LElKtTy3q+Uzbd2iQQ50I2xsI1v9d+f5Dr0Y4+8pm8A/1H3
         v0bS6WNtxj2uRhzg7bq0fhTFvwIatQAStRIfmtI6FGPKW2aT2ptZEG/H5pmwRy9olqMH
         Cig2R7XBT8Ig3T5/2K85dgF54kXfz8VMnV7tliVT+tpfpEm/AHEl42AhxxpNqeFVQPkM
         uGYGJuCmSx+SkIh7zXLYfhH9KmAo+AG51M/3v7kXfq6z0/CX7W0Mqs6khgQqr3TNQVDg
         LnOj+qlCqhBV3sVw/TY8U+8UK7Zl/y2/uYz1qEsjJNz7a3iFpLnhPfEN3YvL8legYYoc
         TWrQ==
X-Gm-Message-State: AOJu0YyrDSrK/WrB0SUKVUbiHs/vErk2HnvfuGsVddalJMC3qm66gj0+
        epM4VRnsFZ6emo+0Bv0xN8j7yF4uA4o=
X-Google-Smtp-Source: AGHT+IElW80NauEiLnp0VKCHY+7uxbhNz7qXA5MV6OjSSQZ717AkJhfMiSG+qu6ysSUY0hEMRC643w==
X-Received: by 2002:a5e:a613:0:b0:785:ccac:a4db with SMTP id q19-20020a5ea613000000b00785ccaca4dbmr3247561ioi.2.1691678183041;
        Thu, 10 Aug 2023 07:36:23 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.92.124])
        by smtp.gmail.com with ESMTPSA id r13-20020a02c84d000000b00430ca5e817fsm441111jao.61.2023.08.10.07.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 07:36:22 -0700 (PDT)
Message-ID: <64d4f5e6.020a0220.cec92.0742@mx.google.com>
Date:   Thu, 10 Aug 2023 07:36:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4709599791898078301=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Improve inband Independent Reset handling
In-Reply-To: <20230810135509.835889-1-neeraj.sanjaykale@nxp.com>
References: <20230810135509.835889-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4709599791898078301==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=774991

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      32.88 seconds
CheckAllWarning               PASS      35.82 seconds
CheckSparse                   PASS      40.56 seconds
CheckSmatch                   PASS      113.79 seconds
BuildKernel32                 PASS      32.16 seconds
TestRunnerSetup               PASS      480.11 seconds
TestRunner_l2cap-tester       PASS      22.35 seconds
TestRunner_iso-tester         PASS      44.96 seconds
TestRunner_bnep-tester        PASS      10.17 seconds
TestRunner_mgmt-tester        PASS      213.02 seconds
TestRunner_rfcomm-tester      PASS      15.43 seconds
TestRunner_sco-tester         PASS      18.38 seconds
TestRunner_ioctl-tester       PASS      17.15 seconds
TestRunner_mesh-tester        PASS      12.63 seconds
TestRunner_smp-tester         PASS      13.77 seconds
TestRunner_userchan-tester    PASS      10.68 seconds
IncrementalBuild              PASS      30.31 seconds



---
Regards,
Linux Bluetooth


--===============4709599791898078301==--
