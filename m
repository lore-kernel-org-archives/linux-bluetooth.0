Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA7AEE49A6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 20:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjHUUA3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbjHUUA2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 16:00:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E6E129
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 13:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E5C65617B0
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 20:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A05AC433CA;
        Mon, 21 Aug 2023 20:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692648025;
        bh=tTo5BZqGhxSYVioh78kqSYVjNjCkT5O4Pw2xULwRtsM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=lIDsCT7SlsYg87hkIxqFx+uHrYAGsdOnaUiPIz0FpYMAxrC1quSNp4Bl5wGrnQZdK
         90viKv/MFyiIE+BUK3LwRKQWJysqSoV230zRrYSOEJQulYTyyx1eMrHpB3dbSqU4Fb
         GTLYIkue/KxPVYTOxmpBvrMgeyCiW65gUNz/N6nUq5npVYvGnt1AW4/dpxM0WWE6RM
         3/xc9itHjitfKYdbCVFhXyri4gRp7eUMeiZSm1ZpZlKJ9hr89lQP2W73LxBqsOoDEe
         ASi6GtuDa6/WfZdTC6BO+khgWx+7dbsqBYFc2Qb6+pd4ChkB0HN4Cw8d3P3rUCPm10
         ubpeQHTsiUhwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2F1BDE4EAFB;
        Mon, 21 Aug 2023 20:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] adapter: wait for kernel exp features in adapter
 initialization
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169264802519.24934.10400065436370754752.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Aug 2023 20:00:25 +0000
References: <00052eaeb78774fd7be365805203cb0c8b189243.1692531437.git.pav@iki.fi>
In-Reply-To: <00052eaeb78774fd7be365805203cb0c8b189243.1692531437.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 20 Aug 2023 14:47:06 +0300 you wrote:
> Things like BAP depend on ISO sockets being enabled in kernel.  It is
> possible the MGMT commands enabling experimental kernel features do not
> complete, before BAP etc. initialization and probing starts, in which
> case BAP will be mostly nonfunctional.
> 
> This was observed to occur always when running BlueZ in a Fedora VM,
> requiring bluetoothd restart after every boot for BAP to work,
> log containing lines in the order:
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] adapter: wait for kernel exp features in adapter initialization
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e93094977f08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


