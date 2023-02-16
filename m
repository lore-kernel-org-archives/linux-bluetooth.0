Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA41C636CC
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Feb 2023 00:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjBPAvL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Feb 2023 19:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBPAvK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Feb 2023 19:51:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356C32A6C8
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Feb 2023 16:51:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EAE82B82432
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Feb 2023 00:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ABBCCC433EF;
        Thu, 16 Feb 2023 00:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676508666;
        bh=UGCKSUaJ5GkGLw7l1j5lsJG8OYi44TQJHHmbZx7Oj+k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=S2zDwHcZdHs4jo+IwwzisX34sHBRJslxOKBSQuMp/CHQTsZ0NbA0lJItGZx/D6Uv/
         rHm6EMUJTVKNVbnItNJ1WVz80Y5QtP8akidriucc999AyYS7C92/x0/9KEkhNnbA31
         ifjgOC2VRDNkcTBosUXCPGeVkeog9Ts85ex2/hnb86GGbvwzxQqNmFPT1BQlckqwEf
         vejgMD5zVH+V4bxxXVxBS/JDCOr+9Zwxa69CemOljPeJu3RnxKUhVF9YVQ1nHIKwK+
         mdEb3F0lz8DfCG3hsuAObz1/Pb4GOr6Tw0L3tQsuq1LHDg6D1nfI+jxcDj02F5Wyuv
         L10CaJ2TsaVyg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 944FAC4166F;
        Thu, 16 Feb 2023 00:51:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/3] audio/transport: add media_transport_get_stream
 method for transports
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167650866660.21680.8123172316646752195.git-patchwork-notify@kernel.org>
Date:   Thu, 16 Feb 2023 00:51:06 +0000
References: <f973ae1e4b2c07902f98a6e7776b44bef25670be.1676499415.git.pav@iki.fi>
In-Reply-To: <f973ae1e4b2c07902f98a6e7776b44bef25670be.1676499415.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 15 Feb 2023 22:26:00 +0000 you wrote:
> Add a method for getting the audio stream associated with a media
> transport.
> ---
> 
> Notes:
>     v2: make generic and split out to separate patch
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/3] audio/transport: add media_transport_get_stream method for transports
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f7d0599afe9b
  - [BlueZ,v2,2/3] media: look up BAP transports by their associated stream
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e9163b09a3df
  - [BlueZ,v2,3/3] media: fix ASAN crash in pac_config_cb
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5d347b54714e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


