Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FE6C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jun 2022 19:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378419AbiFPTkS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jun 2022 15:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378172AbiFPTkR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jun 2022 15:40:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC0459960
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 12:40:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8A575B825AB
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jun 2022 19:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4D8DDC3411B;
        Thu, 16 Jun 2022 19:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655408413;
        bh=AXin5EtUHIV81eSZ/gR723I02jGp46QB8cEvKqCLg0s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=luCTWr8RRXhyiICmVcR+kvaFS09serpUoOUz78AiBQpD2c4iRm27BlfvXiyrj02cI
         mOmJI8m9zk2lHe8taFqBIUovr8Nw8g0gFwj5jvWTuU0fSYa6Sm3bCEWlPZ2ejXQ8Ji
         sUk3+vQXb7THljEAh14fY46sdjZITmx6KDHm1m9R3RNIZYm9jVRb11LpPKBK985OOk
         wpFDlb4LXDDOhvsFC6hihz9K2Vm3X+52Ge5t79Ut6HELXoFaRpOhcELvmSR6uMFN9D
         3jPlbJ04yo9yUv+1Kxe9rbto8ne8IA5JQsIYmTZDdgTTrUHFR3sXKEcZd3Zu1iT9Qi
         hRyOuTCr5vVCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31271FD99FF;
        Thu, 16 Jun 2022 19:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] main.conf: Split Kernel Experimental UUIDs from
 Experimental
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165540841319.1034.7520891078846747091.git-patchwork-notify@kernel.org>
Date:   Thu, 16 Jun 2022 19:40:13 +0000
References: <20220614215609.596687-1-luiz.dentz@gmail.com>
In-Reply-To: <20220614215609.596687-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 14 Jun 2022 14:56:08 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This splits kernel experimental UUIDs from D-Bus Experimental interface
> so they can be controlled indenpendetly.
> ---
>  src/adapter.c | 28 ++++++++++++++++---------
>  src/btd.h     |  5 +++--
>  src/main.c    | 57 ++++++++++++++++++++++++++++++---------------------
>  src/main.conf |  8 ++++++--
>  4 files changed, 61 insertions(+), 37 deletions(-)

Here is the summary with links:
  - [BlueZ,1/2] main.conf: Split Kernel Experimental UUIDs from Experimental
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a5382ba2f09c
  - [BlueZ,2/2] bluetoothd.rst: Document -K/--kernel option
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=afc8c8f56fa2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


