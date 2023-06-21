Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834B3EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 21 Jun 2023 22:31:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjFUWbH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Jun 2023 18:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjFUWbG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Jun 2023 18:31:06 -0400
Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338A6173F
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 15:31:05 -0700 (PDT)
Received: from github.com (hubbernetes-node-b9afe89.va3-iad.github.net [10.48.144.33])
        by smtp.github.com (Postfix) with ESMTPA id 7108B41067
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Jun 2023 15:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1687386664;
        bh=XZWKBacjbvVt6lvm/6unBrcELrjJiVXTh9XBCk3zwH4=;
        h=Date:From:To:Subject:From;
        b=SfoVRryI+g0OT4mqNg9bAdle6Lv0M82qT25ALQU7TGPEyA6i1bgqR9bqsyCA7Dy5w
         7yb9G8cJIPRXkMMO7pEY/Dtu1SuCt4RuDwzaxQRQmDS7defeDnIyPxz+pGzLkvRs7j
         HYVUQZ2UOMn1lFUTXKttycxXz5lDS9LVnbpwiMio=
Date:   Wed, 21 Jun 2023 15:31:04 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/95d3e6-37042c@github.com>
Subject: [bluez/bluez] 98383b: mgmt-api: Update Device Found Event
 documentation
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
  Commit: 98383b917a4355c5fb87d1771a31b1f3420f2a1b
      https://github.com/bluez/bluez/commit/98383b917a4355c5fb87d1771a31b1f3420f2a1b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-06-20 (Tue, 20 Jun 2023)

  Changed paths:
    M doc/mgmt-api.txt

  Log Message:
  -----------
  mgmt-api: Update Device Found Event documentation

This updates Device Found Event documentation to mention the new flag
introduced to track when the event is generated due a interleaved Scan
Response that couldn't be merged.


  Commit: 741a04aba0c348d4e1b280e1202d439f2e572ab6
      https://github.com/bluez/bluez/commit/741a04aba0c348d4e1b280e1202d439f2e572ab6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-06-20 (Tue, 20 Jun 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add missing flags to MGMT Device Found Event

This adds the missing flags to MGMT Device Found Event so they can be
decoded properly.


  Commit: c8235156c31b36e85784b0a984705b3eb45d4041
      https://github.com/bluez/bluez/commit/c8235156c31b36e85784b0a984705b3eb45d4041
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-06-20 (Tue, 20 Jun 2023)

  Changed paths:
    M lib/mgmt.h
    M src/adapter.c
    M src/adapter.h
    M src/adv_monitor.c

  Log Message:
  -----------
  adapter: Handle Device Found Event with Scan Response flag

This handles recently introduced Scan Response flag since that
shouldn't affect connectable flag the device would be considered
connectable but it shall not create a new device by itself.


  Commit: dafec5e4e41e80bc220bd1b577837e6328306ab9
      https://github.com/bluez/bluez/commit/dafec5e4e41e80bc220bd1b577837e6328306ab9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-06-20 (Tue, 20 Jun 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix decoding of HCI CIS Established Event

The ISO Interval is actually using set using 1.25ms slots:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
page 2304:

  Time = N * 1.25 ms


  Commit: 2f3479337f14a8e1dbc5ba0d70bf2723bf8b1b0d
      https://github.com/bluez/bluez/commit/2f3479337f14a8e1dbc5ba0d70bf2723bf8b1b0d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-06-21 (Wed, 21 Jun 2023)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix CIS Establish ISO Interval

ISO Interval is actually using 1.25 ms slots so it needs to be properly
converted.


  Commit: 37042ca9c6ddcdbbb0899b3d62238935cd53f443
      https://github.com/bluez/bluez/commit/37042ca9c6ddcdbbb0899b3d62238935cd53f443
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-06-21 (Wed, 21 Jun 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Use get_le24 to convert 24 bits values

This uses get_le24 to convert 24 bits microseconds values.


Compare: https://github.com/bluez/bluez/compare/95d3e66524bf...37042ca9c6dd
