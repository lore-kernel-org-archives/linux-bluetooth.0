Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77449C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Apr 2022 23:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbiDFXcO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Apr 2022 19:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiDFXcN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Apr 2022 19:32:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B737F7F72
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 16:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C3669B825D3
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Apr 2022 23:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71FB0C385A6;
        Wed,  6 Apr 2022 23:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649287813;
        bh=T+1yX1rq3i3y5A42sag22Q8UCubFGzkZS6sCjHc7XeE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jnP/AGnozB/oUvzBxuYDStMP55VMeTqjkAX0qQJilKvzifJ1J1ZFKehckDjtdVHa2
         PhLQj3Rgyaz7CZIkjfUwIb4At6UlSfI1/71mGM+0YbaFBw65EHHfW8r3kQIKy5qO7k
         NdjEeFTMSFhyC9caFFWNI5d3AuuH3VzpPRBI7LsVo0+OJUp83IR1Jqd6xFcaMsiuPW
         YycBVfrtBaPV6wlS3/+FyG4VMYhp5l4ez/Ld53bPaxsadQYCXp2JGxAbykFaV11S3t
         ouGbvu9jMLssNh7r8QNvTxrMKNcYvmlf4Z9o7gra/IS9vIKPWuqswbTE2qZlHpzxHs
         t0rFuACB8m1mg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 51D28E85BCB;
        Wed,  6 Apr 2022 23:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/3] monitor: Add support for LE BIG Info Adverting
 Report
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164928781333.14953.8804045522926383453.git-patchwork-notify@kernel.org>
Date:   Wed, 06 Apr 2022 23:30:13 +0000
References: <20220406213355.1918220-1-luiz.dentz@gmail.com>
In-Reply-To: <20220406213355.1918220-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  6 Apr 2022 14:33:53 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds support for LE BIG Info Advertising Report.
> ---
>  monitor/bt.h     | 17 +++++++++++++++++
>  monitor/packet.c | 23 +++++++++++++++++++++++
>  2 files changed, 40 insertions(+)

Here is the summary with links:
  - [BlueZ,1/3] monitor: Add support for LE BIG Info Adverting Report
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0533085d22ba
  - [BlueZ,2/3] btdev: Add support for sending LE BIG Info Adv Reports
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=10948891336d
  - [BlueZ,3/3] btdev: Fix BIG Create Sync
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d1871fc93522

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


