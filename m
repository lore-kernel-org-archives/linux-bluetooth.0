Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21685C761A6
	for <linux-bluetooth@archiver.kernel.org>; Sat,  1 Apr 2023 02:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbjDACQ2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 22:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbjDACQ1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 22:16:27 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37BE3E072
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 19:16:23 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id a30-20020a9d3e1e000000b006a13f728172so9690817otd.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 19:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680315382;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=el92BjI67uAMS2nMUj16UsLC6e81lPQmetHLA+v5FJg=;
        b=Yh05I0XPajgV4gB2FGNJqCyDIaPZj3x4fLvQGJ6BE1GRlIcryge7TkSfaOjETmqxN0
         ppB6whq8jUv1e0Gy4s6o64lefaiL9WayEbEeO068C0ITA2diSmZHIa4cHhXYVSHravZ7
         elaT478mNZfyOxxjjet6ATZQU1QAy8D7LuvWOaUYEMzFFGX2iPBpPWKNNWvJNk3n+Hg0
         V4VHlLFatibcLEwXfGO2KT1faEpYjuzFbK2kHGcJb/wMKD4+U9Tk2Sco74hSkMwou4pV
         YKp837e+jdjImF+Ncyei2Li/bIBhmfpHKKIFE2mk7rGjC2l3GK3hrRE+XuKZ1n7Ft7c/
         Mfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680315382;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=el92BjI67uAMS2nMUj16UsLC6e81lPQmetHLA+v5FJg=;
        b=BSaHsdQ78T9UptN20E4GgYFowygtX7V7ihvhirlFUkLcvCdQ0AUJ218ycSKta9FqbB
         ziCOLyr+WAixfjnRyXVAflpcGcNuXuBUhg6IGfiCvUWENETg5xUYPrqyDsId047ieKQQ
         ynxtUASUOR4vnm1De6K3XSegq7iN/IkQuUWkmO10/Lqh5jQS8AUnSfUEctGN6TnMjDSN
         phlgOx5eO3MfPcT/A4DIROEkW+yhpjVkug4hbRwh7sr9Crps4ZQUE8vVeZMpbLZut/Fd
         HSbMar1TuctoM3VAbBWP/MCEvCJt2M8J2d2K3HMCUskYOO9OuJfnvURPbJ4Mxej/AGjY
         MCkQ==
X-Gm-Message-State: AO0yUKVwFmKdpWULDJ7xbB54MZM/7JhQ7G7Wpgs0Rhx4Ib6cKzBKYQ1j
        fSPaN7ci4mHWzaG0lcFL/QHUHXcxHcY=
X-Google-Smtp-Source: AK7set++oeK7fPJoR5oI22HHv+BbHmrM6V9h9bNQ39K1z+hOMvoPHFe1SgjGeRZe8OymLIF3WmioIg==
X-Received: by 2002:a05:6830:2003:b0:69a:4b77:ff6c with SMTP id e3-20020a056830200300b0069a4b77ff6cmr13676108otp.8.1680315382429;
        Fri, 31 Mar 2023 19:16:22 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.10.114])
        by smtp.gmail.com with ESMTPSA id w10-20020a4aaf0a000000b0053479edbc17sm1489926oon.33.2023.03.31.19.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 19:16:22 -0700 (PDT)
Message-ID: <642793f6.4a0a0220.4b59.9a4c@mx.google.com>
Date:   Fri, 31 Mar 2023 19:16:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1266596194061432993=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@gmail.com
Subject: RE: [BlueZ,v2] mesh: Tighten IO and fix out-of-bounds array access
In-Reply-To: <20230401001602.4161-1-inga.stotland@gmail.com>
References: <20230401001602.4161-1-inga.stotland@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1266596194061432993==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=736008

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.32 seconds
BuildEll                      PASS      32.36 seconds
BluezMake                     PASS      1087.84 seconds
MakeCheck                     PASS      11.80 seconds
MakeDistcheck                 PASS      174.57 seconds
CheckValgrind                 PASS      280.45 seconds
CheckSmatch                   WARNING   387.23 seconds
bluezmakeextell               PASS      113.54 seconds
IncrementalBuild              PASS      892.63 seconds
ScanBuild                     PASS      1250.51 seconds

Details
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
mesh/mesh-io-mgmt.c:523:67: warning: Variable length array is used.


---
Regards,
Linux Bluetooth


--===============1266596194061432993==--
