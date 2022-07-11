Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 419F2C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Jul 2022 16:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbiGKQkP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Jul 2022 12:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGKQkO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Jul 2022 12:40:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0752DA99
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 09:40:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA379612B8
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Jul 2022 16:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 32ED7C341C8;
        Mon, 11 Jul 2022 16:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657557613;
        bh=xwZq9LEqoZ/hX2D3nJP2ymZ3rQXZpnMeaMUpxz40rC0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XL5oyrWRH+qJbhaQBXAz2D+QzSOlnn9cMyWudY6W9rZWEIfsVehTQzuuxZdw4H2ir
         IVduFHqw1p1uLqzD4wpILNa6PbnZKVE7NYUPvD3BbK4WMk24BAE2tY4bEBSmEIBVvK
         asUyxebt1eMLpnnsUEYRVIoZo6/6T0fTXik3iR7uKZxt6prXRYq7GV+PLGLx2W6Abp
         j3EJOiHOnYh+ZRQZ7WVtDvcZnDyKNOGDpaUJrPeXtAhl82syf8mW4hwxjdH89OjnVN
         NZsFpYckjLZ+WpEP3C2FMtfIvFIbPqeb+AULk4LQHDwYf2B3zH6rFo/Y/Mkyu3GsHi
         +SSc/OUVkEopA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13C9EE4521F;
        Mon, 11 Jul 2022 16:40:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] btdev: Fix not checking if a CIG has any active CIS
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165755761307.19082.15759142680740158998.git-patchwork-notify@kernel.org>
Date:   Mon, 11 Jul 2022 16:40:13 +0000
References: <20220708002751.2308369-1-luiz.dentz@gmail.com>
In-Reply-To: <20220708002751.2308369-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  7 Jul 2022 17:27:51 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Bluetooth Core specification says the CIG must be in configurable state
> in order to accept the SetCIGParameters:
> 
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E page 2553:
> 
> [...]

Here is the summary with links:
  - [BlueZ] btdev: Fix not checking if a CIG has any active CIS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=163de8e231e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


