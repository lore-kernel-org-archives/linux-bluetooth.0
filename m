Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AF6C05027
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Mar 2023 19:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjCNTkZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Mar 2023 15:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCNTkY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Mar 2023 15:40:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6637D244B8
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 12:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D87EB81BA1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Mar 2023 19:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0A75C4339B;
        Tue, 14 Mar 2023 19:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678822818;
        bh=ga/jhptkmMKnIaXO2u+sad5sUB9sAZ+QyJMfA/QUogM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cSmK+dqnCO3dlkBrwFcw1NFgdVDyUGhQK9Uafy4GMQ9K7NqntSse9sSehMF237WkR
         txV7eDSwy0wYZBEa8CjR5KwW0D5ZSqlL5sQB/a/s9927ZuVcSZjZGltteKG5dM4OQ0
         /WFvcWhj2QEdZRk3qoX96BMtmH49TqUNgUJbWCKu8iuZqy/OGLMeTrOKFMnmqkM9qb
         mW1OYEKTDJYGgdgYPbDZ/FdX4jtz/OfTlHFrccUYm+OhRk/WaXoopGv+2kFDZKtLlq
         EdPB5FfhIVL+gUrscE5VLpbCMl05h8S+qvTDUDdxRQnuEde5viLoYrJ0fbKOZq/r6V
         32EaSi/5pKsrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 908D4E66CBA;
        Tue, 14 Mar 2023 19:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] device: Fix crash attempting to read Sets property
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167882281858.1169.788725737877447013.git-patchwork-notify@kernel.org>
Date:   Tue, 14 Mar 2023 19:40:18 +0000
References: <20230313183121.162037-1-luiz.dentz@gmail.com>
In-Reply-To: <20230313183121.162037-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 13 Mar 2023 11:31:21 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The following set can be observed when a sirk is exists but it is
> encrypted leading to info->set to not be set:
> 
> Invalid read of size 8
>    at 0x1ACDF0: append_set (device.c:1662)
>    by 0x1FFEFFF7DF: ???
>    by 0x1D4461: queue_foreach (queue.c:207)
>    by 0x1AC8DE: dev_property_get_set (device.c:1700)
>    by 0x1CF3E2: append_property (object.c:498)
>    by 0x1CFA91: append_properties (object.c:527)
>    by 0x1CFAFD: append_interface (object.c:542)
>    by 0x48D7CEF: g_slist_foreach (gslist.c:887)
>    by 0x1CF5A7: append_interfaces (object.c:1104)
>    by 0x1CF5A7: append_object (object.c:1119)
>    by 0x48D7CEF: g_slist_foreach (gslist.c:887)
>    by 0x1CF5D0: append_object (object.c:1122)
>    by 0x48D7CEF: g_slist_foreach (gslist.c:887)
>  Address 0x8 is not stack'd, malloc'd or (recently) free'd
> 
> [...]

Here is the summary with links:
  - [BlueZ] device: Fix crash attempting to read Sets property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2762129212f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


