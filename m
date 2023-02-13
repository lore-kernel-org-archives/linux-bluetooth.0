Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F9BC636CC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Feb 2023 20:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjBMUaV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Feb 2023 15:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBMUaU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Feb 2023 15:30:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B34E1BC0
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 12:30:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C4ACB81613
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 20:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2463C4339B;
        Mon, 13 Feb 2023 20:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676320217;
        bh=BQwu19x2N0Wgsxfub2VunC1j+B+QZzQdihqJ+H2JNXc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EF+JXghSJIgoUOIloFg/qAn0nq7/ys2GDr/0xf4ppYu8Hgp0+BZ1fTzmke1zdXI7m
         BoklR3RRsxsPu+CPFEa40pVlE7I1oRrWyKCBFSYX6/1CZSRKt6TseIjsHa4AYMJEnM
         RatqE6IKnTugN75SYIDW1vrSJlq7zPpnQgI0c8mqMH1t8sEsNJ++JC+FJ3kb4CdY0f
         3q9pbfrQVViWc724UBoS7yeWM3eKY+abMp8lP1sBimVHAam7InDWQpV8pwhQ+NoQ7s
         yoawomkgQV/ljlopXvcgnCsZu666AFJN5ZXPZM5GqlTccFFPtoeI3h2GygGATnZ13J
         jGLnn/a3lsf7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0A0FC41676;
        Mon, 13 Feb 2023 20:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH BlueZ v2 1/2] shared/bap: fix local endpoint state to be
 per-client
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <167632021691.5042.13756008658007120614.git-patchwork-notify@kernel.org>
Date:   Mon, 13 Feb 2023 20:30:16 +0000
References: <a0b0c0b71c0bbf0e200fd01619901bc5fa00e531.1676145318.git.pav@iki.fi>
In-Reply-To: <a0b0c0b71c0bbf0e200fd01619901bc5fa00e531.1676145318.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluez.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 11 Feb 2023 19:55:52 +0000 you wrote:
> ASCS v1.0 Sec. 4.1: "For each ASE characteristic (distinguished by their
> attribute handles), the server shall expose separate ASE characteristic
> values for each client."  In shared/bap.c, the ASE chrc value is
> contained in bt_bap_endpoint struct.
> 
> As implemented currently, the same local ASE chrc value is shared
> between all clients, in contradiction with the above.  Namely, the
> bt_bap_endpoint is looked up based on the gatt_db_attribute handles, in
> bap_get_endpoint and bap_get_endpoint_id, but the handles correspond to
> the ASCS registrations, and do not depend on which client is in
> question.
> 
> [...]

Here is the summary with links:
  - [BlueZ,v2,1/2] shared/bap: fix local endpoint state to be per-client
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=f56205e30564
  - [BlueZ,v2,2/2] media: clear the right transport when clearing BAP endpoint
    https://git.kernel.org/pub/scm/bluetooth/bluez.git/?id=7b1b1a499cf3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


