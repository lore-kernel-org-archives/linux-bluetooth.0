Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3688C32771
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 01:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbiIVBKa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 21:10:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbiIVBK1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 21:10:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36CF2EF38
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 18:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49974B83394
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 01:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D8B6C433D6;
        Thu, 22 Sep 2022 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663809022;
        bh=xNaVudcXdYCrwv43PNOrEJZcA0G10zuE3z0HcQfj+TQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CCcZhaGO7wGLas3vIMSGDKxFd2BlHYm1ELvBJQ6HuL7kb1fuxNIcaRRqSplPunNa0
         GKE2CMkJv45z+kxvhj8bHz/1v1pZBYtwrbBdXwMAH3QwkZsva7V9SqmeEA0xwIE7X+
         8OgGS3QKn10AeddK4HMBbELS0Qo482NJXRyTFUcSzJxNHTNjmk/bepRfjLrQTS4rlw
         PthMy9iWsAX7mCMmsr2H36ueQsxI4TYmj2pqzr3vscpnO6qUXlXZCmcGoGtPe090KP
         ysNsoXvGEVriwdUFAO7GqXslTzST/iKCkd7IFB2/EEty+n+XC3LUA8i8qqCbnnhOXQ
         uWDG7/6/gxzRA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EDC5EE4D03C;
        Thu, 22 Sep 2022 01:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/3] gatt: Fix not setting permissions for CCC
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166380902197.22214.662103270812215678.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Sep 2022 01:10:21 +0000
References: <20220921214656.2241730-1-luiz.dentz@gmail.com>
In-Reply-To: <20220921214656.2241730-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 21 Sep 2022 14:46:54 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> CCC shall always have both Read and Write permissions set in addition to
> what application set.
> 
> Fixes: https://github.com/bluez/bluez/issues/399
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] gatt: Fix not setting permissions for CCC
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fbf17ac497bb
  - [BlueZ,2/3] gatt-db: Check if permissions are set when adding CCC
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=50782b0eeb05
  - [BlueZ,3/3] client/gatt: Fix notification enabled/disabled output
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c2734c41f7c0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


