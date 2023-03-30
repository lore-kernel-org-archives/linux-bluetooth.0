Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98B9C77B60
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Mar 2023 18:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbjC3SK2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbjC3SK0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Mar 2023 14:10:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5CFEB77
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 11:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D695462161
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Mar 2023 18:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49BC3C4339B;
        Thu, 30 Mar 2023 18:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680199825;
        bh=lGYMcYmnmw6ho7OKIGTw5z93TW70uWjVjvUDp6BSg3s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=dyDSUK7PTFovSX7tN+Z0Gl3yH0nbtNXgKIDvo56pz9Mu+BltfPkEEsXs9LefWa9VV
         Rmxla13Q2eEyEvkLIRA6RJaNkEv96vZdg+5tub1C/PXWdkFSTowXFGaztTv9Saj0j2
         e6aSoTnbyeQDCVwoeuhUirGWjxk5Zn2ucqpBEyaAMlN5J8aVhirMT+iLznLjGjxdA9
         4td97JM7wryqJDj1ZFIhpKBPomC27ZrIlnhIU4i6ybvaOJYDeBPu7CatRM57WwaWr3
         umLApIQqmrhwjGpyYXYMaXOC1x1ZWP4CCAWsp0aBUw9/MAZ5MMIek+r7oG3UiRGmHa
         uzzMXcx+DaA3w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A4ADC41612;
        Thu, 30 Mar 2023 18:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] bap: Mark devices to auto-connect
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168019982516.20045.67274806063965464.git-patchwork-notify@kernel.org>
Date:   Thu, 30 Mar 2023 18:10:25 +0000
References: <20230329232537.577958-1-luiz.dentz@gmail.com>
In-Reply-To: <20230329232537.577958-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 29 Mar 2023 16:25:36 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This makes devices with BAP support to auto-connect once they start
> advertising.
> ---
>  profiles/audio/bap.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [v2,1/2] bap: Mark devices to auto-connect
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ca07d198f9c7
  - [v2,2/2] device: Fix not setting initiator flag when auto-connecting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2b022fa5297a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


