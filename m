Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F69EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 22:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjFUWK2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 18:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjFUWK1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 18:10:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610F419A2
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 15:10:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3EC4616F7
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 22:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A11FC433CA;
        Wed, 21 Jun 2023 22:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687385425;
        bh=Pa9xDj9Bb2+ddL/0zDH+fTrezTw62A7AmSa79iKmp/k=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=YW+oIenZssdmb7pJSRwVTz/yGfxHpqNvplnypW9m2+BtBe6KJHU9wjEmh3Yqstzuv
         LWgntGwmibBG5oOa03h3ZVjoG+kELGaQfaNHq8KvqNbzhIA+sIHule1Y7ilQU9IkrP
         wQUqhBrOQI8eqSIyr36dwnuBR0dcQVMrMTBiuuukGbpzrGRP482fC7Bc4U3VSYBPOU
         8fZuFfsnszYBT5KlVNW4CcKUNjXYTEV++IuSo7O9ifAAG7Q+FX/DZVMsMesLweAHCC
         MzfcP6K9vk1Y/4Sx2QWvHKSun+ErGGxJBjLN4o9g8MCeuBd3T3kWBEovNM8HpxiZ3Y
         OF4oI3LGeltuw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34751E4D027;
        Wed, 21 Jun 2023 22:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ 1/3] mgmt-api: Update Device Found Event documentation
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168738542521.32529.13902091080525146600.git-patchwork-notify@kernel.org>
Date:   Wed, 21 Jun 2023 22:10:25 +0000
References: <20230620204053.643608-1-luiz.dentz@gmail.com>
In-Reply-To: <20230620204053.643608-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 20 Jun 2023 13:40:51 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This updates Device Found Event documentation to mention the new flag
> introduced to track when the event is generated due a interleaved Scan
> Response that couldn't be merged.
> ---
>  doc/mgmt-api.txt | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [BlueZ,1/3] mgmt-api: Update Device Found Event documentation
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=98383b917a43
  - [BlueZ,2/3] monitor: Add missing flags to MGMT Device Found Event
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=741a04aba0c3
  - [BlueZ,3/3] adapter: Handle Device Found Event with Scan Response flag
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=c8235156c31b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


