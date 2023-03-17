Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38BDC7618A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Mar 2023 16:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbjCQQkY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Mar 2023 12:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjCQQkX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Mar 2023 12:40:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F9816AE0
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Mar 2023 09:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D92FB8264D
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Mar 2023 16:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCB8AC433D2;
        Fri, 17 Mar 2023 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679071218;
        bh=eMha2w8ls1pZ+TIxzwUoQabAWO3mkiHHwy7SqBSloKg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=opxphAzda79e+epQcS0A2S/L8auZUelYOht470Q9fCKIsmR8JSMQFnYSsa04lvuih
         oUlyFbMnPfee4MAV1yhfJDnb8ijzfJwJkphn0/kwF859z+ZEyPodlXJ5NdtLCn5EHB
         tZn5MMutN+oMcxaWjp1TGn73Wh8ZA43nwEJxXrGAoW6QqaziFEYR7tC5fTLrJm8/Gs
         3MUF95GHSMgzFvCrxZ/Drc8g1iWZONMX66hVEHE/H5QQuLR/jo+1ZVzyzxbGHOwuSC
         eyg55k15aw6K8wpjwMP0vhtxd7Pa8jIzToRHxBswksZeJGYMfvKGQ5GYosON9CrSFr
         ufQpJou6iPtNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A696EE21EE6;
        Fri, 17 Mar 2023 16:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] transport: add CIG/CIS/PHY properties,
 don't show unset QoS properties
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167907121867.10682.235943421192331669.git-patchwork-notify@kernel.org>
Date:   Fri, 17 Mar 2023 16:40:18 +0000
References: <e856ad3174024bb61113217cb889005a0bf0ad1c.1678918574.git.pav@iki.fi>
In-Reply-To: <e856ad3174024bb61113217cb889005a0bf0ad1c.1678918574.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Mar 2023 22:16:38 +0000 you wrote:
> Add CIG, CIS, and PHY properties to BAP transport.  The other QoS
> properties are there, and these may also be useful to clients, e.g.  to
> manage CIG/CIS allocation as client.
> 
> Hide transport QoS properties when they are not configured.
> ---
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] transport: add CIG/CIS/PHY properties, don't show unset QoS properties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=28422cd23119
  - [BlueZ,v2,2/2] doc: describe new ISO Transport properties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=39260c3cfa05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


