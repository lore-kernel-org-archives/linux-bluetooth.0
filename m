Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B46BC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Nov 2022 22:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbiKQWh3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 17:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbiKQWh0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 17:37:26 -0500
Received: from smtp.github.com (out-26.smtp.github.com [192.30.252.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0981E1C92D
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 14:37:19 -0800 (PST)
Received: from github.com (hubbernetes-node-1610bd8.ash1-iad.github.net [10.56.201.85])
        by smtp.github.com (Postfix) with ESMTPA id 367885E04A8
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 14:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1668724639;
        bh=9Tao59Pdje9Ou862FnZQpoHAKfImCiPLYqwf8wzc+CE=;
        h=Date:From:To:Subject:From;
        b=joIO/FGmoCDF4c669A5u/6NI4WMsZq8ko2iPG7NmL1J6E699f5mXiGgs4XlppfX9T
         IMtMl14gU3ENNKVylLli8j+HvjmmJ/gYPdbzGNKDLdfU3caHxyYLsQqqCSF40oynqV
         DbV0sEOTAnxTjpMkr9X7GTSlIK8DAWxQ9YwxQvQI=
Date:   Thu, 17 Nov 2022 14:37:19 -0800
From:   hadess <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f65b4d-e2b2b1@github.com>
Subject: [bluez/bluez] b3f76b: tools/test-runner: Remove
 bluetooth.enable_ecred
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
  Commit: b3f76b30ec9d0e06d44a9240698698926df9e333
      https://github.com/bluez/bluez/commit/b3f76b30ec9d0e06d44a9240698698926df9e333
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-10-28 (Fri, 28 Oct 2022)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  tools/test-runner: Remove bluetooth.enable_ecred

L2CAP ECRED is now enabled by default by the following kernel change:

98f18bb78b7d ("Bluetooth: Add CONFIG_BT_LE_L2CAP_ECRED")


  Commit: d9253248363b995e44c1f5e393ed1c7aa4ec81ce
      https://github.com/bluez/bluez/commit/d9253248363b995e44c1f5e393ed1c7aa4ec81ce
  Author: Marek Vasut <marex@denx.de>
  Date:   2022-11-01 (Tue, 01 Nov 2022)

  Changed paths:
    M tools/hciattach.h
    M tools/hciattach_bcm43xx.c
    M tools/hciattach_qualcomm.c
    M tools/hciattach_tialt.c

  Log Message:
  -----------
  tools: Make hciattach_* firmware path build-time configurable

Make hciattach_qualcomm.c and hciattach_tialt.c behave the same way
as hciattach_bcm43xx.c does, where FIRMWARE_DIR can be overridden
at build time by using -DFIRMWARE_DIR= CFLAGS.


  Commit: f9657b86ddd3008768b3f6fef2c94eec46d976b5
      https://github.com/bluez/bluez/commit/f9657b86ddd3008768b3f6fef2c94eec46d976b5
  Author: Marek Vasut <marex@denx.de>
  Date:   2022-11-01 (Tue, 01 Nov 2022)

  Changed paths:
    M tools/hciattach_qualcomm.c

  Log Message:
  -----------
  tools: Switch hciattach_qualcomm to FAILIF macro completely

Use the FAILIF() macro consistently to avoid unused variable n warnings.


  Commit: 3a3298e29b4468bd6cbf74de6d677c052a4e960a
      https://github.com/bluez/bluez/commit/3a3298e29b4468bd6cbf74de6d677c052a4e960a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-11-04 (Fri, 04 Nov 2022)

  Changed paths:
    M monitor/att.c
    M monitor/l2cap.h

  Log Message:
  -----------
  monitor/att: Add handler support for Read by Type

This adds handler support for Read by Type so it can further decode
the values when the procedure is used.


  Commit: 7e0e08ca5396bd9e40f25fac74018963f6516c61
      https://github.com/bluez/bluez/commit/7e0e08ca5396bd9e40f25fac74018963f6516c61
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-11-04 (Fri, 04 Nov 2022)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Add support for decoding Characteristic Declaration

This adds supports for decoding the so called Characteristic
Declaration (0x2803):

> ACL Data RX: Handle 3585 flags 0x02 dlen 76
      ATT: Read By Type Response (0x09) len 71
        Attribute data length: 7
        Attribute data list: 10 entries
        Handle: 0x0002
        Value: 200300052a
            Properties: 0x20
              Indicate (0x20)
            Value Handle: 0x0003
            Value UUID: Service Changed (0x2a05)
        Handle: 0x0015
        Value: 021600002a
            Properties: 0x02
              Read (0x02)
            Value Handle: 0x0016
            Value UUID: Device Name (0x2a00)
        Handle: 0x0017
        Value: 021800012a
            Properties: 0x02
              Read (0x02)
            Value Handle: 0x0018
            Value UUID: Appearance (0x2a01)
        Handle: 0x0019
        Value: 021a00a62a
            Properties: 0x02
              Read (0x02)
            Value Handle: 0x001a
            Value UUID: Central Address Resolution (0x2aa6)
        Handle: 0x0029
        Value: 102a00372a
            Properties: 0x10
              Notify (0x10)
            Value Handle: 0x002a
            Value UUID: Heart Rate Measurement (0x2a37)
        Handle: 0x002c
        Value: 022d00382a
            Properties: 0x02
              Read (0x02)
            Value Handle: 0x002d
            Value UUID: Body Sensor Location (0x2a38)
        Handle: 0x002e
        Value: 082f00392a
            Properties: 0x08
              Write (0x08)
            Value Handle: 0x002f
            Value UUID: Heart Rate Control Point (0x2a39)
        Handle: 0x0031
        Value: 0a32008a2a
            Properties: 0x0a
              Read (0x02)
              Write (0x08)
            Value Handle: 0x0032
            Value UUID: First Name (0x2a8a)
        Handle: 0x0033
        Value: 0a3400902a
            Properties: 0x0a
              Read (0x02)
              Write (0x08)
            Value Handle: 0x0034
            Value UUID: Last Name (0x2a90)
        Handle: 0x0035
        Value: 0a36008c2a
            Properties: 0x0a
              Read (0x02)
              Write (0x08)
            Value Handle: 0x0036
            Value UUID: Gender (0x2a8c)


  Commit: 3bd7df28cbbccd59cca5c35e95c4275229b0badf
      https://github.com/bluez/bluez/commit/3bd7df28cbbccd59cca5c35e95c4275229b0badf
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2022-11-07 (Mon, 07 Nov 2022)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add some definitions from Bluetooth 5.3 Core specification


  Commit: 532c903aa423291e32f1328a69b053cb8185d4f9
      https://github.com/bluez/bluez/commit/532c903aa423291e32f1328a69b053cb8185d4f9
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2022-11-10 (Thu, 10 Nov 2022)

  Changed paths:
    M Makefile.am

  Log Message:
  -----------
  build: Update library version


  Commit: 63b01d0b0661d6a0048107dcb9e6f12ceac409e0
      https://github.com/bluez/bluez/commit/63b01d0b0661d6a0048107dcb9e6f12ceac409e0
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2022-11-10 (Thu, 10 Nov 2022)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.66


  Commit: b3a8f8fea99bc47abcf91d79f611fc7c1fce5c4b
      https://github.com/bluez/bluez/commit/b3a8f8fea99bc47abcf91d79f611fc7c1fce5c4b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-11-15 (Tue, 15 Nov 2022)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Fix not dequeing att_read on error response

If a read/read by type fails it needs to be dequeued otherwise it can
cause the next operation of the same type to return the wrong request
and possible decoding as if it was a different attribute type.


  Commit: 7c2e276d9e7c27e863d2cb9ebcf3be99b3c4fb4e
      https://github.com/bluez/bluez/commit/7c2e276d9e7c27e863d2cb9ebcf3be99b3c4fb4e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-11-15 (Tue, 15 Nov 2022)

  Changed paths:
    M src/shared/util.c
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Add iovec helpers

This adds iovec helpers functions.


  Commit: f96bccd80979283e7bf99a07a6dd9af3110cdf42
      https://github.com/bluez/bluez/commit/f96bccd80979283e7bf99a07a6dd9af3110cdf42
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-11-15 (Tue, 15 Nov 2022)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Make use of util_iov helpers

This make use of util_iov helpers instead of reimplementing them.


  Commit: 918c73acb778e2359abcf5c3fa4c6528164b3910
      https://github.com/bluez/bluez/commit/918c73acb778e2359abcf5c3fa4c6528164b3910
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-11-15 (Tue, 15 Nov 2022)

  Changed paths:
    M src/shared/tester.c
    M src/shared/tester.h

  Log Message:
  -----------
  shared/tester: Add tester_io_set_complete_func

This adds tester_io_set_complete_func which can be used to set a
callback when all iovec has been sent/received.


  Commit: 7fcd6889fb13858e3f78e9d5e35ffd80d8e0accb
      https://github.com/bluez/bluez/commit/7fcd6889fb13858e3f78e9d5e35ffd80d8e0accb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-11-15 (Tue, 15 Nov 2022)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix crash when canceling requests

If bt_bap_unref/bap_free is called while there is an ongoing pending
request it may endup calling into bap_notify_ready which will try to
notify ready callbacks while holding a reference, but in case the
reference is already 0 that means it would switch to 1 and back 0
causing a double free.

To prevent that bap_notify_ready now checks that the reference is not 0
with use of bt_bap_ref_safe.


  Commit: 1ebbfee345171cb4d38ae55501849a5671d2df4a
      https://github.com/bluez/bluez/commit/1ebbfee345171cb4d38ae55501849a5671d2df4a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-11-15 (Tue, 15 Nov 2022)

  Changed paths:
    M Makefile.am
    A unit/test-bap.c

  Log Message:
  -----------
  unit: Introduce test-bap

Test Summary
------------
BAP/UCL/DISC/BV-01-C                                 Passed
BAP/UCL/DISC/BV-02-C                                 Passed
BAP/UCL/DISC/BV-06-C                                 Passed
BAP/UCL/DISC/BV-05-C                                 Passed
BAP/UCL/DISC/BV-03-C                                 Passed
BAP/UCL/DISC/BV-04-C                                 Passed
Total: 6, Passed: 6 (100.0%), Failed: 0, Not Run: 0


  Commit: e515f4b6e25c971c47ab79e9cbdfa17119bbde23
      https://github.com/bluez/bluez/commit/e515f4b6e25c971c47ab79e9cbdfa17119bbde23
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2022-11-16 (Wed, 16 Nov 2022)

  Changed paths:
    M plugins/hostname.c

  Log Message:
  -----------
  hostname: Add '' around printed strings

Otherwise we can't see whether the string is nul, or empty.


  Commit: e2b2b1675f310023862319ea10ffd205a75cc0cb
      https://github.com/bluez/bluez/commit/e2b2b1675f310023862319ea10ffd205a75cc0cb
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2022-11-16 (Wed, 16 Nov 2022)

  Changed paths:
    M plugins/hostname.c

  Log Message:
  -----------
  hostname: Fallback to transient hostname

After pretty hostname, and static hostname, also support transient
hostname as a last resort before 'BlueZ X.XX'.

This happens on Fedora's Workstation installation as it calls
"hostnamectl set-hostname" on startup. In Fedora Silverblue, the default
hostname is set as fedora in /etc/os-release.

In both cases, we should fall back to that transient hostname, as bad as
it could be.

Note that the transient hostname needs to be monitored through the
kernel directly, as explained in:
https://www.freedesktop.org/software/systemd/man/org.freedesktop.hostname1.html


Compare: https://github.com/bluez/bluez/compare/f65b4d5fc77f...e2b2b1675f31
