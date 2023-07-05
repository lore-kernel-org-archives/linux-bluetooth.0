Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFB9C001B0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 23:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjGEXA2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 19:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGEXA0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 19:00:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AA9122;
        Wed,  5 Jul 2023 16:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 623B461820;
        Wed,  5 Jul 2023 23:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0589C433CB;
        Wed,  5 Jul 2023 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688598024;
        bh=BBHHu+HU003GAqmQHb6iDcZmZaki1ZmPaQ/m4wTdQvY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GYkmdWAYh46nJguWM7+pPDdSf3lovyk2eDPa/iyrnnmjw7bVs/sbUU3M0BVXf4/qB
         O0JWvbS39TREEcEWlt2BPIeXOFkSpaZxioYYLShRK5FhgcuoOjIDCUrBNHHB2SIuE3
         QRjBT0s4OhIv8JCHFFA2VWGt9MSRqzIcWLuNYnp1GsI7hvag2iQpe1lAVZC19+xUvF
         T9aEnfk57KEmtbnRJwXHwFHYHvDHA8+ITodgpZYW9HSgkC7rdQTq5sHbXfTGz+MCta
         vo5OEH5S8hqOS5bvRG0B+2+Yiu49SSlEATBpKc/BpeI0p/0mB1E+JqnfGahxGoplxc
         FenqSm1hl6HKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA6C2C561EE;
        Wed,  5 Jul 2023 23:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: msft: Fix error code in
 msft_cancel_address_filter_sync()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168859802469.24898.3849324869308320065.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Jul 2023 23:00:24 +0000
References: <be155fef-7758-41b2-a6e8-8f7e253ff452@moroto.mountain>
In-Reply-To: <be155fef-7758-41b2-a6e8-8f7e253ff452@moroto.mountain>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     hildawu@realtek.com, marcel@holtmann.org, johan.hedberg@gmail.com,
        luiz.dentz@gmail.com, alex_lu@realsil.com.cn,
        simon.horman@corigine.com, linux-bluetooth@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 3 Jul 2023 17:17:16 +0300 you wrote:
> Return negative -EIO instead of positive EIO.
> 
> Fixes: 926df8962f3f ("Bluetooth: msft: Extended monitor tracking by address filter")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  net/bluetooth/msft.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - Bluetooth: msft: Fix error code in msft_cancel_address_filter_sync()
    https://git.kernel.org/bluetooth/bluetooth-next/c/375f2744ab84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


