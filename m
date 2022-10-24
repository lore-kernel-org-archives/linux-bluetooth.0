Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE319C38A2D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Oct 2022 21:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiJXVkI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Oct 2022 17:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiJXVjw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Oct 2022 17:39:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CC462AB2
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Oct 2022 12:48:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AF68B8119A
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Oct 2022 19:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C99BC43470;
        Mon, 24 Oct 2022 19:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666639816;
        bh=pUg8Fannv1C5NIrL6ldk5hbaR7/VzftwbDBxwjhFmFw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AfZbZVYPanWJpA6rx9hvCgNxm2KSvJgTl1FhmNyGhGjxKZSdPYRMDxKvWFNk+jH12
         AaQebiSimEBkCyyyTBtA0HAKxgc74VBrPmwX09obT97NBwfWibN4xzWTMrkdqZnUkq
         kNRKDMW+QsO/rfjHrAi3qWFykX1tq8PbtUswyFF0QfUDi9bVFrwEgNMHDPFVE5ry+w
         MmGyKYVip40ZQv5SUixFCAYaKn1reu3OQM737ZrfMQKXkwAc7ZYZTfrI9TSFM5WUoZ
         +G1viszTJ5BiDNitWh494oZMy1qWFa0XeX2I5pe8HXFKfUF172PLr3MjQ3sxkf8/mH
         ZvA/8cNGY6lIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF0A9E29F30;
        Mon, 24 Oct 2022 19:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: MGMT: Fix error report for ADD_EXT_ADV_PARAMS
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166663981590.14797.17091056780467477736.git-patchwork-notify@kernel.org>
Date:   Mon, 24 Oct 2022 19:30:15 +0000
References: <20221022004856.31984-1-inga.stotland@intel.com>
In-Reply-To: <20221022004856.31984-1-inga.stotland@intel.com>
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 21 Oct 2022 17:48:56 -0700 you wrote:
> When validating the parameter length for MGMT_OP_ADD_EXT_ADV_PARAMS
> command, use the correct op code in error status report:
> was MGMT_OP_ADD_ADVERTISING, changed to MGMT_OP_ADD_EXT_ADV_PARAMS.
> 
> Fixes: 12410572833a2 ("Bluetooth: Break add adv into two mgmt commands")
> Signed-off-by: Inga Stotland <inga.stotland@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: MGMT: Fix error report for ADD_EXT_ADV_PARAMS
    https://git.kernel.org/bluetooth/bluetooth-next/c/28fd83db215e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


