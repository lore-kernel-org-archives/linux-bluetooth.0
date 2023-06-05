Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA287C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Jun 2023 19:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235738AbjFETkZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Jun 2023 15:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235471AbjFETkX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Jun 2023 15:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF490ED
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jun 2023 12:40:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EF53622C2
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Jun 2023 19:40:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A34D2C433D2;
        Mon,  5 Jun 2023 19:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685994021;
        bh=nuQIn5Th/ZadxCaxyg2uO2xf5EjoHHZq3PvdvCGJ9AI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EjdFg1tM/CGeECamL8GP14X3grIS4Rqkf8+/9FqQMKyfWd5zQnGcz4al4zkeS3UhV
         W2ns5G0X6TmH0VBTpUdDhK6BygBTFgRxHQYrA4GKpzozVjjQI4L6McI6VxtjHSRVDI
         qwpccH5yFWFuoDGNcuCOC7/MzbTP9f0jnuw4QQWVTNNLQFYRPNOg7IzKLAWfln4HB8
         cwk+dErNxXaJ6uZlGq9i9A+hUOYSiMmpp+MYjqz+iC4Fz6LFpSVI7S1YAyHkNwkL9V
         TpUUyC40zlvQD63UYHq/qjvLHytRWTrT9HCAjAAewG5O3Ifzmg9bKqYGiPQ65E4VoA
         PjhEBRcWZetZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 816A9E87231;
        Mon,  5 Jun 2023 19:40:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 1/3] Bluetooth: Consolidate code around sk_alloc into a
 helper function
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168599402152.27522.6383337496901075984.git-patchwork-notify@kernel.org>
Date:   Mon, 05 Jun 2023 19:40:21 +0000
References: <20230603001628.1886596-1-luiz.dentz@gmail.com>
In-Reply-To: <20230603001628.1886596-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  2 Jun 2023 17:16:26 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This consolidates code around sk_alloc into bt_sock_alloc which does
> take care of common initialization.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v3,1/3] Bluetooth: Consolidate code around sk_alloc into a helper function
    https://git.kernel.org/bluetooth/bluetooth-next/c/2cb4c5f3c8a3
  - [v3,2/3] Bluetooth: Init sk_peer_* on bt_sock_alloc
    https://git.kernel.org/bluetooth/bluetooth-next/c/701bc46e055c
  - [v3,3/3] Bluetooth: hci_sock: Forward credentials to monitor
    https://git.kernel.org/bluetooth/bluetooth-next/c/5b40b70a9b67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


