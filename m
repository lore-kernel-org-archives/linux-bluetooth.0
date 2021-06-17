Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B28DC2B9F4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Jun 2021 13:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C95361185
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Jun 2021 13:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhFQN66 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Jun 2021 09:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhFQN65 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Jun 2021 09:58:57 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50FBC061574
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jun 2021 06:56:49 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id c14so8372259ybk.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Jun 2021 06:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rMLOVBAQJl3F1mUyqdQMmm91i0oizXXZmct2m4tTtx0=;
        b=sp5yfkP+3aHYOU02mBFl5OClvzbavynHAz7pVhUPX8jhzoZFzOOmWikIGUu0FUHJSq
         cs2SmSpKMxmUvy20ZBe1pMxyKJnk/Qxu+0uK3s/YWBg/dEMNKeDsJIvYqsU4XlJLiXOC
         Yt+vL1rzhdB2iJwIzwP5bCh85indXfze7bTLj6hzLEqUGq58Focl8+yJKxv/0EtzfPDW
         jHeNIz3QtvTiYfWSlbUvD8rMVDwIKIs52bIKZd14sCp0CFfaweIAQ5libOAZLVNGXwNr
         FW7X+MnP/Q9n0KQEFifRiEp5OOrSMjOqx20wxuTiHbMCJYgMoyxD/iRc3IIwQ0J7bbVP
         Q8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rMLOVBAQJl3F1mUyqdQMmm91i0oizXXZmct2m4tTtx0=;
        b=CaiZgMjYxkFGOAnJnvvYVfFeus6iOW2eEWzsfW6BXO4CPzj1Mf5O4vy8U1lixZ/GGH
         oa5WVSYI7A5DzgRlQbPs+FQ5TXpewoWScx6CZ5J6j7sOZDKrd9Q0aazFviwX9i4GNx9W
         vipqhuTwSLyY7DiOoE9KGmuKm2rzN1vim/3AsowvxTi3EfWJf1k6n9cKX/7RAaDC2glN
         NZkixekFXjVoGej8Qb/q1QsKkmzbgFNzaLMvAJWzL448LFk2kpPjybu/NtXiWiVZgKJ2
         WMotKhpi/i9tWJ4sFpy0zx8Kmk3+QEnbrBfkUYwDSebl04SQ9Xm/IR5vetylYO7KyR0U
         GSFw==
X-Gm-Message-State: AOAM530IRECNMdH4YyxvVRPuMnk4bnQOvprePItxxYfFs4hwHYz69Rrf
        kqTxPW74MRNVzfedBep2xaafpMscFN1frzrfX7osC+hbiy0G+A==
X-Google-Smtp-Source: ABdhPJykjG+6cm1xm6nNHw/0JEp+DEme90io/n0hv1CJvZPH7he1FxM8hbJqWJJ7uXbcl7vVdRICRXZdzsm6JHJrR54=
X-Received: by 2002:a25:d3c9:: with SMTP id e192mr7156478ybf.20.1623938209002;
 Thu, 17 Jun 2021 06:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <CA+rLJxX4=oLbSO-4RML7+WM6iwxTc50BDbOgNM2CcAsW4NK0Mg@mail.gmail.com>
In-Reply-To: <CA+rLJxX4=oLbSO-4RML7+WM6iwxTc50BDbOgNM2CcAsW4NK0Mg@mail.gmail.com>
From:   Barry Byford <31baz66@gmail.com>
Date:   Thu, 17 Jun 2021 14:56:38 +0100
Message-ID: <CAAu3APZkSWXCB1GiRwbcEXVKOHwsqj5cYGARPRaQYETD5-uUPw@mail.gmail.com>
Subject: Re: iOS Central with BlueZ Peripheral disconnect due to insufficient auth
To:     Matt Hazley <lists@matthazley.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Matt,

On Thu, 17 Jun 2021 at 09:43, Matt Hazley <lists@matthazley.com> wrote:
> Does anyone know of a workaround that avoids a recompilation of BlueZ?

You can start the Bluetooth daemon with the "-P" flag to remove the
Battery plugin.

Depending on your system, that means modifying the following file:

/lib/systemd/system/bluetooth.service

To read:

ExecStart=/usr/lib/bluetooth/bluetoothd -P battery

Cheers,
Barry
