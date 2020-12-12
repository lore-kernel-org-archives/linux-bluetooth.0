Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2961C1B0D8
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 02:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA1723B31
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Dec 2020 02:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405998AbgLLCBW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Dec 2020 21:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395364AbgLLCBK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Dec 2020 21:01:10 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A9DC0613D3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Dec 2020 18:00:30 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id z11so10466462qkj.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Dec 2020 18:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=UQJ3aReXFra2h+s0BkTlla9ReD83iEwJ8X13T0JtsRM=;
        b=UEgATC/GDYOVuveEmp3FzArmEP5ge4HFxYp3cv6DpVxyWR2B4lCHsG7PamTRYgbBtJ
         /ya/SsKugtqe7gJQXBPCeANi3QR3XbrIVS/h4cE7HVrniAOnotRlWJxG77M0LpG2NXax
         YPvYmaaIQbTirq3q7wQqL5amsMtSN6BmJI4+hjlQwoEMQ88sInZUDauAYCeWSNnbelDZ
         raJYKaPZNXDMgLWYG9waNOefKCHPRzHiPHraPiX87W9jNGnkziJppXdiZs4DnW8yiHMf
         2reSxjylYKOtQqkeVyWwnNMkaHs+vLjznYCmAO8DoVFlIBECvTA8fgPqPfanXrcZTSOk
         y/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=UQJ3aReXFra2h+s0BkTlla9ReD83iEwJ8X13T0JtsRM=;
        b=cie5kJsQoKfsFBS3WDhNDZ/TBrda2SjyH+WVqV2TBuDknGozkyBRXtbBlC5WzphCDw
         CtkOxYp8w6eYQIzf6RtaasmVY+MuIvcEUPrr5lMBZr8+p7T8rLLT9iZCJKXQz/C1PbuZ
         aiM6pslW8KMKcoRn+AKhkvL264sMcLyqkuJOVgLNrYR8vK8ej0UvLu+PQLk/3OYdA4MJ
         0IBLWANK8BBNESQ9ro0K1B/8uqMUdvd/kTX/HdBe3U3pT2OpINZNBeupMHJPJx2pM/70
         gvSe5XY5eNM/4xsc+GoOzY9UxC9DvkbODPFDbF3sbvSuj6xUTsLyHN4/h508tYlTepqp
         Jx7Q==
X-Gm-Message-State: AOAM530zXAibbOnJqa66tEOsKUEXdjEFvqsvHviYukuskMv7r13H3Kg4
        VycNMiMJ0AOODKRP83v41lxKkmrhbFxd9w==
X-Google-Smtp-Source: ABdhPJxh2apmzJzeNFxId4kn2PruXC3oXbuStuuyLZps/wCVyM9lgXpsECDMdJQfygXD7Y5iUUnSNA==
X-Received: by 2002:a37:ef10:: with SMTP id j16mr6015033qkk.129.1607738429437;
        Fri, 11 Dec 2020 18:00:29 -0800 (PST)
Received: from [172.17.0.2] ([52.168.38.181])
        by smtp.gmail.com with ESMTPSA id v5sm8777841qkv.64.2020.12.11.18.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 18:00:29 -0800 (PST)
Message-ID: <5fd4243d.1c69fb81.a8a92.b613@mx.google.com>
Date:   Fri, 11 Dec 2020 18:00:29 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3599758220094429736=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhishekpandit@chromium.org
Subject: RE: [bluez] adapter: Change noisy log to DBG
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20201211160831.bluez.1.Ideb5dbf81fdb531ff36814aed2c969980049dd28@changeid>
References: <20201211160831.bluez.1.Ideb5dbf81fdb531ff36814aed2c969980049dd28@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3599758220094429736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=400909

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


--===============3599758220094429736==--
