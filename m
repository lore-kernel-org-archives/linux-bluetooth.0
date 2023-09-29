Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF92E743D3
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Sep 2023 00:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbjI2Aks (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 20:40:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232443AbjI2Akq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 20:40:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328CE199
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 17:40:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B5EBC433C9;
        Fri, 29 Sep 2023 00:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695948024;
        bh=P07UEcMi0k3l8yY8S2ig/YO3h5sFAs6y8hePZeKt7F0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FFPsmAEJd7A00HzpAQfuBtnPmiAaaLyK3UFWG1o/7ORWM1eC+rj5aPNYV99RDyQ0o
         sv8mV1LBZlorARD9iC8ZjZD5uRUyU2UNB6V8HM3EENs2shsO3NcS5fObVBW1ML78/u
         AdkdNMUJNo52UppNC9ONCL9Sd9c+efxRNjTSiWFgyUsVqzYrf+Jx09hgbQgtAWTx2M
         sZEWjB0cZFuXCme0cO4gVr23Gb0J7v3/QKSyCbEOxrTrfKb1r35lgVdUys5oEwUNyu
         lljIQuigD1TmFhbTgrT5v8AK+Yobf/Fp0IihBfNjeGbOUCcbwCR5xTTow+IsxabnJu
         shQSg6adTOP/g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 423E9C395E0;
        Fri, 29 Sep 2023 00:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] csip: Fix not registering CSIS service
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169594802426.19150.15200789451221848515.git-patchwork-notify@kernel.org>
Date:   Fri, 29 Sep 2023 00:40:24 +0000
References: <20230928203856.2100456-1-luiz.dentz@gmail.com>
In-Reply-To: <20230928203856.2100456-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 28 Sep 2023 13:38:55 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> adapter_probe callback shall register service the plugin wants to
> expose which was not the case for csip since it depended on a device to
> register the bt_csip instance which is then responsible to register its
> attributes, so this change it so there is a dedicated driver for CSIS
> which takes care of creating the necessary attributes and associate it
> with the adapter so it can be cleanup properly.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] csip: Fix not registering CSIS service
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c488783cb55e
  - [v2,2/2] shared/csip: Remove bt_csip_add_db
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ae9bf50a2792

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


