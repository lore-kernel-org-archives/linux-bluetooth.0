Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3CAC74A5B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Mar 2023 16:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjCUQA0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Mar 2023 12:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjCUQAY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Mar 2023 12:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656B31E5E8
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 09:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5B6961CFD
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Mar 2023 16:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14D62C433D2;
        Tue, 21 Mar 2023 16:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679414418;
        bh=GqHDzSN0rnO/UAySVlA9LrYnMHHgprLrgrIyB3yLFIk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WmlzHwvEuBJdTtfGHIX7AiIZd+kOPOt8Wnvlnd7jPtbVGg55UJyBCruWfzh8XU7Ot
         gf3e7elr8E2YatKeDIzLwVfible5f6nfqxvA8Zb3k0NytUANgsRA13tW/Um3Ppm0lU
         QDyn8m0285E7wvHNNsGnAQZ97Rt97S+W5O7jGnBKfhjpm1mz6pEfhubi9r05zVNBlc
         GjiRi92gbLolDHknuSYsix7UYpPb1j0mS5SBb1obd/T8fA918CQPyx6GiW3TDEus5O
         pMKfKV4E3Yc5sZAxowgExtQTKz/t0qqVszj/n0lvm1I+8F49iEebElAKFrENnDA6G6
         o9IQ/3UJ9UPWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E828BE66C97;
        Tue, 21 Mar 2023 16:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] audio/transport: Propagate errors from avrcp_set_volume
 to DBus
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167941441794.2626.8050550544503930436.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Mar 2023 16:00:17 +0000
References: <20230311011202.486271-1-marijn.suijten@somainline.org>
In-Reply-To: <20230311011202.486271-1-marijn.suijten@somainline.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        bartosz@fabianowski.eu
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 11 Mar 2023 02:12:02 +0100 you wrote:
> Any error while setting absolute volume on the peer, or notifying the
> peer of changes was previously going completely unnoticed.  Propagate it
> to the logs and back to the DBus "Volume" property setter so that they
> aren't misled into thinking that the AVRCP command succeeded.
> 
> Note that an error is mostly harmless when the setter of the property is
> an audio sink and the peer the audio source: in this case we're only
> _notifying_ the peer of the change when it has already been applied on
> the sink.
> 
> [...]

Here is the summary with links:
  - [BlueZ] audio/transport: Propagate errors from avrcp_set_volume to DBus
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1de41786c1a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


