Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0C0E7AD78
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 17:10:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjJCRKd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 13:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjJCRKc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 13:10:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02A2FA7
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 10:10:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9BBA1C433C8;
        Tue,  3 Oct 2023 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696353027;
        bh=sffx/fc2QiY2yopVmvlFFzi0A5WGVXMiOIaGg2Ta9tc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=MzvXx6hIxkx28nV1ak+KnfgOspASZTTH1MH9rAOg/zTPR9jpdxcAy/u4G3NCXHJGZ
         xzIdSBNUiGXdgRGr/QqD9QoLvIFCilFRL5yRjAVrorjL34o0rrQK+QTrswiUOc3qPq
         mOk3wxbw55FHNTSZQlK9WzyOPDYpkRN9iKQ1peMhqnfve1nKYPBu7HAZLzsZu6x2tN
         UKWYQ8vW2Q5sbEKaEA+MbQMH1VbpKj7xdk0jc2KzJmV42Kei2s1b431N6ntBADU7Jv
         CW9pe4swH4imFNgSi6Zrp4triofP1Npk6M59Atr87isa2v0Fa2TR4THqfxLQAli0+x
         lpolrUHJ7An1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 79A6EE632D1;
        Tue,  3 Oct 2023 17:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] Bluetooth: hci_sync: always check if connection is
 alive before deleting
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169635302749.22624.6754938752814022940.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Oct 2023 17:10:27 +0000
References: <53130b4a5fb21a15f2674c336282d25ef5d2232e.1696077070.git.pav@iki.fi>
In-Reply-To: <53130b4a5fb21a15f2674c336282d25ef5d2232e.1696077070.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 30 Sep 2023 15:53:32 +0300 you wrote:
> In hci_abort_conn_sync it is possible that conn is deleted concurrently
> by something else, also e.g. when waiting for hdev->lock.  This causes
> double deletion of the conn, so UAF or conn_hash.list corruption.
> 
> Fix by having all code paths check that the connection is still in
> conn_hash before deleting it, while holding hdev->lock which prevents
> any races.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] Bluetooth: hci_sync: always check if connection is alive before deleting
    https://git.kernel.org/bluetooth/bluetooth-next/c/32f6776f0083
  - [v2,2/2] Bluetooth: hci_conn: verify connection is to be aborted before doing it
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


