Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A223C54799
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 19:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354761AbjHQTub (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 15:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354797AbjHQTuY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 15:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F11359B
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 12:50:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF1DA66826
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 19:50:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1A699C433C9;
        Thu, 17 Aug 2023 19:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692301822;
        bh=Qv3ltt7fAKJJ5JDri+RfZQGzkWvuY6kHbcvtVWKbbyA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mjLL2bzQ7Wzk91Sg8R4S2FhNuNCIqQGzXm2sYyV2ySQoUadSdOY3n63nd1TXcZaQe
         g24uPmoNvwtQDLmkAKXX9jqlrFVN8jyn5aHbgmX4wksfTv6d40Nm0Io6yMC6EvnO6E
         ZnGzXTNCstKhjtBOEp+5cqJwn1JaTZbalKCAgWdsHuVrXcoyxKzEOtBQ81PF8B3qJT
         3RHdUYxPmeTm09IQUMi1qa3siEIr16Y3RD0XGY48m4b7GQft7BdM4HhDS4eq9tCz9e
         26Nj1x0ZSFzjjDfA4ijfBbAJ5p7T6tm2uQJ0LSddWcAVDmr2l7jcuYbwlcSVESkVwH
         U4kX+sn03b4+Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F31B8C395C5;
        Thu, 17 Aug 2023 19:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/1] Bluetooth: ISO: Use defer setup to separate PA sync
 and BIG sync
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169230182199.7718.11583848723742447156.git-patchwork-notify@kernel.org>
Date:   Thu, 17 Aug 2023 19:50:21 +0000
References: <20230817064427.3647-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230817064427.3647-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 17 Aug 2023 09:44:26 +0300 you wrote:
> Some scenarios require a Broadcast Sink to complete the PA sync and
> BIG sync procedures separately.
> 
> For example, a Broadcast Sink might synchronize to the periodic
> advertising transmitted by a Broadcast Source and it might detect
> that the BIG is encrypted, by looking at the BIGInfo advertising
> reports. If the Broadcast Sink doesn't know which Broadcast Code
> to pass as parameter to the BIG Create Sync command, it might learn
> it from a BASS Client through the Set Broadcast Code operation.
> Only then will it be able to successfully sync to the BIG.
> 
> [...]

Here is the summary with links:
  - [v3,1/1] Bluetooth: ISO: Use defer setup to separate PA sync and BIG sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/f0835e7404b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


