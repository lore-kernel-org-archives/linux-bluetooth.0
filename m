Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FAFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Apr 2022 23:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbiDYXDX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Apr 2022 19:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbiDYXDU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Apr 2022 19:03:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30B93B572
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 16:00:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 636EEB81B6B
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Apr 2022 23:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2FFFFC385A7;
        Mon, 25 Apr 2022 23:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650927613;
        bh=n9FCq77CZeGSjXnSPiImQMXUTXd8svJV2vatHMDIhM4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Pxf80oV5UdxohXNTbeOnoi298E1QQNDjphA6kaNxH2YphqlWdmMVnme/+ydcgSpAS
         zdEN/ECL9P1uIBWrUDNNFhlhtLFWs1VZQL39A8yZ8nh0OhNwTTMm0dFeZJV/VR1mm4
         hCN15kSnDYEf7kL1g22MyQG4Bt0PpTB7jcN1Xej7Zlt3QsYCOj244Ut8eXCFihE8i2
         mdS1AmZOJg5tC0fB/nCwW+UHjTXnfZ9rAbrKv03GejurwfCaYprR6cI3uLY2sBVzoh
         pCn0QSrjsfmp0OC0DPVTdyhC8wuTHmPFxf87N5woQVBpLEg0x+xvcqvB0v0NwUg/pa
         NUvRkgOPyJvpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12B9DE6D402;
        Mon, 25 Apr 2022 23:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] client/player: Add transport.volume command
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165092761306.17476.554529284216128964.git-patchwork-notify@kernel.org>
Date:   Mon, 25 Apr 2022 23:00:13 +0000
References: <20220422230238.3836087-1-luiz.dentz@gmail.com>
In-Reply-To: <20220422230238.3836087-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 22 Apr 2022 16:02:38 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds transport.volume command:
> 
> Get/Set transport volume
> Usage:
> 	 volume <transport> [value]
> 
> [...]

Here is the summary with links:
  - [BlueZ] client/player: Add transport.volume command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dd5b66695c2b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


