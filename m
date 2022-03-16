Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1E5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Mar 2022 14:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351574AbiCPObd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Mar 2022 10:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351845AbiCPObc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Mar 2022 10:31:32 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A8984C413
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Mar 2022 07:30:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 931D2CE1FD7
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Mar 2022 14:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0082C340EC;
        Wed, 16 Mar 2022 14:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647441014;
        bh=fApZ/55qJKekdpOH2ZDemZX8qmjaczi86ePXbWuWdzw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=oq8KTnG1Pcfj1lnX/bU2075GkZAMV25QL9J2YRFPD53lbC6bqiCAaN4M7LpJdrMTE
         rKR/27HGf/+FWhoSrnAh6v1u3bM2PPAbbZQr7UWGfVJqOiIF/g9GIepNEpqYXPi8gK
         QKi7c2hyFuhCwDZshM5D7Zvb27ykGnOuroL/KhERk4KT8reDOjLIDLMPameeoYkWb1
         YW72xJrN2/1+2+meNq8KPYytwuuE9OCGYU4HkH4a23ebXaUpxJOzXCfnzMkZNv0LHr
         dJVW075+NIWXDYfNUbldc0Q7QjWXkHtufJMg0oDrbxhm8FX8+saMxOixKi6LByLHJG
         QFwjV5PdzU9rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9E012F03844;
        Wed, 16 Mar 2022 14:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: fix incorrect nonblock bitmask in
 bt_sock_wait_ready()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164744101464.26276.11768502385839741285.git-patchwork-notify@kernel.org>
Date:   Wed, 16 Mar 2022 14:30:14 +0000
References: <20220314224252.3166367-1-gavin@matician.com>
In-Reply-To: <20220314224252.3166367-1-gavin@matician.com>
To:     Gavin Li <gavin@matician.com>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
        linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Marcel Holtmann <marcel@holtmann.org>:

On Mon, 14 Mar 2022 15:42:52 -0700 you wrote:
> From: Gavin Li <gavin@matician.com>
> 
> Callers pass msg->msg_flags as flags, which contains MSG_DONTWAIT
> instead of O_NONBLOCK.
> 
> Signed-off-by: Gavin Li <gavin@matician.com>
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: fix incorrect nonblock bitmask in bt_sock_wait_ready()
    https://git.kernel.org/bluetooth/bluetooth-next/c/f09ab95cfdb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


