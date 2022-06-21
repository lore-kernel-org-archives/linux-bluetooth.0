Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4527EC43334
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Jun 2022 20:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354221AbiFUUUR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Jun 2022 16:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354017AbiFUUUQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Jun 2022 16:20:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB511CFCD
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 13:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6C8DB81B2A
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 20:20:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8DEFAC341C8;
        Tue, 21 Jun 2022 20:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842813;
        bh=HnLMkqaZyFEARacZu6sw1XAE9IuP0jon6gdCId/pGDA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KxF3hjr1bG1fd15gch5cH9NgaSWY7LWlkkKKdLlZV0IxvKHtOBTDbYY2gYIufubRF
         x8D/E3L37t69VJSaSl5+zbh8XdfpqRUHIynr5ojgck/VV84x2cGEQGtNCGwk+Kk3Pt
         0bKlPBk4j3w0TDuE9qAL6B8qogU+gFnZxQ76bNBuni6UTbakYTArgEKKQodefoUZvm
         MSOeXoU9Y3W5iljL93+TqezUJsm7ZPQSEoy+Bb7y6aVdUKX3CLRZRbum7FKsLeWO9q
         H5QndmHdutcrgxlp/H5yLSZYAWt4hSmnwzdI6IJeqok8EfvpEaiprSymapJ3U6SaJk
         2hF3Z6yJXSQMA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FF64E574DA;
        Tue, 21 Jun 2022 20:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] Fix bug where bluetooth-meshd stops sending
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165584281345.22978.18302144345517363110.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Jun 2022 20:20:13 +0000
References: <20220610152902.21677-1-jonas@dptechnics.com>
In-Reply-To: <20220610152902.21677-1-jonas@dptechnics.com>
To:     Jonas Maes <jonas@dptechnics.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@intel.com>:

On Fri, 10 Jun 2022 17:29:01 +0200 you wrote:
> This patch fixes a bug where bluetooth-meshd may stop invoking the tx
> worker thread and hence stop broadcasting, accumulating all packets
> in its tx_pkts queue instead.
> 
> Updated: long line split in 2 lines
> 
> Jonas Maes (1):
>   Fix bug where bluetooth-meshd stops sending
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] Fix bug where bluetooth-meshd stops sending
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=71560e12863f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


