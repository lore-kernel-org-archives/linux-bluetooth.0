Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C1DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 20:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344465AbiEaUaT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 16:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240755AbiEaUaS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 16:30:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9109859D
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 13:30:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A3894B8116B
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 20:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 64B45C3411C;
        Tue, 31 May 2022 20:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654029015;
        bh=Ez0W7iqIwk8PJBOXvFYYCFBzgM0b2EMI2gy6EiAbIWw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IgQU9Ynk92nWThnxTHVfvrwEcg0yHRFsEJdtxfThHrTURyDilyxHeaHITdz9VVuNs
         Msl+vF8CKPR0G50M0uy2EHihi+oNfM1iu/d1vgORCOHrfSyxRVmlR5jl4KVS9fxabK
         KGgZNGPSTFgF01DbuxOqa1PuIwoixZIwrZfSJ+aRzqDXmJxXsPJCUB/ICHlT8oTDKR
         Qp8EtH4+V/HukOQQVN/B5ZGTeDX+88ISfZ4eFJa/GbgY1Our2U4uhzovpYZNn1Vp2c
         xhz+zqHiYawJi7pGPjMXcqmdEgqqvWnOkB8hfLYYkuH01GATeTVomBufj1jV+AV3aJ
         6oErcWNJbWeKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 47D75F03944;
        Tue, 31 May 2022 20:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bluez 00/13] Fixing memory leak, leaked_handle and use_after
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165402901529.30526.11321598096807902566.git-patchwork-notify@kernel.org>
Date:   Tue, 31 May 2022 20:30:15 +0000
References: <20220531074117.610321-1-gopalkrishna.tiwari@gmail.com>
In-Reply-To: <20220531074117.610321-1-gopalkrishna.tiwari@gmail.com>
To:     Gopal Tiwari <gopalkrishna.tiwari@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        gtiwari@redhat.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 31 May 2022 13:11:04 +0530 you wrote:
> From: Gopal Tiwari <gtiwari@redhat.com>
> 
> Following fixes are reported by coverity tool.
> 
> Gopal Tiwari (13):
>   Fixing memory leak issue in gatt.c
>   Fixing memory leakage in appkey.c
>   Fixing memory leak in jlink.c
>   Fixing memory leak in sixaxis.c
>   Fixing leaked_handle in cltest.c
>   Fixing leaked_handle in create-image.c
>   Fixing leaked_handle in l2cap-tester.c
>   Fixing resource leak in mesh/mesh-db.c
>   Fixing leaked_handle in obex-client-tool.c
>   Fixing use after free in src/device.c
>   Fixing memory leak in pbap.c
>   Fixing possible use_after_free in meshctl.c
>   Fixing use_after_free in prov-db.c
> 
> [...]

Here is the summary with links:
  - [Bluez,V2,01/13] Fixing memory leak issue in gatt.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b4233bca1815
  - [Bluez,V2,02/13] Fixing memory leakage in appkey.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5eb96b3ec854
  - [Bluez,V2,03/13] Fixing memory leak in jlink.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6f02010ce004
  - [Bluez,V2,04/13] Fixing memory leak in sixaxis.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=fc57aa92a4f3
  - [Bluez,V2,05/13] Fixing leaked_handle in cltest.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f4743109f381
  - [Bluez,V2,06/13] Fixing leaked_handle in create-image.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4ae130455b17
  - [Bluez,V2,07/13] Fixing leaked_handle in l2cap-tester.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4334be027ae1
  - [Bluez,V2,08/13] Fixing resource leak in mesh/mesh-db.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=35cbfd966094
  - [Bluez,V2,09/13] Fixing leaked_handle in obex-client-tool.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=39b638526d9a
  - [Bluez,V2,10/13] Fixing use after free in src/device.c
    (no matching commit)
  - [Bluez,V2,11/13] Fixing memory leak in pbap.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=06d3c7429ad6
  - [Bluez,V2,12/13] Fixing possible use_after_free in meshctl.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=56bda20ce9e3
  - [Bluez,V2,13/13] Fixing use_after_free in prov-db.c
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5cdaeaefc350

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


