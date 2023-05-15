Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D00C7EE24
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 May 2023 19:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243404AbjEOTkW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 May 2023 15:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjEOTkV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 May 2023 15:40:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD12C525A
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 12:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62AB6631E4
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 19:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7C9BC433EF;
        Mon, 15 May 2023 19:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684179619;
        bh=73aVcDy5DJO4wtefwVYOLsdfV59s3hkqH9ihplYu5mw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=XJty7hBSI+AwV5V5K0LrqeOhGeGXJ0bN5fjfjQ9HaSaLJMDzMMX4Uxj3UQqy8+TPO
         oQyjVWnJ+/7jZ3lyaTK5SvjTyuF+2RI2wamnH5ya6pElfcqgWUVFg/h5isc43rWll7
         zV9pfEtKpdqPO9S691ivAq3qZ71dhKNMrdb6TQEgfAs59DM11MZh0nS7yXcc2fx5Ky
         2QcsXJsXmT+iQnFlSfQXimiSf+tfUEjowsCqvA0ooWy8/B92IhQSmgCJIlvvKgWKDS
         4+GLLyQrYdYnQHzNgAhpnJsR85dp0rhnkPz5kdVUox/q/rgxsavJGy+pLqgxxzpfxp
         HExJAoEyn6btA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E6D5E49FAB;
        Mon, 15 May 2023 19:40:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/1] Bluetooth: Check for ISO support in controller
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168417961964.11671.9854954504887799038.git-patchwork-notify@kernel.org>
Date:   Mon, 15 May 2023 19:40:19 +0000
References: <20230510134557.11486-1-claudia.rosu@nxp.com>
In-Reply-To: <20230510134557.11486-1-claudia.rosu@nxp.com>
To:     Claudia Draghicescu <claudia.rosu@nxp.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed, 10 May 2023 16:45:56 +0300 you wrote:
> This patch checks for ISO_BROADCASTER and ISO_SYNC_RECEIVER in controller.
> 
> Claudia Draghicescu (1):
>   Check for ISO_BROADCASTER and ISO_SYNC_RECEIVER bits in adapter's
>     supported features
> 
>  include/net/bluetooth/hci.h      | 1 +
>  include/net/bluetooth/hci_core.h | 1 +
>  include/net/bluetooth/mgmt.h     | 2 ++
>  net/bluetooth/mgmt.c             | 6 ++++++
>  4 files changed, 10 insertions(+)

Here is the summary with links:
  - [v2,1/1] Bluetooth: Check for ISO support in controller
    https://git.kernel.org/bluetooth/bluetooth-next/c/fd4fbf8cd81f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


