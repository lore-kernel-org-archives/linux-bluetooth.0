Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F1DC04A6A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 18:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjHDSe7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 14:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231459AbjHDSe0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 14:34:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA3B5FF0
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 11:30:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46E71620DB
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 18:30:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BB74C433C7;
        Fri,  4 Aug 2023 18:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691173822;
        bh=GHTDX2KkggnPoJl9i292ifoazooMhF+UQ9y++GXeWO0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EzqYqbtqhXGdEtDzqb47ky6yTlOIsJd1YLNZaT7tvZDCjDK3McDMQf07iSvAYXEz4
         ApKG46cR2U8WSReoBKgp/4KNbsUHkn96eimj+hUDoQNifU9oR5APQtGwvX4NFjjwje
         YMqSM95hAMtot2aLd6cReYrkW/BuZX7nVhd+LwaNg/Ch37yFO8AdgKuN206TyBCzgl
         6PULoDCHZd6xdl2ZIA1JyqJETupWvBCYoMKGBNonQeQx7CQAgZd+NUWTmVjpm//Fxf
         eg1PCDOdeDChXMi28LJve/Jfg2ajIevI/G9sCQevSGw1UNipDi/vtO3g0ic+tudh6U
         uHt4SxysYb1oA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 820D7C41620;
        Fri,  4 Aug 2023 18:30:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 0/5] Additional tests for ISO and hci_sync
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169117382252.30435.4022501011774859108.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Aug 2023 18:30:22 +0000
References: <cover.1690907478.git.pav@iki.fi>
In-Reply-To: <cover.1690907478.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  1 Aug 2023 19:38:37 +0300 you wrote:
> This adds a few tests checking ISO socket handling of invalid input
> parameters and cleanup in some race conditions:
> 
>     ISO QoS CIG 0xF0 - Invalid
>     ISO QoS CIS 0xF0 - Invalid
>     ISO Connect2 CIG 0x01 - Success/Invalid
>     ISO AC 6(ii) CIS 0xEF/auto - Success
>     ISO AC 6(ii) CIS 0xEF/0xEF - Invalid
>     ISO Defer Close - Success
>     ISO Connect Close - Success
>     ISO Defer Wait Close - Success
>     ISO Connect Wait Close - Success
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/5] btdev: check error conditions for HCI_Create_Connection_Cancel
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5815a92423c3
  - [BlueZ,v2,2/5] btdev: fix Command Status command opcodes for Setup Sync Conn
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=23a7d4003064
  - [BlueZ,v2,3/5] sco-tester: test local and remote disconnecting simultaneously
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=80c8266ae20a
  - [BlueZ,v2,4/5] iso-tester: test with large CIS_ID and invalid CIG_ID/CIS_ID
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=10d83e3423bb
  - [BlueZ,v2,5/5] iso-tester: add tests checking Remove CIG is emitted
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=033b68cbb1bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


