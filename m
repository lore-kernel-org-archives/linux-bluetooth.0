Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942ECE743D0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Sep 2023 00:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjI2Aae (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 20:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjI2Aad (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 20:30:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5B26180
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 17:30:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BE89C433CA;
        Fri, 29 Sep 2023 00:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695947429;
        bh=AuJfYMsfdkKHvfyfjsodqih3g5tiJE55EogdBoqbSW0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=H72H6VGK6PpEuvx94yKRYebdCCmm3xkW7u06S9w1knNf0gUTzQq/C51v5JzK62Rg3
         uW/eukqXqoUSwX7TtZA5yIlzbYuhw/iM0ruS9CC5E9885cy0lctyToFklnbaP2Ka79
         nyQZtM3IDWQ4DQAh+yXTX1DAAcLVal9x5Z5Jf4obXkxMMUIPyc8IBWna4lvXMt+Vnm
         5wxLD0z5zMDsIs9BkTY/Y2Y71vcszyaxGZgj3wxJJsaL7ippvkAqJTmoQTTBxYimgE
         wspH9PN4yLsfuCJhtwdaLY7jc3DGNQtldJ1ysTvUfwTv0mHUoiidD2plO8OQYKkxzJ
         658i4KiZm4I0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23006C395E0;
        Fri, 29 Sep 2023 00:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 01/12] media-api: Update to reflect the last code changes
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169594742913.13274.2018551544447448919.git-patchwork-notify@kernel.org>
Date:   Fri, 29 Sep 2023 00:30:29 +0000
References: <20230927215354.1874835-1-luiz.dentz@gmail.com>
In-Reply-To: <20230927215354.1874835-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 27 Sep 2023 14:53:43 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This reflect the last code changes adding the missing Broadcast
> properties.
> ---
>  doc/media-api.rst | 179 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 138 insertions(+), 41 deletions(-)

Here is the summary with links:
  - [v4,01/12] media-api: Update to reflect the last code changes
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=676e8b0cf174
  - [v4,02/12] transport: Implement QoS property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=771b19e1966a
  - [v4,03/12] client: Make transport.show to print QoS configuration
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=d1bb05e3edbc
  - [v4,04/12] media: Implement QoS property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=df75d2f37ca3
  - [v4,05/12] client: Make Endpoint.SelectProperties reply properly
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=1c79a45667e7
  - [v4,06/12] doc/media: Convert media-api.rst into manpages
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=3ca45476faa4
  - [v4,07/12] shared/bap: Add support content and contexts to bt_bap_pac_qos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=a6aac75b410e
  - [v4,08/12] doc/MediaEndpoint: Move QoS capabilities to its own dict property
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=32afb9df424c
  - [v4,09/12] shared/bap: Add support for location and contexts to bt_bap_pac_qos
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=bcd7a6b697aa
  - [v4,10/12] bap: Add support for missing MediaEndpoint properties
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=e932ff330fd0
  - [v4,11/12] client: Make endpoint.show print ISO specific capabilities
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=8e5142a1fad5
  - [v4,12/12] bap: Fix freeing value of dbus_message_iter_get_fixed_array
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2a61791d1679

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


