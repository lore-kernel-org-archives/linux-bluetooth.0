Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0ECCDB482
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Oct 2023 21:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442945AbjJLVu2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Oct 2023 17:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442931AbjJLVu1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Oct 2023 17:50:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D95B8
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Oct 2023 14:50:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A84AEC433C7;
        Thu, 12 Oct 2023 21:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697147425;
        bh=X8Xw1BVr+gXiR/UOwP1t/mjSL8JKtRI8UAZFyAvdFo8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aKS6EmQsGdkkQ9avsNFtvStHWpx5hPEXlfVymeUSGpEAN7HpRxOZ+0kVHtiljOUbt
         6AkZbDJxCDNokDawmDkLcKnpwBgXX9sbMC5Hpf+fn3pya3rgLfyY4rV3MwQvdjzTKQ
         MvInDaTaZbmaNnRUeWyNtNuMd7cm1ax2kgILaRlQMz9HTVGe5q1DkfeYfjJMyWMk09
         t4TMobyVGTxB5EOgOTKPo8606r2hElElxnEcD0Wz0N7Fuv1O+x8mf0ZOD+YW6C/zjC
         iC4KskR1zU0BUUJA4iDXAcE61VCLD4XMkAmKvySxDYOQp5uu4PFbE0ha9CZhUUesnY
         TznphkU+YaEkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D5B1C595C3;
        Thu, 12 Oct 2023 21:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] doc/obex-*-api: Rename to org.bluez.obex.*.rst
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169714742557.28993.2582057187022579961.git-patchwork-notify@kernel.org>
Date:   Thu, 12 Oct 2023 21:50:25 +0000
References: <20231012202207.1365107-1-luiz.dentz@gmail.com>
In-Reply-To: <20231012202207.1365107-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 12 Oct 2023 13:22:07 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This renames obex-*-api.txt to org.bluez.obex.*.rst and generate
> manpages org.bluez.obex.*.5.
> ---
>  Makefile.am                            |  28 +-
>  doc/obex-agent-api.txt                 |  62 --
>  doc/obex-api.txt                       | 894 -------------------------
>  doc/org.bluez.obex.Agent.rst           |  54 ++
>  doc/org.bluez.obex.AgentManager.rst    |  45 ++
>  doc/org.bluez.obex.Client.rst          |  69 ++
>  doc/org.bluez.obex.FileTransfer.rst    | 155 +++++
>  doc/org.bluez.obex.Message.rst         | 139 ++++
>  doc/org.bluez.obex.MessageAccess.rst   | 201 ++++++
>  doc/org.bluez.obex.ObjectPush.rst      |  84 +++
>  doc/org.bluez.obex.PhonebookAccess.rst | 386 +++++++++++
>  doc/org.bluez.obex.Session.rst         |  61 ++
>  doc/org.bluez.obex.Synchronization.rst |  82 +++
>  doc/org.bluez.obex.Transfer.rst        | 123 ++++
>  14 files changed, 1426 insertions(+), 957 deletions(-)
>  delete mode 100644 doc/obex-agent-api.txt
>  delete mode 100644 doc/obex-api.txt
>  create mode 100644 doc/org.bluez.obex.Agent.rst
>  create mode 100644 doc/org.bluez.obex.AgentManager.rst
>  create mode 100644 doc/org.bluez.obex.Client.rst
>  create mode 100644 doc/org.bluez.obex.FileTransfer.rst
>  create mode 100644 doc/org.bluez.obex.Message.rst
>  create mode 100644 doc/org.bluez.obex.MessageAccess.rst
>  create mode 100644 doc/org.bluez.obex.ObjectPush.rst
>  create mode 100644 doc/org.bluez.obex.PhonebookAccess.rst
>  create mode 100644 doc/org.bluez.obex.Session.rst
>  create mode 100644 doc/org.bluez.obex.Synchronization.rst
>  create mode 100644 doc/org.bluez.obex.Transfer.rst

Here is the summary with links:
  - [BlueZ] doc/obex-*-api: Rename to org.bluez.obex.*.rst
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=345ad5e352b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


