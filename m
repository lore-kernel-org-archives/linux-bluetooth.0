Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C213BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Mar 2022 19:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345821AbiCXTvt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Mar 2022 15:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241865AbiCXTvs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Mar 2022 15:51:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFD45576F
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 12:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E944060A5B
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Mar 2022 19:50:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55E2EC340F3;
        Thu, 24 Mar 2022 19:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648151414;
        bh=IqqmnCKCMx9OTXvJLXzRgN0hZ+RADxdy2S04amBscTY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KwtgKkBik+4f9YdSBVO3ujgy0IkelEMTqos1EbViUQemLRqo9bsEJC4lTfIv2gTXj
         nANakv0ptQGJYmKK6MTYucW9e9bxgWIFQ5e0Ezu5fN0rnDqFcQuBzVs6SAwXhJed/h
         CZMz3U1wXrSUsx7hdETdSwM05IH+zBIHPKyNipck5rxv6rVK/OhuQ341134uKHHBwf
         XR9/Qij7dhP9h7Bwww44sA8DGrOuxMm7HVxQOaGc93uscx4xWlXloyJdIN1fQ//4SK
         bqio55gbYsUYxFvimQHznjL15bJdIiLC5MGVxmrdHr8sfSRLK9Sl4wrqp92GiKNVJm
         cfyxoq2VNFPUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2ECFBF03842;
        Thu, 24 Mar 2022 19:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v4 1/9] log: Don't log __FILE__ and __func__ with
 DBG_IDX
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164815141418.1997.13254505864475530061.git-patchwork-notify@kernel.org>
Date:   Thu, 24 Mar 2022 19:50:14 +0000
References: <20220323224003.3736525-2-luiz.dentz@gmail.com>
In-Reply-To: <20220323224003.3736525-2-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Mar 2022 15:39:55 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This removes __FILE__ and __func__ from DBG_IDX since users of it may
> already contain such information embedded in the format.
> ---
>  src/log.h | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ,v4,1/9] log: Don't log __FILE__ and __func__ with DBG_IDX
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a3c9409035de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


