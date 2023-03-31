Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48EBC76196
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 22:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233353AbjCaWKX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 18:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233183AbjCaWKW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 18:10:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4497A55A3
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 15:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB761B83285
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 22:10:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6F7AEC4339C;
        Fri, 31 Mar 2023 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680300618;
        bh=22POkhdID+EP4LgiXQ0xWVHFwofxspLpBSCmlZkOWnU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=pPgcWMBvF/rfgJpd03Yl2nTuQNbxvEp7vazksRwfbieAAlMhcOj1cdi2ZxTIoWB4f
         tERAUoy3iqWpNS3sfOZusmwOsaBj8uoZPKnNJ2OgRLyjzHMpk7qpypCsIueJ+J8UmN
         sKUPSBdzBp8r+ahUOzJ5NmBRnCU5oW8oXQ530S8eeFxmEVVNi5tHSKlpViF+luIR3C
         Anrw8o8KDUQdIIcK8vlZjO9yoDzBxWbJk1ZrVqa/M1eqVsM8RfNN09EAXuhR+D8g+b
         gmMD2CgIPppSggmgj/TRtQgENoBgnLFvDfIaTmd4e5laO+p4XGtlG8eQqlu673AneH
         yWClVt/x53Hiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D1BDE21EDD;
        Fri, 31 Mar 2023 22:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/1] Bluetooth: Split bt_iso_qos into dedicated structures
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168030061831.9780.17665215762184848731.git-patchwork-notify@kernel.org>
Date:   Fri, 31 Mar 2023 22:10:18 +0000
References: <20230331153801.35290-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230331153801.35290-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 31 Mar 2023 18:38:00 +0300 you wrote:
> This patch adds support for additional ISO broadcast QoS parameters,
> that the user can set before performing broadcast procedures
> using an ISO socket.
> 
> This patch splits the "bt_iso_qos" structure into dedicated
> unicast and broadcast structures, so that ISO sockets
> can be configured with dedicated QoS options depending
> on the type of ISO procedures to run.
> 
> [...]

Here is the summary with links:
  - [v3,1/1] Bluetooth: Split bt_iso_qos into dedicated structures
    https://git.kernel.org/bluetooth/bluetooth-next/c/991aa4a69a47

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


