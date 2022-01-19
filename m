Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255DEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Jan 2022 02:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350800AbiASCOW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jan 2022 21:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350768AbiASCOW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jan 2022 21:14:22 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054A8C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jan 2022 18:14:22 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id n8so756450plc.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jan 2022 18:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=y6APoMcn8hTDLRhof5ewu9Fc1qSC+yE6TEWgeVtrg8g=;
        b=k4jXLUbtnAguPwvuht6vXNN+A/+esSKdDaIu0uvh76szXC2NfkNYpN8TNFuTnjvbfl
         mQEkVVMlT1uM4w95qTAi8MnT8r2J28BRYcK5IXAGLSl3eXd8HLKsyZXpkrf8RVu4GnvP
         Uf7wVpjhwAEuyLBDw9qBoFM9uhVPlskxkVzmkyCvNPRMlm6UMU9O8sixbL1leMr7iNk3
         ODhJMddRewidQbvJdznAbbpRJQchJle3bltux9lON5iHhDTcOYS8a33Zhfd8GOGAv1IT
         7F78LsIE/KJKWW3ld7xlrstu7jqQIovrGyBnOpOptJXxa7O3mtzAbviMYYuQom02FjPq
         9TMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=y6APoMcn8hTDLRhof5ewu9Fc1qSC+yE6TEWgeVtrg8g=;
        b=Wz5ehOFzS+WZ1D63YaSPQ55ki+0zVowLwtyltdeAw+2tag/C4CmK43ogUBqtSOT8v0
         SRmsi7pwC71ScxJ0c/xzbvSkjeH9gqiqpV5WNwXJSUUp5xJY56tYGIrjeRu5z63nK010
         BSJ54H6Yxmf/XynKYmqQ2t5Gj8IkVUWu9xS/8KuL1oqQJqZIr/0NyaXD9eaDrkeHMOsH
         8Iia3Wl9BsLZ/H5F9ElhWFm2RfQVH4nlyxQNSF3gs141fiaCV2090Fg1G9DvtvU5zH5s
         e5XAuIpNt3nWjV3XWjZN76O50GDp0JXapsvxwrbtPaCou9EJ2xMQueya3G2L2net9s58
         0r5w==
X-Gm-Message-State: AOAM531E7UgF42sq3R/+A5OZt92O9pe1Ww731+p4wkpiTxJo//L8RUY5
        46qiORTGFP1rTC23PuUPXa72+TJliL8=
X-Google-Smtp-Source: ABdhPJyg+Qg6S5W4asReqSOMIhvwZ/vBcHGn1QxUG5/RWTlrngRLHWCK4f8siATwkXcjsQ0sSPMabA==
X-Received: by 2002:a17:90b:180d:: with SMTP id lw13mr1657091pjb.215.1642558461215;
        Tue, 18 Jan 2022 18:14:21 -0800 (PST)
Received: from [172.17.0.2] ([20.112.92.87])
        by smtp.gmail.com with ESMTPSA id t12sm16511365pfl.68.2022.01.18.18.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 18:14:20 -0800 (PST)
Message-ID: <61e773fc.1c69fb81.7f03d.d578@mx.google.com>
Date:   Tue, 18 Jan 2022 18:14:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7513866925166267514=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] hog-lib: Make use of UHID_CREATE2
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220119002257.1428841-1-luiz.dentz@gmail.com>
References: <20220119002257.1428841-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7513866925166267514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=606425

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.36 seconds
Prep - Setup ELL              PASS      42.37 seconds
Build - Prep                  PASS      0.42 seconds
Build - Configure             PASS      8.16 seconds
Build - Make                  PASS      1409.22 seconds
Make Check                    PASS      10.96 seconds
Make Check w/Valgrind         PASS      440.84 seconds
Make Distcheck                PASS      228.14 seconds
Build w/ext ELL - Configure   PASS      8.25 seconds
Build w/ext ELL - Make        PASS      1397.65 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============7513866925166267514==--
