Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76464C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 09:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34EE561AA2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Nov 2021 09:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232741AbhKPJFj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Nov 2021 04:05:39 -0500
Received: from mail-0201.mail-europe.com ([51.77.79.158]:34066 "EHLO
        mail-0201.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbhKPJFi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Nov 2021 04:05:38 -0500
Date:   Tue, 16 Nov 2021 09:02:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1637053352;
        bh=vaDlCooLwyOAJMCtPaLlgqGcNpUI/2Bmi8kEjru79aI=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=NLIE/UAiwyoWULaUOezUpHR+yQkswtXTxvMtcWRsxm936qpy8QLQWCivv+zCpWzcG
         +H1VLtHLhovJx4+HTSHjBd8furXUa6lghL0MCCUx2vajUUKOJwSGkD4EACyRK37L56
         nul5toTu83/qSW7VDWQvA/GAvm3WKO3QEuaTHW08=
To:     regressions@leemhuis.info
From:   Orlando Chamberlain <redecorating@protonmail.com>
Cc:     danielwinkler@google.com, gargaditya08@live.com,
        gregkh@linuxfoundation.org, johan.hedberg@intel.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org,
        redecorating@protonmail.com, regressions@lists.linux.dev,
        sonnysasaka@chromium.org
Reply-To: Orlando Chamberlain <redecorating@protonmail.com>
Subject: Re: [PATCHv2] Bluetooth: quirk disabling LE Read Transmit Power
Message-ID: <20211116090128.17546-1-redecorating@protonmail.com>
In-Reply-To: <70a875d0-7162-d149-dbc1-c2f5e1a8e701@leemhuis.info>
References: <4970a940-211b-25d6-edab-21a815313954@protonmail.com> <275acce4-9eab-9cba-7145-5a75a69ca530@protonmail.com> <20211001083412.3078-1-redecorating@protonmail.com> <CABBYNZLjSfcG_KqTEbL6NOSvHhA5-b1t_S=3FQP4=GwW21kuzg@mail.gmail.com> <972034A8-4B22-4FEE-9B37-C0A7C7ADD60C@live.com> <YYZr14zwHnd52rQ7@kroah.com> <829A2DF8-818E-4AF1-84F9-49B5822F9146@live.com> <YYePw07y2DzEPSBR@kroah.com> <70a875d0-7162-d149-dbc1-c2f5e1a8e701@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> Bluetooth maintainers, what's the status here? The proposed patch is
> fixing a regression. It's not a recent one (it afaics was introduced in
> v5.11-rc1). Nevertheless it would be good to get this finally resolved.
> But this thread seems inactive for more than a week now. Or was progress
> made, but is only visible somewhere else?

I think the best solution is getting broadcom to update their firmware,
I've just sent them a message through a form on their website, I couldn't
seem to get it to tell me "Your message has been sent", so it's possible
that it didn't submit (more likely I've sent the same message several times=
).

If I hear back from them I'll send something here.

