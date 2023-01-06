Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DBFC61DB3
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Jan 2023 20:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbjAFUAT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Jan 2023 15:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbjAFUAS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Jan 2023 15:00:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5382881D7A;
        Fri,  6 Jan 2023 12:00:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E31E361F46;
        Fri,  6 Jan 2023 20:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 48339C433D2;
        Fri,  6 Jan 2023 20:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673035216;
        bh=0vMjJ32YysqcGvkZGvs+7H86gSBEs9R9VayV/RpNBY0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fQNbFWrbewD+0bVlTtX0Eemt6uEdLEq+jQzUtoevShTkxKtni7dIuH6hmFV3230tE
         u2sQ/vQAr3xMB+lRMuF0g7ZZqf6vGcunIr3T+X2LzLLLDmPB62eqeKDyHTqmnozbXD
         WZNNyCGbYOTSDa+VQsP3xVUJtezXMQ74sJvAW6ZG5vrYCnmaucMT4NV9ZK0IbBid5y
         p0SK4+/A8tWyN+IBAnF9fdAV1B3/LLdaMmHlCBZQCxTjATsEeQdiGdwA8rYJ8jjm/9
         y+j+pAc2305gxi4Kk4ngAz04vge1820uSKYryV1SPyA1cAKQmQZbR2pIgOlRx7vGeC
         heF34FxJcvBig==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2DF42E270EC;
        Fri,  6 Jan 2023 20:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add VID:PID 13d3:3529 for Realtek RTL8821CE
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167303521618.6339.17452980006788051590.git-patchwork-notify@kernel.org>
Date:   Fri, 06 Jan 2023 20:00:16 +0000
References: <20221225190713.656505-1-moisesmcardona@gmail.com>
In-Reply-To: <20221225190713.656505-1-moisesmcardona@gmail.com>
To:     Moises Cardona <moisesmcardona@gmail.com>
Cc:     luiz.dentz@gmail.com, johan.hedberg@gmail.com, marcel@holtmann.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 25 Dec 2022 14:07:13 -0500 you wrote:
> Happy Holidays everyone,
> 
> This patch adds VID:PID 13d3:3529 to the btusb.c file.
> 
> This VID:PID is found in the Realtek RTL8821CE module
> (M.2 module AW-CB304NF on an ASUS E210MA laptop)
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add VID:PID 13d3:3529 for Realtek RTL8821CE
    https://git.kernel.org/bluetooth/bluetooth-next/c/e0d6e384a1ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


