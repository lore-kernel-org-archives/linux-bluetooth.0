Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA34CCE79A9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Sep 2023 19:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbjISTUf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Sep 2023 15:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjISTUd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Sep 2023 15:20:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E7F128
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 12:20:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 850D9C43391;
        Tue, 19 Sep 2023 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695151225;
        bh=DFAVVhQoifkm+qys3f7F+OLxGUywxmB/bcieoPxynTA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Eum/NnwoVACpCxW/eh3NiH/ZlFKpwbZANaAAsL6qSZQQkloS/V+HHwGFSfiLsXT/b
         Hv5ui2I2mQHHmL3H2lh3ScFCeCQ/gMT7Q1sT4Q/uGi49tVld0iuAOdsevlU2fZ3MS3
         353SJZVkpNqy1tQRF+SIQYojcqIVrouzDrLRfrOKmgkRQEjE/NmhLSe9UobHdptQPS
         FdrRZxrVLI5PRaov1yW+xnGQTA8CidY8CkMvk38U/fcI/59dDrbNLIfwqXL3X907XE
         rItNXJC6f25IO0ossHGWuA30jdlYwIeQnEvHDJ19sZetIm/hobJv/mD7OKxQtUXI8V
         BKZupFm7vBCgQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E32DE1F671;
        Tue, 19 Sep 2023 19:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] shared/log: Fix not checking vasprintf return
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169515122544.29274.10299509749862719582.git-patchwork-notify@kernel.org>
Date:   Tue, 19 Sep 2023 19:20:25 +0000
References: <20230918212219.190667-1-luiz.dentz@gmail.com>
In-Reply-To: <20230918212219.190667-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Mon, 18 Sep 2023 14:22:19 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> It seems like some implementation of vasprintf set the content of the
> str to NULL rather then returning -1 causing the following errors:
> 
> =================================================================
> ==216204==ERROR: AddressSanitizer: attempting free on address which
> was not malloc()-ed: 0x55e787722cf0 in thread T0
>       #0 0x55e784f75872 in __interceptor_free.part.0 asan_malloc_linux.cpp.o
>       #1 0x55e7850e55f9 in bt_log_vprintf
> /usr/src/debug/bluez-git/bluez-git/src/shared/log.c:154:2
>       #2 0x55e78502db18 in monitor_log
> /usr/src/debug/bluez-git/bluez-git/src/log.c:40:2
>       #3 0x55e78502dab4 in info
> /usr/src/debug/bluez-git/bluez-git/src/log.c:52:2
>       #4 0x55e78502e314 in __btd_log_init
> /usr/src/debug/bluez-git/bluez-git/src/log.c:179:2
>       #5 0x55e78502aa63 in main
> /usr/src/debug/bluez-git/bluez-git/src/main.c:1388:2
>       #6 0x7f1d5fe27ccf  (/usr/lib/libc.so.6+0x27ccf) (BuildId:
> 316d0d3666387f0e8fb98773f51aa1801027c5ab)
>       #7 0x7f1d5fe27d89 in __libc_start_main
> (/usr/lib/libc.so.6+0x27d89) (BuildId:
> 316d0d3666387f0e8fb98773f51aa1801027c5ab)
>       #8 0x55e784e88084 in _start
> (/usr/lib/bluetooth/bluetoothd+0x36084) (BuildId:
> 19348ea642303b701c033d773055becb623fe79a)
>   Address 0x55e787722cf0 is a wild pointer inside of access range of
> size 0x000000000001.
>   SUMMARY: AddressSanitizer: bad-free asan_malloc_linux.cpp.o in
> __interceptor_free.part.0
>   ==216204==ABORTING
> сен 18 13:10:02 archlinux systemd[1]: bluetooth.service: Main process
> exited, code=exited, status=1/FAILURE
> 
> [...]

Here is the summary with links:
  - [BlueZ] shared/log: Fix not checking vasprintf return
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=6169001a2b57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


