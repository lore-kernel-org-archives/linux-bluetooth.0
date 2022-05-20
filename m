Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788CDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 May 2022 21:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346297AbiETVUO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 May 2022 17:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbiETVUN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 May 2022 17:20:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F4519C752
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 14:20:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B683061D71
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 21:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 237A7C34115;
        Fri, 20 May 2022 21:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653081612;
        bh=nt+vj4pxFn3V+Awukk8qgK5cwC/k2L2Oreo+pabLfZM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tT0M5N8f0KCuWtXRi02FHjBtFRrRdUPMzVQI9WXuT2G7mCFpLNKq1b/HZ2T/+2ObU
         HaRX8Uo0ibmBDdKp1ZGJ3TbgeYR/dKWwGQo1M9w2Cd0IwIe0vQSzQCyNDeWuZR8t7Q
         oKFmdV5hKWY6qCP4Cm5YZyZ55TvUYZNbs9ivf93XkIb94Uao6uZOq09V0giz04f+1a
         PqkDBVGNJv+iiVLhKhuIIJwsnnRWdWuTE5hY/ULQVAEtM05Rx1PEANsxeNLcfLHIOR
         D8UOwlssGJLj9yozroEMrRUWEwgeR7z7rFv71N8Vi20deqIjfszRjdZelGeBQeGxPV
         vjhuf+R1Hfylw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0192FF03937;
        Fri, 20 May 2022 21:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] gatt-server: Fix crash while disconnecting
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <165308161200.31176.4427175768508209959.git-patchwork-notify@kernel.org>
Date:   Fri, 20 May 2022 21:20:12 +0000
References: <20220519214002.2525857-1-luiz.dentz@gmail.com>
In-Reply-To: <20220519214002.2525857-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 19 May 2022 14:40:02 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> If there is a pending notify multiple the code was not removing before
> freeing the object causing the following crash:
> 
> Invalid read of size 8
>    at 0x4A3D10: notify_multiple (gatt-server.c:1703)
>    by 0x4D05F0: timeout_callback (timeout-glib.c:25)
>    by 0x4956900: ??? (in /usr/lib64/libglib-2.0.so.0.7000.5)
>    by 0x49560AE: g_main_context_dispatch
>    (in /usr/lib64/libglib-2.0.so.0.7000.5)
>    by 0x49AB307: ??? (in /usr/lib64/libglib-2.0.so.0.7000.5)
>    by 0x49557C2: g_main_loop_run
>    (in /usr/lib64/libglib-2.0.so.0.7000.5)
>    by 0x4D0A34: mainloop_run (mainloop-glib.c:66)
>    by 0x4D0F2B: mainloop_run_with_signal (mainloop-notify.c:188)
>    by 0x2B0CD1: main (main.c:1276)
>  Address 0x6ca35c8 is 136 bytes inside a block of size 144 free'd
>    at 0x48470E4: free (vg_replace_malloc.c:872)
>    by 0x415E73: gatt_server_cleanup (device.c:698)
>    by 0x415E73: attio_cleanup (device.c:715)
>    by 0x47745B: queue_foreach (queue.c:207)
>    by 0x490C54: disconnect_cb (att.c:701)
>    by 0x4CF4AF: watch_callback (io-glib.c:157)
>    by 0x49560AE: g_main_context_dispatch
>    (in /usr/lib64/libglib-2.0.so.0.7000.5)
>    by 0x49AB307: ??? (in /usr/lib64/libglib-2.0.so.0.7000.5)
>    by 0x49557C2: g_main_loop_run
>    (in /usr/lib64/libglib-2.0.so.0.7000.5)
>    by 0x4D0A34: mainloop_run (mainloop-glib.c:66)
>    by 0x4D0F2B: mainloop_run_with_signal (mainloop-notify.c:188)
>    by 0x2B0CD1: main (main.c:1276)
> 
> [...]

Here is the summary with links:
  - [BlueZ] gatt-server: Fix crash while disconnecting
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f1069c4fe106

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


