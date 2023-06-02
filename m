Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA79C7EE2C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Jun 2023 20:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbjFBUa2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Jun 2023 16:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbjFBUa1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Jun 2023 16:30:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A24E59
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jun 2023 13:30:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 478D361DFC
        for <linux-bluetooth@vger.kernel.org>; Fri,  2 Jun 2023 20:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A4424C4339B;
        Fri,  2 Jun 2023 20:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685737820;
        bh=wbz8/0UksQ7blCPJoenuoM/2ybxNpNRHxbGgWmlVAwc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=WOqRrOgwpgpAlsTKlXpR6kz12rpB7aQnt/NkUifrJ6ta7Ta6/7JmKqObZ2MfZNmw2
         G4yOtwMtgQlOIOcA52uxoTS7SZ+GVSMBu/flXck2uVj5680rAHdMRZbuFTfkgARkY+
         jenBxr+rGzedpUAqvlY1bhB25ltU3sIyDXUK4vq9j07IuW6zZhPbphFLlors9VRANx
         YnOuAwHtoAbgcQiI6Hkv7k+nG07sdYvd8ebl3mt8ozHLIYQNtsKCam4GziSb6fLqE9
         sHVThPAhnIXqoar+ywmxFXuRks0snll7e44U5IvxT9EjgFZDNnQsus1WMwa3dHfxWJ
         QU8UhfJltoLzw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A544E52BF5;
        Fri,  2 Jun 2023 20:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/4] LE Set CIG Parameters / Create CIS fixes
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168573782056.11756.1454729445948023566.git-patchwork-notify@kernel.org>
Date:   Fri, 02 Jun 2023 20:30:20 +0000
References: <cover.1685565568.git.pav@iki.fi>
In-Reply-To: <cover.1685565568.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu,  1 Jun 2023 09:34:42 +0300 you wrote:
> This patchset fixes a few issues with emission of HCI Remove CIG, Set
> CIG Parameters, Create CIS when multiple ISO sockets in the same CIG are
> closed and reconnected rapidly.
> 
> v2: Dropped patches that added error checking in hci_le_set_cig_params,
>     TBD separately later.  Returning errors there triggers some race
>     condition in the emulator when it's cleaning up the connections, which
>     needs some more looking.
> 
> [...]

Here is the summary with links:
  - [v2,1/4] Bluetooth: ISO: use hci_sync for setting CIG parameters
    https://git.kernel.org/bluetooth/bluetooth-next/c/f0393238e391
  - [v2,2/4] Bluetooth: ISO: don't try to remove CIG if there are bound CIS left
    https://git.kernel.org/bluetooth/bluetooth-next/c/59b32ee40f50
  - [v2,3/4] Bluetooth: ISO: use correct CIS order in Set CIG Parameters event
    (no matching commit)
  - [v2,4/4] Bluetooth: ISO: do not emit new LE Create CIS if previous is pending
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


