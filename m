Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A94C4167B
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Dec 2022 23:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbiLTXkY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Dec 2022 18:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbiLTXkT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Dec 2022 18:40:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A141FF8D
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Dec 2022 15:40:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CE163B81A77
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Dec 2022 23:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8180CC433F1;
        Tue, 20 Dec 2022 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671579616;
        bh=bBxqo14Ib3ToPPG7IOPHOnd2bINsIbrXLq3vStktUjE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tOf9Kg/sJZEZog14JYrenaSE/BZe+Xn3X+hzSItcu2DJa9wE3c48+QYlBjx5CKYMj
         yVwWg3PrVKee806W8kdZF0u/vPAX6vE/yzCq5JOddzEwq/TkJffBHuyuzBrBoR1ckr
         Xy8DN+ErXlbgHLzL9hMSSiZ3sPGHrA8vxkBfwhsrsTSoGiMCw1beS+qqXesO7O/X+W
         IFSmIziDCDprsmbb4dRPQbg6ENXAlYJabN50tMnxprO3kMbpZ0XL4KUxzfvpzhGWzp
         OVjtDEMvTUBTDApKV8sRI+BMLj54HA9BH5pL3jhuok/m778N57IpncNGRn2xo/Zylx
         GxEsk6+qq9FIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6622AC5C7C4;
        Tue, 20 Dec 2022 23:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/6] CSIP - Client Role
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167157961641.23834.7162429998025656221.git-patchwork-notify@kernel.org>
Date:   Tue, 20 Dec 2022 23:40:16 +0000
References: <20221121234624.2961-1-sathish.narasimman@intel.com>
In-Reply-To: <20221121234624.2961-1-sathish.narasimman@intel.com>
To:     Sathish Narasimman <sathish.narasimman@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 22 Nov 2022 05:16:18 +0530 you wrote:
> The following patches are for CSIP (Co-ordinated set identification
> profile) Client role. The patches also includes using SIRK and adding it
> to ADV data. Configuring CSIP Server values.
> 
> Sathish Narasimman (6):
>   lib/uuid: Add CSIS UUIDs
>   main.conf: Add CSIP profile configurable options
>   shared/csip: Add initial code for handling CSIP
>   profiles: Add initial code for csip plugin
>   monitor/att: Add decoding support for CSIP
>   tools: Add support to generate RSI using SIRK
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/6] lib/uuid: Add CSIS UUIDs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b709058c6008
  - [BlueZ,2/6] main.conf: Add CSIP profile configurable options
    (no matching commit)
  - [BlueZ,3/6] shared/csip: Add initial code for handling CSIP
    (no matching commit)
  - [BlueZ,4/6] profiles: Add initial code for csip plugin
    (no matching commit)
  - [BlueZ,5/6] monitor/att: Add decoding support for CSIP
    (no matching commit)
  - [BlueZ,6/6] tools: Add support to generate RSI using SIRK
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


