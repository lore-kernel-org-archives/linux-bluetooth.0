Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A96C77B6C
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 22:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbjCaWKZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 18:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbjCaWKW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 18:10:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 683E759E9
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 15:10:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F13AB83288
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 22:10:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4250C433A1;
        Fri, 31 Mar 2023 22:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680300618;
        bh=fyMUA0UI8Es3AcJoP4LdIf1vZnAMJCuyDP4PDQeltsA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qAoICM8tFqvkCyjKYuet4hj3caF1yPfUWhtpDWTY537K9mJUDYKijOpEMaYgRkwtm
         FLPo2bs9ldBpJc0+QSOYVTwoDYmBK5J0fcZy7//niFY6GXAU4GTH0G5MGbEaSbRcbY
         eL4/nPlOZmpPOu/q8mx3KVAEP/NDeL29FkFLawJeW4lZLRczPAH/JAY6DYraKG1/v8
         G4QjKwOgNnfYa+evhRHtRR6IL85V0jNKuKua3V3NsNe+SbEW1MRvnUvgiXiA7UmV+L
         DGJij4oCDRTdVY4sgW5dJ0NqMB0qu2MCsFqNAxi6Nb7wTEcLOwiZa/3ed7iZLIpy1l
         0iOiYSmvp+zjw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C0815C0C40E;
        Fri, 31 Mar 2023 22:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ] avrcp: Fix crash while handling unsupported events
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <168030061878.9780.9987417728326612378.git-patchwork-notify@kernel.org>
Date:   Fri, 31 Mar 2023 22:10:18 +0000
References: <20230330234425.1064422-1-luiz.dentz@gmail.com>
In-Reply-To: <20230330234425.1064422-1-luiz.dentz@gmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 30 Mar 2023 16:44:25 -0700 you wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> The following crash can be observed if the remote peer send and
> unsupported event:
> 
> ERROR: AddressSanitizer: heap-use-after-free on address 0x60b000148f11
>  at pc 0x559644552088 bp 0x7ffe28b3c7b0 sp 0x7ffe28b3c7a0
>  WRITE of size 1 at 0x60b000148f11 thread T0
>      #0 0x559644552087 in avrcp_handle_event profiles/audio/avrcp.c:3907
>      #1 0x559644536c22 in control_response profiles/audio/avctp.c:939
>      #2 0x5596445379ab in session_cb profiles/audio/avctp.c:1108
>      #3 0x7fbcb3e51c43 in g_main_context_dispatch (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x55c43)
>      #4 0x7fbcb3ea66c7  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xaa6c7)
>      #5 0x7fbcb3e512b2 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x552b2)
>      #6 0x559644754ab6 in mainloop_run src/shared/mainloop-glib.c:66
>      #7 0x559644755606 in mainloop_run_with_signal src/shared/mainloop-notify.c:188
>      #8 0x5596445bb963 in main src/main.c:1289
>      #9 0x7fbcb3bafd8f in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
>      #10 0x7fbcb3bafe3f in __libc_start_main_impl ../csu/libc-start.c:392
>      #11 0x5596444e8224 in _start (/usr/local/libexec/bluetooth/bluetoothd+0xf0224)
> 
> [...]

Here is the summary with links:
  - [BlueZ] avrcp: Fix crash while handling unsupported events
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f54299a85067

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


