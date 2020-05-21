Return-Path: <SRS0=imY+=7D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF26C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 18:07:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 958AC20826
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 May 2020 18:07:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyeyxSRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgEUSHu (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 May 2020 14:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbgEUSHt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 May 2020 14:07:49 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6405CC061A0E
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 11:07:49 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id s1so8129385qkf.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2020 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=G5y4WfaOvAyCqHLH2smoqXCWU3N3Op9skQhpAjj2NpA=;
        b=fyeyxSRY3j8OUQnJ6xoYahUErGhUdzkgkOeF7nyFmDCrSiriwhaVFCATsXm6oxUs8W
         jLpWfnl/zzvxnuEW/NdMQfUTg8WgO2IW99HPVw1tRFq25fpAAhpXvye6dE2/AJ04i6PD
         OQt9KG3WGxpn8nFicH2T+yRLgok39A8voUEnUSYlEniS+i45GDfWTsUeSJvXaPElYO8x
         KvbxjcLj1CELFkcvAabNPENDzcFDqYR2gfSh1ihKiatzmWyoXFHz/sELJaHCn3h+oCCL
         nIKqu7N/6ZVdNMZhTYNog4L5efCBuSduVF5swAWdthU1w3D/fHdI+KAHZTUd2fwwMMp3
         wESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=G5y4WfaOvAyCqHLH2smoqXCWU3N3Op9skQhpAjj2NpA=;
        b=bSJpRoTP2chCBiiZ15/dp3Cvvll04w3sx7VkLNj2xOFkbFOgTFxjMTKEuu6iZOREGn
         AaAmgvXoKj5ArDaxtshVqMwvvMssDPtipg/eUui5bwU//JUpKgBuWt8jRTpXZqQLbtjf
         VuAfeZ7eAsF6o+OZbThBSYtUdw0Owy+FwKX/CI71vyMuPv41+FvJDGpJAEV7mEMYg7qe
         x4Gg68H/ogieoRgwG1RjuxGb6sTL/iZsW804Uw2zyxNI90bKtlkxiuNU5XrNQM8HoB1d
         wADFV4Z7Swabiz9UNtCCIF++vQ1ANbQoMID9QmrVbo2dbDGMkP6qIjZlslLi4Wy4DJf2
         LYzQ==
X-Gm-Message-State: AOAM53108Hiz9fmumFBaYX0RHVLqGr+TICoKvp4L+qajQ+SjYQFdefKz
        s55+piVSsEE1HlfeRy5LFte1E2xXkzw=
X-Google-Smtp-Source: ABdhPJwcOX00L0aM4A7Ld37bJc1T/SWxe0+q03COML4/lB+AMHVdwarha9YxGbF+/3UoGjvkCahADQ==
X-Received: by 2002:a37:7643:: with SMTP id r64mr4299353qkc.137.1590084468554;
        Thu, 21 May 2020 11:07:48 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.232.232])
        by smtp.gmail.com with ESMTPSA id g1sm5716140qkm.123.2020.05.21.11.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 11:07:48 -0700 (PDT)
Message-ID: <5ec6c374.1c69fb81.f9143.1a7c@mx.google.com>
Date:   Thu, 21 May 2020 11:07:48 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5905718232860771971=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [v2,3/3] client: Print device property "Types"
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20200521175543.7923-3-sonnysasaka@chromium.org>
References: <20200521175543.7923-3-sonnysasaka@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5905718232860771971==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit


This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While we are preparing for reviewing the patches, we found the following
issue/warning.

Test Result:
checkgitlint Failed

Outputs:
3: B6 Body message is missing



---
Regards,
Linux Bluetooth

--===============5905718232860771971==--
