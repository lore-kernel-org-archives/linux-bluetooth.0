Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BF1C05027
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Feb 2023 21:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjBAVuU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Feb 2023 16:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBAVuT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Feb 2023 16:50:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50F24C1E
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 13:50:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66EBD61943
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Feb 2023 21:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1DF3C4339B;
        Wed,  1 Feb 2023 21:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675288217;
        bh=/Y17dBtl86sOLIUHjPDvJqXl4mOZuwQ7sccPPG73xB8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XOGWw3JfhRBl4HNfqYI8VVPRKyomor6XPM6w/fqP2DQE07wvuHKtHSK0/vBKDF3ih
         BnGBzztoMRvdVGlRijqxdnhAOBvDPwXk4m35GVDJY323u1zEBm+FS7sanPWVQvBDO/
         Zzx29dkzlDL8TLy1VhaTNqUDk1OEyr5TMsm0gjvSR5KJhh9yhwz//vulx8LKlG/k18
         vavDCyaHBmVxuHYFj1V8Mm53MJcTh5S/pxSfdAy7ShS9LQrON1JeDRd7FHIWek3kdC
         XL3iGbC+IHTS8Qa5Oz9VF+2a42j2teI9g/xCMoxM4nARX5j9vLPI/hbg0obYSIf6sD
         PIkEbP+Md2vIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9CAA1C4314C;
        Wed,  1 Feb 2023 21:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] media: set default value for BAP endpoint Vendor
 field
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167528821763.11549.17598566933811555145.git-patchwork-notify@kernel.org>
Date:   Wed, 01 Feb 2023 21:50:17 +0000
References: <26d36cc8d645773b6795a18355631134bf2bd074.1675281104.git.pav@iki.fi>
In-Reply-To: <26d36cc8d645773b6795a18355631134bf2bd074.1675281104.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 Feb 2023 19:51:47 +0000 you wrote:
> The "Vendor" field is optional, and should have an initialized valid
> default value.
> 
> It has the default values in register_endpoint, but not in
> app_register_endpoint, so make the latter match the former.
> ---
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] media: set default value for BAP endpoint Vendor field
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=67395a3b357d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


