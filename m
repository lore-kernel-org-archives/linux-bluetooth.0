Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50FCC761A6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 22:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233383AbjCaWKZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 18:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233244AbjCaWKW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 18:10:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3AA9751
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 15:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 319F4B8328A
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 22:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D9EE4C433A4;
        Fri, 31 Mar 2023 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680300618;
        bh=zG9FHOpzq9p5zh/l5skY1f90THEhNfoe5Rza414AEew=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZLfMsRgYrzCditE07rROyE+godGkqExXkRVSwPukO4RD/42cNQc1r/JI0LC1i0dsy
         caRy1tcI0MRMnaqPH9JizfPHgBsJUYsJuNUqMf0ryO7uDE00fUwfpir4tg110u+NR+
         ysS2+gRcRsSey4iQQ/p3d85DGAMVA+woh9aW6NFzcEKXcR8/VSQCa025IrzY5Grfbe
         Aht1R3jWfSuwuXxKnLuQhQGNs2jW9NZ5FJMXHx4xfV3VCUzKAelPZMclbbwD5GhjrQ
         u3nF23awVvh+5ZukDRBwGSBayF8gscVJl7c7/6MlbCsb5hAIPvKghrQuiGILDFUz7p
         jMhkHqbtZ8tAw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8808E21EDD;
        Fri, 31 Mar 2023 22:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v3 0/1] Split bt_iso_qos into dedicated structures
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168030061881.9780.2905721652873874499.git-patchwork-notify@kernel.org>
Date:   Fri, 31 Mar 2023 22:10:18 +0000
References: <20230331153927.35411-1-iulia.tanasescu@nxp.com>
In-Reply-To: <20230331153927.35411-1-iulia.tanasescu@nxp.com>
To:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 31 Mar 2023 18:39:26 +0300 you wrote:
> This patch adds support for additional ISO broadcast QoS parameters,
> that the user can set before performing broadcast procedures
> using an ISO socket.
> 
> This patch splits the "bt_iso_qos" structure into dedicated
> unicast and broadcast structures, so that ISO sockets
> can be configured with dedicated QoS options depending
> on the type of ISO procedures to run.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v3,1/1] Split bt_iso_qos into dedicated structures
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c4d9b99db5a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


