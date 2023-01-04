Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BD00C5479D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Jan 2023 00:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238544AbjADAaX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Jan 2023 19:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbjADAaT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Jan 2023 19:30:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E214D68
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jan 2023 16:30:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B960A61543
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Jan 2023 00:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 24483C433F0;
        Wed,  4 Jan 2023 00:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672792217;
        bh=gK4Qh7TsIZpZ7Ex+ORWwqk4csJpMEM3IrtkCUHuNdko=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=b8z4veLw+3qSBv69VzYVzh/Z3jaopr1zaOVC4P9amhNVbyeliAhGCyrX0Xpi+MKwX
         S+7BnmMJasPCwuM3gGhukXC95xkh0WeFi1uyVa7o7dF56NnVuh+9V6s6c+8+y2UdAC
         vyLXfLCSl8O1KDt2xDHyfZw9YIUEz+dqkzDQorMr+Jz8r4VHNXSqAKUcDQkwqBEJik
         7m9zgK+B4i9Tvs5jRmKo1zB/DtZGWPdTsMoTsqUwD/rPfllbYD7no9pLgiHkr4JQVo
         cvDm/q7tjSW4Tx9Y1+1KLmqWLUqm4Tq+NJiBOxzFgLTTlvzuy4Egfm0uBxsUcjxK2b
         rZtFqVaw5Mk7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 083EEC395DF;
        Wed,  4 Jan 2023 00:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/6] To add support for Metadata, CID, VID
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167279221703.4957.7483450913741816466.git-patchwork-notify@kernel.org>
Date:   Wed, 04 Jan 2023 00:30:17 +0000
References: <20221229155257.341327-1-abhay.maheshbhai.maheta@intel.com>
In-Reply-To: <20221229155257.341327-1-abhay.maheshbhai.maheta@intel.com>
To:     Maheta@ci.codeaurora.org, Abhay <abhay.maheshbhai.maheta@intel.com>
Cc:     linux-bluetooth@vger.kernel.org, mabhay125@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 29 Dec 2022 21:22:53 +0530 you wrote:
> This series of patches adds support for Metadata, Company ID and
> Vendor Codec ID during Endpoint Registration for LE Audio.
> 
> Abhay Maheta (6):
>   shared/bap: Fix handling for Company ID and Vendor Codec ID
>   shared/bap: Add support to set stream metadata
>   profiles: Add Support for Metadata, CID and VID
>   media-api: Add CompanyID, VendorCodecID, Metadata
>   client/player: Add support for Company ID, Vendor ID
>   client/player: Add support for Metadata in BAP Profile
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/6] shared/bap: Fix handling for Company ID and Vendor Codec ID
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=441eeb2a1448
  - [BlueZ,v3,2/6] shared/bap: Add support to set stream metadata
    (no matching commit)
  - [BlueZ,v3,3/6] profiles: Add Support for Metadata, CID and VID
    (no matching commit)
  - [BlueZ,v3,4/6] media-api: Add CompanyID, VendorCodecID, Metadata
    (no matching commit)
  - [BlueZ,v3,5/6] client/player: Add support for Company ID, Vendor ID
    (no matching commit)
  - [BlueZ,v3,6/6] client/player: Add support for Metadata in BAP Profile
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


