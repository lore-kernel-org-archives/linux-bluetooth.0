Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7EAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Apr 2022 23:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiDDXJu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Apr 2022 19:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241064AbiDDXJe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Apr 2022 19:09:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2D04F475
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Apr 2022 15:40:56 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b13so10409113pfv.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Apr 2022 15:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=OEeWjyrCaPqz3xM+ATJ7k07/fIOk/PqodS/ki4FUm98=;
        b=KBjDYegvzzhHvxQdsrU8twj1P/9nIXhCq145DSio/3xFFYg3u7BwMruUaT3fnaSYrT
         EHs5F2j5WcEioNxSQIhEC78bYbzat4tvjiRLCvvnlxfE2a9X6ccW/DmjoWHDHlZPIsim
         p7QK3iVDpiKlbV8T/CLqciV8+1xkDxcezWu1xlbP8AxU8+hpzqEtCkTZXoDmXvoH3urs
         rlVgZCstB4imBz8MvM0m53G+9ICPlg0LTsyX4a/xPBdYmpWO6an5k8ESZUoXPqTPXf6v
         jb6pXyfP5R2ehSKmxiRyRZxFwiN7b1iUIr/qN7AlABOsAAP06bzJ5k1xPH14AiPN40+t
         FAUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=OEeWjyrCaPqz3xM+ATJ7k07/fIOk/PqodS/ki4FUm98=;
        b=Z/ZmFUBvTdycHTHHPieIGFzPYhBGABRNywcfsi+M/qMbs7w1AXJwnU1fVYhQbIrCMn
         /JdIVSIWP4DvIdmHXOauqn4n6aMb74eDI50Baq4XHFdgwgxz/8mbbuteHlOtxpGjWyg9
         1/gZXgt09aMrg8Ny6Dk8QfOa9hsuVa1hc3S/baFXYICVnRqC7nYlEyqX3lRqWY3fa/Gu
         SYRGbd7O8zVw4ZbXUTKPvglkidk6LPkdAuhVi1hfusAlhtEr021EGbMui+72mE5zUgfx
         Fc3EnHQqM34Cfjcm/BE/cNDuMH2n/gIABJJ/pNdfXDoDSb6SChNtOIRPimE+IFRTHMbq
         Tibw==
X-Gm-Message-State: AOAM5327KqewiwruT+SykRWICN5D+Utgr6dVAe1+1T7mky9z6di/mTLq
        6+rjyzzthLTcVyH6zj/zyboR5ptlX9Q=
X-Google-Smtp-Source: ABdhPJzf1lqOza5V9bhW3eVURF572Z/Dy1FowB8rW+YRlEBjAbq8Ys2HNm/jRFSRqu1QC0tiVlIvhA==
X-Received: by 2002:a63:6c04:0:b0:398:54fb:5632 with SMTP id h4-20020a636c04000000b0039854fb5632mr349623pgc.78.1649112055953;
        Mon, 04 Apr 2022 15:40:55 -0700 (PDT)
Received: from [172.17.0.2] ([13.93.183.166])
        by smtp.gmail.com with ESMTPSA id o14-20020a17090a4e8e00b001caa2ac128bsm154110pjh.28.2022.04.04.15.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 15:40:55 -0700 (PDT)
Message-ID: <624b73f7.1c69fb81.c472c.0b63@mx.google.com>
Date:   Mon, 04 Apr 2022 15:40:55 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8832094593401862059=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RFC,BlueZ] gap: Don't attempt to read the appearance if already set
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220404201750.1082470-1-luiz.dentz@gmail.com>
References: <20220404201750.1082470-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8832094593401862059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=628906

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.45 seconds
Prep - Setup ELL              PASS      45.95 seconds
Build - Prep                  PASS      0.44 seconds
Build - Configure             PASS      9.39 seconds
Build - Make                  PASS      1311.83 seconds
Make Check                    PASS      12.17 seconds
Make Check w/Valgrind         PASS      472.21 seconds
Make Distcheck                PASS      252.30 seconds
Build w/ext ELL - Configure   PASS      8.86 seconds
Build w/ext ELL - Make        PASS      1291.83 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============8832094593401862059==--
