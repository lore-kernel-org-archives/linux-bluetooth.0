Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D91AC38A2D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Oct 2022 22:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiJYWkZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 25 Oct 2022 18:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbiJYWkU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 25 Oct 2022 18:40:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE765F9A1;
        Tue, 25 Oct 2022 15:40:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C04DFB81F5D;
        Tue, 25 Oct 2022 22:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75E8DC433D6;
        Tue, 25 Oct 2022 22:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666737616;
        bh=3aODH2DC5T4ffwARnZV3TaCrR3IEJusjhm6xQMrFLxY=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Xm95a+2LZZV7nBxsEBelj10KoYvmZ3hYta9uWRw8OUD39gwyB94Sf0FEZGy6o9A18
         wSfGV8Qpuik2w2eyzABjan/ySaNgGgoX1IHOahNS93iSX5FYynqKD9IbEfwJehgCEN
         +7LxJEiwQ3ZoSlp8WK4OOmPNS1E6DhiT+Zokgvxh1+KIunphq+VwVEve8+mDgwZCIn
         8fmE50rV2sL2ctS3dmnTHnFljWG251Q3EbTD69aCaMRzpTWQ1sL20c67J0VjLDWfZP
         Lpu0EUTneh+bClP+2PzsR4l5RqrkbbXzQnWTh53dUOdusib9ja7MkQtNJ+vuMhgM7f
         k7nGU8+ibewpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53C4BE45192;
        Tue, 25 Oct 2022 22:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/1] virtio_bt: Fix alignment in configuration struct
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166673761633.12942.17797973137720417120.git-patchwork-notify@kernel.org>
Date:   Tue, 25 Oct 2022 22:40:16 +0000
References: <20221018173050.581812-1-Igor.Skalkin@opensynergy.com>
In-Reply-To: <20221018173050.581812-1-Igor.Skalkin@opensynergy.com>
To:     Igor Skalkin <igor375@gmail.com>
Cc:     virtualization@lists.linux-foundation.org, luiz.dentz@gmail.com,
        mst@redhat.com, marcel@holtmann.org, johan.hedberg@gmail.com,
        jasowang@redhat.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, Igor.Skalkin@opensynergy.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 18 Oct 2022 19:30:49 +0200 you wrote:
> According to specification [1], "For the device-specific configuration
> space, the driver MUST use 8 bit wide accesses for 8 bit wide fields,
> 16 bit wide and aligned accesses for 16 bit wide fields and 32 bit wide
> and aligned accesses for 32 and 64 bit wide fields.".
> 
> Current version of the configuration structure has non-aligned 16bit
> fields.
> 
> [...]

Here is the summary with links:
  - [v2,1/1] virtio_bt: Fix alignment in configuration struct
    https://git.kernel.org/bluetooth/bluetooth-next/c/57dc0d471d27

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


