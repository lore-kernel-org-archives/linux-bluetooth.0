Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9E8C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 19:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238415AbiFBTKT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 15:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238389AbiFBTKR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 15:10:17 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A987BB55
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 12:10:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 098F4CE203C
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 19:10:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39A6DC34115;
        Thu,  2 Jun 2022 19:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654197013;
        bh=pKkqpDel49PMigjfqB2Rpwe/SvI13HPBMHZ3qvV0N8g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Dkn6NMxtdD0OIu3hXohWjIG7Pg1o3fgNt+SbLprtO454xljRfaZXEwVvp7Cwf5JUj
         4ZjmTgBh2Cx6ROh+WgGA8Nfto42x/lv7xqIiyFUqw7mrKWxKyo5Um1bh/fAeQgXJdZ
         vWjR+gF4Z171DYeFZw4OnOpCmnyx16AGTl8VF4NJp4gKgUf5kTLDFBYmm8Z9jkdayB
         9cKZ04v57hYbyLGZFzIJm3B+qbwkqTXyYNpGWd5UM3T+iptQ1jWUBRmzlJ43XbgMMX
         c6K45IJOe0DFYJmEpqVCssoVIswbu0Y3ilKaJf3ca+9n7ppe479DvZhwtz4LdGwxzl
         nHuYfGWV+zhzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17D61F0394E;
        Thu,  2 Jun 2022 19:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] test-runner: Enable BT_HCIUART and BT_HCIUART_H4
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165419701309.15914.6639612939399472906.git-patchwork-notify@kernel.org>
Date:   Thu, 02 Jun 2022 19:10:13 +0000
References: <20220601212255.1356507-1-luiz.dentz@gmail.com>
In-Reply-To: <20220601212255.1356507-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  1 Jun 2022 14:22:55 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> These options are required when running with -u option since that uses
> H4 headers to serialize the communication of host and guest.
> ---
>  doc/test-runner.txt | 2 ++
>  doc/tester.config   | 2 ++
>  2 files changed, 4 insertions(+)

Here is the summary with links:
  - [BlueZ] test-runner: Enable BT_HCIUART and BT_HCIUART_H4
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=67b325c614e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


