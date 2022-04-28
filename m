Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD8FC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Apr 2022 22:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352871AbiD1Wdc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Apr 2022 18:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236003AbiD1Wd3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Apr 2022 18:33:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7896DE96
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Apr 2022 15:30:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D50E62070
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Apr 2022 22:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94022C385AD;
        Thu, 28 Apr 2022 22:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651185012;
        bh=d+4iHLWEh4sfuzyy6MaNwYKxsy6tNUcSDCUfEBs+BNQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YN5EqQecAe4H7IZQVNv7RPJVBRa6ZJwElC2+3uj+Ou3g1FGpDzJxIjz5Ck6y4B9Mt
         T6p93WWUWK+Db0bbL7N6cumcBitEAo027Or58Dv9O7Jth2ev1ASoRNmJc4rnVZPmCL
         IsRNMxlimtTOxU+EniBJb7xbwKXi8KUs/v70tOjDpDTO6Y09hfaxa9o9GJv5x2tKpo
         TFrsB+CIHIVTZOzqwzrs4jj36cf81Ya4J+pVgUa7HVD7xKBi6ZgesdW2vsdYU0rqz9
         34SiwLx9UFkRkxszHoHKkAjbD9eC9OGH73OvjWqZ4v22NDF0UG2NdSXPgn+1QCs6uc
         xiuXWb9VguhDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7798FF03874;
        Thu, 28 Apr 2022 22:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/4] btmon: Add proper decoding to Service Data UUID
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165118501248.18997.7133488232607108686.git-patchwork-notify@kernel.org>
Date:   Thu, 28 Apr 2022 22:30:12 +0000
References: <20220426230347.857783-1-luiz.dentz@gmail.com>
In-Reply-To: <20220426230347.857783-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 26 Apr 2022 16:03:44 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds proper decoding for Service Data UUID:
> 
>         Service Data: Apple, Inc. (0xfd6f)
>           Data: e6b07e19815e902100b8b2f4a55255fd18f0c6be
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/4] btmon: Add proper decoding to Service Data UUID
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=640d6b5c662d
  - [BlueZ,2/4] btmon: Add support for decoding Broadcast Audio Annoucements
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6da642225f5a
  - [BlueZ,3/4] btmon: Add support for decoding Basic Audio Annoucements
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=80cd36cd2a0c
  - [BlueZ,4/4] btmon: Fix not decoding LC3 id
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f65a9c9d21f6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


