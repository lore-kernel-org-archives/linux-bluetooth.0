Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C539C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 19:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCNTkW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Mar 2023 15:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjCNTkV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Mar 2023 15:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91521C313
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 12:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62E3361961
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 19:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B98C3C433EF;
        Tue, 14 Mar 2023 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678822818;
        bh=qhB3sb8ZJnYq/D794Q6xrsVFEYFcyWY202G1mDC7Nwg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ivRQ+SxopvHjkjdEj5J5kaBbJs3fgjd85EIfy31cR/grh+Z35vtEIzfdms8YhlRO0
         ldDTDihZ2sNOy66WkN4suFy2c8SVq/iA4qtXjIuj5xBj/eSmnkj0qvFX4SjOlh31zK
         IU1eQPRZYZOOU6jzIaBtYRnNwow+HgJA2kUu0f6683RZEHBZNcUMPw3sZkX0NpK+qT
         lLZVQR4kyeStDfwoWw4VGaHL6eJrpMt44GShSL7wUjv7fn/xR2RccEvRPPFZY8YMbV
         hvaBm9PLAHKdYtJqlQgpKNto5uML2+NeN9QMjUzO8xtJeL2OJa3dUF/sRrvu8GV/Oa
         1xBYFsUim1a9w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9A008E50D65;
        Tue, 14 Mar 2023 19:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/4] shared/bap: Fix not unregistering idle callback on
 detach
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167882281862.1169.3288278075595209173.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Mar 2023 19:40:18 +0000
References: <20230313225150.267896-1-luiz.dentz@gmail.com>
In-Reply-To: <20230313225150.267896-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 13 Mar 2023 15:51:47 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This make sure idle callback is unregistered before bt_gatt_client is
> unref.
> ---
>  src/shared/bap.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [BlueZ,1/4] shared/bap: Fix not unregistering idle callback on detach
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=932b90f6c33e
  - [BlueZ,2/4] shared/csip: Fix not unregistering idle callback on detach
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=605ee768b789
  - [BlueZ,3/4] shared/gatt-client: Introduce bt_gatt_client_ref_safe
    (no matching commit)
  - [BlueZ,4/4] shared/csip: Fix crash on bt_csip_get_sirk
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e040109302d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


