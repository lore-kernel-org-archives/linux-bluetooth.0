Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AB5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 06:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiFVGaQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 02:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiFVGaO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 02:30:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84B52F64A
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Jun 2022 23:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70D9F61173
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 06:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DA64DC341C5;
        Wed, 22 Jun 2022 06:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655879412;
        bh=WyTZNAFPgtKhy3E/zdermKXo30LXISGBocPSNWG4Ibo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=miMeEejn0ltn/RolDhDHL7x0S20ytgRVUr1dymbqaI97TssuITgsRlSAYuMqxLzAp
         4ZbKcrRnOu2YyOFoRUPTRUhPgscdAmT30T3z8kBcW7ZEjbVXPSVIQNXEbLV/UFkhes
         QS1uti+t5PPefPpJyToXgVuBr9YGecbakEYEhCPy45ZZOnC2APw+QppcxNPg4jxaAd
         UIlNgvqgvQNVy3L4Yw5u6vaq/ADFX9t7W6OGOGpWzl1bn5T0zk4/pcd0FA6xW3r471
         yXgUVDHCyNlgz+SSK0vyIgInIWfS7TF1vrkUtXndm4PvifPWlOCjh11bBsr99lmm6F
         lNFuj14dtP/kw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BBD25E574DA;
        Wed, 22 Jun 2022 06:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH] tools/mgmt-tester: Add test case for scan response data
 is not updating
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165587941276.28820.1996698265401619013.git-patchwork-notify@kernel.org>
Date:   Wed, 22 Jun 2022 06:30:12 +0000
References: <20220621201054.66411-1-hj.tedd.an@gmail.com>
In-Reply-To: <20220621201054.66411-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 21 Jun 2022 13:10:54 -0700 you wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> This patch adds a test case to test if the scan response data is updated
> when the following scenarios are performed.
> 
> 1. Add Extended Advertising Parameters Command
> 2. Add Extended Advertising Data Command w/ Scan Resp Data
> 3. Remove Advertising Command
> 4. Add Extended Advertising Parameters Command
> 5. Add Extended Advertising Data Command w/ Scan Resp Data
> 6. Host should set Scan Resp Data
> 
> [...]

Here is the summary with links:
  - [BlueZ] tools/mgmt-tester: Add test case for scan response data is not updating
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b8b3277ba387

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


