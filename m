Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8964FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Oct 2022 20:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiJNUuU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Oct 2022 16:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiJNUuT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Oct 2022 16:50:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794453A4AA
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Oct 2022 13:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BB8361C0D
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Oct 2022 20:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04DE6C43140;
        Fri, 14 Oct 2022 20:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665780616;
        bh=zzMI1B/1KQqDltwx5cZNVG1ihPpPn6H8lMyuqgLrArw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rX42lNjKJBNSPbBTNv7CyaGZbNXhsCJGiQ0MzZl1K4C4/0DB1GvVUtHoJVDlxy5+v
         p3q1KOEhPQQLm1+tpbyeUof5wPbTCwIsPp6oI7B+JAWmtriBhnduaDzOnobGPBaCUA
         CHfoyqQb8LvCsRdtpR/+qdGqRvkDfThm+LvY8Z3q2njOpfCT86bGe35ft3V7MlfXwy
         Dr3DzhskmoFTYLbzsAJx90OqMyX0HUlk30GddAbyZoq62DJJiXHnw+F7R8wa/gIWu/
         /YvZehpLp2oWfuXqDT23rgTD2nM8b566r4m2/wlhwP509zOL1KUagGiZwDrUPY3Ac7
         0uF6K4cd2r0ZQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DD586E4D00A;
        Fri, 14 Oct 2022 20:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH v2] monitor: Fix incorrect vendor name for vendor cmd
 and evt
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166578061590.24462.9802957310256753095.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Oct 2022 20:50:15 +0000
References: <20221014185720.1132417-1-hj.tedd.an@gmail.com>
In-Reply-To: <20221014185720.1132417-1-hj.tedd.an@gmail.com>
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 14 Oct 2022 11:57:20 -0700 you wrote:
> From: Tedd Ho-Jeong An <tedd.an@intel.com>
> 
> This patch fixes the issue that the vendor name for all vendor HCI
> command and event are display as Microsoft.
> ---
>  monitor/packet.c | 46 +++++++++++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 15 deletions(-)

Here is the summary with links:
  - [BlueZ,v2] monitor: Fix incorrect vendor name for vendor cmd and evt
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1096a99cadfa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


