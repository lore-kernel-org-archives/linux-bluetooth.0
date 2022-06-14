Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF87C43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jun 2022 20:52:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358427AbiFNUwE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jun 2022 16:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358452AbiFNUvw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jun 2022 16:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F0750E13
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 13:50:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4959061605
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jun 2022 20:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA771C341C5;
        Tue, 14 Jun 2022 20:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655239815;
        bh=zJjwCEKXKDiR64RRo3CQx8HtyrvA87l9nTW4gRP9TNs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=a35JiDzCNwjdAUq6LkzvRHpsh3ltO4XyHQ3njJbTdT1yaW8vLQsOyCMJ6meZWZuPe
         viRP7mLuKINtapFokuT3FCHN0/pLwNUldN1p1zQ52AO4nV1U8SKICuSQxE2hPeaaI8
         UAgohce1nrg1hxJyCGu0iitI9MvmpW9/vMAugLZEw2afV02+2XOLtMs73RpRFza+TF
         8dinc0aq3XoxiZ5pB3ftoFeKSjfvwW7rBCAu/+XJMMhO3/KJx4wwitd9Y5nP3qgfG7
         UnphRX27Q3O+ENHOqjG8NnN5Bq1m/HUozgmXPjQQ2pSrT17DDvzdnddcGiCW9fy49W
         /dbEyWvhxCM9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92270E6D466;
        Tue, 14 Jun 2022 20:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] mesh: Fix keyring snprintf usage range checking
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165523981559.27818.5402247822136859352.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Jun 2022 20:50:15 +0000
References: <20220614171338.177983-1-brian.gix@intel.com>
In-Reply-To: <20220614171338.177983-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com, tedd.an@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 14 Jun 2022 10:13:38 -0700 you wrote:
> snprintf performs it's own range checking and returns a negative value
> if string construction fails. Not checking the return value throws a
> warning at compile time on GCC 12 and later. This patch removes
> redundent range chacking and checks all snprintf return values.
> ---
>  mesh/keyring.c | 68 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 40 insertions(+), 28 deletions(-)

Here is the summary with links:
  - [BlueZ] mesh: Fix keyring snprintf usage range checking
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5cc08527c0aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


