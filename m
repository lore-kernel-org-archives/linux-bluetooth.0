Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC23E7AD77
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 17:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjJCRKe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 13:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjJCRKc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 13:10:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8866A6
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 10:10:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D9D3C433CB;
        Tue,  3 Oct 2023 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696353027;
        bh=uNBTgcYyguK5XuakEVSI2EyDw6sBp3x3OJpV45EPuac=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=rXiuEhhiIIGvbEugXeyAnS+ozVk4tNAj0tM/zc+02NWODIRXcHUz6rNy/3FosC/8g
         m4PZC7fB8k8gsK34rxGnVYz+pskZZLMkiYu1HzlWh24JGW0xYOpZ71d/WMO2Rn2m0d
         9Gj6A5xdiARDMU6zOPrf1ZY2KU+aRd2CcClBZ5ldVMG5c94NoUqVTm70CN6V8nlXhn
         mHzRxiDhuRSU/arfkDBWXXb8j9xdIwf9KfYpVdsh68tYmgEiiGyqY80XoqILarr4B6
         CEtpwLMVK99uYkCCD0ohW8ydIcZfte3SM7x0+Z9xg5s7CiS+LfK933CIaiFRFMfo8Q
         gwqonh+NzoW+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6F845E632D8;
        Tue,  3 Oct 2023 17:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] Bluetooth: ISO: Match QoS adv handle with BIG handle
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169635302745.22624.9791942110142970744.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Oct 2023 17:10:27 +0000
References: <20231003143739.2925-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20231003143739.2925-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com,
        luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  3 Oct 2023 17:37:38 +0300 you wrote:
> Currently, if the user wants to bind multiple broadcast sockets to the
> same BIG handle, the BIG and BIS fields of the QoS structs must be set
> and identical for all sockets.
> 
> It means that the user must remember both the BIG handle and the
> associated advertising handle that the BIG will be opened for.
> This information is redundant, since one BIG handle may only be
> associated with an unique adv handle.
> 
> [...]

Here is the summary with links:
  - [1/1] Bluetooth: ISO: Match QoS adv handle with BIG handle
    https://git.kernel.org/bluetooth/bluetooth-next/c/cffdc28aa2e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


