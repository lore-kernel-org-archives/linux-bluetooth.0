Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2CDC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 May 2022 00:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359692AbiEMAAQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 May 2022 20:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359704AbiEMAAO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 May 2022 20:00:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466BA28B6A3
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 May 2022 17:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D82036209D
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 00:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48218C34113;
        Fri, 13 May 2022 00:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652400013;
        bh=PFuILzuFMXfzjZAMXvvQSTUJefxgRX0YYlbRBKkgwVc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LYfoSAnl/MrU9kcJafOeq3GV99aL4izl2C95IhQcKwSZ2QbWDJC4g3AM6dP8Du0U6
         IEaznse02ViE8kgLf4mv4RZeeJsj0yhCgDSdJDu13ckE/UME5nWAFyZChQZ3yzjzlW
         iocbG8pQrzruQ4lOff0jx+5ck98h1U3IueKxpoTbWXYBfJbIRP/10qCOjPrVRIvBtt
         7FJWliFG2kc4syTJAnEb6yAU8KMcccoxINx7Y/9+mi0GX0JgPCEy3UexOTQzx22IOn
         2hYOleEbThg9WRRMkAIHtvcrzB8BhLcsEUPHpUBG6JsbrOYYVuvlLdLbXOSeORDhvi
         oQ23mbS7QYWaA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C57FF03934;
        Fri, 13 May 2022 00:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] gatt-db: Allow passing Characteristic Value to
 gatt_db_attribute_get_char_data
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165240001317.24546.12440574076611367095.git-patchwork-notify@kernel.org>
Date:   Fri, 13 May 2022 00:00:13 +0000
References: <20220512005515.844857-1-luiz.dentz@gmail.com>
In-Reply-To: <20220512005515.844857-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 May 2022 17:55:14 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes gatt_db_attribute_get_char_data work with Characteristic
> Value rather than only with Characteristic Declaration.
> ---
>  src/shared/gatt-db.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [BlueZ] gatt-db: Allow passing Characteristic Value to gatt_db_attribute_get_char_data
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=83497bbb307f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


