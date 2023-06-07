Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E857C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 10:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjFGKFx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 06:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjFGKFw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 06:05:52 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9F41707
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 03:05:50 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3f9b2b7109dso9651701cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Jun 2023 03:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686132349; x=1688724349;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fR6gV7/2KsKYxSx3K1zC53y8fm2mjOtWWfcxGS3gl20=;
        b=AJiRyBEtsfeyRFh8BjUQGTA/TiR71KXQsH547qpCEId09pKE1/iEcgOzSCVLeZkqHN
         76cigPL4GwbBgnz4YJ0DRHwYiuROj/9gc1NVrqquZ5Gh6QEvQB8KsPysGW5VecqhWOgC
         QDHwcQKufUQhXT5NnranTjAXYIDZTue+xTLZECjC6nX/gs67OMn8AZLzJh8R2AttxdJn
         +wMT3pBT9urR0FMksFvfeDxc2BOtpyvlt9w1VnIofX0tHIcF3flBnwIdjEFPB4WzdRe9
         WC6IYRD70X8+WUGJT8gkQZTHRTgMVP9comb0XCY+xpsSs6vnpQuiRUdOEYx8p5szJEIl
         sD+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686132349; x=1688724349;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fR6gV7/2KsKYxSx3K1zC53y8fm2mjOtWWfcxGS3gl20=;
        b=cxOIEyKcQTma9OvEhIMCcheaKEipywvXXHekS28GBBwcnosKfKh30p+j8X2e0OgIFz
         rR4iFqca2mBERZntNV+EBFLJ4KYCSQMeeGIZ1lXv92CfVuDA9a1scofAfE41NDVtIT2r
         9GRAbyXri8nNLmirPG/48aCyk8iaRIjDW30x0rx567F1me1BMBbZyFuOgjASz6fCvDXj
         wsSgyv62eR082T+i/0XSDQCSzUsOejznCvVHsWPW9hnpffjbCN6uEOPjaNK6NjOyePag
         IBDKIPiC/lv12XyTQxeU/7sDmNKrZORDyYPF7TvkL/ZNiJf7MeHrqOV09Nsmql1LuXmJ
         IRUQ==
X-Gm-Message-State: AC+VfDzaz6WkUw98CV89Xe5eSCbnTvCvcW0lPyfrhwJ3zNmuQnow/f2Q
        aKJvLQ0ddexy0/BhWiF4R0Ey7LUarUU=
X-Google-Smtp-Source: ACHHUZ76va+jBvIsKtV74ZsjclFDU+L7Y0J7Pa92NeRDOX0amJzNTyqX/M//8SD2N5BG/O0+ZO+zhg==
X-Received: by 2002:ac8:5954:0:b0:3f8:67d7:e99c with SMTP id 20-20020ac85954000000b003f867d7e99cmr2821144qtz.39.1686132349488;
        Wed, 07 Jun 2023 03:05:49 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.129.242])
        by smtp.gmail.com with ESMTPSA id f12-20020a0cf7cc000000b0062628f1d1dfsm5986792qvo.138.2023.06.07.03.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:05:49 -0700 (PDT)
Message-ID: <6480567d.0c0a0220.d836f.1d53@mx.google.com>
Date:   Wed, 07 Jun 2023 03:05:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5814579815548882564=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add initial support for BAP broadcast source
In-Reply-To: <20230607082300.4970-2-silviu.barbulescu@nxp.com>
References: <20230607082300.4970-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5814579815548882564==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=754766

---Test result---

Test Summary:
CheckPatch                    PASS      3.28 seconds
GitLint                       PASS      1.37 seconds
BuildEll                      PASS      26.70 seconds
BluezMake                     PASS      782.50 seconds
MakeCheck                     PASS      11.91 seconds
MakeDistcheck                 PASS      153.78 seconds
CheckValgrind                 PASS      248.53 seconds
CheckSmatch                   PASS      334.32 seconds
bluezmakeextell               PASS      101.15 seconds
IncrementalBuild              PASS      2619.13 seconds
ScanBuild                     PASS      1009.30 seconds



---
Regards,
Linux Bluetooth


--===============5814579815548882564==--
