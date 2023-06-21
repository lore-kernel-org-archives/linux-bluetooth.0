Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D404EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 22:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjFUWK2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 18:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjFUWK0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 18:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCF11992
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 15:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9F96616F6
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 22:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3EF3CC433C0;
        Wed, 21 Jun 2023 22:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687385425;
        bh=G80Ah3mi7ldPvbDMFEk3/5SQXtPNdg0blVm+fJEPo+8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=QtjeLDsx0y8D64YC01ptgR/S3wdwDK4nkP09GgoPpg/COweP2mvNTkymqt6LeestZ
         1Fahe1qf/fj7dX4JQfAbgrCU4mqJ6DGSYqT+3JLwJyGuHRjfg0csE6IiZF/KFbO1VD
         Uqfss7VfP9ivvxHfzcKBQUAUFvRG1tkL0IS3U58k/DrQdDvkU4A8RxMj2j/rqhd6f5
         a+jImp8nBI1r9dus/bmI1xRfA35YdvS9LngC6pEA7hlpJJfOCGp7P7PzCO6+s3Ar7e
         IqxTPMQwH1H+3gdUFvpPhByvoAYcAzmnFQEWov9SWt4ZYz26UDZ5L/smESoppUjRjE
         U8LY4U6MlbniQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B6CBC395C7;
        Wed, 21 Jun 2023 22:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] monitor: Fix decoding of HCI CIS Established Event
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168738542517.32529.3318289082815063888.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Jun 2023 22:10:25 +0000
References: <20230621213845.1021997-1-luiz.dentz@gmail.com>
In-Reply-To: <20230621213845.1021997-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 21 Jun 2023 14:38:44 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The ISO Interval is actually using set using 1.25ms slots:
> 
> BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
> page 2304:
> 
> [...]

Here is the summary with links:
  - [v2,1/2] monitor: Fix decoding of HCI CIS Established Event
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=dafec5e4e41e
  - [v2,2/2] btdev: Fix CIS Establish ISO Interval
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2f3479337f14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


