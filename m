Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294D0C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Dec 2022 21:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiLIVb0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Dec 2022 16:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiLIVbY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Dec 2022 16:31:24 -0500
Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274B079CBF
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Dec 2022 13:31:24 -0800 (PST)
Received: from github.com (hubbernetes-node-afe6486.ac4-iad.github.net [10.52.11.145])
        by smtp.github.com (Postfix) with ESMTPA id 75B4B600206
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Dec 2022 13:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1670621483;
        bh=MAlKgHclu/fpYJt8M750032kBmGtBQs8xx2adxgzuhM=;
        h=Date:From:To:Subject:From;
        b=M7KkD8NxtflpR3C2xLdsoF/1o86TOg5DzGOTJOLp9LaxaH1QZnTsU8UDLpF6ZRKPR
         XpM4p5/zrph2xypCYFnF9Vw8ATUOOGQ44LfTUMJF4Poldvfc0Lab1xTWgjMNXp7lsx
         vUCDAvdohXxSr2J1qCwQspaLNxukAb6oKyClTBA4=
Date:   Fri, 09 Dec 2022 13:31:23 -0800
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/758161-3d6e4b@github.com>
Subject: [bluez/bluez] f8670f: shared/att: Fix not requeueing in the same
 channel
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
  Commit: f8670f9aa0a0c60f0d6f246a0eaaa932747140ed
      https://github.com/bluez/bluez/commit/f8670f9aa0a0c60f0d6f246a0eaaa932747140ed
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-09 (Fri, 09 Dec 2022)

  Changed paths:
    M src/shared/att.c

  Log Message:
  -----------
  shared/att: Fix not requeueing in the same channel

If request needs to be resend due to change in the security use the
chan->queue otherwise it may end up using a different channel.


  Commit: 6b5b5139231246e2ea2b2de1120eabe7de1b7bb8
      https://github.com/bluez/bluez/commit/6b5b5139231246e2ea2b2de1120eabe7de1b7bb8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-09 (Fri, 09 Dec 2022)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Log error message if request cannot be sent

This makes sure a error message is logged if a request cannot be sent
for some reason.


  Commit: 3bdc16d9e59cd3e740ed9f7b422e17ada30cd207
      https://github.com/bluez/bluez/commit/3bdc16d9e59cd3e740ed9f7b422e17ada30cd207
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-09 (Fri, 09 Dec 2022)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Read PAC Sink/Source if respective location is found

If PAC Sink/Source has been found but not record has been recovered it
means an error must have occurred so this attempt to read the records
once again.


  Commit: be9fc9222c033391329e6145ccf4e81dcfcf1934
      https://github.com/bluez/bluez/commit/be9fc9222c033391329e6145ccf4e81dcfcf1934
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-09 (Fri, 09 Dec 2022)

  Changed paths:
    M src/shared/gatt-db.c

  Log Message:
  -----------
  shared/gatt-db: Allow passing NULL to gatt_db_attribute_write

This makes gatt_db_attribute_write to accept NULL as a func when
storing directly on the db itself.


  Commit: 253502d311bf1858af2aeb90d5996167f1da9bf3
      https://github.com/bluez/bluez/commit/253502d311bf1858af2aeb90d5996167f1da9bf3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-09 (Fri, 09 Dec 2022)

  Changed paths:
    M profiles/audio/bap.c
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Make bt_bap_pac_register to be per session

This makes bt_bap_pac_register to be per session rather than global so
the callback don't have to match the session by itself.


  Commit: e07c1e723ee72ca6c14fda5c636a702fcbb82ae8
      https://github.com/bluez/bluez/commit/e07c1e723ee72ca6c14fda5c636a702fcbb82ae8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-09 (Fri, 09 Dec 2022)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix not calculating time to wait

The difference of time start and current time may have advanced just
enough to add a second leaving start nanoseconds to be bigger.


  Commit: 3d6e4bf14abfe592bb95471eb989a7899febe779
      https://github.com/bluez/bluez/commit/3d6e4bf14abfe592bb95471eb989a7899febe779
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-12-09 (Fri, 09 Dec 2022)

  Changed paths:
    M tools/isotest.c

  Log Message:
  -----------
  isotest: Fix not calculating time to wait

The difference of time start and current time may have advanced just
enough to add a second leaving start nanoseconds to be bigger.


Compare: https://github.com/bluez/bluez/compare/758161c422e6...3d6e4bf14abf
