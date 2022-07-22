Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764D1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jul 2022 20:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbiGVUkU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Jul 2022 16:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiGVUkT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Jul 2022 16:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7060C13F5B
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 13:40:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F06FE61F6A
        for <linux-bluetooth@vger.kernel.org>; Fri, 22 Jul 2022 20:40:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38CF5C341C7;
        Fri, 22 Jul 2022 20:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658522417;
        bh=GqkZ+oBTYZWWwHbdveAHsN5BU2/KVJ+M9FEZZJMmYCI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=CuqqeGiAp+gBf/aN9gSCrTHXnlrbt2FBJRc4U2dEn3mgzzlHyCX0teRo1n1hpD7ye
         K95rHnL+zIDCArGE4bDQbYLk01ptF+Ij9fLBj7TQSRUI3VNnoOdFU++SCAUcqj60zz
         QoAKMyOfPhd4QgXzm4yn78Ax2of82o4TPpSrRJvslSADFrEM5RF580VKds3NRc7uo0
         4EFUmiEFDxCw7Hn6sUbAK+QP5hAmK3GcbkoSNwYvcOpWJNsIh1zLk6OYIJ5+bKR8Wv
         mGDYQ8Kswga69ftNVv6ih2ysqmGml9uav5DcT0qlnGuB6PaYE9IpOrptC0IMBNtfqo
         ozFmTjrDI/Wug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20EDDE451BB;
        Fri, 22 Jul 2022 20:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [BlueZ PATCH v8 1/8] lib: Add definitions for ISO socket
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165852241713.788.6962201186413090937.git-patchwork-notify@kernel.org>
Date:   Fri, 22 Jul 2022 20:40:17 +0000
References: <20220630221452.638591-1-luiz.dentz@gmail.com>
In-Reply-To: <20220630221452.638591-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Jun 2022 15:14:45 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> ---
> v2: Fix CI findings.
> v3: Add patch fixing mgmt-tester Read EXP Features tests.
> v4: Rebase and add flag EXP_FEAT_ISO_SOCKET
> v5: Add BT_DEFER_SETUP tests to iso-tester
> v6: Make iso-tester disable ISO Socket experimental UUID after each test
> v7: Fix scan-build findings
> v8: Add tests Defer and Defer send which use DEFER_SETUP when connecting which
> emulates the QoS state of BAP where a SetCIGParameter shall be used without
> CreateCIS which is left to just Enabling state.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v8,1/8] lib: Add definitions for ISO socket
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b031e4dc8c4e
  - [BlueZ,v8,2/8] shared/util: Decode BlueZ Experimental ISO Socket UUID
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=cc482ad3780b
  - [BlueZ,v8,3/8] mgmt-tester: Fix Read Exp Feature tests
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=9c65bad7a878
  - [BlueZ,v8,4/8] adapter: Add support for setting ISO Socket experimental feature
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8dc5b5e1ba6b
  - [BlueZ,v8,5/8] btio: Add support for ISO sockets
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=b1b575cf1720
  - [BlueZ,v8,6/8] tools: Add iso-tester
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=26ee34d7be40
  - [BlueZ,v8,7/8] tools: Add isotest tool
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=037ed8c5b12a
  - [BlueZ,v8,8/8] isotest: Add documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=4314f7066721

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


