Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44C1CCA473
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 20:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiGVUkW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 16:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiGVUkT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 16:40:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5630513F1C
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 13:40:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 70F1CB82AD0
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 20:40:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 064E8C341C7;
        Fri, 22 Jul 2022 20:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658522415;
        bh=UFtyzX90As67gZowNHFuZpVB8JXTC8Z3g67laMjhSbw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=M7RRwaI3W5fHIxQFA6sNtputS7sPfRKqVsi/K7WPcAh6PNn1xHWYMP7z7CQ5C7gax
         AzxUG81IBDn4ItcNQaGXiPI1cz9Bzvry/5T3zopxsbpm0qtjBLNxKN3PnxtdQy8kb9
         k7a3WLx/nFS41+9DaBTG1WDyHHOYxh7+lTj+or2E4d617Dhu43j05uhnqSmPJMe66c
         4szPki1uVUwEM3uWuuzyKBn1LC2zF7pPgBoreNT0FGM8px1dMqPMBTo7lKCY/PpQ73
         9pqAsNiVMPsO6EqgnQRSCsrOSxVju4GEtZfJQxPiUhqO9X3lChNWSTg2jAPS5zEvK7
         kN2u24c8ejmUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DB898E451B3;
        Fri, 22 Jul 2022 20:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v7 1/7] Bluetooth: hci_core: Introduce hci_recv_event_data
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165852241489.788.1055658696122699316.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Jul 2022 20:40:14 +0000
References: <20220711233535.3134546-1-luiz.dentz@gmail.com>
In-Reply-To: <20220711233535.3134546-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 11 Jul 2022 16:35:29 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This introduces hci_recv_event_data to make it simpler to access the
> contents of last received event rather than having to pass its contents
> to the likes of *_ind/*_cfm callbacks.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v7,1/7] Bluetooth: hci_core: Introduce hci_recv_event_data
    https://git.kernel.org/bluetooth/bluetooth-next/c/dfe6d5c3ec23
  - [v7,2/7] Bluetooth: Add initial implementation of CIS connections
    (no matching commit)
  - [v7,3/7] Bluetooth: Add BTPROTO_ISO socket type
    https://git.kernel.org/bluetooth/bluetooth-next/c/8cdb3ca6b616
  - [v7,4/7] Bluetooth: Add initial implementation of BIS connections
    https://git.kernel.org/bluetooth/bluetooth-next/c/336c0d956419
  - [v7,5/7] Bluetooth: ISO: Add broadcast support
    (no matching commit)
  - [v7,6/7] Bluetooth: btusb: Add support for ISO packets
    https://git.kernel.org/bluetooth/bluetooth-next/c/f64201d50966
  - [v7,7/7] Bluetooth: btusb: Detect if an ACL packet is in fact an ISO packet
    https://git.kernel.org/bluetooth/bluetooth-next/c/768677808478

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


