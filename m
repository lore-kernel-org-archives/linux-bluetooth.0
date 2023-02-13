Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F114BC636CC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Feb 2023 22:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjBMWUW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Feb 2023 17:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMWUV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Feb 2023 17:20:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2321ADC9
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 14:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D0377B8197A
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 22:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 773B8C4339C;
        Mon, 13 Feb 2023 22:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676326817;
        bh=Z6lBysXr0P9w5fL2EFZ9c5L87XriCzEuhbNMlteE5+Y=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=s1qHclO8yA4LExN48wvQOwOFbzxTef3nr0ZqVYXeLrSvnIdBV0FLClszgbgUahf4/
         bWRp+kTRlJ9K+E1jbMAPgoS2p2+P5uUIqn+uM8sml0l042aZnpgYgtEgbYNoS+BuYn
         MlF7yfMRzawpVuWA6F3cif/PP593SG57C2Qp4U8pE4UXNAnWr1wy1Bha8zANFH9eLj
         KgdAVLjAAafM6/SYjAjyyt+GRRxu7NWZUs7UjcnGIIVE1zygwm4OYfZ3R/pU0cJEoM
         MrdLOMMbzqxQmwDy07ABU5Wx0O5P4ZHsEQgvNR1dDzZzTwF7QjVIfDcZREATtdMNKC
         jpyxNyVrIO42g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53701C41676;
        Mon, 13 Feb 2023 22:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/8] doc: add MGMT setting for CIS features,
 remove Quality Report
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167632681733.28787.4286157502141715950.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Feb 2023 22:20:17 +0000
References: <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
In-Reply-To: <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 30 Jan 2023 20:37:32 +0200 you wrote:
> Add definitions for new MGMT Controller Information settings bits,
> indicating adapter Connected Isochronous Stream - Central/Peripheral
> feature support.
> 
> The Set Quality Report command was removed in
> commit 0454e2d09570 ("mgmt: Add support for Mesh in the kernel"),
> but the settings bit was not removed. It's also not implemented on
> kernel side, so remove it now.
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/8] doc: add MGMT setting for CIS features, remove Quality Report
    (no matching commit)
  - [BlueZ,2/8] lib: Add defines for MGMT setting bits for CIS feature support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c35d32b19989
  - [BlueZ,3/8] monitor: add names for MGMT setting bits for CIS feature support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0f2f7a8fe270
  - [BlueZ,4/8] tools/btmgmt: add names for MGMT setting bits for CIS feature support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6f131929b832
  - [BlueZ,5/8] adapter: add functions indicating adapter CIS capability
    (no matching commit)
  - [BlueZ,6/8] media: Check adapter CIS support to add BAP in SupportedUUIDs
    (no matching commit)
  - [BlueZ,7/8] shared/bap: handle central-only case
    (no matching commit)
  - [BlueZ,8/8] bap: handle adapters that are not CIS Central / Peripheral capable
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


