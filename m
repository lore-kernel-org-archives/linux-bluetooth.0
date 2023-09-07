Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BB35EC875E
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 23:10:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237160AbjIGXKi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 19:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240982AbjIGXKi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 19:10:38 -0400
Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9809E1BD3
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 16:10:33 -0700 (PDT)
Received: from github.com (hubbernetes-node-1b2bad3.ac4-iad.github.net [10.52.210.31])
        by smtp.github.com (Postfix) with ESMTPA id 865597010D2
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 16:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1694128232;
        bh=FppFR+6ehpnmoOW22KcIgTeHsnfF2G8hN3gxQriJT4U=;
        h=Date:From:To:Subject:From;
        b=G7A7gIe5PHypHtzjdYW+1RvfG6SQMDas3X6SECiQZotXRYRJN3JmIqwbGXWdnYvdH
         aTawGnmvoPcdE2oo3T0POZztRqzcw383E7f8tKTjMTXj6FuO7Mpqd7O+yUGRDfTfgc
         5lmDmrWJXMn59jj0zaHeXBO+S+fvSUMY4bC+0/wY=
Date:   Thu, 07 Sep 2023 16:10:32 -0700
From:   iulia-tanasescu <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/dc13da-df658c@github.com>
Subject: [bluez/bluez] 32daf6: main.conf: Fix printing errors for valid
 options
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
  Commit: 32daf644a4971d8757a2818a377d40fb6b709641
      https://github.com/bluez/bluez/commit/32daf644a4971d8757a2818a377d40fb6b709641
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-07 (Thu, 07 Sep 2023)

  Changed paths:
    M src/main.c

  Log Message:
  -----------
  main.conf: Fix printing errors for valid options

This fixes the following errors:

Unknown key RefreshDiscovery for group General
Unknown key Encryption for group CSIS

Fixes: https://github.com/bluez/bluez/issues/583


  Commit: 3294c42c9677b185f22f625d8f25aac30a9cb34d
      https://github.com/bluez/bluez/commit/3294c42c9677b185f22f625d8f25aac30a9cb34d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-09-07 (Thu, 07 Sep 2023)

  Changed paths:
    M src/main.conf

  Log Message:
  -----------
  main.conf: Fix documention of CSIS.Encrypt

CSIS.Encrypt is a boolean so it shall only be set with true/false not
yes/no.


  Commit: ed0def339ccad7b69278ab613f9fa058d288101c
      https://github.com/bluez/bluez/commit/ed0def339ccad7b69278ab613f9fa058d288101c
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-09-07 (Thu, 07 Sep 2023)

  Changed paths:
    M btio/btio.c
    M btio/btio.h

  Log Message:
  -----------
  btio: Add support for accepting BIS after defer setup

This adds btio support for accepting BIS connections when defer
setup is enabled on a Broadcast Receiver socket.


  Commit: 42681a7c15ab21783001cf3921e99a594693ae55
      https://github.com/bluez/bluez/commit/42681a7c15ab21783001cf3921e99a594693ae55
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-09-07 (Thu, 07 Sep 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix ATT decoding issue

This fixes the way conn handles are marked as unused in the
conn_list array, so that valid conn entries are not overwritten
by new ones.


  Commit: df658c6c4ab5bd5ec4a8a3f8faa36e0d0a5f906a
      https://github.com/bluez/bluez/commit/df658c6c4ab5bd5ec4a8a3f8faa36e0d0a5f906a
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2023-09-07 (Thu, 07 Sep 2023)

  Changed paths:
    M src/shared/bass.c
    M src/shared/bass.h

  Log Message:
  -----------
  shared/bass: Add Set Broadcast_Code opcode handler

This adds the Set Broadcast_Code opcode handler, enabling a BASS Server
to sync to an encrypted BIG.


Compare: https://github.com/bluez/bluez/compare/dc13da09d78b...df658c6c4ab5
