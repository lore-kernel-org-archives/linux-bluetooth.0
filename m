Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1719CC7EE29
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 May 2023 17:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjECRab (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 May 2023 13:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjECRa1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 May 2023 13:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7531CBF
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 May 2023 10:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10E0A62F09
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 May 2023 17:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B10FC433EF;
        Wed,  3 May 2023 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683135022;
        bh=WPFN1i+PrSAxQF2fjjcNzCn8rPVXDYKnmq1torjyX60=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=hF/Q/4sC4JaH9+YjI8/3zYELfMmnpvRoyHIF3SqwA0tk0ODI48aJ+HLwP5YzTilBi
         SsybuR3NDO/9hsVcYBD1927p8wDFE0fvaSxmyh9BYJGK+Kv6jc5Vq4HRp6xHQv+Vs+
         AprZ0T8yXsBDIB6uBGemgn3T/MccyU5zDIQXbuOw3Bb57f8qYTluF2huBVyynZdvUo
         8viiXdeoyHOliuLqBQn+/oyPVtHN2Gd935ijlqe7z5qxn6qKWRVz/HYAH++NWfGsxy
         IDHJ3BvUsB4u/IM95WrS/2EVwpF6cF3K5KkhasN0UcAW8auxxR0NDnnKU4Dr8yjGFc
         viNpIUnfk2LlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 406CAE5FFC9;
        Wed,  3 May 2023 17:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/4] Bluetooth: Fix potential double free caused by
 hci_conn_unlink
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168313502225.19283.10886307523744996705.git-patchwork-notify@kernel.org>
Date:   Wed, 03 May 2023 17:30:22 +0000
References: <20230502212527.1662896-1-luiz.dentz@gmail.com>
In-Reply-To: <20230502212527.1662896-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  2 May 2023 14:25:24 -0700 you wrote:
> From: Ruihan Li <lrh2000@pku.edu.cn>
> 
> The hci_conn_unlink function is being called by hci_conn_del, which
> means it should not call hci_conn_del with the input parameter conn
> again. If it does, conn may have already been released when
> hci_conn_unlink returns, leading to potential UAF and double-free
> issues.
> 
> [...]

Here is the summary with links:
  - [v3,1/4] Bluetooth: Fix potential double free caused by hci_conn_unlink
    https://git.kernel.org/bluetooth/bluetooth-next/c/3214238e9dc7
  - [v3,2/4] Bluetooth: Refcnt drop must be placed last in hci_conn_unlink
    https://git.kernel.org/bluetooth/bluetooth-next/c/38e9b45310de
  - [v3,3/4] Bluetooth: Fix UAF in hci_conn_hash_flush again
    https://git.kernel.org/bluetooth/bluetooth-next/c/29f883dcbfd0
  - [v3,4/4] Bluetooth: Unlink CISes when LE disconnects in hci_conn_del
    https://git.kernel.org/bluetooth/bluetooth-next/c/e6e576ec4e72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


