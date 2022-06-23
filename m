Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2206DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jun 2022 23:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiFWXaS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jun 2022 19:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiFWXaR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jun 2022 19:30:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A824CD42
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jun 2022 16:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56E39B825BB
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jun 2022 23:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 173C1C341C0;
        Thu, 23 Jun 2022 23:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656027014;
        bh=/P4ehAti11iHSbZIwtsHL6sfoUcXCCyAsM4eK2DqsbI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EE3JpRNPMN4gMGuBlb5IHm+7Xmw/7rbaEZEFQe2vysGtMHSkyow/+IlybccZNZqfy
         3getkGXBTXeRSFxAKza7bzWwcjYktCyanhc3LLez2auHOp5iABom6WiLuTWnE+SMhW
         uHkq7CT/d4k81lf4TLUKLbqsJHzMrT9IM6eX01tBlV7gE8PRG9DvKP0QAYoxfGXxg/
         lTUOLJNmGzDoFtdhbgH2XlzP2G8R/KfXdtO3FmThsWMjlzBcw9w2teMhUgaD3FbHbR
         eXWLiZW1AlJxtDjktqzLN87WAjsNuLLdmaQsYLhWMHLqoYbTvLvpPd7QzAy+bUjBN5
         7i91U0QwIh8Dw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA9E4E737F0;
        Thu, 23 Jun 2022 23:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH] mgmt-tester: Fix null dereference issue reported by
 scan-build
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165602701395.3875.3030928518602402235.git-patchwork-notify@kernel.org>
Date:   Thu, 23 Jun 2022 23:30:13 +0000
References: <20220623044520.458626-1-hj.tedd.an@gmail.com>
In-Reply-To: <20220623044520.458626-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 22 Jun 2022 21:45:20 -0700 you wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> This patch fixes the null dereference reported by the scan-build.
> 
> tools/mgmt-tester.c:12025:28: warning: Access to field 'cap_len' results
> in a dereference of a null pointer (loaded from variable 'rp')
> [core.NullDereference]
> 
> [...]

Here is the summary with links:
  - [BlueZ] mgmt-tester: Fix null dereference issue reported by scan-build
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e3c92f1f786f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


