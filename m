Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70781C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 03:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjCKDeg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 22:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjCKDef (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 22:34:35 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDD713D882
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 19:34:34 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c19so7936435qtn.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 19:34:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678505673;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bPIoNmmWQk71XgICPYtQirH5fokTRF+X1x5V9dbzTs8=;
        b=nwmUeIqG9oZMcaC933gDnfrCzhgjquShYao5J96DnHM3uySP0K+USOMLeevIrzz9HK
         IQ2bbpOu3oQ0Y79eOYjy0+6hAtaRu3QuOlTy+4mx6FmB82PQITpUJGUuPHoAOGe5wdF5
         +cKUZctuDhqYFbeJwrwPp6/4PQpIJq+xmT8ZxcOjESkT1eL2vLLX+ksaDHYQUJnTxkuT
         R2vJbj8Fo99KCiNBqPZjqeGMHjKp9v9TNOk2cfbyVS4mjvn3RIaMEztHrvvdF8sEvkqS
         6Cdrj1ohQoBaqHqe/nf4Ov/CS5gzEjRlta6akAOKdKKfNzpjo4JRzLTusTzZlwmyTVCi
         l0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678505673;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bPIoNmmWQk71XgICPYtQirH5fokTRF+X1x5V9dbzTs8=;
        b=ZXhCyztXMUX8ipxSqOPOaSlEi91BW1T7E1fuBSr3qFUHyPdYdtqOa8l3/5Z2rYd1Ah
         3CNZAwkvP2IWrlYP3A8OhrDzgjRaq3fFiByhLsNzixEZ6hIvjQdREI3DrG/SrgieL+V5
         luNNr0tL/EFakncd2YVsg0G0LKdfhUsUylVdZLE/1RSUQxa2ghSKzFBG1r/G4Id1tYCe
         2l3j2GXEDfR+Kx80D4BC1zdE9Am2Y3tIyH7psYVFyn6NEr3SURO3MJ1YLiTtZ/QsrQyN
         CT8smt+bERpScXne7UHZaNFiXCbnvYuub8eqf+MGqizNTWrKqtucZU77qEaCSJS2ty9I
         2R3A==
X-Gm-Message-State: AO0yUKX1BweH9d8VK8g4BgOH0p7nYyw0TKOkmzBi+mrzK2wGCvsa+BC1
        4P6k/T/KjKvIpUthZOgqsO/ASW0jUsU=
X-Google-Smtp-Source: AK7set85gXESsKOvqbhmhxaGqIZaR/jcoJuhg/LJLu8LJtqedT/rzrwN6YUTPrmFnM6f8AyLSkGBwQ==
X-Received: by 2002:a05:622a:d6:b0:3bf:e471:69a3 with SMTP id p22-20020a05622a00d600b003bfe47169a3mr46715901qtw.65.1678505673736;
        Fri, 10 Mar 2023 19:34:33 -0800 (PST)
Received: from [172.17.0.2] ([172.177.129.241])
        by smtp.gmail.com with ESMTPSA id p12-20020ac8740c000000b003afbf704c7csm1163907qtq.24.2023.03.10.19.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 19:34:33 -0800 (PST)
Message-ID: <640bf6c9.c80a0220.a3b9e.4b0e@mx.google.com>
Date:   Fri, 10 Mar 2023 19:34:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6120720319032733116=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marijn.suijten@somainline.org
Subject: RE: [BlueZ] audio/transport: Propagate errors from avrcp_set_volume to DBus
In-Reply-To: <20230311011202.486271-1-marijn.suijten@somainline.org>
References: <20230311011202.486271-1-marijn.suijten@somainline.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6120720319032733116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=728988

---Test result---

Test Summary:
CheckPatch                    PASS      0.56 seconds
GitLint                       PASS      0.36 seconds
BuildEll                      PASS      32.31 seconds
BluezMake                     PASS      1004.82 seconds
MakeCheck                     PASS      12.92 seconds
MakeDistcheck                 PASS      179.77 seconds
CheckValgrind                 PASS      295.28 seconds
CheckSmatch                   PASS      395.81 seconds
bluezmakeextell               PASS      120.26 seconds
IncrementalBuild              PASS      824.62 seconds
ScanBuild                     PASS      1216.73 seconds



---
Regards,
Linux Bluetooth


--===============6120720319032733116==--
