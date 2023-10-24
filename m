Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA517C00A8F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Oct 2023 12:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbjJXMKD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Oct 2023 08:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233761AbjJXMKC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Oct 2023 08:10:02 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25BF128
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Oct 2023 05:09:59 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-586753b0ab0so238521eaf.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Oct 2023 05:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698149399; x=1698754199; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GVjMRHoDvrPxt3bvuIflQcBrerls6H3ThOaDxMZWOH0=;
        b=bsgEGvPX6oEVGQPN36UG+QPDXEwCxmkQnMxymdkXQftengSlkzfU9bWUB9FSq7TQRk
         rx3MtmBOsZIZjxp2Xp3rYHuTpxaEYvfHiP6Oi+nCNYMoFIv6HNFX5HWg6/pkDH4QcUxS
         5ZgX8l7GEjw6/YbZXgTaq43oFVlOPdojPIZd//DaVUCfr0QTTEZs7EKO4Hg/KKPdjfjS
         99xyaW3wnIlUd+ZMArr4/bLJVQCuBi93YlL9PgWoodT9VzEq0dhaFwdTzQZ4jgRpeLKU
         QeDFBE4IcIdUXPvM3rg5M6PJE8WcSQWsu4eC4jFq09ez35hTXrZAlDm2JDsR+lH8BoQI
         lgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698149399; x=1698754199;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GVjMRHoDvrPxt3bvuIflQcBrerls6H3ThOaDxMZWOH0=;
        b=spXsOYEihbWTq9llefyze29LNGas/iIvH06wCYg/S04Zc5pJheri+YKrSFXTonIZGI
         dahF1sbfxgToTp9WeDF8cyX1TD1SwTq5Els6Vq0S9qhbKg7mFasG0rd774XY3lEtCdLL
         fmL86ZUn3VTUlEAfga6bQhwkUscDySvwVp8M3cfQb2EWku8PyFyFTv32mm6Oaau9U6UW
         RG5jHC2xn6CUCLCQQ04cO4PMOF55T0g285Pb5oPOvEEAqChXdkN+2Bmy+N0xyJpRU55T
         18WoHqhczc2HJzVSH/guUc+oxnOD9Bt2LZHnQwXad8vzza14hsASiVGrs2kC8/sPeRsB
         OEmg==
X-Gm-Message-State: AOJu0YyH5ZiNMRfAyG10hTIXp+IxkrZKODh6I9aK4W8h4xxkQMDFg5VD
        39NOXi9Kz60124HV1lv3al2KZDuvNpI=
X-Google-Smtp-Source: AGHT+IH3rI435oAw1lD0cN5sEl3k2qNtADiZm9ag18VpulKAhHQXlf2JXdHdVAE6qYl4s0YUUEbyJg==
X-Received: by 2002:a05:6808:138f:b0:3a4:2204:e9e6 with SMTP id c15-20020a056808138f00b003a42204e9e6mr15682853oiw.21.1698149398798;
        Tue, 24 Oct 2023 05:09:58 -0700 (PDT)
Received: from [172.17.0.2] ([104.210.132.171])
        by smtp.gmail.com with ESMTPSA id t1-20020a0568080b2100b003afdc0f000esm1937378oij.9.2023.10.24.05.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 05:09:58 -0700 (PDT)
Message-ID: <6537b416.050a0220.278ec.a533@mx.google.com>
Date:   Tue, 24 Oct 2023 05:09:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5147392144496901235=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: btio: Allow binding a bcast listener before accept
In-Reply-To: <20231024110430.3323-2-iulia.tanasescu@nxp.com>
References: <20231024110430.3323-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5147392144496901235==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=795983

---Test result---

Test Summary:
CheckPatch                    PASS      0.52 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      27.76 seconds
BluezMake                     PASS      789.97 seconds
MakeCheck                     PASS      11.45 seconds
MakeDistcheck                 PASS      172.73 seconds
CheckValgrind                 PASS      265.21 seconds
CheckSmatch                   PASS      357.15 seconds
bluezmakeextell               PASS      114.79 seconds
IncrementalBuild              PASS      683.68 seconds
ScanBuild                     PASS      1039.55 seconds



---
Regards,
Linux Bluetooth


--===============5147392144496901235==--
