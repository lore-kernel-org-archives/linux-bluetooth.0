Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3E8ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 23:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiHaXK0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiHaXKX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 19:10:23 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55305F233
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 16:10:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DB2C8CE23BB
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 23:10:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B829C433C1;
        Wed, 31 Aug 2022 23:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661987416;
        bh=fWYBxWCpwUiyq/G5tc3NPHP3fP9pA5EbNRlgkLaj1/0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NYja+RDAK4/gnWiX9F1cP65DJFtCuTEPphXmtGjpukQhZ7OLp1rCQaUZTOCeLsp/+
         yRlp1551viE7mOZaYX9/jb8Oei1+PWNPtGyMMIh0rzGQdkn2KKiJsFjWDzMKWIZIN8
         5qXkizc9XlJOxm1olrmdw+dJQja7MbOgOM8N7d8L+4xH0NZAvB2B2gNb1FBXrktIXk
         NNjA5Go/TPjrfcSPMZpIcWEWWG81zUriK9jRxC+5JO5sxSl9gIypFBNsKT+MOdCJKT
         hrwNUl/DGU/QbE2e7Z+x9Ri90S/lyF+v/GntM1juJUEOpDxYuSNdkhjBvgiBWVYkeA
         GstWAprwN1x0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 59C40E924DA;
        Wed, 31 Aug 2022 23:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] New BT devices from the Realtek rtw89 family
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166198741636.19908.7617765130882172394.git-patchwork-notify@kernel.org>
Date:   Wed, 31 Aug 2022 23:10:16 +0000
References: <20220816213523.5207-1-Larry.Finger@lwfinger.net>
In-Reply-To: <20220816213523.5207-1-Larry.Finger@lwfinger.net>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 16 Aug 2022 16:35:21 -0500 you wrote:
> One new BT device for the RTW8852AE and two new devices for the RTW8852BE
> have been reported through GitHub repos that I maintain to help users
> with new devices get wifi and Bluetooth as soon as possible.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> 
> 
> [...]

Here is the summary with links:
  - [1/2] Bluetooth: btusb: Add BT device 0cb8:c549 from RTW8852AE to tables
    https://git.kernel.org/bluetooth/bluetooth-next/c/a0476f6a2cac
  - [2/2] Bluetooth: btusb: Add BT devices 0bda:4853 and 0bda:887b from RTW8852BE to tables
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


