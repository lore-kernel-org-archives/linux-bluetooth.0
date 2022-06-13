Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F73C43334
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Jun 2022 19:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiFMTmN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Jun 2022 15:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244004AbiFMTlq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Jun 2022 15:41:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729435F5D
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 11:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0C8E2611DD
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Jun 2022 18:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69ABFC36AFE;
        Mon, 13 Jun 2022 18:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655143815;
        bh=GAhS2qTs4aapVT5A+l7TuNo2Qv5ZHXFvEtfCa6sKiA8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aXd6cAlEjFS3J1sjcYHmarCzIcC4d8kgY/vUontTZbF8Xws+Y29KDItEkV0lerdSi
         uiNcapGPUlYHBL7psWJLtUgjd5Ne/jY4MWQcBm3Sc/FZACXWzopIcCJ17a3RerNB3z
         hX8+1Ng2+ZLnz5DD7Ihf3JmnW8ymHUrj8KFNwx+Li62szNcQ6x0UVaieGfq4pwjUhy
         YlrvtIQ5vrQrz51dwY6Mho62DHK2nKPyDId75Z4McpM3CPhZP7totV1FTcaVyKrit0
         EAX5Z/bjQADnVdq86uKbqmjPR9cbKTj0A6XtoMFj7tIAXkzzY2WHc8wrHnaUH1itjc
         7NW5m2/qK6z6w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 50C51E73856;
        Mon, 13 Jun 2022 18:10:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] btproxy: Allow to select multiple BT controllers
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165514381532.24573.7226158085847945884.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Jun 2022 18:10:15 +0000
References: <20220603145447.45655-1-frederic.danis@collabora.com>
In-Reply-To: <20220603145447.45655-1-frederic.danis@collabora.com>
To:     =?utf-8?b?RnLDqWTDqXJpYyBEYW5pcyA8ZnJlZGVyaWMuZGFuaXNAY29sbGFib3JhLmNvbT4=?=@ci.codeaurora.org
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  3 Jun 2022 16:54:47 +0200 you wrote:
> When running on a computer with a real Bluetooth controller (e.g. hci0) and
> multiple emulators (e.g. hci1 and hci2) it isn't possible to use the
> emulators with 2 test-runner vms.
> If btproxy is started without index parameter the first test-runner will
> use hci0, and btprox can't be started with multiple index parameters
> (e.g. -i1 -i2).
> 
> [...]

Here is the summary with links:
  - [v3] btproxy: Allow to select multiple BT controllers
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6e2066fdab73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


