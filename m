Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 146D3ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 19:50:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiH2TuW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 15:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiH2TuT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 15:50:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44CA63F0F
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 12:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C5EF60BB7
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 19:50:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B9FD0C433D7;
        Mon, 29 Aug 2022 19:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661802617;
        bh=pqiGdAm2kv3cltmnpYkavgtQgWZ8W3cwzquqtYVWLdk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=BXWkYzLrMeGxX38L4sd34LpvAf5u/oV3PtpkIFdYlJTdBqicOEbIOik1mqK9l8km9
         6aMjP4xCHrTzoCWF4btzBL+k6P0Le9SlWsuzXP5kNUOsOqfR3Le1wQTMbZbfCw2IV/
         zaUdxvrZr+qh5z4WsVCDmTwIhCvqnu1FLnhWATyOdDhKh1CmvKeOI6U49hbJGMy8f5
         TQq5+ekCiindaeTRRZg+Q190KQMqSx9KJEvsz77kfmcJ9jE185EI6pWRBNt/ttgaHH
         x15w0qgyvFue9FWDFA9Ek/gAtAoJ/eHQrkVG+IMCf0vDa5ByjpS0ANRry8mTVg7OuR
         2sBhYMF7Rq8rA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E28FE924DA;
        Mon, 29 Aug 2022 19:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/2] gatt-api: Add error code ReadValue/WriteValue
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166180261764.15300.5386070448671873657.git-patchwork-notify@kernel.org>
Date:   Mon, 29 Aug 2022 19:50:17 +0000
References: <20220825200758.1645136-1-luiz.dentz@gmail.com>
In-Reply-To: <20220825200758.1645136-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 25 Aug 2022 13:07:57 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This allows application to return error codes in the range allowed by
> the spec:
> 
>  'GATT - Section 4.9.5:
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/2] gatt-api: Add error code ReadValue/WriteValue
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ea903d120680
  - [BlueZ,2/2] gatt: Parse error message
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6b8f9fbd5bb8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


