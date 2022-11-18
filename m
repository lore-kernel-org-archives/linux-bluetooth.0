Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310F2C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 06:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240707AbiKRGEW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 01:04:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiKRGEV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 01:04:21 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525968D498
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 22:04:20 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-13be3ef361dso4829406fac.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 22:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GFDJqKzo1C+j2rq21WDTZs960dtq+8zV7MlGfnDFC+c=;
        b=mP+OxUGUugUVfJyq/rcxnbYLwdmW9duPoxEN1mN/nNPVBHoqUDrbcmkqqzrIxCsX5y
         oNVAbsBTGNbiajyv2wB4rX2z/hRrYsy4Db55lH3HdsaAwRhHGrqifm3/1I6a7VMgXItU
         kdUwp7vGS4iXFlAZ6KqRRik8dzQ4RAUSgYn5APDXTRtKGRY/Yx3FvmBxOu2zl/tWw9rA
         Oge6DQNP0KGTQI5RZbqVb3FZWx4XNUIcLOW5WU/MT5zbcfUfOeC7GQqJLq/fdZD4d9d7
         1HDbjpTh/UqjKJ4oMR881MWmXeP/y4sujjWVaG361b5gew3i+MHlt0lS8yDjN+bCcU7U
         Q1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GFDJqKzo1C+j2rq21WDTZs960dtq+8zV7MlGfnDFC+c=;
        b=6cuHCszGW6IhGLLyTI4xmyoJP4VN2Pt5B6DWZtyF/rR4diXJ/BX1PRR5w+QVUmfDyx
         Nk0OgYGFrE0QzhFp2n1VBZQxb4cdgXquCRkvf+h2gm6t9nfQjR+DKOJJj2+KKTTYw+04
         aTOsXYtFg9t9Z8K60riXck3GHlJ2E5+Sl/885N1540BxAMOYwoCNnUHPXVPa7wUnC9zc
         S7KMuagSovetTf/Bq2P73EgbBQoa+nLszA3X5P5RJXU0nBlXC2ldn+XUEcEGAoG1fBtq
         uXCM3svstuwcd6FUbmBvXjCmaxuIcuu9MlIz04wXoRuJXVIyWvheieYO8czuepsZBK3O
         pvdA==
X-Gm-Message-State: ANoB5plb72ljd9rEHvogx/b7MhcFw9FXC5aleai6fGbo8BR4TnZq4ttD
        OdUotnNOzjGbLcSXlKtNq2380/Qiggg=
X-Google-Smtp-Source: AA0mqf7DWzZyqBKdsceCt22CZ2N/fQx4k1CgJlZMb785OLoFnztv8RVtSfYsUeIPNTDKA7rawZqcuA==
X-Received: by 2002:a05:6870:ac07:b0:13e:bdf2:3e6c with SMTP id kw7-20020a056870ac0700b0013ebdf23e6cmr6174513oab.45.1668751458873;
        Thu, 17 Nov 2022 22:04:18 -0800 (PST)
Received: from [172.17.0.2] ([20.225.200.24])
        by smtp.gmail.com with ESMTPSA id v14-20020a056870b50e00b0013320d9d9casm1511813oap.44.2022.11.17.22.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:04:18 -0800 (PST)
Message-ID: <63772062.050a0220.77116.6c6d@mx.google.com>
Date:   Thu, 17 Nov 2022 22:04:18 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3237773157103039786=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] main.conf: Add comment about LA Audio BAP UUIDs
In-Reply-To: <20221102101224.1463549-1-hadess@hadess.net>
References: <20221102101224.1463549-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3237773157103039786==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691153

---Test result---

Test Summary:
CheckPatch                    PASS      0.36 seconds
GitLint                       PASS      0.28 seconds
BuildEll                      PASS      26.57 seconds
BluezMake                     PASS      769.73 seconds
MakeCheck                     PASS      11.05 seconds
MakeDistcheck                 PASS      147.94 seconds
CheckValgrind                 PASS      240.89 seconds
bluezmakeextell               PASS      93.89 seconds
IncrementalBuild              PASS      621.01 seconds
ScanBuild                     PASS      967.70 seconds



---
Regards,
Linux Bluetooth


--===============3237773157103039786==--
