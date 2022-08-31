Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC35ECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 23:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiHaXAZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbiHaXAV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 19:00:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976692E9EC
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 16:00:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E39DB823A8
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 23:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1EEFC433D6;
        Wed, 31 Aug 2022 23:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661986816;
        bh=dWBTp4ypSXxU1cbwlwNs3IAwLZiqTQ+UupW9wAHEZ9k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=HoAP0ui50tN+bOr2AKHslCXM+C41xvIXdBdo7bj6UWL0HcSDikG1MDWddoFPONseE
         RlYwrsyv0Rcub7KBSb09sfsANsBO1aO75/dKy/YAez7+noNjGTVmVdVxufgyJ5UyBv
         o4q25/fumVR/ZfldfSaUreiArVp/IY7YseRyl0g0g+anZnNhpQnWy9c98mK3LRXBWW
         pyOFpiy4w+Z3KcaSLzhB/eg4fjo+yX6lN7MY7Ci7QbL/jXdu3Jbq5QRjHdzr4gk7yS
         hDnVi+3UMIJAdNNhUkx2Dpmq5yy6MxvvaLzWhRhxIc4yeU4V+TTyWbiFp9uUfcV/pH
         TBzKq3nTw9RKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE2C7E924D6;
        Wed, 31 Aug 2022 23:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: Normalize HCI_OP_READ_ENC_KEY_SIZE cmdcmplt
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166198681590.15501.8288064355394041535.git-patchwork-notify@kernel.org>
Date:   Wed, 31 Aug 2022 23:00:15 +0000
References: <20220816190434.1015206-1-brian.gix@intel.com>
In-Reply-To: <20220816190434.1015206-1-brian.gix@intel.com>
To:     Brian Gix <brian.gix@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 16 Aug 2022 12:04:34 -0700 you wrote:
> The HCI_OP_READ_ENC_KEY_SIZE command is converted from using the
> deprecated hci_request mechanism to use hci_send_cmd, with an
> accompanying hci_cc_read_enc_key_size to handle it's return response.
> 
> Signed-off-by: Brian Gix <brian.gix@intel.com>
> ---
>  net/bluetooth/hci_event.c | 92 +++++++++++++++++++--------------------
>  1 file changed, 45 insertions(+), 47 deletions(-)

Here is the summary with links:
  - [v2] Bluetooth: Normalize HCI_OP_READ_ENC_KEY_SIZE cmdcmplt
    https://git.kernel.org/bluetooth/bluetooth-next/c/278d933e12f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


