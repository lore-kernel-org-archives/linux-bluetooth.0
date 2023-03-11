Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210C0C6FD19
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 00:41:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjCKAlg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 19:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjCKAlH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 19:41:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353AB139072
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 16:40:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 303BCB82473
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Mar 2023 00:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCA71C4339C;
        Sat, 11 Mar 2023 00:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678495220;
        bh=9POsjiQfg3M3sEKMv2PJWbmr4dbQHjFLZs31jyFHjOs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=stdaCtdFdpgINmExiyZWV7z+cINBEZ7QvaHix5iwPcHY1moT3borWt0XlqbfDW3pK
         5ZKyya3GAWMXJNmB8pitF89yTOlUONHwi4QBDq5O2rKzrMArC9yK8EcTQJ7flLjgIZ
         OUMovENnjCa/TPype7X/fMvhjX/MMKLsl37TmiGXgkurE6K8isES5RVRf/IToihKsQ
         BqYu6JFySTxkVAHgQY5Tl55F6C1mmAQimoAjQXgXRpkJ0KQblaPiZvhXpPeHf7hAfZ
         HZ/sovg08Qy3nRdsHZxxemu41OyUbyDVpwR2BX+in+Poju06ys0fwfHqTFGa7Kj3LI
         dYxkUf4p+7VWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE3E4E21EEA;
        Sat, 11 Mar 2023 00:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RFC v2 01/12] shared/crypto: Add bt_crypto_sirk
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167849522070.21816.4954897604805294201.git-patchwork-notify@kernel.org>
Date:   Sat, 11 Mar 2023 00:40:20 +0000
References: <20230307222422.2608483-1-luiz.dentz@gmail.com>
In-Reply-To: <20230307222422.2608483-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  7 Mar 2023 14:24:11 -0800 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds bt_crypto_sirk which attempts to generate a unique SIRK using
> the following steps:
> 
>  - Generate a hash (k) using the str as input
>  - Generate a hash (sirk) using vendor, product, version and source as input
>  - Encrypt sirk using k as LTK with sef function.
> 
> [...]

Here is the summary with links:
  - [RFC,v2,01/12] shared/crypto: Add bt_crypto_sirk
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c1dd94cc7f81
  - [RFC,v2,02/12] shared/ad: Add RSI data type
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c2e99aefd337
  - [RFC,v2,03/12] doc: Add set-api
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6477522e92e3
  - [RFC,v2,04/12] device-api: Add Set property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5bac4cddb191
  - [RFC,v2,05/12] core: Add initial implementation of DeviceSet interface
    (no matching commit)
  - [RFC,v2,06/12] core: Check if device has RSI
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f95ffcc8b1fe
  - [RFC,v2,07/12] main.conf: Add CSIP profile configurable options
    (no matching commit)
  - [RFC,v2,08/12] shared/csip: Add initial code for handling CSIP
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d297a03b7a61
  - [RFC,v2,09/12] profiles: Add initial code for csip plugin
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9e1eb0a62b3f
  - [RFC,v2,10/12] tools: Add support to generate RSI using SIRK
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c446a64d461b
  - [RFC,v2,11/12] client: Add support for DeviceSet proxy
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=373bafc34ce6
  - [RFC,v2,12/12] client: Use AdvertisingFlags when available
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=815f779aa8e4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


