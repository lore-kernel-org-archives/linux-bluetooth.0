Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2639C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 01:20:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJDBUU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Oct 2022 21:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJDBUT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Oct 2022 21:20:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE4617895
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 18:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A46260277
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Oct 2022 01:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B8D02C433D6;
        Tue,  4 Oct 2022 01:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664846415;
        bh=/0DbmjNwN1L8wtaAFn/sfpn6Ba6d5Hi2C15vlkgcYEc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kTJuIZAvZMj75dZVkyqPr5ANelwhBrGlAktSXCVfgsfFbZups+TNjuRzwR7GgifzH
         mkyIXJDdmy1/YdN8f1EhGPQ/ocAVB/BHPr/oDsB6RWFLFIh3/p3Hq8WT7SGJ8HokX3
         K2u09lb5rBSDFO1Gq9RuwoJIuG9YruCDjn9sLt3DuUrn7iNybn1kcLYENepRntAV6e
         w9axhMcHjAExMhmPDYOZsN9JoAPFO7JGZq+OdK8umcHKdXDZ/fGfMr/e/8JT0TEUgR
         w7UtfwNcdNF8jeX5SWaRUg/cyjY5teujW+8hZ2Yv5aeJpq4gKMihlP96dmX1c1U2HM
         Aux1mHioZ+SaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F4FBE4D013;
        Tue,  4 Oct 2022 01:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] build: Deprecate meshctl tool
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166484641564.16258.3598243273326956573.git-patchwork-notify@kernel.org>
Date:   Tue, 04 Oct 2022 01:20:15 +0000
References: <20221003230642.164327-1-inga.stotland@intel.com>
In-Reply-To: <20221003230642.164327-1-inga.stotland@intel.com>
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.von.dentz@intel.com,
        brian.gix@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  3 Oct 2022 16:06:42 -0700 you wrote:
> This marks meshctl tool as deprecated since it is not longer
> maintained.
> ---
>  Makefile.tools | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [BlueZ] build: Deprecate meshctl tool
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1f6553edd8a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


