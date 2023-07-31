Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB32C00528
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Jul 2023 17:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbjGaRub (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Jul 2023 13:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjGaRu1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Jul 2023 13:50:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676B095
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 10:50:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 814B16126D
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Jul 2023 17:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 78676C433D9;
        Mon, 31 Jul 2023 17:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690825824;
        bh=xUanpwl2W/ELRk/9rli6bY4ENAS/7JxcJVhx3D75nTc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RjIUqPkbYHxFO1vIn5pM4MarCkuTtdRNzBqN063HIeUArND/gRmVK3cF3V0gaeUE9
         vahVg3D/Ii6TMNKToeQ5UsMHW5fMHdsg7r94HG+GrSRAYn33SN8x94dM/3YWo57g1A
         U752j56tGoFEcda4GJKa5co2Tp21g+hZ+cFoN/AttonX0wBmDVZhzQcEpa2xJACFNa
         Oj4OsXDqp1HawPZhlKacl7//sBbjTjKHZenWk3NVUMsy1s1/ISupzdqL6Cdg5WAWnb
         Z9wPuSpICRMoes21tZ7Oj8UYGW/k7TNeqn0Gew+P3UUReWiRoc7bi7CumVswv8pZco
         JJjKmbc9++GpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58A8CC64458;
        Mon, 31 Jul 2023 17:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] main: Fix a logical error within parse_config_int()
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169082582435.13999.16530650273299454723.git-patchwork-notify@kernel.org>
Date:   Mon, 31 Jul 2023 17:50:24 +0000
References: <1690789604-3576-1-git-send-email-quic_zijuhu@quicinc.com>
In-Reply-To: <1690789604-3576-1-git-send-email-quic_zijuhu@quicinc.com>
To:     Zijun Hu <quic_zijuhu@quicinc.com>
Cc:     luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 31 Jul 2023 15:46:44 +0800 you wrote:
> Fix a logical error within parse_config_int().
> ---
>  src/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [v1] main: Fix a logical error within parse_config_int()
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=446d8ada5790

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


