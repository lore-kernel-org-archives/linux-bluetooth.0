Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C52C19F29
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Aug 2022 21:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234981AbiHAVP5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233378AbiHAVPu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Aug 2022 17:15:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8E910CC
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 14:15:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E31AB8172C
        for <linux-bluetooth@vger.kernel.org>; Mon,  1 Aug 2022 21:15:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC66FC433B5;
        Mon,  1 Aug 2022 21:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659388546;
        bh=1OoiG0ZQZ0mG7V3JpmP+wA3GwUY6yR+4wxoVVbBSs7g=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Hgv7BrOpXVWlX+U/yeNeTjlAxNTlN7DpZFut0ceYKXDkbTqQlBYE5GZ+dEWi5jqph
         90xQ8nNUGDaveHu11p9HZMYq2tMzSC/Kk5o73X6/rS6kP/y+vF575VCf8spVuvsitf
         yb2PA7VFh0hKyfQ8YdbYUe1vdeH91TCkkZQpumccytP6o8ni4GtEkC13S0xw2zSINf
         zn+AHZxe5ilMtWR69b8C/R0z9OhZibATPo669Sws2DtmJ6Yc6DJ/fFfkgjNkrwomjg
         fW1on04TMZ+YW+lVvQzaGJNKaDMDeSAUCvJhMjwOXKHcPnBV1LwweYnv5G7Sn9twvr
         SxZMk1kzUJCDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D9FBC43143;
        Mon,  1 Aug 2022 21:15:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix use-after-free caused by
 l2cap_chan_put
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165938854657.17345.8294073123741026578.git-patchwork-notify@kernel.org>
Date:   Mon, 01 Aug 2022 21:15:46 +0000
References: <20220721161050.305799-1-luiz.dentz@gmail.com>
In-Reply-To: <20220721161050.305799-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 21 Jul 2022 09:10:50 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following trace which is caused by hci_rx_work starting up
> *after* the final channel reference has been put() during sock_close() but
> *before* the references to the channel have been destroyed, so instead
> the code now rely on kref_get_unless_zero/l2cap_chan_hold_unless_zero to
> prevent referencing a channel that is about to be destroyed.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: L2CAP: Fix use-after-free caused by l2cap_chan_put
    https://git.kernel.org/bluetooth/bluetooth-next/c/d0be8347c623

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


