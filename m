Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A02C5479D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Jan 2023 22:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbjACWX1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Jan 2023 17:23:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbjACWVs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Jan 2023 17:21:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D2B71707D
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jan 2023 14:20:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93080B81133
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jan 2023 22:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BCB7C433F0;
        Tue,  3 Jan 2023 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672784417;
        bh=2F2WHvOUiToSkkgOQu4voRla6TBSyHL8tigm68+Uzng=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AloaWcHuWghWw6XSibJCJEK/5hdgTUXTrphSLpHNJuRRRJ3NOu7Bx14UKDRfjTY9S
         tWQeKwUtJyr7yrMe53LjkFVverOtLP5OOVXhG6ZykLTnidrjCNrkPKmvr5NIVsU87+
         r7RcEUjgU1TQ53JffqOeiXnu4UbhnbhoUwzDJlJ+UOecdAK7dJiwV6YjUEvPyiLr6B
         pSqnSiWi8obHkhpk9C6u2Y5EG04J38qBDMmkMRDmSn+7fUnqICMTYF6Vq6oxq7UfId
         frDGELnFAXLV0yV1gDHEAGl8ySIK4NiQF0Ntks5OhpN5rN0yBDzUYz19+jJjBrSoMg
         uS0yuhJRkMJ9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27D0FC395DF;
        Tue,  3 Jan 2023 22:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/5] shared/crypto: Adds bt_crypto_sih
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167278441716.15653.1206951664014036723.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Jan 2023 22:20:17 +0000
References: <20221222224329.685837-1-luiz.dentz@gmail.com>
In-Reply-To: <20221222224329.685837-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 22 Dec 2022 14:43:25 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds bt_crypto_sih is is used to create a hash as stated on
> CSIS[1] spec:
> 
>   '4.7. Resolvable Set Identifier hash function sih'
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/5] shared/crypto: Adds bt_crypto_sih
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5abd9914a1eb
  - [BlueZ,2/5] test-crypto: Add /crypto/sih test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=09293fd22b3e
  - [BlueZ,3/5] shared/crypto: Adds bt_crypto_sef
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a38b6ca525b3
  - [BlueZ,4/5] test-crypto: Add /crypto/sef test
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=051ccb1e878b
  - [BlueZ,5/5] monitor: Add support for decoding RSI
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7a32f2918035

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


