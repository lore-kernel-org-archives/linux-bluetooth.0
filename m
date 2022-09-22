Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5182C32771
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 01:10:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiIVBKb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 21:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiIVBK1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 21:10:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C380B3122B
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 18:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8405FB83396
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 01:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 288F5C433B5;
        Thu, 22 Sep 2022 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663809022;
        bh=9VPqF7gCSwObY/U8H2xjtGIdx+JSHaolYVHwwiN7MoE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CHlMKymlfFzObar9I8rRDzsCOWfejRVn4pZpVa2+WZNhLQBLRpEYx1jqlktuqylZd
         DXsQjQuOs0qJfHlDZ6tV0kdaWQeOXndAYT7JvFNT3TOjwi1j77KExZvev4EJJ7cPlR
         jkiKrp8F4xP5kfLg1k33PgarXCsAeHcpbK875R6Y1dKeKu2YHrwQQKTTnGLoLU55pp
         jQgYJxZw1bwb4xeFiYAeQZ4moknYPQSnpvrg5Nzd+2omifEP5KRccpb1xSuntack1H
         lr7zUgTJk2OfI6NOQWyiKELyQrwNP2O8xvLodFAQsz1TG5P4Q2oHaQEmNF08QLL94I
         edmdkqAK5TNFA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F146E4D03D;
        Thu, 22 Sep 2022 01:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] shared/vcp: Add bt_vcp_set_debug
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166380902205.22214.1718303464212322937.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Sep 2022 01:10:22 +0000
References: <20220921102732.688081-1-sathish.narasimman@intel.com>
In-Reply-To: <20220921102732.688081-1-sathish.narasimman@intel.com>
To:     Sathish Narasimman <sathish.narasimman@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 21 Sep 2022 15:57:31 +0530 you wrote:
> Add support for bt_vcp_set_debug and replace the exisiting DBG.
> ---
>  src/shared/vcp.c | 238 ++++++++++++++++++++++++++++++-----------------
>  src/shared/vcp.h |   5 +
>  2 files changed, 156 insertions(+), 87 deletions(-)

Here is the summary with links:
  - [BlueZ,v2,1/2] shared/vcp: Add bt_vcp_set_debug
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=89ac7b826557
  - [BlueZ,v2,2/2] Profiles: Enable bt_vcp_set_debug
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7233b50f4135

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


