Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF64EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 10 Jul 2023 21:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjGJVa0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbjGJVaY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 10 Jul 2023 17:30:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618DB106
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 14:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3A4561210
        for <linux-bluetooth@vger.kernel.org>; Mon, 10 Jul 2023 21:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6553EC433C9;
        Mon, 10 Jul 2023 21:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689024622;
        bh=++3lTdb1uyzWbe4+o1ezr3Ge1YYmSlnUmL818IFnAV4=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=POGvv+23xVvhzf+FOWcct0peUfLd7UfIzSgGEn4znVChM5dPu0AUIAyODrowvFm7h
         IrKBldL3DbX6h3zhmJ1EcN+4cjQwYDISsMUtq4eJDJQuF1YbikEYiEZKkH2iiYFWLL
         OUuEAvhK+MyRucWq7IDBtYTpnYFQEv+rysiBvV5cpTU5sHG8pw526tSQSqbCEsqiFg
         aJpX2/cd+1x6gZ36b5V3aEHzdSdBo0jGIFtN9oj+Wjow8BJF7Aq+xSGubfUh3WM3Ny
         a5JeSlR4whR1+2v/8nqxLYKCVZH7IsXhlNlatRFAXMGYG7ye8mnBz5coPRtXofPHFT
         ERojdC2tYXubQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34F54E5380A;
        Mon, 10 Jul 2023 21:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: MGMT: Fix always using HCI_MAX_AD_LENGTH
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168902462221.18683.18234487358526141050.git-patchwork-notify@kernel.org>
Date:   Mon, 10 Jul 2023 21:30:22 +0000
References: <20230707224318.677205-1-luiz.dentz@gmail.com>
In-Reply-To: <20230707224318.677205-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri,  7 Jul 2023 15:43:17 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> HCI_MAX_AD_LENGTH shall only be used if the controller doesn't support
> extended advertising, otherwise HCI_MAX_EXT_AD_LENGTH shall be used
> instead.
> 
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: MGMT: Fix always using HCI_MAX_AD_LENGTH
    https://git.kernel.org/bluetooth/bluetooth-next/c/c9a85685d0c1
  - [v2,2/2] Bluetooth: hci_sync: Fix using Legacy PDUs with certain advertising
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


