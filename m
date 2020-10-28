Return-Path: <SRS0=FSAH=ED=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD70C4363A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7C1B20829
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Oct 2020 23:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3tdOjRi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgJ1Xmw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Oct 2020 19:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390515AbgJ1Xd7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Oct 2020 19:33:59 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB138C0613CF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:33:59 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id p15so1435386ioh.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2020 16:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=JzZZkqrz46b5AroLzCJSWKJYgE8rWDfEEsOIDZldTaU=;
        b=b3tdOjRiZ+Zu2ybSQAie5D6cW2I8yrROLzkLlgyxDZe/efDQJKN+OoqukEZ4ND/pDD
         1goLKnvdRyBfvmPSoyW2coxnDpZWJSJyLhogrM/hN3zTtgPFb7Xx5y3/E7ya2DNpIcTr
         fSli6fmfwPCml1b6JnFL6ANm27n9IIEPUOAWvmhqzer+rHmhiwg0JEopImaYR95H/CqL
         5czH2Z+BFH8j77hS2OYOvhgZqVytLF9kv9LEi1pwFrrPmSj5nZJ8vnDyNZLy1gwaG1cC
         Yn0iD0HKr9dNCOgSJiUhXQumUavUYgZ8eDtRulGlwlhAC5TKQ0ZwIoIIoikPWp8xhDfA
         9CVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=JzZZkqrz46b5AroLzCJSWKJYgE8rWDfEEsOIDZldTaU=;
        b=TPIOzXQGUc0FvDe8jiZHljBpNPAxNT5mr5ubCDZbXYm905fYQDEhCfsabvbHXakYiY
         thkvl2M1zTJYpZZsikKZ1QcoOmEBXOUS0RqxcWIfwqh45vOwHJKV546677Hh2os5llWm
         sTnk3/J+pD5E8Y4ZNpidx6r8tx+5sDW6hU54icA7R2JDtNlf+mOAGuOELkEQtdoluVK4
         dtDdeDs5f8lWEAPN2pJ5rcnQ+pJ8ksLnO0LAaUrY2WP33KKeHXkaE/9JiZApmOd+Pp+T
         2KiRY7BZjX3MZEydAwrKHxPAFVC0INp/wZgP2gRqesTm6maYY+swlG0sM7ZcECPpRxjH
         zukA==
X-Gm-Message-State: AOAM532US2Qc2nAoFGE8lVrPqVvdqS85gj3MOmuuK8NqTJ6ZL16Dqat0
        nB+bTynvu6dRkXTIUXQRAufN6SVCh/Y=
X-Google-Smtp-Source: ABdhPJz+vsoP0S/XRSJeYWkoXGxP4evENTT32MdGhZ7ffOEUFZpl8Pat6SOupJguIo2Hyr02JJbi/g==
X-Received: by 2002:a6b:3f88:: with SMTP id m130mr1447703ioa.78.1603928039059;
        Wed, 28 Oct 2020 16:33:59 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.189.227])
        by smtp.gmail.com with ESMTPSA id 80sm926376ilv.13.2020.10.28.16.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 16:33:58 -0700 (PDT)
Message-ID: <5f99ffe6.1c69fb81.a9e8e.4fe7@mx.google.com>
Date:   Wed, 28 Oct 2020 16:33:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8972442694147168608=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mcchou@chromium.org
Subject: RE: [BlueZ,v7,1/7] adv_monitor: Implement RSSI Filter logic for background scanning
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201028160433.BlueZ.v7.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
References: <20201028160433.BlueZ.v7.1.I2830b9c1212a64b062201ed9f2b71294f50ad22d@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8972442694147168608==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=372473

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


--===============8972442694147168608==--
