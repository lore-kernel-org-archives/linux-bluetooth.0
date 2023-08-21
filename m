Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17755EE49A0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 20:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjHUUA2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjHUUA1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 16:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3556A11C
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 13:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C89566172D
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 20:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BB7BC433C8;
        Mon, 21 Aug 2023 20:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692648025;
        bh=Bz1G5Rtm6CfFPFbnfnMjrC1JzV0F+SPx2EPnkaBnc6c=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YrGsTc6J9Phjxcihj0qv9ClDGjKOUtEb0fbMB/h3BxrTF9cPHYAn4mK6xkbLeM6bn
         GmeIu1vGoJvm0e2609Nvhefug7cvP572CFYYYy8+xTzYsmsznrqg7yycFe2xnomEp8
         a9SIEDEVosdZfffXVRySOd0Fv55/AuYj6+bGaBOMoD5wxz/is/EOHYEqcxtJH0kAiZ
         R19U2J0PTAqQ2Oax/vzcqQuZymsD9p5CgvZJzkPhpdcBh3ktOR9+TTa5e4LJTjZDni
         U9LfRqSmFrIfhsdayqbTnRvWISytYC2u2Sv9IIQQZf52Dofw/VyB7xcgQ+YLQW6QR/
         phTvkvwV6orSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 26330C3274B;
        Mon, 21 Aug 2023 20:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/4] vhci: Add function to pause processing input from
 vhci
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169264802515.24934.10897400430640466949.git-patchwork-notify@kernel.org>
Date:   Mon, 21 Aug 2023 20:00:25 +0000
References: <feaee15ebafa76155f6c1a91755d6d5ba054d451.1692451184.git.pav@iki.fi>
In-Reply-To: <feaee15ebafa76155f6c1a91755d6d5ba054d451.1692451184.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 19 Aug 2023 16:31:20 +0300 you wrote:
> Add function to pause (temporarily) reading data from vhci.  This can be
> used to synchronously pause handling of btdev commands from the kernel.
> ---
>  emulator/vhci.c | 9 +++++++++
>  emulator/vhci.h | 1 +
>  2 files changed, 10 insertions(+)

Here is the summary with links:
  - [BlueZ,1/4] vhci: Add function to pause processing input from vhci
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dbe52200549b
  - [BlueZ,2/4] hciemu: Add hciemu_flush_client_events for ordering VHCI vs bthost
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bfcc3f7bf48f
  - [BlueZ,3/4] sco-tester: add test for ACL disconnect before SCO established
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=465108814db2
  - [BlueZ,4/4] iso-tester: add test for ACL disconnect before ISO created
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=70b4db6803b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


