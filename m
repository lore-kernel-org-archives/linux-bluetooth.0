Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61783EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Jun 2023 20:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjFZUmh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Jun 2023 16:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjFZUmb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Jun 2023 16:42:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E6CE54
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 13:42:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2543D60F6E
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jun 2023 20:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7F06EC433CA;
        Mon, 26 Jun 2023 20:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687812134;
        bh=ROY2C+vz6Aza/XLavVEep12p6uoYd6K0rQaYl+KRAxQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bOE50HEp7HYCw+JWHnVb82mchktNe3p7/jL6f1rj7wJNvVTztdlPYdOUl09jMv8PN
         7b/r/P38hQ1R1dyo7WGjRF6emmxdPAuSM9U2BP7nJJ7JQlbFDuc+7bF79pBiRuqBop
         opzi4PV9+G3OLsjhA4ZbEQDNtCZTciVncDwHbjnN+pONmc6gaTRhZt3jgwdDjZg5/H
         0c3oEIlcCFcMTVtFl0qpDC3z8RFI6AMV2umVHw4QV8Vy5tou00EASdIubX5sbknUsi
         0Q1iRW6ejbwJpHT/xPjVwAMdPfZxocg2qCrxskQOaPRkKVbx29BaTfoF++qSI/+HKx
         xTMQv+VhMBaOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5FE76E537FE;
        Mon, 26 Jun 2023 20:42:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] Bluetooth: hci_event: Fix parsing of CIS Established Event
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168781213438.29844.9936704307447731174.git-patchwork-notify@kernel.org>
Date:   Mon, 26 Jun 2023 20:42:14 +0000
References: <20230623212439.1702413-1-luiz.dentz@gmail.com>
In-Reply-To: <20230623212439.1702413-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 23 Jun 2023 14:24:39 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The ISO Interval on CIS Established Event uses 1.25 ms slots:
> 
>     BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
>     page 2304:
> 
> [...]

Here is the summary with links:
  - [v5] Bluetooth: hci_event: Fix parsing of CIS Established Event
    https://git.kernel.org/bluetooth/bluetooth-next/c/5f68122ac282

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


