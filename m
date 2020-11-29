Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72586C3E8C5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Nov 2020 06:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 274D020809
	for <linux-bluetooth@archiver.kernel.org>; Sun, 29 Nov 2020 06:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B6XFi/mu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgK2GdH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 29 Nov 2020 01:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725468AbgK2GdH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 29 Nov 2020 01:33:07 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D935C0613D1
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Nov 2020 22:32:27 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id s10so8641521ioe.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Nov 2020 22:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=ksHwNoKaWlOtVMfUb7aRPBsYzzLMMjMWwACif7SK7+w=;
        b=B6XFi/mur6F46Lz11p02pLcnMC4ysxrIUzmj0omoNdvSE886jA+JOQtjW8DnCRyi7g
         D+Wc+s7tFKOupn48ewVG1zAUN7nBSYrg8W1dTyywOV2kjebYQSuHL6pvY1L6VMgMI4X+
         RCGp6cpMWMI8uNF1X2tA6VGOIG7XeCmLeMSoa7fFSccO/Qt/JOnjd50GkZzhUe3bcWNe
         W5Fqezjw5SMpOCOD8C4GfoOnZHdRQnGt+EF8VoDAmEWOzmwp9vmtN5zqV3YQKGnKUCw/
         qdZ83BZU4YC6Dvh25B50/zMyMnOb8A0cV5wPap6XiVHXup1KqSo9slLg+c8Tg9LoXC4O
         xHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=ksHwNoKaWlOtVMfUb7aRPBsYzzLMMjMWwACif7SK7+w=;
        b=SgREcZ1qet4sFuWn2WidPN0u3AyhyXKiGDKDJCgwhXevVCOznRuovkH6QsBTpckOTX
         7UB4ES4SGXBhz3l8x+e2XcAEk57j7nWeHVGbSeM4PPg1+r0kFF3BawInghdtF/xmH9by
         86P18ZIBS2ezeXtiJJIfG/8KGqEEy7KGZZrPk5UoIK9ZaZpTrZlM6Hl/SZZ2RjN8lHf2
         wT2nl6KB8Iy3H5m5A8nPpEara82QOwLNQq0p9ectRasJvLK38QSY763SvPBUNV+GNNgz
         SAQMjyabgkRBwcD9iPvvC+QYYjP618WhTRhe2VEXiBWgEswmk7Qzcu0ePeeRNkpIUZEQ
         CL5g==
X-Gm-Message-State: AOAM533T56kFCFY3Tw+hqIvjdBff9GHl5+UbLc4JaZ4PkmBy8g6vB5ZD
        drDQebeOgo6kTq5TmLv7MvMxPqCfsIQ=
X-Google-Smtp-Source: ABdhPJyFcxqJK4anBf8/ydz2BRBLZIR6ukI13jBadUDUQa88dvxpMAUmC+CwIGJDbBPxWGLFGmSYAQ==
X-Received: by 2002:a5d:8793:: with SMTP id f19mr3823964ion.106.1606631545141;
        Sat, 28 Nov 2020 22:32:25 -0800 (PST)
Received: from [172.17.0.2] ([40.70.42.160])
        by smtp.gmail.com with ESMTPSA id t26sm6070750ioi.11.2020.11.28.22.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 22:32:24 -0800 (PST)
Message-ID: <5fc34078.1c69fb81.744d2.4a6f@mx.google.com>
Date:   Sat, 28 Nov 2020 22:32:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6605169277448915743=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ,v2] mesh: Fix check for mkdir return value in keyring.c
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201129062202.91034-1-inga.stotland@intel.com>
References: <20201129062202.91034-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6605169277448915743==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=392799

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============6605169277448915743==--
