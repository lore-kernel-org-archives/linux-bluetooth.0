Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C89C64ED9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Feb 2023 21:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjB0Vk3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Feb 2023 16:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbjB0VkY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Feb 2023 16:40:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F0A1E1EF
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 13:40:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74CCCB80DC6
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 21:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F05EC4339B;
        Mon, 27 Feb 2023 21:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677534018;
        bh=0TUczbcJ7mXALq2Sr1g4sviP6NvVoElZ2pxOL5Jbkzs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ByITMJdTlOY9/+RAF7//s8P3WWNuDWORh0eND353Bpf8GilYSMCDc2anWRD2qfAwu
         MWZ/rQ274EeASwE8T7TCHgGgAeh4K7JLenPijqVNbvK/6dmfhWcLD3mQ5Ls+9izWkz
         ArUFKNCMgTg4uFbKmTM/FAyEx+RLOV9atA0xEJqscL1/TxZ1yp/S3MxTFnsXdE+kD0
         ONACrn4yDJLzryql65lKpCx0KbJTFmmoGeW5N8nXj7cz3HrCmFJnglOHwsb2sqcWa3
         pwAvIqMUvwPqDSf+8C7rBdpvBpHZLnTJASz0eQAvg/7E/c538TqHb/xC3OTLdblt1D
         wl+RVl7vXWrpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B953E1CF31;
        Mon, 27 Feb 2023 21:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] bthost: Allow sending ISO packets with sequence
 number and timestamp
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167753401817.12319.155272368674120365.git-patchwork-notify@kernel.org>
Date:   Mon, 27 Feb 2023 21:40:18 +0000
References: <b071b484b1b199ad69412ca0b2610c9c75fe7181.1677361002.git.pav@iki.fi>
In-Reply-To: <b071b484b1b199ad69412ca0b2610c9c75fe7181.1677361002.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 25 Feb 2023 21:42:50 +0000 you wrote:
> Change bthost_send_iso to take packet sequence number and timestamp, and
> allow it to send timestamped HCI ISO data packets.
> 
> Currently, btdev passes through ISO packets, so this can also be used to
> test RX timestamping.
> ---
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] bthost: Allow sending ISO packets with sequence number and timestamp
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=80a45cb6a240
  - [BlueZ,2/2] iso-tester: Add test for central receiving timestamped ISO packet
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2be849c2398b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


