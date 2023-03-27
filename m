Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17D5C76195
	for <linux-bluetooth@archiver.kernel.org>; Mon, 27 Mar 2023 21:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjC0Vhc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 27 Mar 2023 17:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjC0Vhb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 27 Mar 2023 17:37:31 -0400
Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD0926B1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 14:37:30 -0700 (PDT)
Received: from github.com (hubbernetes-node-5c9502f.ac4-iad.github.net [10.52.208.87])
        by smtp.github.com (Postfix) with ESMTPA id 149005201F9
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Mar 2023 14:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1679953050;
        bh=bnPM8YNtzPBQgNS+m9OBiY7JWjLJ2pj+nvwo6m7PToo=;
        h=Date:From:To:Subject:From;
        b=R5sZT/q/KISo3PjmgeAbVN9ttWjMA8TE1xNhmj5Qm/fdjCRex37md5klXRyO8mOps
         L5LTqpJplYM7FQ7DoWbKowQLDhReqNTZcZCroF6tLn4BxG0IoklQ+KNp9Wqvp/bI0d
         54sLlNSWt8FQUCBlIJcFv2aF3e/UTTzs9zN9Xqe4=
Date:   Mon, 27 Mar 2023 14:37:30 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/fb1c69-011e56@github.com>
Subject: [bluez/bluez] 7610b9: shared/gatt-db: Make
 gatt_db_attribute_get_value p...
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
  Commit: 7610b9264147c387e0c12d17221ae83f97add776
      https://github.com/bluez/bluez/commit/7610b9264147c387e0c12d17221ae83f97add776
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-27 (Mon, 27 Mar 2023)

  Changed paths:
    M src/shared/gatt-db.c
    M src/shared/gatt-db.h

  Log Message:
  -----------
  shared/gatt-db: Make gatt_db_attribute_get_value public

This makes gatt_db_attribute_get_value public so it can be used by the
likes of btmon.


  Commit: cf72428156689a7bf2e2c6013788fedca08c6ff7
      https://github.com/bluez/bluez/commit/cf72428156689a7bf2e2c6013788fedca08c6ff7
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-27 (Mon, 27 Mar 2023)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Print value when printing descriptors

This prints the value attribute information when print attribute
descriptors:

< ACL Data TX: Handle 3585 flags 0x00 dlen 9
      ATT: Write Request (0x12) len 4
        Handle: 0x002c Type: Client Characteristic Configuration (0x2902)
        Value Handle: 0x002b Type: Battery Level (0x2a19)
          Data: 0100
            Notification (0x01)


  Commit: 2719bb5aaf6df77edb4bf7c2654c178836300c73
      https://github.com/bluez/bluez/commit/2719bb5aaf6df77edb4bf7c2654c178836300c73
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-27 (Mon, 27 Mar 2023)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Fix not loading gatt_db for devices using RPA

Device using RPA have its storage using its identity address so this
uses keys_resolve_identity to attempt to resolve the destination
address instead of always using the connection address.


  Commit: 011e562a98a8b8c278391bc64d9dc2c8df0a5585
      https://github.com/bluez/bluez/commit/011e562a98a8b8c278391bc64d9dc2c8df0a5585
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-27 (Mon, 27 Mar 2023)

  Changed paths:
    M monitor/keys.c
    M monitor/keys.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Cache IRK being parsed

This caches any IRK being parsed so they can be used to resolve
addresses later which fixes the problem of only being able to resolve
addresses if the monitor happens to be active while SMP exchange the
keys.


Compare: https://github.com/bluez/bluez/compare/fb1c694100b2...011e562a98a8
