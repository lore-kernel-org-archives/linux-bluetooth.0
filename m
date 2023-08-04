Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484A5C001DB
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 22:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjHDWu1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 18:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjHDWu0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 18:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1F14EED
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 15:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5DD826213C
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 22:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C769EC433C9;
        Fri,  4 Aug 2023 22:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691189423;
        bh=ISLA2eKjYP4zE9kwTPCUlGnj6X6pHbBpr0sVxgrfUss=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OqourbXHjQS+xbN1Hc850HNMq1xsxGwUJyoRmxI7RoG9ctPHgxyYE63/wN5NUpnZA
         x7vSMOPVbqOGiqbjOeJ9ww7w4/2LDxGx1fJUo5HB0mcv0clahXlBieTvDd1FsrfwTk
         6pG1ZFaf94+1WRZoar3evwE1rt8dTdZf28DsVsdWh9XpqUVQ69CB/XaH3UE1XYOE0m
         kTbCuoOog1MtqRFbhGZzfzz1o75JnC0ug86vDph3DeKBXBem1tQZ1cN8plEpEywZw0
         mxBzu2/FwOmWHU1jVU273SN2SHNXHSMce98IpF7X+hJL8eWs8iGSRmgdT/TBQowO8c
         e7m6yB8gAJUrA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A892DC64458;
        Fri,  4 Aug 2023 22:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RFC 0/6] Locking in hci_sync
From:   patchwork-bot+bluetooth@kernel.org
Message-Id: <169118942368.8518.9843355036673015644.git-patchwork-notify@kernel.org>
Date:   Fri, 04 Aug 2023 22:50:23 +0000
References: <cover.1690399379.git.pav@iki.fi>
In-Reply-To: <cover.1690399379.git.pav@iki.fi>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 27 Jul 2023 00:25:20 +0300 you wrote:
> The current guarantees that a given hci_conn is not freed concurrently
> appear to be:
> 
> - hci_dev_lock is held, or,
> - rcu_read_lock is held  (doesn't guarantee valid conn state), or,
> - hci_conn_get refcount held (doesn't guarantee valid conn state),
> - current task is running from hdev->workqueue (which is ordered)
> 
> [...]

Here is the summary with links:
  - [RFC,1/6] Bluetooth: hci_conn: hci_conn_cleanup is not needed, combine with del
    (no matching commit)
  - [RFC,2/6] Bluetooth: hci_conn: add hci_conn_is_alive
    (no matching commit)
  - [RFC,3/6] Bluetooth: hci_sync: add hci_conn_sync_queue and hci_cmd_sync_dev_(un)lock
    (no matching commit)
  - [RFC,4/6] Bluetooth: hci_sync: fix locking in hci_conn_abort and hci_disconnect_all_sync
    (no matching commit)
  - [RFC,5/6] Bluetooth: hci_sync: delete CIS in BT_OPEN/CONNECT/BOUND when aborting
    (no matching commit)
  - [RFC,6/6] Bluetooth: ISO: handle bound CIS cleanup via hci_conn
    https://git.kernel.org/bluetooth/bluetooth-next/c/2dfe76d58d3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


