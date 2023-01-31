Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE894C636CC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Jan 2023 17:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjAaRaW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Jan 2023 12:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjAaRaV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Jan 2023 12:30:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC35E6A46
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 09:30:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47776615EA
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Jan 2023 17:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A2AC2C4339B;
        Tue, 31 Jan 2023 17:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675186219;
        bh=BkXyVVBc95CRt6nP2n1GRbVv14q0adVJA4gYJC9z9Ck=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=AahWnB4QVtko7h56qq/K4wDZkrxVuW/A5Bc1F6b78Se0Ycj2A9/BM/q6JJO73eMMQ
         39qwGY/po6V/rkoPvKQJF26gjPnTHx43/NFnMi4IFfnytS1kKDe/GBm8Pv5eqZiLZi
         rZO0X57Ly8ZTP9QOYy3P6tGNjw08wGBfngpxDUT30rt/4t4oXPwfUgkHzNc4LfmBdy
         fzMPcNDbapbq1peyw47QoI/+bgNlwE7icZTM2Qkd0PEoVZ4dSFYT+UXRnT5lu+XvK+
         HOkrA+jpgQpJzhbxbwzGfmtD6xCqVTHQPthBl+5YOjNN1souRRjSAukH5H+gRxsfwV
         mlV3vJGUZVvWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8BEE4C072E7;
        Tue, 31 Jan 2023 17:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v5 00/14] Mesh v1.1 additions
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167518621956.31106.86554305859366691.git-patchwork-notify@kernel.org>
Date:   Tue, 31 Jan 2023 17:30:19 +0000
References: <20230130235210.94385-1-brian.gix@gmail.com>
In-Reply-To: <20230130235210.94385-1-brian.gix@gmail.com>
To:     Brian Gix <brian.gix@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com,
        inga.stotland@intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@gmail.com>:

On Mon, 30 Jan 2023 15:51:56 -0800 you wrote:
> This patch-set includes implementations for Client/Server Remote
> Provisioning, and Client/Server Mesh Private Beacons
> 
> v2 - v4: Clean-up checkpatch warnings.
> 
> v5: Add Inga's Extended Composition support
> 
> [...]

Here is the summary with links:
  - [BlueZ,v5,01/14] doc/mesh: Add Remote Provisioning DBus APIs
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=265c12dc9608
  - [BlueZ,v5,02/14] mesh: Add Remote Provisioning
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f3243ecba0a2
  - [BlueZ,v5,03/14] tools/mesh: Optimize for multiple RPR servers and NPPI
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c50ecca56654
  - [BlueZ,v5,04/14] mesh: Rename parameter list per crypto usage
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9923c09de57e
  - [BlueZ,v5,05/14] unit/mesh: Add unit testing of Mesh Private Beaconing
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2ff937b6aa50
  - [BlueZ,v5,06/14] mesh: Add storage of Mesh Private Beacon settings
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cbeca2fba171
  - [BlueZ,v5,07/14] mesh: Add Mesh Private Beacon server
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6619b24cc237
  - [BlueZ,v5,08/14] mesh: Add Tx/Rx support of Mesh Private Beacons
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5ba57cf85140
  - [BlueZ,v5,09/14] mesh: Add internal Mesh Private Beacon model
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ebb219614108
  - [BlueZ,v5,10/14] tools/mesh: Add support for Mesh Private Beacons
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cc8a4d858bcc
  - [BlueZ,v5,11/14] mesh: Switch beaconing net key
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e71d0e802629
  - [BlueZ,v5,12/14] mesh: Fix Checksmatch warning
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4bdd7090f0df
  - [BlueZ,v5,13/14] mesh: Remove unused byte swap for ScanBuild
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=5045e9845b9f
  - [BlueZ,v5,14/14] tools/mesh-cfgtest: Support extended device composition
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8787aed7fe00

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


