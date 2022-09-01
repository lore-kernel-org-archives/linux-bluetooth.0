Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240ABECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 22:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiIAWA6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 18:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiIAWAr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 18:00:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A42240BD7
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 15:00:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3EFA61F93
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 22:00:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BD13C433D7;
        Thu,  1 Sep 2022 22:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662069643;
        bh=c4KpC9lgj1RccMllJjVK/BNp/YGfxSukFXeeSF5KOzg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fKHakJIfT2aKUEsqh30s3nZDLS99/HOqpyfMW/QsIHf1vtS3m/3vV4TOssV/HMkyi
         CE8WMuSek8qICbKUUnYdXOdbq8P3qPmi+8w2of0fUUd4jdww+wEdj5jdDBJx8I4R9z
         +4NMYjjLBrSgfUOwMV/U3ozq5AqvjcNXc4kipSUCyu2oD5cJDa8pPA7j5kyRCBgJTR
         VRuLnM3CvG5LcPn5ZGEy7LWQdxGe0qbC0rkfEv12sGfvUvZd94pulPlznZW63tJ1lD
         u82B0Cs5dafqvEhZ9rI2OE1yiYHI7ySaLp2m4+Fb/20iCkL4Mycjb7MYI97eWR32ee
         4cn+nD55/bqKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3584AE924E4;
        Thu,  1 Sep 2022 22:00:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 0/2] Add mesh testing support
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166206964320.4836.5908657912397432707.git-patchwork-notify@kernel.org>
Date:   Thu, 01 Sep 2022 22:00:43 +0000
References: <20220831235932.290032-1-brian.gix@intel.com>
In-Reply-To: <20220831235932.290032-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 31 Aug 2022 16:59:30 -0700 you wrote:
> This patch set reserves MGMT events and opcodes for Mesh, and adds a new
> unit tester for those features: mesh-tester
> 
> v2 - v4: Fix whitespace
> 
> 
> Brian Gix (2):
>   lib: Add mgmt opcodes and events for Mesh
>   tools: Add mesh-tester to test Kernel mesh support
> 
> [...]

Here is the summary with links:
  - [BlueZ,v4,1/2] lib: Add mgmt opcodes and events for Mesh
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4f452c7753da
  - [BlueZ,v4,2/2] tools: Add mesh-tester to test Kernel mesh support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=da4b654834b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


