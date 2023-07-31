Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9475C04A94
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 18:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjGaSAY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 14:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjGaSAX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 14:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC187E52
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 11:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ED9761267
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 18:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BC5FAC433CA;
        Mon, 31 Jul 2023 18:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690826421;
        bh=5dPxpTF1rYG0w5UDpUhl89Hvut1ReHQzAA//JLc0AXQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iVjKPRJ1HPMlDzAQlK1cquUWgFfFok7jI7tnBW86zqGFQ+HLVTTX12qxs9maPXlra
         Ufwp8XZC5aVLKHuUZcrqY35cgjJWwxlcbkTNE3th7LWZFUA1HAM7vFVG3xnOWYt6vO
         KBzEbeCpe5vVJA7meI8kiiG7ooRmUwAPHOc7n0AZ3GiSKJSuThQxPCbaK5rAuLKwSB
         OpDsQ/leZ5PWY4csljchJYAANKbWPMj3Our4lbDDXvWyk2Bo5uJKOKYsp0inW+Tz/7
         UFdrilv8yRyuvr938UdVl9S4Wxdt46wlH37WvpzDKwumg3jR+H5iITtSrxCBLWnjuk
         0hsJ8rywGrxsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A1CE3C64458;
        Mon, 31 Jul 2023 18:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] gatt: Fix not establishing a socket for each device
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169082642165.19346.6932521430064344787.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Jul 2023 18:00:21 +0000
References: <20230724212731.848134-1-luiz.dentz@gmail.com>
In-Reply-To: <20230724212731.848134-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 24 Jul 2023 14:27:31 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> AcquireWrite and AcquireNotify shall establish a socket pair for each
> device connected otherwise the application cannot distinct the
> operations of each client.
> 
> Fixes: https://github.com/bluez/bluez/issues/460
> 
> [...]

Here is the summary with links:
  - [BlueZ] gatt: Fix not establishing a socket for each device
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8eb1dee87e01

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


