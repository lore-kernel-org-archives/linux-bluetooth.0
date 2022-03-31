Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4069C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 31 Mar 2022 18:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbiCaScB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 31 Mar 2022 14:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbiCaScA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 31 Mar 2022 14:32:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE08412759D
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 11:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34B16618A9
        for <linux-bluetooth@vger.kernel.org>; Thu, 31 Mar 2022 18:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90F98C34111;
        Thu, 31 Mar 2022 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648751411;
        bh=0nome9kzQRed6i6hQgL2Q9jNjClud/N/obQoq2T+z/8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nQ0rCTQCLNtch7XhfG4cksnPmVUzZqbpwqOCJDfY7JgHMg5Q345HXITq+SPsBOAZm
         ZXRWASYi0AkHcMTW0Y+uZh8zzMvCAB9DGZr8H73qFkljfVm+94wsOz4wnR/1gHIFt6
         U0KWQyXHFbyCUjhAlcvjdTKeeunyR8LPHoSjj7pI9o6A5ZfT1Hi6OamlBB/tzR7Cjy
         0S9aPXFmGNsCUaod/oO635E8A9ICxYdK65gU1JiityRhgxklqOv/Ijlxj5NTvncXqV
         S6icvhHnimbGRg4Wc72DKpSu7QllnEvzOryS0brr/j71oDdWIqjZmiF+ycvMdHNVp0
         zCug/IzH+dx/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70B4EF03848;
        Thu, 31 Mar 2022 18:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] mesh: use explicit uint32_t when bit shifting left
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164875141145.30107.12733086065208747296.git-patchwork-notify@kernel.org>
Date:   Thu, 31 Mar 2022 18:30:11 +0000
References: <20220330211747.48759-1-inga.stotland@intel.com>
In-Reply-To: <20220330211747.48759-1-inga.stotland@intel.com>
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     brian.gix@intel.com, linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@intel.com>:

On Wed, 30 Mar 2022 14:17:47 -0700 you wrote:
> This addresses a situation when a boolean type is represented by
> an integer and performing a left shift on a boolean causes
> an integer overflow.
> 
> This fixes the following runtime error:
> "left shift of 1 by 31 places cannot be represented in type 'int'"
> 
> [...]

Here is the summary with links:
  - [BlueZ] mesh: use explicit uint32_t when bit shifting left
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ff35b1d2e97e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


