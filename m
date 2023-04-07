Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B51C77B6C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Apr 2023 19:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjDGTls (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Apr 2023 15:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjDGTlq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Apr 2023 15:41:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108D66A52
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Apr 2023 12:41:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95C03651D7
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Apr 2023 19:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00E3DC4339E;
        Fri,  7 Apr 2023 19:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680896504;
        bh=meBlIptUxMnEqF39VMfricqPU9rWfsZ9wN1Gj+AI66k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IlN8erRFwpF0hXP4c0UE4pGge5hSYZvzZl+eS1DoydcsVy2VP8DjxHJ7e0a1VA3cP
         lO+sYtKdavjpy2RaeVXVt0qYDppsYfQM7WTaaOWELmNq6pYFA9qs5nHZhgANDxNNtj
         QxZcapmnEvpTQdYUxwEiBjH5DXoYUjiKyAUvdMuxyKCu5p8xt2qAZD5I2WfNQx6eow
         3c33jELnq4Or293YbwbFoOFqQGZXgh7vqWRlVMPGVyfHx90zp8bRTCVNyrBUu2he8E
         jDPlJMO7tXIuguGWeLvV9VYtYBoHbqmyvUn7uTkU+Uk4QT2HrNcB9eqIe7vl96bOjG
         +UKN4fe6iINZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E4D91C4167B;
        Fri,  7 Apr 2023 19:41:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND BlueZ] mgmt-tester: Fix Get/Set PHY tests
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168089650393.19462.1487190985725190245.git-patchwork-notify@kernel.org>
Date:   Fri, 07 Apr 2023 19:41:43 +0000
References: <20230407184440.3291592-1-luiz.dentz@gmail.com>
In-Reply-To: <20230407184440.3291592-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Apr 2023 11:44:40 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following tests now that all supported PHYs are enabled
> by default:
> 
> Start Discovery LE - (Ext Scan Param)   Failed
> Get PHY Success                         Failed
> Set PHY 1m 2m coded Succcess            Timed out
> 
> [...]

Here is the summary with links:
  - [RESEND,BlueZ] mgmt-tester: Fix Get/Set PHY tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e122a0708896

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


