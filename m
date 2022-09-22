Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E02DECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 01:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiIVBKe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 21:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiIVBK1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 21:10:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E903205B
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 18:10:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79EE8B8338E
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 01:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3696DC4347C;
        Thu, 22 Sep 2022 01:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663809022;
        bh=AYWsteXjGl4fp7Snp/W4S47eq6EA5zfeIxlQs/ahUaE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=o8aiTXuakR/1rSlpxDo2GBLMqd/Cs/+CBkY7nG6AaP8LXauZxnJXO40rF6yl6deSY
         FjMkHEAZDH19lnCVcrcFR5LMEBiX7ZUAdqFuPJlu5kgU60uei6gJA79E9E6iU4kbg8
         gIN0nKIROTfbLq6M8eh2REWXXxUbKkdYK5ZvPsFoXniQVA4sms5wlD5zBPo33D5/aM
         O/nrV1x5LOnylCPM64VJR2p97gFG5+6lm3XFq1NXad2YfifznGFuNpLyOAsKPWiU4d
         Fo+cBifqCYeasPriK8+QkA0dcDDycSGd23b4NRNzR/qXxRFXnGf+GbGSwJgNCdIynV
         Y3SItg5lbIKCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C475E21ECF;
        Thu, 22 Sep 2022 01:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH v2] tools/ioctl-tester - Add ioctl-tester
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166380902210.22214.8719483951038733963.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Sep 2022 01:10:22 +0000
References: <20220921192826.102801-1-hj.tedd.an@gmail.com>
In-Reply-To: <20220921192826.102801-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 21 Sep 2022 12:28:26 -0700 you wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> This patch adds ioctl-tester which tests the IOCTL commands.
> 
> HCI Down
> Device List
> Device List - Invalid Param 1
> Device Info
> Reset Stat
> Set Link Mode - ACCEPT
> Set Link Mode - MASTER
> Set Pkt Type - DM
> Set Pkt Type - DH
> Set Pkt Type - HV
> Set Pkt Type - 2-DH
> Set Pkt Type - 2-DH
> Set Pkt Type - ALL
> Set ACL MTU - 1
> Set ACL MTU - 2
> Set SCO MTU - 1
> Set SCO MTU - 2
> Block BDADDR - Success
> Block BDADDR - Fail
> Unblock BDADDR - Success
> Unblock BDADDR - Fail
> Connection List - No Conn
> Connection List
> Connection Info
> Connection Info - No Connection
> Connection Info - Wrong Type
> Authentication Info - No Connection
> Authentication Info
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] tools/ioctl-tester - Add ioctl-tester
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=0da759f1a36d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


