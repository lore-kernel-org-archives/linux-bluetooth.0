Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD33C433E9
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 00:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61C3964EF4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Mar 2021 00:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355778AbhCDAdm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Mar 2021 19:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242241AbhCCNoF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Mar 2021 08:44:05 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29870C061756
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Mar 2021 05:43:01 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id s15so17492170qtq.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Mar 2021 05:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=WhMFcTmj/1AAY85BdrJuojWi68ckeltTmNNr8ME4xIw=;
        b=Pme5p1VZGwVC+33dsi6rWxcBQE2fg7+LHRfL/FnCgRAHC63LSnkI+S84y9U+hDH+rm
         V6pUwC+Vx65+ExUuDE4YPnmb05O0D/D/TmnKNGP8zf95qN63YBiQS0wLL0ryaTZeRB8R
         +PJf7VrFX/hcj22/HBqmMO040jOa9rNa8WU6dtEw0FIN+yC41x8elz7LIwXh+Cmsy5xQ
         fN7vm6xVne8lz7n1Licnz9yAuuGfes095a1z2eijvHI22EHqZphp9IVXeRDmGcypxvuq
         xBANDoAdiALxxL4DD7/ksHPbOJaZ2bdxfSo/skpqFjgf93vBvjNMz2EE0XssBB58hnug
         7bCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=WhMFcTmj/1AAY85BdrJuojWi68ckeltTmNNr8ME4xIw=;
        b=eOzcygQW4WzTC916tvB71q2yfZRqFMyDNlaw/TpzssdrxsfQrSasXje+9ZwnZI4OvO
         BeQ+FF5adfTJPYmoTQyha4SnWOh7ZStGL4Uf3ZD1Tkwwf3q/BqJu/DSgB7nDwbgEscPd
         JHSVqlm688M//OlrwrucWhvBUd6A/1jcTCHC1+KJpjJh+hkOfh87WICJrmE9rhRXTmWx
         Xp6NgyiZN5hlLNak/ZNiW7MG0I7TCuXn6t9P0Lm5PNsQDfCqEFJV56FnATSwPpAO3qs7
         3JeXFxnZ1xokrpzw4XeYpvXbnv56LhQUSvyo0pZyjoZLQeeEDLL0eGZX6KbGqI6pO2sm
         qnPQ==
X-Gm-Message-State: AOAM533mgeSVRUuWDBLh2ir6OU36kAvEDBoZhYeThtPPumDbjb2y4H08
        GbPeLE9hgO8brY8R6jxZihuclflf/HpXEQ==
X-Google-Smtp-Source: ABdhPJyKu58ROZKE6Fl1riH1XZVs91X0yB/SQLXmZ+XDNQ0V33xchj0Bb3TysFWPORUpz78R7enZ5w==
X-Received: by 2002:ac8:5a15:: with SMTP id n21mr11838578qta.85.1614778980256;
        Wed, 03 Mar 2021 05:43:00 -0800 (PST)
Received: from [172.17.0.2] ([52.247.127.43])
        by smtp.gmail.com with ESMTPSA id f8sm15042107qth.6.2021.03.03.05.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Mar 2021 05:43:00 -0800 (PST)
Message-ID: <603f9264.1c69fb81.f6ea8.c865@mx.google.com>
Date:   Wed, 03 Mar 2021 05:43:00 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8534434578580712602=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] shared/gatt-server: Fix not properly checking for secure flags
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210303002944.3444644-1-luiz.dentz@gmail.com>
References: <20210303002944.3444644-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8534434578580712602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=441167

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


--===============8534434578580712602==--
