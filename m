Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43615C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 21:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiIVVKT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Sep 2022 17:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiIVVKS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Sep 2022 17:10:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFBF5467B
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 14:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C857634A1
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Sep 2022 21:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 772F2C433B5;
        Thu, 22 Sep 2022 21:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663881016;
        bh=d8/KcH9Y9U8p+3kw2NHpHQFrz9eVDbEYWYvYq1i+JeQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nYsjeyuhc/3oHgRpJ4XUu7CnJV6nkfTAmIogSzjLlKm4ORT+BSTgddCSlhlp2qo3a
         gAFRoHixi33PbP7+dw3wEIrM3J7PN853L2rTp4SK6DE2Afhdicq1yRVvz0JDpnxCdt
         R7VNYOSTxc4h2yU4DXNgN7qWOoe5KjzjcY8iPElaZ99+bGXeAPxrxrHupApW6Co/Bn
         pze/ax52tC/AMV5TQM7mIE4+p3O5fgj2JMJq1om8ltTp4VcMrQ5XYxbrsoXKa2py1k
         EcMOoQnK3DyYyHZNzYyQ0ANidARdlx+sIoUIasNMd2UJCr4OmUvPltD3728usI9j/0
         B45SgpH9ViGTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5D97CE50D6A;
        Thu, 22 Sep 2022 21:10:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/3] Mesh model publication fixes according to mesh
 profile
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166388101637.22480.18300225277952361024.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Sep 2022 21:10:16 +0000
References: <VI1PR09MB42396AFF2009109A4318E51AE34F9@VI1PR09MB4239.eurprd09.prod.outlook.com>
In-Reply-To: <VI1PR09MB42396AFF2009109A4318E51AE34F9@VI1PR09MB4239.eurprd09.prod.outlook.com>
To:     Isak Westin <isak.westin@hotmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@intel.com>:

On Wed, 21 Sep 2022 10:39:38 +0200 you wrote:
> Hi,
> 
> I am testing the BlueZ Mesh stack with PTS (MESH and MMDL layers) and
> there are some parts of the mesh stack that are not behaving according
> to the mesh profile. Here are fixes to a few of them I encountered
> when testing the model publication procedures (MESH/NODE/CFG/MP).
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/3] mesh: Add interface output filter
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a76ff5879b75
  - [BlueZ,2/3] mesh: Do not accept publication for unbound appkey
    (no matching commit)
  - [BlueZ,3/3] mesh: Remove RFU check for publication set
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c9fadca7eba4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


