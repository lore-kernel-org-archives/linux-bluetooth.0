Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D01F9C3DA7A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Jan 2023 20:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbjAFUER (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Jan 2023 15:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjAFUEP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Jan 2023 15:04:15 -0500
Received: from smtp.github.com (out-26.smtp.github.com [192.30.252.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A52A1
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jan 2023 12:04:13 -0800 (PST)
Received: from github.com (hubbernetes-node-92049f4.ash1-iad.github.net [10.56.224.61])
        by smtp.github.com (Postfix) with ESMTPA id 5BC765E0415
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 Jan 2023 12:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2014; t=1673035452;
        bh=9qkG42srHkmLFPh3guNhvfeXAMosz6bcCMBCProGe2A=;
        h=Date:From:To:Subject:From;
        b=vsRoyk9dN1BQya6SJlkdNLidoCaBZXPvwIMx3jft4Y5yhYjSYt1rtQSLJaRDpYTBc
         v/iY0iYHDfy6keUmkJPUT+LKxxqefZBvwL/Rj2BCTPwjccHgI/7+OJY2ORWJV7Z7QA
         4aoDMIzvjV4JPU+pK98dvetCrLdL6EPVrAccbLOs=
Date:   Fri, 06 Jan 2023 12:04:12 -0800
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4e2ae1-c18e3b@github.com>
Subject: [bluez/bluez] 6e3059: shared/gatt-client: Use parent debug_callback
 if n...
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
  Commit: 6e3059ae8cac28b8eefd6e55b47a6e39278d6410
      https://github.com/bluez/bluez/commit/6e3059ae8cac28b8eefd6e55b47a6e39278d6410
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-01-05 (Thu, 05 Jan 2023)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: Use parent debug_callback if not set on clone

If clone don't have a dedicated callback set use its parent so users of
bt_gatt_client_clone don't have to keep setting the same callback for
all clone instances.


  Commit: fde32ff9c9c0ab531767c4539cd0b5da3aec289b
      https://github.com/bluez/bluez/commit/fde32ff9c9c0ab531767c4539cd0b5da3aec289b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-01-05 (Thu, 05 Jan 2023)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: Allow registering with NULL callback

This makes bt_gatt_client_register_notify allow registering with NULL
callback which is interpreted as the CCC write has already been
performed therefore it won't be written again.


  Commit: 47b6cfeee3335c2d8a25876537071b30630abf4b
      https://github.com/bluez/bluez/commit/47b6cfeee3335c2d8a25876537071b30630abf4b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-01-05 (Thu, 05 Jan 2023)

  Changed paths:
    M Makefile.am
    M attrib/gattrib.c
    M attrib/gattrib.h

  Log Message:
  -----------
  attrib: Introduce g_attrib_attach_client

This introduces g_attrib_attach_client which can be used to attach a
bt_gatt_client instance to GAttr so it can be used to register
notifications.


  Commit: 2f4c576ad24324e13ae6522f0799fce23e1ef0bd
      https://github.com/bluez/bluez/commit/2f4c576ad24324e13ae6522f0799fce23e1ef0bd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-01-05 (Thu, 05 Jan 2023)

  Changed paths:
    M profiles/input/hog-lib.c
    M src/device.c

  Log Message:
  -----------
  hog-lib: Fix not handling BT_ATT_OP_HANDLE_NFY_MULT

This is a temporary fix for not handling BT_ATT_OP_HANDLE_NFY_MULT in
GAttr so the code will use g_attrib_attach_client to attach the
bt_gatt_client instance which is then used to register notifications
including those sent with BT_ATT_OP_HANDLE_NFY_MULT.

Fixes: https://github.com/bluez/bluez/issues/71


  Commit: c18e3bf92e048e44cbeb36846fe26a300dcc6be6
      https://github.com/bluez/bluez/commit/c18e3bf92e048e44cbeb36846fe26a300dcc6be6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-01-05 (Thu, 05 Jan 2023)

  Changed paths:
    M src/shared/gatt-client.c

  Log Message:
  -----------
  shared/gatt-client: Fix smatch warnings

This fixes the following warnings:

shared/gatt-client.c:2764:33: warning: Variable length array is used.
shared/gatt-client.c:2994:23: warning: Variable length array is used.
shared/gatt-client.c:3075:23: warning: Variable length array is used.
shared/gatt-client.c:3514:23: warning: Variable length array is used.


Compare: https://github.com/bluez/bluez/compare/4e2ae14ea311...c18e3bf92e04
