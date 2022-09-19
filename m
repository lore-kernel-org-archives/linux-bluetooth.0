Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F7EECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Sep 2022 21:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiISVkS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Sep 2022 17:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiISVkR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Sep 2022 17:40:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DAF3F1ED
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 14:40:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0290461EF5
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 21:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57C0AC433D6;
        Mon, 19 Sep 2022 21:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663623615;
        bh=88OQV4wwfFEQA3CrCB8dNMnEkyAdwMv86oE0fLEgMWM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BbtwUt9k53fFlTtV1R4RfjoLlLuYdxJcJEnMhBsOPJkP+miCi6rWe710OOta0Rbgn
         NuECMwdGv14J9J0km86hpDpDclOsU24q+MPNdm2Jdk9mxzf/CP7Wb5BRKYK/STChG8
         LnHyqMJtSRfLy9CLlsn0TMf8RALqVlbkhvCU6jLnIgullekd1/0Pz1nDXxxfEFUjO/
         uvU1OjA0ehSEeQRuGz3X7nsW5cO1T6+3c8Wt8KpEAXqqsfp7b+LMd9bKmE/N3k9sRp
         GrRimRt64qK8GdLHKOKYM5BqbLQAeL3x0S3XwFqqVUbKPjPfxvmByXKWDq1WSuSWOI
         EnSRQoEqMHA8w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35EDBE52535;
        Mon, 19 Sep 2022 21:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] a2dp: Fix not detecting transport connection collision
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166362361520.14010.9826946078350354290.git-patchwork-notify@kernel.org>
Date:   Mon, 19 Sep 2022 21:40:15 +0000
References: <20220916214235.1120979-1-luiz.dentz@gmail.com>
In-Reply-To: <20220916214235.1120979-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 16 Sep 2022 14:42:35 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> Some headsets appears to attempt to connect back after receiving
> AVDTP_Open which would cause unexpected transitions since setup->io
> and stream->io would not be in sync:
> 
> > ACL Data RX: Handle 70 flags 0x02 dlen 6
>       Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
>       AVDTP: Open (0x06) Response Accept (0x02) type 0x00 label 2 nosp 0
> < ACL Data TX: Handle 70 flags 0x00 dlen 12
>       L2CAP: Connection Request (0x02) ident 6 len 4
>         PSM: 25 (0x0019)
>         Source CID: 67
> > ACL Data RX: Handle 70 flags 0x02 dlen 12
>       L2CAP: Connection Request (0x02) ident 10 len 4
>         PSM: 25 (0x0019)
>         Source CID: 68
> < ACL Data TX: Handle 70 flags 0x00 dlen 16
>       L2CAP: Connection Response (0x03) ident 10 len 8
>         Destination CID: 68
>         Source CID: 68
>         Result: Connection pending (0x0001)
>         Status: Authorization pending (0x0002)
> < ACL Data TX: Handle 70 flags 0x00 dlen 16
>       L2CAP: Connection Response (0x03) ident 10 len 8
>         Destination CID: 68
>         Source CID: 68
>         Result: Connection successful (0x0000)
>         Status: No further information available (0x0000)
> > ACL Data RX: Handle 70 flags 0x02 dlen 16
>       L2CAP: Connection Response (0x03) ident 6 len 8
>         Destination CID: 69
>         Source CID: 67
>         Result: Connection successful (0x0000)
>         Status: No further information available (0x0000)
> 
> [...]

Here is the summary with links:
  - [BlueZ] a2dp: Fix not detecting transport connection collision
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b7023510c929

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


