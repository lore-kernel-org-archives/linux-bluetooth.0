Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E48BC67871
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Oct 2022 21:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiJXVxe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Oct 2022 17:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiJXVxG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Oct 2022 17:53:06 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329A3132DCD
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Oct 2022 13:06:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 9DB11CE13CF
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Oct 2022 20:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD09BC433D7;
        Mon, 24 Oct 2022 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666641616;
        bh=7ToBhbO4Kxh/RFKay51R53VtuX3WzCH/IGnNGC5AS/o=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=C1D0o+gYaxT+g++vSzH+k1eUPR1RnIPp7s1ELSKq9zRaKFzgJ4XKPtla8fJY+seq4
         cyF8AArVvX6VFsqeTkCHyXnDXRi8LHZoZNw+VQdiQ14u1WsfCBNHwmLuSid4mALGP5
         ctgQXhUOu/5bH16ZGnq0Bn5kGaoRkceBeBhZnGEobo6hJaqM+DQ9p+hDawWvoIRsZ6
         wkVixyazZOHD3Lw06E+qzrnSwo28oqLz23pJOGCpDCMDxk8hDjVlhPRcfIgmkyxemZ
         Y2dR3nrZRiB3HEwtszXgjjdD4kNdhfRKKgamqk63g0jefG/j6C+u2G90W5R/g+QrME
         tkoUc49mQWcKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C2795E29F30;
        Mon, 24 Oct 2022 20:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/1] monitor: Ellisys: Add iso packet support
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166664161679.31850.6622560238267088637.git-patchwork-notify@kernel.org>
Date:   Mon, 24 Oct 2022 20:00:16 +0000
References: <20221022031333.4333-1-xiaokeqinhealth@126.com>
In-Reply-To: <20221022031333.4333-1-xiaokeqinhealth@126.com>
To:     None <xiaokeqinhealth@126.com>
Cc:     linux-bluetooth@vger.kernel.org, xiaoyao@rock-chips.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 22 Oct 2022 11:13:33 +0800 you wrote:
> From: Yao Xiao <xiaoyao@rock-chips.com>
> 
> Ellisys Bluetooth Analyzer Injection API Services.pdf
> 
> HCI Packet Type Object
> Value   HCI Packet Type
> 0x05    HCI ISO Data (host to controller)
> 0x85    HCI ISO Data (controller to host)
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] monitor: Ellisys: Add iso packet support
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6899322b68e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


