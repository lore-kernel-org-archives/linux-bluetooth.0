Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57649C001E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 18:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjGaSA1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 14:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjGaSAY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 14:00:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35C910FE
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 11:00:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 428AD6125E
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 18:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7ECCC433C9;
        Mon, 31 Jul 2023 18:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690826421;
        bh=+6M+vt6quI0iGo/FzNo8ZqTsHWS7pePki8YHGCWCrZs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZElMan27lTTe5x7Rc+YZtkUnzJ1aG/chm7qncYeknhVTtiPD8W3IaurHkgIpAKrAQ
         qtqPzceFObh1ggRU/xUuQh68Heq5XmDAUSMLi1u00yDD9V1SjsZMunWlNFoIqqjdcC
         tmT43QE9j9m3T3ffYJL6b8bUlIFwvf8UcSWcwJYkdGosO6MOA5mOhmEt/dH7OHPU+2
         dlsdC9n7ahfHsLH5IeCz36kBzxh1RyIRXyB27w590qKLGU0zHA6utc1CQjIHxOlVWs
         /hncGH16TPplfRBaXndaspyo2l4q+GWhPiepsFRNvOBs+GRBNY67dI35XoAHbC6MC3
         q6SdAIPoISVDg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F4C3E96AD8;
        Mon, 31 Jul 2023 18:00:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/5] Couple of improvements to btmon
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169082642158.19346.15350726406594286173.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Jul 2023 18:00:21 +0000
References: <20230729004552.1422547-1-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <20230729004552.1422547-1-lukasz.rymanowski@codecoup.pl>
To:     =?utf-8?q?=C5=81ukasz_Rymanowski_=3Clukasz=2Erymanowski=40codecoup=2Epl=3E?=@ci.codeaurora.org
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 29 Jul 2023 02:45:47 +0200 you wrote:
> Szymon Czapracki (1):
>   monitor/ll: Add support for connection parameter command.
> 
> Łukasz Rymanowski (4):
>   monitor: Fix decoding Command Complete for Remove ISO Data path
>   monitor: Update le event mask with bits 20-23
>   monitor: Add support to decode le read ISO link quality
>   monitor: Add parsing Service Data of UUID 128
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/5] monitor: Fix decoding Command Complete for Remove ISO Data path
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=86a4015659e3
  - [BlueZ,2/5] monitor: Update le event mask with bits 20-23
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7c6e030ac976
  - [BlueZ,3/5] monitor/ll: Add support for connection parameter command.
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=af3549724b0a
  - [BlueZ,4/5] monitor: Add support to decode le read ISO link quality
    (no matching commit)
  - [BlueZ,5/5] monitor: Add parsing Service Data of UUID 128
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8d60b555e8e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


