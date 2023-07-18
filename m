Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53896EB64DC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Jul 2023 19:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjGRTpx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Jul 2023 15:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGRTpw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Jul 2023 15:45:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4039F198D;
        Tue, 18 Jul 2023 12:45:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE15360B68;
        Tue, 18 Jul 2023 19:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F86C433C7;
        Tue, 18 Jul 2023 19:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689709550;
        bh=94qN7IxSeuyb7pEQYiFkSuDjUouVRsu/gsID7UmjLsE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rPsOyVA7/PABWabDCwLsaJiEIzold1feSFOLd21VdtYtOmwg1+MgFTrfFdEahbjYJ
         cLKYT3VnO/S1zyb/kSuQCOrfEj2+TTkZraKhOCmqOz7SxvgkZZzCg2T4I+ZIGglZE6
         iOvWaFfax7yREr2Rb5KVySLopQr7jEoSEy1VQ4eFwSjfwpEEyMlQdP0oJP1v2nbMuP
         PMASQvA5uda3+QGF34YE0F+/yIkDGstbhXLzItw5KzpJag7oKSCFuKWjaFzuIDeJ+y
         LRweB2pzUFC+Eps48Ag9TS9taTyfjFXIp8FF9/1pwP8msO0bl3MrgYsSLor9GoBIko
         a+o/frAWTgHeA==
Date:   Tue, 18 Jul 2023 12:45:48 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     syzbot <syzbot+c19afa60d78984711078@syzkaller.appspotmail.com>
Cc:     davem@davemloft.net, hdanton@sina.com, jiri@nvidia.com,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [bluetooth?] general protection fault in
 hci_uart_tty_ioctl
Message-ID: <20230718124548.7b1d3196@kernel.org>
In-Reply-To: <00000000000077b5650600b48ed0@google.com>
References: <00000000000049baa505e65e3939@google.com>
        <00000000000077b5650600b48ed0@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Mon, 17 Jul 2023 13:22:24 -0700 syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit d772781964415c63759572b917e21c4f7ec08d9f
> Author: Jakub Kicinski <kuba@kernel.org>
> Date:   Fri Jan 6 06:33:54 2023 +0000
> 
>     devlink: bump the instance index directly when iterating

Hm, don't think so. It's not the first issue where syzbot decided
this commit was the resolution. I wonder what makes it special.
