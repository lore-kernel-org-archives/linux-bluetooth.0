Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD48C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Apr 2022 22:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352870AbiD1Wdf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Apr 2022 18:33:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352869AbiD1Wdb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Apr 2022 18:33:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C48E0E6
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Apr 2022 15:30:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B047B830E7
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Apr 2022 22:30:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B104EC385B0;
        Thu, 28 Apr 2022 22:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651185012;
        bh=FbFNv1VSO4pn1uQY9qfqvJY8QYZ2laEet/weVqJ/0NE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=jHsavi0Xa9pZTlzETuWtAHpkLaq2S+vGwfhtt3vJ0FdNVnpDxtW8ixJjgTbybwl3p
         DGmX+gL7gT6EPbTus8/LzNEyuWKh1LBmxy0CnS3k5qhISiIuidKDO2xe7udTgcihRS
         FyUNfbaeRZBxLGZD9zedLfSjuSrSvQhx18Qqq+AnfpyMb36mIZtlKwTJ2+pBxqsgkC
         jSCRFJmcHTtrnNLStwmMGF2OcmztUY1INfIj4LVjTQatKZQt/HVPq7IR9O/Vb+/ELN
         LHdZqYKk8FWPc4DPOP0Eo1VOvuOoDZlg/92sJYdtQbJDym+xiV7aYZvZ1aCwtA7tmS
         Qt0TVJ5HBXw4w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8A70AF03876;
        Thu, 28 Apr 2022 22:30:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 BlueZ] client/player: Add transport.receive command
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165118501256.18997.15243401684823435353.git-patchwork-notify@kernel.org>
Date:   Thu, 28 Apr 2022 22:30:12 +0000
References: <20220426180401.794718-1-luiz.dentz@gmail.com>
In-Reply-To: <20220426180401.794718-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 26 Apr 2022 11:04:01 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This adds transport.receive command:
> 
> Get/Set file to receive
> Usage:
> 	 receive [filename]
> 
> [...]

Here is the summary with links:
  - [v2,BlueZ] client/player: Add transport.receive command
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7a87497da4ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


