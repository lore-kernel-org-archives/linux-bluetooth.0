Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9241C433DB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 05:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A8E86024A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 05:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhBVFgE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Feb 2021 00:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhBVFgD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Feb 2021 00:36:03 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6B1C061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Feb 2021 21:35:23 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id o21so8511860qtr.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Feb 2021 21:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=SLlSm3c5gFSdy4dQPKpzQIpB85F/sKmdWJMUb799920=;
        b=XX+9cIovFLpjWeWPBLuT2xYVEShnuGRwl1daun1Wqn60dcOg3REco9WxoXDGkpZuoW
         DUNaRADVqUAh88xUKW8qwjmXrBVZ/+97nUqRMsvo9Y3ZheS/khPpJVl3dT3GiXyutt7V
         eHzvms3dYbjRzhwC8kQk7ZEH6kaLm3MOYjVT8aR/SABhk/1g1Rd6OqHgSrF7tv04yLxv
         HrINBqNe9eBIGk5iDimABlxSD2RPTgpMfhr3EiNHbC/M51aJB6YPaWkucDDP9AvF25gP
         Uddefcde97CVh6rsgGhYRXwAYlIfhzR0kSWf+pwmajXggexj74eTK0nxzE0WjBdUJcxr
         0mXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=SLlSm3c5gFSdy4dQPKpzQIpB85F/sKmdWJMUb799920=;
        b=FMgQQV8T3+aENMYfES3KarFyzjfZ9l/IZqqxWGbSXfjXcO07JN/D29OeT+E1J4dXLz
         IKth9yDykCKCwdTu1pSoyQiEsMEsaSGS6O85896HS9/RHxwfKQJgsmDRL0fxYacCWwKa
         P6zC/scs4+fpSAyJqjgGM/2RqsJvd1uIn13iE/FPSo5LmF9YwBcng/zi36/2y2kqwn07
         kTpr9BGU8lDmi2H29auhYwDbrmzXl15TbuoKFY0dAUC8LaS56LKNepCEi3RPxfMqy/FI
         Tndpc7RGBV5CELYwjc7ao4ApHGOt2rdVNIbPLorw4RRyABPTqA7fMIuB8MR0r4IypgNt
         dWnQ==
X-Gm-Message-State: AOAM530UoKpubg4MDi0HYh1ag6XuwtohLZnPAezSF1suzOM8m3XFkSD+
        tHotAdVbFUikgew/RdXfdSAQstP7s25F6g==
X-Google-Smtp-Source: ABdhPJx+gXpsKbdrYyfpQWwss9MaZIHPnrDff1w596pDQzIllA2S+09nAcfcEZVbPKAswF/Fshj75g==
X-Received: by 2002:ac8:6ed9:: with SMTP id f25mr18121463qtv.352.1613972122438;
        Sun, 21 Feb 2021 21:35:22 -0800 (PST)
Received: from [172.17.0.2] ([52.177.59.215])
        by smtp.gmail.com with ESMTPSA id g2sm11686869qkd.124.2021.02.21.21.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 21:35:21 -0800 (PST)
Message-ID: <60334299.1c69fb81.5c44f.60ff@mx.google.com>
Date:   Sun, 21 Feb 2021 21:35:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5514134585123495143=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: [Bluez] adapter: Check whether adapter is pending powered
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210222131802.Bluez.1.Ic834b418cdbb81a6e9980632567fe9d7c23cd8d4@changeid>
References: <20210222131802.Bluez.1.Ic834b418cdbb81a6e9980632567fe9d7c23cd8d4@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5514134585123495143==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=436321

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


--===============5514134585123495143==--
