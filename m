Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BCDC77B73
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Apr 2023 20:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjDNUKW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Apr 2023 16:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjDNUKV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Apr 2023 16:10:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC9519AA;
        Fri, 14 Apr 2023 13:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF77464A1C;
        Fri, 14 Apr 2023 20:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 23259C4339B;
        Fri, 14 Apr 2023 20:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681503020;
        bh=jx+5aFH+D1AaOqLb6zg5Z9VuHhLk8+ajilCemoTPDpc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=j0TdiFzsNaa3rq243EyDH7scX2A39LaJG1xcRE1tkQAnbUOMwWIpLS8NCE/2qUVmE
         AFCEjYHuGSioYS1celYYYD/kww4xemHJs4NSsWs//eBTieiVO2sgfRy4yENVfl9mEQ
         8cBg6j+KfBtYJKifRdfCV9u/dwQessohrm9lvANlNePd5cSxqChtmmc6RYsYdBJcko
         kpqIC6dkpRHQSE0ktrJbJRpFL7VzMeatcId+TKUUPtj34jPznwpXcWhRAzy9DTZ5KY
         sO99sGnvt6aY67i/32ptZknrobEz4vibedNcXHdTAL9F4WqdzQ+mfkn7DJk+h7ewa7
         1C0TBbayUSMrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12E33E29F3B;
        Fri, 14 Apr 2023 20:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_qca: mark OF related data as maybe unused
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168150302007.15322.13621162833443050946.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Apr 2023 20:10:20 +0000
References: <20230412-bluetooth-v1-1-377b9bf7b08e@kali.org>
In-Reply-To: <20230412-bluetooth-v1-1-377b9bf7b08e@kali.org>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 12 Apr 2023 18:58:17 -0500 you wrote:
> The driver can be compile tested with !CONFIG_OF making certain data
> unused.
> 
> Signed-off-by: Steev Klimaszewski <steev@kali.org>
> ---
> There was a patch to mark OF related data as maybe unused in flight when
> I was doing my bluetooth driver work and I didn't notice it.  Since I
> don't build on !CONFIG_OF systems, I hadn't seen the warning.  This
> patch simply marks our data as maybe unused as well.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_qca: mark OF related data as maybe unused
    https://git.kernel.org/bluetooth/bluetooth-next/c/875d76c2f7c1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


