Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF3FC64EC4
	for <linux-bluetooth@archiver.kernel.org>; Sat,  4 Mar 2023 00:50:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCDAu0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Mar 2023 19:50:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCDAuY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Mar 2023 19:50:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA435FEBD
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Mar 2023 16:50:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDFB7B81A13
        for <linux-bluetooth@vger.kernel.org>; Sat,  4 Mar 2023 00:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B7DBC4339C;
        Sat,  4 Mar 2023 00:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677891020;
        bh=YMKwlk8a5k5kjdRK6kiS0Puqrv8cFSYWQtQ99yTTgCY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UD/oGkB3tgMurmJ4Xj1wonvEJlhhTvOb83BsbZsKvvuuHVRcRfeUipCZXboTjLuy9
         p3nLI1S7rPDAFrFMj7NduzDd98lSNHWN2vog0FULl4T5cbnuQk3Tr7eAwX9hx1hLPa
         sCMv0+Kk3ArptzwfkLmmKIHnbdlcJ992xOkY0LM6ULlnBXeUTPx49inDaEZqHbBnYz
         s0j6iGr1S8oEU2jEXKxLioXqX6jQGqAiCpVrPQ1+IFZ2eQOWwxBiz5NFDbxi6G4Tzm
         nbUqOH1gcOhtbFIEHAR6/8VfKpAQfIOVdIQjOL0+6ME8wb0t10MPRuTABaM1IeyHTV
         EE41GLWfk2KCA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4EFD2C04E32;
        Sat,  4 Mar 2023 00:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] Bluetooth: btintel: Iterate only bluetooth device ACPI
 entries
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167789102032.19976.1148547526699639040.git-patchwork-notify@kernel.org>
Date:   Sat, 04 Mar 2023 00:50:20 +0000
References: <20230228110154.18936-1-kiran.k@intel.com>
In-Reply-To: <20230228110154.18936-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        chethan.tumkur.narayan@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 28 Feb 2023 16:31:54 +0530 you wrote:
> Current flow interates over entire ACPI table entries looking for
> Bluetooth Per Platform Antenna Gain(PPAG) entry. This patch iterates
> over ACPI entries relvant to Bluetooth device only.
> 
> Fixes: c585a92b2f9c ("Bluetooth: btintel: Set Per Platform Antenna Gain(PPAG)")
> Signed-off-by: Kiran K <kiran.k@intel.com>
> 
> [...]

Here is the summary with links:
  - [v1] Bluetooth: btintel: Iterate only bluetooth device ACPI entries
    https://git.kernel.org/bluetooth/bluetooth-next/c/ee9b749cb9ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


