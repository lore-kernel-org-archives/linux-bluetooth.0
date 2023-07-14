Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69F11EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Jul 2023 23:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjGNXhy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Jul 2023 19:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGNXhx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Jul 2023 19:37:53 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29F12D5D
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 16:37:50 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b9c90527a0so54233a34.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Jul 2023 16:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689377870; x=1691969870;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hjG9RhA+LloC0qFaAe8TRiwc7bqw7OGRQrg7qKhqlCs=;
        b=c6ppEoV5YexC9SwxvKjL6zYv+fgtJB74pfrjSUIyT6LyjkDsTs5GIT8J6mqiWw4cBx
         9Z/H3OTdGrZGlEYuzoEyLTFq7QlxgM6FeOMGyFXGqbWQ49qwMMm33lLEMmp4CDRBe67e
         /g+h40g5mytbTp9T0bYRb5GzYWLGDNLY1U0tX3IwHw9JzyTt2Vnt/j0D8CLJYwqo4jgd
         UGWqQaUzDQiRyW/Zy7XGFQtMI3EEwPneVhDqmoqL03rM+EkHuGqi1U8wuGT1Ti+bDVzp
         Am9+8C/kOTq9I5dYSRN2+mw0Ev01ysTxKxE4AdKwUks3PGl+dPVM9+i3ZG5yvK9VeFHK
         EQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689377870; x=1691969870;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hjG9RhA+LloC0qFaAe8TRiwc7bqw7OGRQrg7qKhqlCs=;
        b=FWhVpYvsppDoIhiX1mWSgj82MYopKEyLiXodprOGW7znQqhqsJ+JKOVlF17kvpPmn+
         weyaTk8HpaXE+iwEAeq7D/mVBOpuDRo8X83Fk8yjP6GEg2vT7gf8/r0E13Iq/Y+ofCGB
         Py1k967xCQY76gKD6d037sybb7eYnqL7qIIEaREay4ZSDSklS0tmuaI3Km0DF3JKdWWk
         2qsNCivkjeGAGdus9JYz1SyZqISnX6cAlwJRFANfbyEoz/kbSvbejpA9b9gBw9Gq7jj7
         FjQDtABJFMAXdlJuHeSj3hWEPRildWexL3cB0OOcb2L2+q+Zob3GRmVGN/ydG1f8Lv5u
         GD9g==
X-Gm-Message-State: ABy/qLaMwIf1QJ4OnzioL8cId00P9Ybhe5iRrJG52/kVNyTgo13iPTrR
        jmT02HvOUSlItXKNvaZphUMRN7QP+k0=
X-Google-Smtp-Source: APBJJlHE9FujtHk9mFsgBdmYL0gnmCmLbYUCX790Yj+ICSy9pnKwjalDXFoAO7fNRYEr5TtXpHwV/g==
X-Received: by 2002:a05:6870:4711:b0:1ad:e92:62e1 with SMTP id b17-20020a056870471100b001ad0e9262e1mr7344968oaq.54.1689377870064;
        Fri, 14 Jul 2023 16:37:50 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.65.76])
        by smtp.gmail.com with ESMTPSA id q2-20020a9d7c82000000b006b96384ba1csm4288213otn.77.2023.07.14.16.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 16:37:49 -0700 (PDT)
Message-ID: <64b1dc4d.9d0a0220.d404.beea@mx.google.com>
Date:   Fri, 14 Jul 2023 16:37:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8311709084986992636=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] client: Add support for mgmt submenu
In-Reply-To: <20230714221653.2437444-1-luiz.dentz@gmail.com>
References: <20230714221653.2437444-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8311709084986992636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=766075

---Test result---

Test Summary:
CheckPatch                    PASS      0.78 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      27.25 seconds
BluezMake                     PASS      871.73 seconds
MakeCheck                     PASS      11.91 seconds
MakeDistcheck                 PASS      155.47 seconds
CheckValgrind                 PASS      256.31 seconds
CheckSmatch                   PASS      342.12 seconds
bluezmakeextell               PASS      103.53 seconds
IncrementalBuild              PASS      705.07 seconds
ScanBuild                     PASS      1062.96 seconds



---
Regards,
Linux Bluetooth


--===============8311709084986992636==--
