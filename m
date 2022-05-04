Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EBAEC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 May 2022 22:50:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241549AbiEDWyc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 18:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379386AbiEDWyC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 18:54:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9C4E30
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 15:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C8E2B82A27
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 22:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 598F7C385A8;
        Wed,  4 May 2022 22:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651704612;
        bh=6MfYxoij1jlC3oaWUF39Sv3nyC+Hp7uFErNewWK9mhQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pev69p5oLJin8+q8rWu3cSBYEWON5u0CfydpTkbGreFcsI6BGmOwpO/y1hPVqPCGa
         R6S0oJxtLGfb6KlybN6uZK7qgqVGQ5HMdVsNWbJqlclZ3M8dZg0PVtbtPm8HkdBsDT
         2DFI6S+I5h089riyC0fhZe8/hsbsfNYayv7u8tzMwZ3texRM19jWd7sXyg3EpSGA4j
         NgEqXHgtw3tyhf9UflUlGE/7p5/FxMIRe9i9dUY3HNN+x4cpFRNnLgSf17sDt6xGFd
         QYpzMlTqW/VZSmAtoj8PeHIRcTtnaenBAP2hbWn1iU5KjLk8KSicmf201a/QqHGzd+
         +Z0C9JL+X2D0w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3BCDAF03848;
        Wed,  4 May 2022 22:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bluez PATCH v3 0/3] Adding bonded flag to D-Bus property
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165170461223.30622.14714373718612988760.git-patchwork-notify@kernel.org>
Date:   Wed, 04 May 2022 22:50:12 +0000
References: <20220504210948.2968827-1-jiangzp@google.com>
In-Reply-To: <20220504210948.2968827-1-jiangzp@google.com>
To:     Zhengping Jiang <jiangzp@google.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        chromeos-bluetooth-upstreaming@chromium.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  4 May 2022 14:09:45 -0700 you wrote:
> Currently BlueZ client can't know easily whether a device is bonded or
> not. This is causing issues for a number of applications. For example,
> in the Nearby Share case, the peer device is paired, but not bonded.
> This series will add the "Bonded" property in org.bluez.Device1 D-Bus
> interface. Changes are also made in bluetoothctl to show the status of
> the bonded flag as well as a list of bonded devices.
> 
> [...]

Here is the summary with links:
  - [Bluez,v3,1/3] device: Add "Bonded" flag to dbus property
    (no matching commit)
  - [Bluez,v3,2/3] doc: add "Bonded" flag to dbus property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5c05df7c7607
  - [Bluez,v3,3/3] client: Add filter to devices and show Bonded in info
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bda2a9e6f902

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


