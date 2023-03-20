Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07854C7619A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 19:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjCTTgT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 15:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjCTTfe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 15:35:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047CF17150
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 12:30:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43554617C3
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 19:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 791FCC4339E;
        Mon, 20 Mar 2023 19:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679340619;
        bh=o3XbL/MIYuOLDgOqvwVIsMyIR9ebBiGsMDNa2ieLmmU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NHj5xL8bLPh6l2BCr4thvoAIiPsDi88fiifR1TRO58dNkijBbrk0p/inVGzmKLAZy
         IU3aCBq+67nWdngdCuEwStxerEdAPQMkYCNHR6EvUDsyzccPylTKGU4UpVKQLtHloZ
         lThspvDt5V/QRvTHvU3kJPcRZndutJJTjCYe2W1OMkC1wUb7DinvLjSaGn2X6dAdRr
         e0q61HtG7SWc8MfORighFyqC/B9YSFrlLYSrkFy/1JdcWao5zjEqUiQJOU2e9Hr/0o
         scxOq+F+QXBWHejMM5GzjkOcv+yXsvsz2luEqyWcKjS4s4xMwYfV0VHEAGlC1xWH3n
         Jf9qzqn5LEc0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A32BE68D22;
        Mon, 20 Mar 2023 19:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] mesh: On exit free timer for filtering duplicates
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167934061923.3672.6343221000285752197.git-patchwork-notify@kernel.org>
Date:   Mon, 20 Mar 2023 19:30:19 +0000
References: <20230320050618.314590-1-inga.stotland@gmail.com>
In-Reply-To: <20230320050618.314590-1-inga.stotland@gmail.com>
To:     Inga Stotland <inga.stotland@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@gmail.com,
        brian.gix@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@gmail.com>:

On Sun, 19 Mar 2023 22:06:18 -0700 you wrote:
> This frees resources associated with duplicate filter timer
> when destroying management IO.
> ---
>  mesh/mesh-io-mgmt.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [BlueZ] mesh: On exit free timer for filtering duplicates
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4a3f465a55c9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


