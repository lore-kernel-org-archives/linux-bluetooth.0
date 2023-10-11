Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F04CDB484
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 21:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjJKVUa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 17:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjJKVU2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 17:20:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372BCC9
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 14:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C3146C433CB;
        Wed, 11 Oct 2023 21:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697059224;
        bh=opgvKO4s04O2tSOc/ZoOyPfsiG6UVD7SYaFw0pPKNJI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ljLNOdD5Q0Nwub0B8NoJx6RaWCgxh9OU0+tyrmv368PoBJ3H0WYs9opnkJ/ekP1Ed
         JnM7IY0Y+sulGanjYNulzK0oVQn4DHRsD97DQiL5CNxsVTOsPWAJ2qVvDljJAXXsd6
         aFrrWCn4W3cqwi5i4UvIYfw2Vb6ANT10IQQ9YqKldUE3O+yn1zagqejPySZE8QDXPM
         08pJWBhNO9Nq53tBe+wva6J16bHoRBWOkW5mbJeDaMbSGnY7nXgmE84FQxv2c+WAN2
         4TxBaVzzZQYy+X3bCqe0F0hxxq+o1ydktwakLhmAk5rUBqmwoGLApiiyhZ0R4z8tSy
         iocLaVflh5gGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A409FE000BB;
        Wed, 11 Oct 2023 21:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] input: Fix .device_probe failing if SDP record is not
 found
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169705922466.14030.9443337374373837708.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Oct 2023 21:20:24 +0000
References: <20231010194306.603745-1-luiz.dentz@gmail.com>
In-Reply-To: <20231010194306.603745-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Oct 2023 12:43:06 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Due to changes introduced by 67a26abe53bf
> ("profile: Add probe_on_discover flag") profiles may get probed when
> their profile UUID are discovered, rather than resolved, which means
> the SDP record may not be available.
> 
> [...]

Here is the summary with links:
  - [BlueZ] input: Fix .device_probe failing if SDP record is not found
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3a9c637010f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


