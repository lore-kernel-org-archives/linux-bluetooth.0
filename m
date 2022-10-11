Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53219C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Oct 2022 20:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbiJKUuX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Oct 2022 16:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiJKUuV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Oct 2022 16:50:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A0D2AC65
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 13:50:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9945EB816B0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 20:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2CC92C433B5;
        Tue, 11 Oct 2022 20:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665521417;
        bh=BaDs7rWSR1HwZC0it2Idrw3ImedA3BFzx4B4S5X2roo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XDGqq+GWaHaBQfn7TXGaSTNw6xgbhQ6RXCpXbUOphHSZdAXpxMhI1x4azM5s9Aqm5
         rNIwonpqcb+7k8swc89uAL7Lp5jREvgCUmdZ60yLCfmESAV3BU1s+6fGlgfkYyWtz0
         6gHj6bR3EAIf1A+qU5bPCSaNIQwX36V+QZe6zJ3ijgPGb4xyzjq/kbOywvGKHxVN+M
         vQs9Ty/RTSBHf5mQ2OWwREMpqhSTct6LUrq9xlsz2fRiNw8CSu23u7zAxZ1MCKAbcg
         6slDYxLPBJgR2w6B6S/98kROLrkT04HCAR9bPxbPv1eUudSBgehCsvTXVg4xpOWsRk
         vPKf9mI1UBrwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 14318E29F35;
        Tue, 11 Oct 2022 20:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_conn: Fix CIS connection dst_type
 handling
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166552141707.15349.14286195925822379039.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Oct 2022 20:50:17 +0000
References: <20221011192534.16281-1-pav@iki.fi>
In-Reply-To: <20221011192534.16281-1-pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 11 Oct 2022 22:25:33 +0300 you wrote:
> hci_connect_cis and iso_connect_cis call hci_bind_cis inconsistently
> with dst_type being either ISO socket address type or the HCI type, but
> these values cannot be mixed like this. Fix this by using only the HCI
> type.
> 
> CIS connection dst_type was also not initialized in hci_bind_cis, even
> though it is used in hci_conn_hash_lookup_cis to find existing
> connections.  Set the value in hci_bind_cis, so that existing CIS
> connections are found e.g. when doing deferred socket connections, also
> when dst_type is not 0 (ADDR_LE_DEV_PUBLIC).
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: hci_conn: Fix CIS connection dst_type handling
    https://git.kernel.org/bluetooth/bluetooth-next/c/2b8166cea8fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


