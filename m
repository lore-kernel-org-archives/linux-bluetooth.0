Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E6DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Jul 2022 11:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbiGNL4a (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Jul 2022 07:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239139AbiGNL4Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Jul 2022 07:56:25 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A581D5C362
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 04:56:24 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id y12so808234ilq.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 04:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=C8BBNzUf3Cfn4y+vuOL7zfp+aQso7KnwTz3jhX0sLcY=;
        b=YAfAJsOFMidG8cqY+xSNv3f+IpgMopE+AIm6KZZIgg/NYgkke34vrRa9haKEPYmwNk
         V9N0dgYQDENvBK/v/uav4rJ99mECu1RhunyhYLJ+Jq7SPCQ9Iw8UMH68ZFtOtFkVkZ52
         dtrucvf+RLjALIpiKLnVyVd+ViijsDeuXXWkdkLpVPiOr1JIbguQEIvBp3CtrizwMGoN
         k/UyWCzKJ2MBtwrkkoDxfsX4wRROGUvMI9wnjMVUwEkttiJIJquFCYgMZjaj2nPSWHpw
         bQbhD8pNJq66optevINham7a+TyJBXYLsDQlHVvhSzALWWWCZxHArRJ21baO5gZsz+U3
         9sFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=C8BBNzUf3Cfn4y+vuOL7zfp+aQso7KnwTz3jhX0sLcY=;
        b=BQunqr03xLTPOimDLZxD9r0U5J8M+rVBz7hcza4TqEOSarSgVatGMJ4Opm2V1+tCMe
         f4UDMABOtOmCdsIT59DeNh8QIsj4+cVGn6L3cI6xwmvFD6kcZ5zgZmq8x8crm46U32jA
         /5BKMPvdszsA0NeRN1s0kJQ+Jm1RhTv122wMO0yj3mvVzkxD/TrnuquN0S442/SnFVAH
         sci8rdz17P+RK1xleT7QcJP/zMUrfhCyGIJFe1NXcms7G1VNyx/JUpVPsBO/rFVBNGnv
         7qg8Xoc1aBtzHjmAPNxl74hFPEZZYKUTftxsov73ml2BC1cf+SInrx0HBkqxZe14clPq
         SF4A==
X-Gm-Message-State: AJIora/+p0kvDAOPaueGAOSqyXsRFD7DnB0ZRph90zyTgJvnBP2fFx9K
        JS9A+kVONrGN8nLm/bOnahOij4r+Oro=
X-Google-Smtp-Source: AGRyM1u/gSuoGQfnBu8Uov4TKdoxaCnUM+Iq7ZV5il9K5LijuhoThEe8ooEZrrbDpYQafaglLcOHzw==
X-Received: by 2002:a05:6e02:219d:b0:2dc:41c2:a1f3 with SMTP id j29-20020a056e02219d00b002dc41c2a1f3mr4605414ila.79.1657799783639;
        Thu, 14 Jul 2022 04:56:23 -0700 (PDT)
Received: from [172.17.0.2] ([40.69.174.47])
        by smtp.gmail.com with ESMTPSA id e12-20020a056602158c00b0067b7360dd5dsm716505iow.4.2022.07.14.04.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 04:56:23 -0700 (PDT)
Message-ID: <62d00467.1c69fb81.509db.0ad8@mx.google.com>
Date:   Thu, 14 Jul 2022 04:56:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0150023980461465143=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: Bluetooth: btusb: Add support IDs for Realtek RTL8852C
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220714112523.13242-2-hildawu@realtek.com>
References: <20220714112523.13242-2-hildawu@realtek.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0150023980461465143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=659673

---Test result---

Test Summary:
CheckPatch                    PASS      6.32 seconds
GitLint                       PASS      3.65 seconds
SubjectPrefix                 PASS      3.03 seconds
BuildKernel                   PASS      30.74 seconds
BuildKernel32                 PASS      26.89 seconds
Incremental Build with patchesPASS      62.72 seconds
TestRunner: Setup             PASS      462.91 seconds
TestRunner: l2cap-tester      PASS      16.39 seconds
TestRunner: bnep-tester       PASS      5.49 seconds
TestRunner: mgmt-tester       PASS      94.26 seconds
TestRunner: rfcomm-tester     PASS      8.89 seconds
TestRunner: sco-tester        PASS      8.68 seconds
TestRunner: smp-tester        PASS      8.74 seconds
TestRunner: userchan-tester   PASS      5.73 seconds



---
Regards,
Linux Bluetooth


--===============0150023980461465143==--
