Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EDEC43217
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Dec 2022 20:00:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiLAUAi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 15:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLAUAT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 15:00:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392E820195
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 12:00:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9335620F9
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 20:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F211C433D7;
        Thu,  1 Dec 2022 20:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669924818;
        bh=PEFYiHH5vBwp2IE2l+of0mvni9NcHWMpu9hkGXolt/4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=sZf2QGUiPiEPrMKAMQvuYg4PYU6j1C6LrcrYLKTW5qaC5B/XS3+eE9Xox82YqN0AV
         tC8JE4+yi31IIz+7sbVb56jz4jGT/XKg7QVlDthEUItxZusMEWKlfq7tHY+1xgmOgE
         bebBZK/1VG+VaOSI91UUjvqXOcLhNVuqRiJqRBRHgjjN4r9n/p95yx63iiglNFlToo
         pYe4crpIUjVxKJ633QC6pbnyNdv2PnWeH4nxqjWwoJLF5gy0Hml2/OlriIieShNsGs
         CFOgelk7P/ragGe7XUyxX3C8WhiqiOwGXVs1lzYPi8X7xXrSxlmE7npWn7QlfyHkWd
         3j61LoYZ9pnGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13570E21EF1;
        Thu,  1 Dec 2022 20:00:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/2] bluetooth: Remove codec id field in vendor codec
 definition
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166992481807.20187.14128711456819746834.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Dec 2022 20:00:18 +0000
References: <20221104071810.22720-1-kiran.k@intel.com>
In-Reply-To: <20221104071810.22720-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  4 Nov 2022 12:48:09 +0530 you wrote:
> From: Chethan T N <chethan.tumkur.narayan@intel.com>
> 
> As per the specfication vendor codec id is defined.
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 2127
> 
> Signed-off-by: Chethan T N <chethan.tumkur.narayan@intel.com>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1,1/2] bluetooth: Remove codec id field in vendor codec definition
    https://git.kernel.org/bluetooth/bluetooth-next/c/f0d0a36e32ab
  - [v1,2/2] bluetooth: Fix support for Read Local Supported Codecs V2
    https://git.kernel.org/bluetooth/bluetooth-next/c/fb77b0482a8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


