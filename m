Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CAFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Mar 2022 17:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbiCZRNn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Mar 2022 13:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234837AbiCZRNf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Mar 2022 13:13:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCFC3C4B6
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Mar 2022 10:10:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 054EE60F9F
        for <linux-bluetooth@vger.kernel.org>; Sat, 26 Mar 2022 17:10:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 67095C340F3;
        Sat, 26 Mar 2022 17:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648314610;
        bh=CQXu/B348T82En33bCUAp1U92pHQaMHzt5sc8Omed3I=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ZzTZ5VhNfiDHMlt+ZFOCCqLmdzDRxt8YIlfRqQIymppHDPH7P4whTh9kWIQPj+TdB
         7om1GWTl6U6za+tVZGa2tJ2x72AbYAk1lk1JsmoxA00nYcVWVF40gch1KvLyvWZnrq
         OnxujYbp+w8+egCKtIMUUgnrWOS+y2LUsahSSirCryHuhPpWxhvH+//1O57wTmI/0h
         64GGQKta9LBZkKD2IEUzEwMUfpbXfIO7UX9BlUUMotMPkBk7rc6xziCVS/vyjZmmXG
         X+6dmDlaS2kSOPqN1zMbyA0OjYGhfgHhnQWG/Fj5ktL/wtpblMO+Yfb470NG0xej+G
         4zu8AP7Bey2CQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 43551F03843;
        Sat, 26 Mar 2022 17:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2] mesh: Fix address overrun error in rx filter
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <164831461027.13360.7891839260901344422.git-patchwork-notify@kernel.org>
Date:   Sat, 26 Mar 2022 17:10:10 +0000
References: <20220325234625.24642-1-inga.stotland@intel.com>
In-Reply-To: <20220325234625.24642-1-inga.stotland@intel.com>
To:     Inga Stotland <inga.stotland@intel.com>
Cc:     brian.gix@intel.com, linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Brian Gix <brian.gix@intel.com>:

On Fri, 25 Mar 2022 16:46:25 -0700 you wrote:
> This fixes the following error for invalid read access when registering
> filter for incoming messages:
> 
> 140632==ERROR: AddressSanitizer: stack-buffer-overflow on address...
>  #0 0x7f60c185741d in MemcmpInterceptorCommon(...
>     #1 0x7f60c1857af8 in __interceptor_memcmp (/lib64/libasan.so...
>     #2 0x55a10101536e in find_by_filter mesh/mesh-io-unit.c:494
>     #3 0x55a1010d8c46 in l_queue_remove_if ell/queue.c:517
>     #4 0x55a101014ebd in recv_register mesh/mesh-io-unit.c:506
>     #5 0x55a10102946f in mesh_net_attach mesh/net.c:2885
>     #6 0x55a101086f64 in send_reply mesh/dbus.c:153
>     #7 0x55a101124c3d in handle_method_return ell/dbus.c:216
>     #8 0x55a10112c8ef in message_read_handler ell/dbus.c:276
>     #9 0x55a1010dae20 in io_callback ell/io.c:120
>     #10 0x55a1010dff7e in l_main_iterate ell/main.c:478
>     #11 0x55a1010e06e3 in l_main_run ell/main.c:525
>     #12 0x55a1010e06e3 in l_main_run ell/main.c:507
>     #13 0x55a1010e0bfc in l_main_run_with_signal ell/main.c:647
>     #14 0x55a10100316e in main mesh/main.c:292
>     #15 0x7f60c0c6855f in __libc_start_call_main (/lib64/libc.so.6+...
>     #16 0x7f60c0c6860b in __libc_start_main_alias_1 (/lib64/libc.so.6+...
>     #17 0x55a101003ce4 in _start (/home/istotlan/bluez/mesh/bluetooth-m...
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2] mesh: Fix address overrun error in rx filter
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=2a2b027176d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


