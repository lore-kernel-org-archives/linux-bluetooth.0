Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70323ECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Sep 2022 01:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiIVB55 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 21 Sep 2022 21:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiIVB54 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 21 Sep 2022 21:57:56 -0400
Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D40A3D06
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 18:57:53 -0700 (PDT)
Received: from github.com (hubbernetes-node-d0b9bcf.va3-iad.github.net [10.48.206.51])
        by smtp.github.com (Postfix) with ESMTPA id B1F0FE0406
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Sep 2022 18:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1663811872;
        bh=h6lwbVV2wv9RACQb4xjDA2UIe9xooJBV40VKkQni724=;
        h=Date:From:To:Subject:From;
        b=VktUoDveIH9Ygaa7xTFnJrfNlo51H44DrvSkAzrsu1OujTlUJZv6LchQuDOI3WYtE
         EofyNiZGJjpoUTcepTr+0Mdz6cTQfr6u5m8HPUhHrfg8u/cEn72jgbUTOxarZS4UPb
         x1xS3bdmic+YUUt5haIWQCGA5XLKlWKx+7dRSpGg=
Date:   Wed, 21 Sep 2022 18:57:52 -0700
From:   Tedd Ho-Jeong An <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/115514-0da759@github.com>
Subject: [bluez/bluez] fbf17a: gatt: Fix not setting permissions for CCC
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
  Commit: fbf17ac497bb2e0077c4cfa22583439e157693fe
      https://github.com/bluez/bluez/commit/fbf17ac497bb2e0077c4cfa22583439e157693fe
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-09-21 (Wed, 21 Sep 2022)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt: Fix not setting permissions for CCC

CCC shall always have both Read and Write permissions set in addition to
what application set.

Fixes: https://github.com/bluez/bluez/issues/399


  Commit: 50782b0eeb05fd0420f3e9c7686eb792f4fb4689
      https://github.com/bluez/bluez/commit/50782b0eeb05fd0420f3e9c7686eb792f4fb4689
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-09-21 (Wed, 21 Sep 2022)

  Changed paths:
    M src/shared/gatt-db.c

  Log Message:
  -----------
  gatt-db: Check if permissions are set when adding CCC

CCC shall always have some permission set.


  Commit: c2734c41f7c0e80bcab195150751e1a5e70945fe
      https://github.com/bluez/bluez/commit/c2734c41f7c0e80bcab195150751e1a5e70945fe
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-09-21 (Wed, 21 Sep 2022)

  Changed paths:
    M client/gatt.c

  Log Message:
  -----------
  client/gatt: Fix notification enabled/disabled output

When notifications are enabled/disable the output was not print a new
line.


  Commit: 31b32daf529204313be3da08e1809dc916a37864
      https://github.com/bluez/bluez/commit/31b32daf529204313be3da08e1809dc916a37864
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-09-21 (Wed, 21 Sep 2022)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt: Fix scan-build warnings

This fixes the following warnings:

src/gatt-database.c:3541:14: warning: Value stored to 'iface' during
its initialization is never read [deadcode.DeadStores]
        const char *iface = g_dbus_proxy_get_interface(proxy);
                    ^~~~~   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
src/gatt-database.c:3542:14: warning: Value stored to 'path' during
its initialization is never read [deadcode.DeadStores]
        const char *path = g_dbus_proxy_get_path(proxy);
                    ^~~~   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  Commit: 40a90f4e98fe0f2fa2da68b99ae136947d3d5189
      https://github.com/bluez/bluez/commit/40a90f4e98fe0f2fa2da68b99ae136947d3d5189
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-09-21 (Wed, 21 Sep 2022)

  Changed paths:
    M src/shared/gatt-db.c

  Log Message:
  -----------
  shared/gatt-db: Fix scan-build warnings

This fixes the following warnings:

src/shared/gatt-db.c:1339:2: warning: Undefined or garbage value
returned to caller [core.uninitialized.UndefReturn]
        return data.num_of_res;
        ^~~~~~~~~~~~~~~~~~~~~~

src/shared/gatt-db.c:725:5: warning: Access to field 'handle' results
in a dereference of a null pointer
        service->attributes[0]->handle == handle)
        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


  Commit: 89ac7b826557c48cc8038c2eec6854aa07909eed
      https://github.com/bluez/bluez/commit/89ac7b826557c48cc8038c2eec6854aa07909eed
  Author: Sathish Narasimman <sathish.narasimman@intel.com>
  Date:   2022-09-21 (Wed, 21 Sep 2022)

  Changed paths:
    M src/shared/vcp.c
    M src/shared/vcp.h

  Log Message:
  -----------
  shared/vcp: Add bt_vcp_set_debug

Add support for bt_vcp_set_debug and replace the exisiting DBG.


  Commit: 7233b50f4135a9e533a997bbb7b3fceeb1dc1bff
      https://github.com/bluez/bluez/commit/7233b50f4135a9e533a997bbb7b3fceeb1dc1bff
  Author: Sathish Narasimman <sathish.narasimman@intel.com>
  Date:   2022-09-21 (Wed, 21 Sep 2022)

  Changed paths:
    M profiles/audio/vcp.c

  Log Message:
  -----------
  Profiles: Enable bt_vcp_set_debug

Set bt_vcp_set_debug to be used for VCP.


  Commit: 0da759f1a36d67ce1d6c84be03ec3986633ca30c
      https://github.com/bluez/bluez/commit/0da759f1a36d67ce1d6c84be03ec3986633ca30c
  Author: Tedd Ho-Jeong An <tedd.an@intel.com>
  Date:   2022-09-21 (Wed, 21 Sep 2022)

  Changed paths:
    M Makefile.tools
    A tools/ioctl-tester.c
    M tools/test-runner.c

  Log Message:
  -----------
  tools/ioctl-tester - Add ioctl-tester

This patch adds ioctl-tester which tests the IOCTL commands.

HCI Down
Device List
Device List - Invalid Param 1
Device Info
Reset Stat
Set Link Mode - ACCEPT
Set Link Mode - MASTER
Set Pkt Type - DM
Set Pkt Type - DH
Set Pkt Type - HV
Set Pkt Type - 2-DH
Set Pkt Type - 2-DH
Set Pkt Type - ALL
Set ACL MTU - 1
Set ACL MTU - 2
Set SCO MTU - 1
Set SCO MTU - 2
Block BDADDR - Success
Block BDADDR - Fail
Unblock BDADDR - Success
Unblock BDADDR - Fail
Connection List - No Conn
Connection List
Connection Info
Connection Info - No Connection
Connection Info - Wrong Type
Authentication Info - No Connection
Authentication Info


Compare: https://github.com/bluez/bluez/compare/115514d85a17...0da759f1a36d
