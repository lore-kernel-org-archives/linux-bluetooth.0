Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F72CC636D3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Jan 2023 00:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjAaAU0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 19:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229874AbjAaAUT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 19:20:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1284625E20
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 16:20:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A329D61341
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 00:20:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 17EC0C433D2;
        Tue, 31 Jan 2023 00:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675124417;
        bh=J0MBIuQ8eyrCv4CUVRLeVWbM3qXzeqT1mkj4DtGlnjo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XzOW5r5Z4AADO6r507u6tS4qcVXR4wPc6IA2pQW/JAFZvUWJsp+wtwuYx1aopPDlM
         ZzL0uBKd6XclL6uftorj7nytDhQFLbetbXDA9ElIQQrz5x5aV2gy2ml9czQ3lYg9er
         Tya38lAn/VwCTX9qu0MzFj3kBUxF1VvF3T9X/nqEkxFYSRfxHIoN2W/Iiz2rmm6jLg
         Glk8jAAHOhkF/KJ5ekjV0sDds7RgAAYxMhOt8Iuf0LD1X6gzOYlSFlRmYc/Fc1e/RD
         YcIXgr7MKwjxiw9iO11y1g1HxGcbxORLXO5TdI1tALWwnJaD4eZwHa39/XT+EZlmHf
         jJmUsOVkJgASA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB35DE4D014;
        Tue, 31 Jan 2023 00:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] AUTHORS: modify email address
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167512441695.21902.10429238330080152037.git-patchwork-notify@kernel.org>
Date:   Tue, 31 Jan 2023 00:20:16 +0000
References: <20230124220416.312697-1-brian.gix@gmail.com>
In-Reply-To: <20230124220416.312697-1-brian.gix@gmail.com>
To:     Brian Gix <brian.gix@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@gmail.com>:

On Tue, 24 Jan 2023 14:04:16 -0800 you wrote:
> ---
>  AUTHORS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] AUTHORS: modify email address
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5845f003ac27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


