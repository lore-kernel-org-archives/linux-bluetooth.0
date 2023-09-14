Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 922FBEEAA60
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Sep 2023 18:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjINSUc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Sep 2023 14:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239368AbjINSUc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Sep 2023 14:20:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C231FD5;
        Thu, 14 Sep 2023 11:20:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E5732C43397;
        Thu, 14 Sep 2023 18:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694715627;
        bh=SS0M6Kt8YuF6xAMBPjxHznl+ExrQhq8P+MWQMNc81sE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BbZVUsIcGvLgqblaaN10iQfuzzPmCo26SVCVlcLK/+jy5xAOL94kd/x0DIFCG+Wy4
         I+Gvwdt2UdcyGFSGJ7TrB1meEnEDz6Qx+gF69y9hBBeoF5iV9lXpkAZjF+hn+CvBXI
         wKaKjtoQvIAvhzi2W2rg83Wvg+H8wVkZOnUphM6XodEPjNM9eVrr8plP6TrrgljOzx
         XU2lH8UZe+IyoHsQ+ScNaDzvgXMzbR1Ha5sFGq8cIUOWCijikmJTyPldhZw9CxYmm6
         r0R6dyQHVpNJXRvh/dpyDcswtr67cFHWKM22ZsSoWzePntYtiv69FDkf59+o8fa+c6
         yL65Mag4JbPmw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D2433E22AF4;
        Thu, 14 Sep 2023 18:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: qca: add support for QCA2066
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169471562785.30611.11145130231020856678.git-patchwork-notify@kernel.org>
Date:   Thu, 14 Sep 2023 18:20:27 +0000
References: <20230912093957.3334273-1-quic_tjiang@quicinc.com>
In-Reply-To: <20230912093957.3334273-1-quic_tjiang@quicinc.com>
To:     Tim Jiang <quic_tjiang@quicinc.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 12 Sep 2023 17:39:57 +0800 you wrote:
> This patch adds support for QCA2066 firmware patch and NVM downloading.
> as the RF performance of QCA2066 SOC chip from different foundries may
> vary. Therefore we use different NVM to configure them based on board ID.
> 
> Changes in v2
>  - optimize the function qca_generate_hsp_nvm_name
>  - remove redundant debug code for function qca_read_fw_board_id
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: qca: add support for QCA2066
    https://git.kernel.org/bluetooth/bluetooth-next/c/e1030955f7aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


