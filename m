Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13275C04AA5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 Aug 2022 21:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239045AbiHXVkV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 Aug 2022 17:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbiHXVkT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 Aug 2022 17:40:19 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC39C26563
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Aug 2022 14:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6CC11B82568
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Aug 2022 21:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08B0EC43470;
        Wed, 24 Aug 2022 21:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661377216;
        bh=3tRHGnXwef0+kvLuOBmdchMkRvsPOCOUMHchuIzGk4k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=n8b80YnGcHyQlSVBmcg8jf2EC8NNAjltHf/Ndnz687VRFNb3fec3aYHjOj3OoS94n
         G05Y4C+Bbn9VCiueaZXDfmXq12eEYdupYqzrH2Mm3AC5IWoXwU7rPu9IuVR68DEpLc
         94r0V5kZcZYmyVunukvsSeJU2hVCkjkSznB2/imH1DOoKJURBObJZY9fbjcmLAqe/i
         AUtR20c9f3rGq+RQ1Iv+0EKHWBsrsWB4GZvSGS6zlcMGH4GCk6cLwE1jB3a4YRzYzP
         EyTT2ndfMoK+LzdvNstZa4RkeoyoMhBvFGXQiIqARD1kLzHTey6ARrA4KesdwCiCCw
         eGlvGrVYcFnsA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D5FEAC04E59;
        Wed, 24 Aug 2022 21:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [Bluez PATCH v2] adapter: Reset pending settings when receiving MGMT
 error
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <166137721586.21154.3235149800377928190.git-patchwork-notify@kernel.org>
Date:   Wed, 24 Aug 2022 21:40:15 +0000
References: <20220823121541.Bluez.v2.1.I541cbea9d6295f531c796bf3bda96b22db76bc19@changeid>
In-Reply-To: <20220823121541.Bluez.v2.1.I541cbea9d6295f531c796bf3bda96b22db76bc19@changeid>
To:     Archie Pusaka <apusaka@google.com>
Cc:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, chromeos-bluetooth-upstreaming@chromium.org,
        apusaka@chromium.org, sonnysasaka@chromium.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 23 Aug 2022 12:15:56 +0800 you wrote:
> From: Archie Pusaka <apusaka@chromium.org>
> 
> We set the pending settings flag when sending MGMT_SETTING_*
> commands to the MGMT layer and clear them when receiving a
> successful reply, but we don't clear them when receiving an error
> reply. This might cause a setting to be stuck in pending state.
> 
> [...]

Here is the summary with links:
  - [Bluez,v2] adapter: Reset pending settings when receiving MGMT error
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=ede7b915980f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


