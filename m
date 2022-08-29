Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 305B5ECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 19:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiH2TuV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 15:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbiH2TuT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 15:50:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B929E61D9F
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 12:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53D2F60A09
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 19:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABDA8C433D6;
        Mon, 29 Aug 2022 19:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661802617;
        bh=TakHLdFhHf2/z45+9B6/gzyXkXFQTTW8V1vdkpIbg6w=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=azIHFlO58IkmQvVOOcjZRDkX3KXDMzaT7phMrlUx4hO4rzMwhe34HfW8IP8/fRo0H
         uHvMJOWFZhXWDt8UU/J3z2RWm4WI5bIz0X2IisqIgEWgr8iOfQ/A8A3MKfBZJtG92M
         ZbNLgFwkcb4MOzytNS498QxqfjSZvTewBP/i//RqoZsrFauWYF/++KSK4xQSh5E9n1
         +GSMMUGF1jXrl27oDJWKvfSrcw9iSHmNNbAreTtBCBIJuB1VEJC1mMadrmrVfhwQbs
         wlByBiYghRNhKbP+MNIshJlJxwsdK9z/IsLr2ovIL2G9QkhUHC7IaIep1Vs7Mhj/aM
         YQB8ExQdcl3hw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 92FC3E924D7;
        Mon, 29 Aug 2022 19:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 00/11] Initial BAP support
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166180261759.15300.16088522841136813877.git-patchwork-notify@kernel.org>
Date:   Mon, 29 Aug 2022 19:50:17 +0000
References: <20220827000540.113414-1-luiz.dentz@gmail.com>
In-Reply-To: <20220827000540.113414-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 26 Aug 2022 17:05:29 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> iThis set add initial support for BAP (Basic Audio Profile) which is
> an essential part of LE Audio responsible for stream control.
> 
> The plugin is considered experimental and depends on ISO socket in order
> to work so the following setting needs to be changed in order to enable it:
> 
> [...]

Here is the summary with links:
  - [v3,01/11] adapter: Add btd_adapter_find_device_by_fd
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=67dfe38b660d
  - [v3,02/11] lib/uuid: Add PACS/ASCS UUIDs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d7b78586afdd
  - [v3,03/11] shared/bap: Add initial code for handling BAP
    (no matching commit)
  - [v3,04/11] profiles: Add initial code for bap plugin
    (no matching commit)
  - [v3,05/11] shared: Add definition for LC3 codec
    (no matching commit)
  - [v3,06/11] media-api: Add SelectProperties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3579cf8bf6a7
  - [v3,07/11] test/simple-endpoint: Add support for LC3 endpoints
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f081ac884591
  - [v3,08/11] client/player: Add support for PACS endpoints
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dc61ec4419eb
  - [v3,09/11] client/player: Use QoS interval on transport.send
    (no matching commit)
  - [v3,10/11] profiles: Allow linked transport to release the fd
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=34e8c20d488f
  - [v3,11/11] profiles: Update transport Links property on state change to QoS
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b843a5c5b4b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


