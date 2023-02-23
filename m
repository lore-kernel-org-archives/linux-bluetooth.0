Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F21C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Feb 2023 21:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjBWVLJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Feb 2023 16:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjBWVLE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Feb 2023 16:11:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7C761ED8
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 13:10:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 00642B81AB4
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 21:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A3A89C433D2;
        Thu, 23 Feb 2023 21:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677186617;
        bh=dm6T759o6F1YYnDwCLzrczUTnXxwCBX1BxBosreL/L8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PjMKdWsiWgvpYqjKmPMi5jcpq2sAHjYJjPaq5kWAljFffzbsJiwKCmCZBEhIb5G8Z
         WiDRJ2zsUN6+3IMLqW8SGIA0NckhxnywRc1tJSjrVF3Xq4MuitShFka6MqkgE6SBWU
         P/O6i4SeJCxPLwILct8EtlV1rZisw+OZD59x6ryNvqveR6TtqEyVE20EghASaxG+IF
         qunu9rWfrXApOQMqPjoJmZL9sdq5KLCuCDzN4fqoNB9dptwCMknDNFM9z2ftWaA5/R
         gf476YiFy0n8nTcRmvxs4NjyoP/xs5A/NfGNk3W8Mr7GXZEHdw+gJkQdz2YQc8xHdw
         fXnePkVasMNxQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8CBF0E68D32;
        Thu, 23 Feb 2023 21:10:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] device: wait GATT client ready before service accept()
 if no cache
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167718661757.25712.16626081241891993566.git-patchwork-notify@kernel.org>
Date:   Thu, 23 Feb 2023 21:10:17 +0000
References: <6387d20af8252ea1198c81afe728a9f67cd6bf77.1677179059.git.pav@iki.fi>
In-Reply-To: <6387d20af8252ea1198c81afe728a9f67cd6bf77.1677179059.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 23 Feb 2023 19:14:44 +0000 you wrote:
> On device ATT attach, do not immediately call accept() for profiles, if
> there is no cached data in GATT database. Instead, wait for service
> resolution to complete, as likely accept() cannot succeed before that.
> 
> Several profiles (bap, vcp, midi, deviceinfo) assume that GATT
> attributes are available when their accept() is called, returning
> success even if not.  In this case, the services never find the remote
> attributes and are not operable.  Other profiles (hog, batt, ...) fail
> their accept which prompts core to retry after discovery, and work
> correctly also in this case.
> 
> [...]

Here is the summary with links:
  - [BlueZ] device: wait GATT client ready before service accept() if no cache
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=46a5d2beccb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


