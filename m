Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2EDC2D0E4
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 01:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA422236F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 Nov 2020 01:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCGbpTRv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbgKUBcp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Nov 2020 20:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728987AbgKUBcp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Nov 2020 20:32:45 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96062C0613CF
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 17:32:43 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id b16so8638828qtb.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Nov 2020 17:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=7JFqshEzqY97yYMzAXCMpiUunJ6OrlkLEExPpzZu0Vs=;
        b=fCGbpTRv0LO0wyV4gWZgRz0ZZ486Q8z0suKPLdiCe2atbAMgol+21gCRsMV8Sitj83
         3c3N4Ev8wN00oTY6o//FU6EWsd0133bi7iG/dKpejzolVrYeTDGJ+OsJRDHz+26YhBCl
         oJh1ydnNoPvJYiA/D8x9pm/0jefOcRwdIMdJcyQix5aVD7J4wTxzgVbAIpcPynmitpQW
         wpPtptOtUG32t4x1Wj9UcYVGfg8zaQlA5eXXfnuxVYZ+libvoYlOkMAIw3dD5ykLH6ZZ
         pPHKssP8d7YKAaC1zmlsnY1MR974kqyGnYOHAD5lLYWf9iliJmBS0Zc9qyAnqCwC2G4E
         vA1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=7JFqshEzqY97yYMzAXCMpiUunJ6OrlkLEExPpzZu0Vs=;
        b=Vmi2sjuRWnN0r3eSi/Be0h9mcDCmbux0SKn6dqstt4lAp656RAz7EekWmo427FfFOz
         ttwU3UttMONMRxH56raYQjEcwr/xNT1+wB4i0vnTwIOMDMVrvgOhQJsYtugCWM4/RxVA
         o6IuaQlZsQxe1b+rNBhIUR1GbE5rNzFDYLF3KicnFs7M+0txcxPTK99YCVYD+vbNYtQA
         NUjBYJjss6X42HWrbqj+z01D6BNedRvvHgrEHl/PBoOW7kaNoMqXh+xRUeLoeX7ilSyG
         gM/tPcR44t3GbgzTq4i2kKWTIscr2nb/T4zD315KqQlS4K3khJET7b5TfWR9+ytoPApN
         p/iQ==
X-Gm-Message-State: AOAM5338zm33rREfa91XfwiDGpv/MQ+7yZIFCvgJMH1cy+cEpFZqb85e
        rsRjCHRltZUpVT01zowOwodlibris+s=
X-Google-Smtp-Source: ABdhPJxeTXAuwDEv3FEPrNvrBKEbbE/+A7aBYHcRxEWoSb5PH9EQ9STsKrm8IzA8H5EMk0wLEfC3VQ==
X-Received: by 2002:ac8:24d0:: with SMTP id t16mr18955042qtt.181.1605922362778;
        Fri, 20 Nov 2020 17:32:42 -0800 (PST)
Received: from [172.17.0.2] ([40.65.201.42])
        by smtp.gmail.com with ESMTPSA id n125sm3449231qkd.85.2020.11.20.17.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 17:32:42 -0800 (PST)
Message-ID: <5fb86e3a.1c69fb81.c4625.6ec9@mx.google.com>
Date:   Fri, 20 Nov 2020 17:32:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8289522745000744050=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, gubbaven@codeaurora.org
Subject: RE: [v2] Bluetooth: btqca: Add support to read FW build version for WCN3991 BTSoC
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1605703943-25980-1-git-send-email-gubbaven@codeaurora.org>
References: <1605703943-25980-1-git-send-email-gubbaven@codeaurora.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8289522745000744050==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=386807

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuildK - PASS



---
Regards,
Linux Bluetooth


--===============8289522745000744050==--
