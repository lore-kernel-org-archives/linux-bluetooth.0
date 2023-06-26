Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF462EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jun 2023 20:50:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjFZUuY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jun 2023 16:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjFZUuX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jun 2023 16:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C879E
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 13:50:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E561060F18
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 20:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55921C433C8;
        Mon, 26 Jun 2023 20:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687812621;
        bh=v4XtPJc2C4sYxT53UDYfm+OfH19ZJxcWaLXjW4H6xI4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LAJ/VX4vtP0m+fbvR3rlh+dAxms4tCLBPxSufJLIHFkV8KpIuJ0xNwGmCZhTBbEWB
         sJyBfTy+jvjyeNg3A1M14hi4Ycx16FIPU/OyKaIF97tV9OfZZ+FVX3cH6VyC+3pnXs
         /bGxP/UbLr3WnJ2duq5N6dBFEDhp8Ji8LyYEyYDF6S/6ghAGVrTvN9+FNTZijDYsr9
         8yZKaajVqGsh48K27dl83vTriOfziRlOILrThHtDjtk3hVhCiW8dcoqd2x/92SWMX1
         DzNi1PQkGy5gBo2DMHnazVVeARKyQFIy0mC69qIydA0GPwtvA9lyNcB2a1BsD19LOt
         K43ZuQTgdbRpA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 36920C43170;
        Mon, 26 Jun 2023 20:50:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] isotest: Add check after accepting connection
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168781262121.4690.7728708756539603961.git-patchwork-notify@kernel.org>
Date:   Mon, 26 Jun 2023 20:50:21 +0000
References: <20230623074406.16522-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230623074406.16522-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Jun 2023 10:44:05 +0300 you wrote:
> This checks for the POLLERR event on a newly accepted connection,
> to determine if the connection was successful or not.
> 
> This check is related to the kernel update introduced by,
> https://patchwork.kernel.org/project/bluetooth/cover/20230623073842.16466-1-iulia.tanasescu@nxp.com/
> where unsuccessful bis connections are also added to the accept queue
> of a listening socket, to indicate the fact that BIG sync failed.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] isotest: Add check after accepting connection
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b00bc612fab8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


