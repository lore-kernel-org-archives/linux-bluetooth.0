Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E9DC05027
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Feb 2023 22:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjBFWA0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBFWAZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Feb 2023 17:00:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A98010A8C
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Feb 2023 14:00:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C33EBB8162C
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Feb 2023 22:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55AFCC4339B;
        Mon,  6 Feb 2023 22:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675720817;
        bh=T4Y8Br+tYD77OX04//otarMe6GdAakY+syQFMBbXfrM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JLOWTzz7EUttRNuV7Tdxj3uki0q6n3nrCQCPrejaEO+KfEl0c6MB1vkwP+wCRmIki
         xXyK9T9fHVE9QoHEtVIZnepapBR5d/6JpSvUPLvmimCFD7aKPyuGt5TLe0YxBL6V2x
         T9YeFAZEkjec+DB58o3B9eCXA51TYaIf8Oo/a31KF+Lfc+VX918cBwlQASd6odh06H
         ojriBghEN6IZSaiS2k/wsae9K1Eo8+CJi1qmfJORdEWTIIjpFlzV7aZanQjTBD9keL
         11iG+ECu/+KOfsHMzCgkExiqQjpeFZh1JxRBxgaCtgApyqPSorIXZ+nHXPpccN4hpP
         zdL/iiBwn0qvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28CF0E55EFC;
        Mon,  6 Feb 2023 22:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: btintel: Set Per Platform Antenna Gain(PPAG)
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167572081715.28546.15309782433795616620.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Feb 2023 22:00:17 +0000
References: <20230206065144.28322-1-kiran.k@intel.com>
In-Reply-To: <20230206065144.28322-1-kiran.k@intel.com>
To:     Kiran K <kiran.k@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com,
        lokendra.singh@intel.com, chethan.tumkur.narayan@intel.com,
        seema.sreemantha@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  6 Feb 2023 12:21:44 +0530 you wrote:
> From: Seema Sreemantha <seema.sreemantha@intel.com>
> 
> Antenna gain is defined as the antenna’s ability to
> increase the Tx power in a given direction. Intel
> is certifying its products with fixed reference
> antenna peak gain values (3/5dBi). The feature takes
> into account the actual antenna gain, and increases
> output power values, which results in a performance
> improvement.
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: btintel: Set Per Platform Antenna Gain(PPAG)
    https://git.kernel.org/bluetooth/bluetooth-next/c/b8ad6dcdc651

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


