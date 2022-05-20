Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BCEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 May 2022 21:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353571AbiETVGl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 May 2022 17:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353567AbiETVGd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 May 2022 17:06:33 -0400
Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACFD7CDEC
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 14:06:31 -0700 (PDT)
Received: from github.com (hubbernetes-node-9807900.ash1-iad.github.net [10.56.208.81])
        by smtp.github.com (Postfix) with ESMTPA id 79F19900303
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 14:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1653080790;
        bh=MwPhUZO2Jr6aMm/MKi0nuZCKCbEjtSOR9feAYTbWZwA=;
        h=Date:From:To:Subject:From;
        b=DFFCT8y70RxgPdofvyPcfwK/rXbFblBhiPcMS9tf8kDylFf2fvDOocN2MJY9MzJDk
         mOCiiiNEsWFeNd3Cz6uiXwu1TtG/vYw76cXz5qv9gCjVDVaUsEol0vkGqte7nAK5GN
         5CBM2d9hw1bp4VzSj/gHH4s3BtaYBgl3moUcd7CI=
Date:   Fri, 20 May 2022 14:06:30 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c159d7-bd6b90@github.com>
Subject: [bluez/bluez] 02017e: settings: Add btd_settings_gatt_db_{store,load}
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
  Commit: 02017e320b4d503b2686e08188a41644c87faac0
      https://github.com/bluez/bluez/commit/02017e320b4d503b2686e08188a41644c87faac0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-18 (Wed, 18 May 2022)

  Changed paths:
    M Makefile.am
    M src/device.c
    A src/settings.c
    A src/settings.h

  Log Message:
  -----------
  settings: Add btd_settings_gatt_db_{store,load}

This adds helper functions to store and load from/to file so they can
get reused by the likes of gatt-database.c and btmon.


  Commit: f66673878a9f3745c9cb3cfaa85b5b8f99a929d6
      https://github.com/bluez/bluez/commit/f66673878a9f3745c9cb3cfaa85b5b8f99a929d6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-18 (Wed, 18 May 2022)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt: Store local GATT database

This enables storing the local (adapter) GATT database which later will
be used by btmon to decode GATT handles.


  Commit: 0247ed333ea9dc0ac914bae68225d5cb3f288f80
      https://github.com/bluez/bluez/commit/0247ed333ea9dc0ac914bae68225d5cb3f288f80
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-18 (Wed, 18 May 2022)

  Changed paths:
    M monitor/display.h
    M monitor/l2cap.c
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Move print_hex_field to display.h

This moves print_hex_field to display.h and removes the duplicated code
from packet.c and l2cap.c.


  Commit: 5efc737f49d4cb98c9b1658d68b226ed4f4c74cf
      https://github.com/bluez/bluez/commit/5efc737f49d4cb98c9b1658d68b226ed4f4c74cf
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-18 (Wed, 18 May 2022)

  Changed paths:
    M Makefile.tools
    A monitor/att.c
    A monitor/att.h
    M monitor/l2cap.c
    M monitor/l2cap.h

  Log Message:
  -----------
  monitor: Move ATT decoding function into its own file

This moves ATT decoding function from l2cap.c to att.c.


  Commit: 1cf5ceeef363cbbf71b1a6f71ef48e01f171988a
      https://github.com/bluez/bluez/commit/1cf5ceeef363cbbf71b1a6f71ef48e01f171988a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-18 (Wed, 18 May 2022)

  Changed paths:
    M monitor/broadcom.c
    M monitor/intel.c
    M monitor/msft.c
    M monitor/packet.c
    M monitor/packet.h
    M monitor/vendor.h

  Log Message:
  -----------
  monitor: Cache connection information

This caches connection information including the device addres so it can
be printed alongside the handle:

> HCI Event: Disconnect Complete (0x05) plen 4
        Status: Success (0x00)
        Handle: 3585 Address: 68:79:12:XX:XX:XX (OUI 68-79-12)
        Reason: Connection Terminated By Local Host (0x16)


  Commit: 0bd5350459c3207260503a24ec3660f83a548d62
      https://github.com/bluez/bluez/commit/0bd5350459c3207260503a24ec3660f83a548d62
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-18 (Wed, 18 May 2022)

  Changed paths:
    M Makefile.tools
    M monitor/att.c
    M monitor/packet.c

  Log Message:
  -----------
  monitor/att: Decode attribute type

This attempt to decode the attribute type if its gatt_db can be loaded:

< ACL Data TX: Handle 3585 flags 0x00 dlen 9
      ATT: Write Request (0x12) len 4
        Handle: 0x000b Type: Client Characteristic Configuration (0x2902)
          Data: 0200


  Commit: bd6b90595e14eb7dfef29e5c56ee6f55fa37c0a3
      https://github.com/bluez/bluez/commit/bd6b90595e14eb7dfef29e5c56ee6f55fa37c0a3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-05-19 (Thu, 19 May 2022)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Add decoding support for CCC

This adds decoding support for CCC so its value can be decoded:

< ACL Data TX: Handle 3585 flags 0x00 dlen 7
      ATT: Read Request (0x0a) len 2
        Handle: 0x002c Type: Client Characteristic Configuration (0x2902)
> ACL Data RX: Handle 3585 flags 0x02 dlen 6
      ATT: Read Response (0x0b) len 1
        Value: 01
            Notification (0x01)
< ACL Data TX: Handle 3585 flags 0x00 dlen 9
      ATT: Write Request (0x12) len 4
        Handle: 0x002c Type: Client Characteristic Configuration (0x2902)
          Data: 0100
            Notification (0x01)


Compare: https://github.com/bluez/bluez/compare/c159d790e878...bd6b90595e14
