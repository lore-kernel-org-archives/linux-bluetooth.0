Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFB2C32773
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Aug 2022 20:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350046AbiHSUAU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiHSUAT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Aug 2022 16:00:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A00E3C36
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 13:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 920CCB825BF
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 20:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E6A0C433D7;
        Fri, 19 Aug 2022 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660939216;
        bh=nkAErsAg9+eM+CJ0UzgGcKCA+xrkHHg7L2dQhGiy06k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VRQjhvSX4oAae/RAFWyw0Lm3a9TWGc5IqZJS+LQJwbker+sMPhziqxIc0IUxkkT6M
         Zahlud4bpyoB5jUPjZwmenYo9gHXnmKa/reSdr7Lv+jO+lEMssNDRfHNz9QxxRIZ2y
         B13Es0pVoaUPym2H2LW7M3P7Y15upTlWA3/4IlF0DUFSRLt58NRdag4uJa7UcVAtIY
         hv6mSObbrAYLzEjZMvAev8ikrsadsX6LgoseKT6nrF57m3ShSpRooWCrKKcDIXR7DK
         JymjyZN1d6iEMjDoMp6xqzlsg0Zrw9QOT2xx4YpK+t6Ra3SeJfMTHU8s/QYbWAbh/Y
         0gUkwxRu86K4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2C131E2A054;
        Fri, 19 Aug 2022 20:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] iso-tester: Fix using shutdown(SHUT_RDWR)
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166093921617.9792.5064404337095470062.git-patchwork-notify@kernel.org>
Date:   Fri, 19 Aug 2022 20:00:16 +0000
References: <20220819184605.19225-1-luiz.dentz@gmail.com>
In-Reply-To: <20220819184605.19225-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 19 Aug 2022 11:46:05 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> shutdown(SHUT_RDWR) results in socket being HUP immeditaly instead of
> waiting for Disconnect Complete event so instead just use SHUT_WR to
> start the disconnect procedure without causing the socket to HUP.
> ---
>  tools/iso-tester.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [BlueZ] iso-tester: Fix using shutdown(SHUT_RDWR)
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4999f80c1f56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


