Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B45A7C7EE24
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 23:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjE3XUY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 19:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjE3XUX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 19:20:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40828AA
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 16:20:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B72C761788
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 23:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D3B8C4339B;
        Tue, 30 May 2023 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685488821;
        bh=C6qzQZaBJQR9oR3iAure+3Ux30GYK6nBG4Dus/kx1OQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oNcyNAwBn6QODFIDp4EF7SFe+2EQ481Px8QTmsi7mX9dOOwDM377NO3sEPjFj6Iys
         qsG2rSOKrjhXNQe2JCceIe05YE8AGndkdmfRCMJIotlFpocCgDWu43thGPUDtt19CT
         29Oj6O2sQhrp9efnDE9wbwDUN37Xvgcw+whRbaiV8BsJ9a6OO6GDM6uXtuhtN1sx6D
         Ljw/MmuCXGxu7RDZi9pFDv95f/XmDI10/KhxkHHOovw5v6IHOoVWWPwlLAgy6EmJqN
         hfI6d1xCdYDrdhPbNoktZETgzNhtsjb7VeDdl9BuJJyUEY3wxyZuT3bXdwRL/yrC+a
         sJE3PAHZgIO8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02164E52C03;
        Tue, 30 May 2023 23:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/2] unit: Introduce test-bass
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168548882100.30926.3281725432375835978.git-patchwork-notify@kernel.org>
Date:   Tue, 30 May 2023 23:20:21 +0000
References: <20230529084650.72126-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230529084650.72126-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 29 May 2023 11:46:48 +0300 you wrote:
> This adds 3 unit tests for BASS server, to simulate the
> Generic GATT Integrated Test suite for BASS.
> 
> This patch also adds the Write Without Response
> property to the Broadcast Audio Scan Control Point
> characteristic, which is mandatory according to BASS
> specification.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] shared/bass: Add Write Without Response property to the CP characteristic
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c39317ed42cb
  - [BlueZ,2/2] unit: Introduce test-bass
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1248bdd43291

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


