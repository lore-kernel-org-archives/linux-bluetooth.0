Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106A7C76196
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Mar 2023 16:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbjCQQkY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Mar 2023 12:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjCQQkX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Mar 2023 12:40:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B1316ACA
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Mar 2023 09:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F54CB8264E
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Mar 2023 16:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D2EFCC433EF;
        Fri, 17 Mar 2023 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679071218;
        bh=gkrOy6KNBDUaVxvNOIsbrw5r2oDFc1zScUm1m2aLdIo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=onZ4Fi2wVNdAYU82PQhrID8ISbTwtpENJHaGI+qhVpEQJ9JWFtdpXC93Bt2Nv7Tas
         7qftvSpPQxCmaUAK8KDeRgXT6+OCCcNVYL681zoCjV7r+IXZnb1yEDSnal+v5a925R
         hGdb5OxHQ05VpLBKi9mjY6UrL2E+EFhkws5FFGW7fvTzZs3c4pvNuEMpHqfDXgxhGc
         SFStUdmwJ0zr0XwEYLL2k79vQYG7Oprl7ZMnb3NBe4pbhSxGIGh1m0ZNRR1qCrXy1p
         gmXFfxEgRQcBKWKs75L8xB0X3+YUfZD6hX9FsawBDCZr/88xsCuU6MTN/LN6pSaMMR
         EBIu2xBls9E4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AEA31E66CBF;
        Fri, 17 Mar 2023 16:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/gatt-client: Fix not creating a request for
 notifications
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167907121871.10682.14358175544691498884.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Mar 2023 16:40:18 +0000
References: <20230316193634.1195948-1-luiz.dentz@gmail.com>
In-Reply-To: <20230316193634.1195948-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 16 Mar 2023 12:36:34 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Notifications were using bt_att_send directly instead of
> bt_gatt_client_write_value thus it wouldn't create a request which
> causes the instance to not be able to track it which in turn may cause
> the client to trigger its idle callback too early.
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/gatt-client: Fix not creating a request for notifications
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=306a8083ad19

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


