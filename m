Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6931AC7113B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 23:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238830AbjHWXA2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Aug 2023 19:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238822AbjHWXA1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Aug 2023 19:00:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A5AD3
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 16:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8F3365C3A
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 23:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B41EC433CA;
        Wed, 23 Aug 2023 23:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692831624;
        bh=/lIWKiJ5jRndc96iIFOLzxfq2997q/kpBfvQSviRcec=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ma5Twc3wIsihWgTVKTajp/QdvDzhQIKu3eUxqKTeFcGlrMGueT60GzXQuFq9ql43J
         ZyyE6iSdHo4UDYGB63bnux6ue4o8Ac+VYrLfoAJ4cTIJMVOsK6laBc2Q3b3MpmqVtj
         N5nSj+99kW0Fu8bOXJ4V9uxe3bixlV0AJzUDgiFpHh8AlidxdSRNRDI4a3xq6g+nl5
         7LLpCoCfWDeDnGCly2OztwPj+BalSRcSZJOWWgcqhKt7Tj7ULrfpSvBwIBora1AZrm
         o8rc6akJl7TAhJr8aYNu+J3RF2MPWAhQ7FEe8e8H/B3xCmZToczZMVygK9pYRLIj8G
         t1pge/CamVJLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02FE1C395C5;
        Wed, 23 Aug 2023 23:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 0/1] isotest: Add defer setup support for Broadcast
 Receiver
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169283162400.30787.7458691088916734653.git-patchwork-notify@kernel.org>
Date:   Wed, 23 Aug 2023 23:00:24 +0000
References: <20230823151125.16100-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230823151125.16100-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org, claudia.rosu@nxp.com,
        mihai-octavian.urzica@nxp.com, silviu.barbulescu@nxp.com,
        vlad.pruteanu@nxp.com, andrei.istodorescu@nxp.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 23 Aug 2023 18:11:24 +0300 you wrote:
> This patch adds defer setup support for the Broadcast Receiver scenario.
> 
> In order to create a Broadcast Receiver with the defer setup option,
> the -W command line parameter should be used, as described in
> isotest.rst.
> 
> Iulia Tanasescu (1):
>   isotest: Add defer setup support for Broadcast Receiver
> 
> [...]

Here is the summary with links:
  - [BlueZ,1/1] isotest: Add defer setup support for Broadcast Receiver
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8b2f002edeb3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


