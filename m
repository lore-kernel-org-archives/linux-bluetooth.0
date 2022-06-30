Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C850CCCA47B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 20:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbiF3UkU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 16:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbiF3UkR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 16:40:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E86EF
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 13:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A50DB82B5B
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 20:40:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA4C0C341C7;
        Thu, 30 Jun 2022 20:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656621613;
        bh=WTL+VXcveVMdbdcL4WC2kcYYwjy2WVIXbM0PxKCQTGQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lzrUFTJmKGS6bIUu7lnkPAV/coAcLOKMDKs4LB+r9PI4GjL7CTVvBESNex7AEu6Zv
         LZojfkpggl37yd7NsjekqjWncrWhzApYk7JMcQlrh9ml3l/EQQVysVKFN7srkYL/K3
         ly7tpf9HJTUlcSVIBWym+7xhwlBmf4vnO4vQt7G6rEidV9UkkX/uw4+hw2H+EKTfhn
         8/rA9yTY5x1nZpC2pqLR+Rnts1s5k9v1uuS0+43pgbcy/rRxlsote0hPO/qEvOvSLO
         svYLGNTgcW7uinXRNz767rLqbKMNGI1PRhiKSr1JD+qp8RBz+/eYyNmSG7QfmoUxdT
         rtO3u7SE/2SuQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BD5E5E49BBA;
        Thu, 30 Jun 2022 20:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] core: make bt_uuid_hash() portable across archs
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165662161376.2141.16470202159580279555.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Jun 2022 20:40:13 +0000
References: <20220629211640.65822-1-brian.gix@intel.com>
In-Reply-To: <20220629211640.65822-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Jun 2022 14:16:39 -0700 you wrote:
> bt_uuid_t is defined as a byte array, so it can cause alignment errors
> on some architectures, when the two 64 bit halves are treated as u64s.
> This patch ensures proper alignment across all architectures.
> 
> Fixes:
> src/adapter.c: In function ‘bt_uuid_hash’:
> src/adapter.c:3617:8: error: cast increases required alignment of target type [-Werror=cast-align]
>   val = (uint64_t *)&uuid_128.value.u128;
>         ^
> cc1: all warnings being treated as errors
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] core: make bt_uuid_hash() portable across archs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8fc3368db840
  - [BlueZ,v2,2/2] core: Fix signed vs unsigned compare
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=31690310c096

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


