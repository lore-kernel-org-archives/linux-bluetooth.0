Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19901C7EE29
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Jun 2023 20:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236077AbjFBUa3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Jun 2023 16:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbjFBUa2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Jun 2023 16:30:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0B2E5A;
        Fri,  2 Jun 2023 13:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 658F961E00;
        Fri,  2 Jun 2023 20:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8DABC433D2;
        Fri,  2 Jun 2023 20:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685737820;
        bh=Now+KUgBzHLU9lGLwsd/mVVtRVXIrRW7/Gpe3WHSQ9w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qwXGBAhBUsO/ieVFN5BqkOL2BgyGJbGzpvGWPMHuLkxOpWms50jHNc00G3mYf2hU8
         AKZO9khGfywugPObf1DlkpKGwcDRWF3CN/G99rvmi03Hnwo7BFDGx6B95Bf9pn4u3o
         dJ1fDfNhvbEAFaNaeF5cdOiIZ7EwMm4RjYop5vwqjquGQcrNRt8StiussBAZYKHsx5
         MIhkkVbQzqZPTPeak8W1Icp8mYqbZwKtP5yQ0yXH097OMaJKGdm+/FEdw5dkhg2MW8
         9e9VBGv10tL8VsnMaAdfZBbiDQ/mVpg361zj4jlovWRp69p3EWCZC8e5jz7crRK17O
         +qyRpfeIgWRWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9539CE49FA9;
        Fri,  2 Jun 2023 20:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_bcm: do not mark valid bd_addr as invalid
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168573782060.11756.12186344038329029663.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Jun 2023 20:30:20 +0000
References: <20230602081912.4708-1-johan+linaro@kernel.org>
In-Reply-To: <20230602081912.4708-1-johan+linaro@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        mka@chromium.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, m.szyprowski@samsung.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  2 Jun 2023 10:19:12 +0200 you wrote:
> A recent commit restored the original (and still documented) semantics
> for the HCI_QUIRK_USE_BDADDR_PROPERTY quirk so that the device address
> is considered invalid unless an address is provided by firmware.
> 
> This specifically means that this flag must only be set for devices with
> invalid addresses, but the Broadcom driver has so far been setting this
> flag unconditionally.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_bcm: do not mark valid bd_addr as invalid
    https://git.kernel.org/bluetooth/bluetooth-next/c/758be2398ff6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


