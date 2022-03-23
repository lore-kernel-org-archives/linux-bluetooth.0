Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37513C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 10:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiCWKvp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 06:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbiCWKvn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 06:51:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964AE75C3C;
        Wed, 23 Mar 2022 03:50:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B2BEB81E70;
        Wed, 23 Mar 2022 10:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF5BDC340F2;
        Wed, 23 Mar 2022 10:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648032611;
        bh=0nZK4AfBZIKQRvSrQXHV2JkZ04BBuYgWS/yp4rPQSGE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t0mn2e8kRqoW7iDenpOwqcqN4qagYeQe4WMUtS6V+eOYPZHbOmCuOa4cyVfoQfzCS
         G2hGSSUsGxqeIzRE2JE9z1OWgOVL5ln0qdmF3zJsBjeBd8sBU+1GHQW6IGEW0RZCi4
         CabmeBsZsQ9D6KLx8BkXs4EDX275841bGvRLxBSgIrGejSeIDGbPk915myQ5nJ4K7K
         t8ZcLbfKxA1S/+JYUkvM7av++0h8Zjc5Nf1pTEm0NS08b/9y4JRphgTOhnSIEtU4Dc
         lr6Yqn+37t0/EQ44Py5x7oCujWU4G6QtZxMICfHIJFeegueNbTAvaL1V4QTiMUkCKB
         RtNbeZ2W8sQyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9257AE6D402;
        Wed, 23 Mar 2022 10:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: mt7921s: fix a NULL check
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164803261159.27387.13243818190116041496.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Mar 2022 10:50:11 +0000
References: <20220323074830.GA4639@kili>
In-Reply-To: <20220323074830.GA4639@kili>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     marcel@holtmann.org, yake.yang@mediatek.com,
        johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        matthias.bgg@gmail.com, sean.wang@mediatek.com,
        markyawenchen@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Wed, 23 Mar 2022 10:48:30 +0300 you wrote:
> There is a typo in the NULL check so it's never true.  It should be
> checking "*ven_data" instead of "ven_data".
> 
> Fixes: 3cabc5ca2c9d ("Bluetooth: mt7921s: Add .btmtk_get_codec_config_data")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/bluetooth/btmtksdio.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - Bluetooth: mt7921s: fix a NULL check
    https://git.kernel.org/bluetooth/bluetooth-next/c/864cc8a234cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


