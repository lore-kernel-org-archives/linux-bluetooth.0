Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E42FC4167B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Oct 2023 19:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbjJaTE2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Oct 2023 15:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjJaTE1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Oct 2023 15:04:27 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4091CF3
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Oct 2023 12:04:25 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-66d17bdabe1so41204586d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Oct 2023 12:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698779064; x=1699383864; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S9h+evqCgOFKqz1WviExD2z1ZpySL7NEK8nGHBZJtx0=;
        b=PH9zrojO+xPhBx8ng7iPSkXIGXXGAXY3FAGZWhsuueQGIbqp9nmC2QcCOR2SZ5+39L
         C526vBJJmxQo1eZZr/rN6OqkYPdmuPGL8rQRy3ccu/Bvi+7/jn98A3mJJo8ZQT5RjiOE
         ClFGJEUmA/tkp3eMqvl4rlvCd9Dw/KBQOf8OojSQSWWvusoGF5DI10xmyI+/LGYE6wRU
         je6H3Pujp6l4BHhmj1aLNq36GCSh2yGbB9us8OufkZnxqEPVJvakGwCuCRMNXQmYykm4
         Ec7bOzW1DAwyEkJkdrFLwuG6RmkX3zvTXwj695qQFQ9LSM4fEUfRRZWgcvMnLWfrhIfT
         DouA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698779064; x=1699383864;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S9h+evqCgOFKqz1WviExD2z1ZpySL7NEK8nGHBZJtx0=;
        b=FI3axRqw8fRoRYiXTjQLd3/V0IM9ecw5OS24/oOBkhPOmLvQ6z3ikhEYg0iu9kC1g2
         T/2IR7dZyhhKpeVkP6KpPjaAKB9ZljtcFQ1RMzBs5MwCgixbO12BHgPEnaukx5BZUjWq
         uNT7qGJNfmn6pkeXH1PzPU64KntkSjMnn3u3WJlv+3gxHMu4WfVzGUDizX6E9/hhWcUa
         pfbL9vICCfz8flhvzP/YXVQzlPj/zz5OAlNYPS9rc3BlU5Z0nuIAnnhl4grK/MK7ZEcR
         7zgQacBiZxb4QrHYtTBqCirudmHMM3+jf3tYR1qYPlNLqCkHSC/lWITgljvRTb5DPJke
         sXnw==
X-Gm-Message-State: AOJu0Yw426njvp8s3SdWcK/XVDMjKmUh/2gn58bf/JKdhiAl1Yfms9+L
        YtRYhFAHnS98AO863vfvWmmbTkvASKU=
X-Google-Smtp-Source: AGHT+IH8UVIf/R3ET1F4iJbvQIs8jjQq55+yEo44XuoKtDfFumQ8bdYxX6v/AceVYMaQhuESJpkD1g==
X-Received: by 2002:ad4:5ca2:0:b0:66d:3723:294b with SMTP id q2-20020ad45ca2000000b0066d3723294bmr14169083qvh.64.1698779064148;
        Tue, 31 Oct 2023 12:04:24 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.202.145])
        by smtp.gmail.com with ESMTPSA id nd8-20020a056214420800b00670c15033aesm754351qvb.144.2023.10.31.12.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 12:04:23 -0700 (PDT)
Message-ID: <65414fb7.050a0220.c09ec.3dbf@mx.google.com>
Date:   Tue, 31 Oct 2023 12:04:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4005863280457378007=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, silviu.barbulescu@nxp.com
Subject: RE: Add support for bcast multiple BISes
In-Reply-To: <20231031155535.228994-2-silviu.barbulescu@nxp.com>
References: <20231031155535.228994-2-silviu.barbulescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4005863280457378007==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=797953

---Test result---

Test Summary:
CheckPatch                    PASS      4.10 seconds
GitLint                       PASS      1.89 seconds
BuildEll                      PASS      38.22 seconds
BluezMake                     PASS      1310.68 seconds
MakeCheck                     PASS      13.90 seconds
MakeDistcheck                 PASS      245.22 seconds
CheckValgrind                 PASS      362.91 seconds
CheckSmatch                   PASS      504.06 seconds
bluezmakeextell               PASS      162.77 seconds
IncrementalBuild              PASS      5777.47 seconds
ScanBuild                     PASS      1545.75 seconds



---
Regards,
Linux Bluetooth


--===============4005863280457378007==--
