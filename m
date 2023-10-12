Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D868EC41513
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Oct 2023 19:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442254AbjJLTka (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Oct 2023 15:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442138AbjJLTk3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Oct 2023 15:40:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89187C0
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Oct 2023 12:40:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 243C3C433CA;
        Thu, 12 Oct 2023 19:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697139626;
        bh=UAdJNfpuaOEDZk9674255LywG9TVyIzCzs2DQaQKkzo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IpV8w97/jBItjrsCctzdTN0tVEahhbAZchvKmhuxJ8fspnzEVIZMgY9oO9D96MwCD
         UBC8IJufZ9M+daj919xASzuP/7KVpzt4s4+Z8ddU6hAHT84IuFtGtYePx1G/odTFl7
         CRRWTrHlXSyy76PD2Mzg4+hvwP3lH/ya5ohA4pZovds/4mYT5ClEpePzjDaa56PGIR
         Mkj/V0CUcZlheKQVjRqzGoeiXpQ3OlqiqiZnq2eKazP7Ry0ZM2+lq7TXq/zFjnzvii
         izoHRmKEsxrcPCaEQ35I81IYFOaTRbmObc1WUCrcSDlH5onHLvfcMp+234S2Lq/GFq
         Xgl2nzo2F2JqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0C409C595C4;
        Thu, 12 Oct 2023 19:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: Make handle of hci_conn be unique
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169713962604.24492.5792188624728999525.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 19:40:26 +0000
References: <20231011212624.1206326-1-luiz.dentz@gmail.com>
In-Reply-To: <20231011212624.1206326-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 11 Oct 2023 14:26:24 -0700 you wrote:
> From: Ziyang Xuan <william.xuanziyang@huawei.com>
> 
> The handle of new hci_conn is always HCI_CONN_HANDLE_MAX + 1 if
> the handle of the first hci_conn entry in hci_dev->conn_hash->list
> is not HCI_CONN_HANDLE_MAX + 1. Use ida to manage the allocation of
> hci_conn->handle to make it be unique.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: Make handle of hci_conn be unique
    https://git.kernel.org/bluetooth/bluetooth-next/c/5c765bbcb233

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


