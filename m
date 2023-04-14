Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D402C77B72
	for <linux-bluetooth@archiver.kernel.org>; Fri, 14 Apr 2023 20:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDNUKY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 14 Apr 2023 16:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDNUKW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 14 Apr 2023 16:10:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F4565B3
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 13:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B887E64A1E
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Apr 2023 20:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2D86FC433D2;
        Fri, 14 Apr 2023 20:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681503020;
        bh=byfWLOYABnI3ZIMRebZn3/r8+3eLl4A5vyQeSu3Mucg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=JD77nsCpBhr4axhSteR9tgkvySz2aze5BQjAKI7xI/e5N7EhulolNqEJy+JdVqx9S
         LdG8CCzxMhuevMbyPA0Gz7ysAmkbx5BJPQqh4Upi0dakVsFqTtIVSL8CzianNezxOY
         q88Gq+zhXdnULRoBJMpIzo92E2A/1Edt6DWDXultpsv5uTvDNKAMACTi3Gq+Om8mlm
         iCX+eU9uZvM3b02xOKZVBFsWrfFf26/lF0Hl9OXadCDJTF/6lDeM2x23kFKWDv9C4/
         4Ygoh1vl9bsHhasRlaHgqaC6eyQ1x/CjDDk3eD8OLcqgVUeTwirqQzDEayHyD9JI0J
         0kSNO4I/d9F+A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1A0BAE52446;
        Fri, 14 Apr 2023 20:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/1] Bluetooth: hci_conn: remove extra line in
 hci_le_big_create_sync
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168150302010.15322.1181322105086656091.git-patchwork-notify@kernel.org>
Date:   Fri, 14 Apr 2023 20:10:20 +0000
References: <20230411074135.69768-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230411074135.69768-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 11 Apr 2023 10:41:34 +0300 you wrote:
> This patch removes the extra line setting the broadcast code parameter
> of the hci_cp_le_create_big struct to 0. The line above copies the
> broadcast code set in the QoS struct into the HCI command struct.
> 
> Iulia Tanasescu (1):
>   Bluetooth: hci_conn: remove extra line in hci_le_big_create_sync
> 
> [...]

Here is the summary with links:
  - [1/1] Bluetooth: hci_conn: remove extra line in hci_le_big_create_sync
    https://git.kernel.org/bluetooth/bluetooth-next/c/f5457383cdf4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


