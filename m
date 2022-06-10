Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90423C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 04:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235982AbiFJEUP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 00:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbiFJEUO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 00:20:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6E5245A3
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Jun 2022 21:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A45361D28
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 04:20:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4598C3411B;
        Fri, 10 Jun 2022 04:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654834812;
        bh=rr7yxIGPngQT8HyciDT3WCKMknbNEXbBwGW0uFsNqMU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JwMgxXdb+LcRL0HtJfCVrj3atovYDV5qZqc1QFyxv7BW9z6YDYWPriGDi/t1WGapI
         fgB97MW+OlNSZD6brOfH/DKkRyb6KeS3WLhJhqaXHqFF6dKYjRHTA6NKU7A5DrHgeX
         aluNQNPmJj/1Ue9IbOEPbnH4OXNSSLGWEsgDD7Xuk5dmHS1+HTG49DiSQWsG9jDb2v
         3guQ6kpUOonygr87ySR1pdduddW2VJ4Nstj07Q+L5HXdf1/s1WSghpqvhKHjGN42ic
         S6pztiIOJUEtwSAI98tcdzV3jeW11q1w7u/YDDn70KBf6NJifZCGtG7I4zC1moEkQB
         qW83ySSbnjcCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AA8F0E737F6;
        Fri, 10 Jun 2022 04:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] doc/coding-style: Update URL to kernel coding style
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165483481269.9629.5112498696816232120.git-patchwork-notify@kernel.org>
Date:   Fri, 10 Jun 2022 04:20:12 +0000
References: <20220603212604.13758-1-puffy.taco@gmail.com>
In-Reply-To: <20220603212604.13758-1-puffy.taco@gmail.com>
To:     Michael Brudevold <puffy.taco@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org,
        michael.brudevold@veranexsolutions.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  3 Jun 2022 16:26:04 -0500 you wrote:
> From: Michael Brudevold <michael.brudevold@veranexsolutions.com>
> 
> ---
>  doc/coding-style.txt | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)

Here is the summary with links:
  - doc/coding-style: Update URL to kernel coding style
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3c7413f49c03

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


