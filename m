Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C350C00140
	for <linux-bluetooth@archiver.kernel.org>; Tue,  2 Aug 2022 20:23:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbiHBUXM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 2 Aug 2022 16:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiHBUXL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Aug 2022 16:23:11 -0400
Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBA71928E
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Aug 2022 13:23:10 -0700 (PDT)
Received: from github.com (hubbernetes-node-5cb4fca.ash1-iad.github.net [10.56.14.60])
        by smtp.github.com (Postfix) with ESMTPA id 438BB900858
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Aug 2022 13:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1659471790;
        bh=1+MxAs0gN739rFgC3torh3WceWuRwAMxn0CwvITApXM=;
        h=Date:From:To:Subject:From;
        b=SHEL8whK3MhEx8cJGF5ThNnercSRZNLAjqVEp2bEUlRMDsHZQtedRRGmtXryUGEzz
         ZrtenUMibikbCOZy1JCuLWlzmLsC/p2rBIkWbh8+tiSSqZM0JzkuuS0JfBgoat6eDK
         g0Ia8lxXEaB1LoGxwo8LytYPOq/eyAX2AFNPuHhA=
Date:   Tue, 02 Aug 2022 13:23:10 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/cb4237-a65ddf@github.com>
Subject: [bluez/bluez] d06b4a: device: Fix not auto-connecting profile
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
  Commit: d06b4a6b74d4da0b997c981e1d506bf051f1a84d
      https://github.com/bluez/bluez/commit/d06b4a6b74d4da0b997c981e1d506bf051f1a84d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-08-01 (Mon, 01 Aug 2022)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix not auto-connecting profile

If the profile is registered and marked to auto-connect it shall
automatically be connected whenever a device is already connected.

Fixes: https://github.com/bluez/bluez/issues/370


  Commit: 7adb3aa7efc3d70381c411c031f579ff63786994
      https://github.com/bluez/bluez/commit/7adb3aa7efc3d70381c411c031f579ff63786994
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-08-02 (Tue, 02 Aug 2022)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h
    M src/gatt-database.c

  Log Message:
  -----------
  device: Add btd_ prefix to device_is_trusted

This adds btd_ prefix to device_is_trusted so it can be used by
plugins.


  Commit: a65ddf710584f2b3dad04fb5e3d725ba340ea1ef
      https://github.com/bluez/bluez/commit/a65ddf710584f2b3dad04fb5e3d725ba340ea1ef
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2022-08-02 (Tue, 02 Aug 2022)

  Changed paths:
    M plugins/sixaxis.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  sixaxis: Fix fliping device.trusted automatically

device.trusted is a user preference which controls if the devices needs
to be authorized or not so the plugin shall not overwrite it and instead
just honor what user has set and skip authorizing if already trusted.

Fixes: https://github.com/bluez/bluez/issues/372


Compare: https://github.com/bluez/bluez/compare/cb42377ae002...a65ddf710584
