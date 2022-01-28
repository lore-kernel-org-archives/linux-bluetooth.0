Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92918C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jan 2022 17:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347683AbiA1Rs5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jan 2022 12:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiA1Rsz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jan 2022 12:48:55 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46B5C061714
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jan 2022 09:48:55 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id qe6-20020a17090b4f8600b001b7aaad65b9so919745pjb.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 28 Jan 2022 09:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:subject:reply-to:from:to:in-reply-to
         :references;
        bh=RyKkE3zBsYqy+eSTIc4apJZDHjNAYNroiEqECe5iFK4=;
        b=jbXx9OiDInB64Oy9OIch066z1KlB0ojq9wCNorcPneUrVMoMbvOncECvQ5eW1DNIiM
         NDp9vOVVSxAB0N2EjHvt8dKbvj+YueM0Ocl3L30LqgeXBJ9nGeVY3nKca2ZSeqnbIxa5
         kIMVd24CIpz97RYejjAfaPuAbbwn9GqiZCgkWxQybRO8NVUV4v2ZkCaHzZyXlp6hQS06
         E59g7jfwjIm0U19ZO5lWdd2WmEMXG6EeSLltu1NbydlOpo++jnZGCldoBOgUihOHjny3
         h+rGGlRFGazuScj41jpzUeJZj0MyuevZ8+rORa6WekiLPv8dR+mauqAB32wRNmJTkrXx
         ZU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:subject:reply-to
         :from:to:in-reply-to:references;
        bh=RyKkE3zBsYqy+eSTIc4apJZDHjNAYNroiEqECe5iFK4=;
        b=G1qItRsfzyV5pKDAf/epQULvi9anpQJLt0656n73x+f2dIagdgxb3l2NCcQHIw8z82
         phgc12+1f3wWAFa0jDDOZZP4U/r5InfSVfUodPhS4CCJIiYedK/KG5d14uV8yApubl7h
         98cHyluVTwjXWpCC4wn5fNz4Jdt2u8atRJm+cgL0xwTPVIZNTLk/pn9G0q/K3C2FTgv2
         XPioW7fPQYrmaMDNT8X2Rui8vDRDPnn3ALOftVivV/WCn44VF1ylk9vRVC7kISmo1hob
         6KkevrE9d1X70W6A4xd5DXP6Zjx7itRFNpQsW5a/K8HFGy9O+Wbr1rLd/pGV+uZDMI+1
         lk4g==
X-Gm-Message-State: AOAM531bS5jUCtAHyg+dIvjH2ay7+FvxcXtjaXKyIdPKLRL2Nf+7RK9s
        A6zreTlcHccg+W2XjZqmpQUAh2f1eJw=
X-Google-Smtp-Source: ABdhPJwvMh9KOkQI6CNhUR3VwvlLGHqDwB1sIFQGM3UiYNLRT/CF6hOX3633GsBt8JuKNjP9HHBDug==
X-Received: by 2002:a17:90b:4a0a:: with SMTP id kk10mr11094048pjb.208.1643392135012;
        Fri, 28 Jan 2022 09:48:55 -0800 (PST)
Received: from [172.17.0.2] ([13.66.188.184])
        by smtp.gmail.com with ESMTPSA id z13sm10462153pfj.23.2022.01.28.09.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 09:48:54 -0800 (PST)
Message-ID: <61f42c86.1c69fb81.7908c.c8b6@mx.google.com>
Date:   Fri, 28 Jan 2022 09:48:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0438532450876993701=="
MIME-Version: 1.0
Subject: RE: [v2,1/2] Bluetooth: aosp: surface AOSP quality report through mgmt
Reply-To: linux-bluetooth@vger.kernel.org
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, josephsih@chromium.org
In-Reply-To: <20220127181738.v2.1.I2015b42d2d0a502334c9c3a2983438b89716d4f0@changeid>
References: <20220127181738.v2.1.I2015b42d2d0a502334c9c3a2983438b89716d4f0@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0438532450876993701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----
error: patch failed: net/bluetooth/hci_event.c:6811
error: net/bluetooth/hci_event.c: patch does not apply
hint: Use 'git am --show-current-patch' to see the failed patch


Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============0438532450876993701==--
