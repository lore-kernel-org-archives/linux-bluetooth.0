Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B239ECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 23:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbiHaXSn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbiHaXSa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:30 -0400
Received: from smtp.github.com (out-26.smtp.github.com [192.30.252.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5491A9C8E5
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 16:18:29 -0700 (PDT)
Received: from github.com (hubbernetes-node-0fa589c.ash1-iad.github.net [10.56.200.62])
        by smtp.github.com (Postfix) with ESMTPA id 7C9DF5E09FF
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 16:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1661987908;
        bh=9nxJjR7UU7zOHJqFiXhmtb8n03BpM66VK0Q8o/zybTE=;
        h=Date:From:To:Subject:From;
        b=rFGp3jkyjh8IW3Y3VxRdbD8qq5gvpxKPwD0aqr9LxBKOQlb00KNlRVr7SbWjaMZhl
         A3QEjfVtWqgLw7zfi/WWAHbXy7bbvey422mZiDHh1XbCos2gKmna2E5plXwQg7ME03
         Aqk9MC5CM3n6jXj4POBgIo8XX/PuvT6Js+f1awuM=
Date:   Wed, 31 Aug 2022 16:18:28 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d04b64-49b8c5@github.com>
Subject: [bluez/bluez] d8febc: client/player: Fix checkpatch warning
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: d8febc76a43fa104457d8167379787949fff8f89
      https://github.com/bluez/bluez/commit/d8febc76a43fa104457d8167379787949fff8f89
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-08-30 (Tue, 30 Aug 2022)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix checkpatch warning

This fixes the following checkpatch warning:

WARNING:LINE_SPACING: Missing a blank line after declarations
216: FILE: client/player.c:625:
+               GDBusProxy *proxy = l->data;
+               print_player(proxy, NULL);


  Commit: f8c3a38e4fe943eaed677a295663426cb7241e0e
      https://github.com/bluez/bluez/commit/f8c3a38e4fe943eaed677a295663426cb7241e0e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-08-30 (Tue, 30 Aug 2022)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Fix scan-build error

This fixes the following error:

src/shared/shell.c:1135:19: warning: Null pointer passed to 1st
parameter expecting 'nonnull'
                        data.timeout = atoi(optarg);
                                       ^~~~~~~~~~~~


  Commit: a84aa0e6e5e7cd94804386eaf09d430d1cf8e692
      https://github.com/bluez/bluez/commit/a84aa0e6e5e7cd94804386eaf09d430d1cf8e692
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-08-30 (Tue, 30 Aug 2022)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: Fix registering PAC endpoints if ISO socket are not supported

If adapter don't support ISO sockets the PAC UUIDs shall not be allowed
to be registered as they depend on ISO sockets to work properly.


  Commit: 49b8c5901584eab77af40f8ad19779747b4506d6
      https://github.com/bluez/bluez/commit/49b8c5901584eab77af40f8ad19779747b4506d6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-08-31 (Wed, 31 Aug 2022)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: Fix scan-build warnings

This fixes the following warnings:

profiles/audio/media.c:1465:6: warning: 8th function call argument
is an uninitialized value
        if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:3012:3: warning: Use of memory after it is freed
                release_endpoint(adapter->endpoints->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
profiles/audio/media.c:3015:3: warning: Use of memory after it is freed
                media_player_destroy(adapter->players->data);
                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


Compare: https://github.com/bluez/bluez/compare/d04b64003d9d...49b8c5901584
