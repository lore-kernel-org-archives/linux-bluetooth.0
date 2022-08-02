Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A93DC00140
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Aug 2022 19:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiHBTuV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Aug 2022 15:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiHBTuT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Aug 2022 15:50:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1102BCB
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Aug 2022 12:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA2A2B82088
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Aug 2022 19:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B3D1C433B5;
        Tue,  2 Aug 2022 19:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659469815;
        bh=OQ3s3YJsQHJgcwMINfoUnd/DYqDGlKMLXenFS/7a0kU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XQ5lak3N4lnTa2JaiBV7kHOz3xasoSa0DIECEY2iFESKfDRdnTnZ2pyIiWj41ru8U
         8GVms9gMmyRVfKrVus2nHPdy7UR7mOhIltFpY4oIjSl7Jq/8hCIhGiNZdgF1g6nPM6
         cjTR35lD3i4vMT1Z9s9tU6hVf9UyvlXWAO39SYCUgkM/vIbbO+NHEhTVPWuQTaz2Fx
         BIuxQK8TE8c5LBztwMEQUB3KzUdGy6fj4AbD9qNCT5CvS8/nXELYqhFpIYdDM+IUU0
         aacJe9tyieUfe4+vHbVwarXbz7Nv90GdYnRMp+wgUvceHgOKp6SfEb3GyIJpd/XdCo
         iPAwbq/QTyVDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 622F7C43144;
        Tue,  2 Aug 2022 19:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] device: Fix not auto-connecting profile
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165946981539.12327.7263801700842697082.git-patchwork-notify@kernel.org>
Date:   Tue, 02 Aug 2022 19:50:15 +0000
References: <20220801222113.2269509-1-luiz.dentz@gmail.com>
In-Reply-To: <20220801222113.2269509-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon,  1 Aug 2022 15:21:13 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If the profile is registered and marked to auto-connect it shall
> automatically be connected whenever a device is already connected.
> 
> Fixes: https://github.com/bluez/bluez/issues/370
> 
> [...]

Here is the summary with links:
  - [BlueZ] device: Fix not auto-connecting profile
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d06b4a6b74d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


