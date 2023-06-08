Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04624C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jun 2023 00:00:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233048AbjFHAAY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 20:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjFHAAW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 20:00:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F039E
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 17:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D9F364310
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jun 2023 00:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB6D7C4339B;
        Thu,  8 Jun 2023 00:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686182421;
        bh=oB4sTeQP1MTzPfqLbs5NNKIeHpqYBmD9hPRq1ONQ+GI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=k8V6RbaJfieEGfvqtD4jQOfQCuJIckbS9rB6GISuIlMPEvBGg+4ZcZInshmc2jrAo
         zzHkhDQg0BQrrxhR00m4A6BU/uAZ6HiOmh3ZAaACnf+Zub4tf1NPj8zt7k9k2hdLNv
         GvgI3XBeGOGoxJ1EIiHw962OYp41MeHuZXC6hQKo7J2urtGdSEltloQdq+1u0JVuAO
         7IEMaCC4eEOnOqPqdkAuDLjG3pOvDYoYm3JLgfxw9U5RgadZGZjIDG4nEGMUSYo3nX
         7ZTXFCw042JnYkyNrOUmECInsGKgY2dCYrb0pWrmmt2qL1lElj+Hm4F76ZLvE9SUte
         Gr6qf3PDeGnTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCF9DE29F39;
        Thu,  8 Jun 2023 00:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 0/4] Add initial support for BAP broadcast source
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168618242083.10548.8032068728467603418.git-patchwork-notify@kernel.org>
Date:   Thu, 08 Jun 2023 00:00:20 +0000
References: <20230607082300.4970-1-silviu.barbulescu@nxp.com>
In-Reply-To: <20230607082300.4970-1-silviu.barbulescu@nxp.com>
To:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  7 Jun 2023 11:22:56 +0300 you wrote:
> This patch adds initial support for BAP broadcast source.
> 
> The current implementation allows BAP source endpoint registration,
> media transport creation, transport acquiring and sending broadcast ISO data.
> 
> Currently, one BIG containing one BIS is supported.
> 
> [...]

Here is the summary with links:
  - [v4,1/4] Split bt_bap_qos structure into unicast and broadcast structures
    (no matching commit)
  - [v4,2/4] Update bluetoothctl with support for broadcast source
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=eb821743f9bf
  - [v4,3/4] This adds the initial code for BAP broadcast source
    (no matching commit)
  - [v4,4/4] Update BAP plugin with broadcast source support
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


