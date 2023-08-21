Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49A7EE49A5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 20:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjHUUKo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjHUUKo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 16:10:44 -0400
Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9EEDF
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 13:10:42 -0700 (PDT)
Received: from github.com (hubbernetes-node-c199cc0.va3-iad.github.net [10.48.135.34])
        by smtp.github.com (Postfix) with ESMTPA id EB02F8C0878
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 13:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1692648641;
        bh=K6OOVDXqcJkaER0fduNaDuIsmNX3B+Fm0bNsdczYAXg=;
        h=Date:From:To:Subject:From;
        b=VqlmgEi38ZyLdI4CxVyRdoMUUkw57lMGEiB2JodTzEieSolcvX2ZSdmN1fZzrm5aK
         yIPrPrMs3JGpFAbPGo7Jx0a9MlWTAOUHcXDUy6NJqd50nEXZE4psG9kkb4z6nZS/P6
         FxRF0Pp9+2kxe+x6VJvvJ38qv+TZ3xDKpuxVzhUE=
Date:   Mon, 21 Aug 2023 13:10:41 -0700
From:   Pauli Virtanen <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0004eb-e93094@github.com>
Subject: [bluez/bluez] dbe522: vhci: Add function to pause processing input
 from ...
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
  Commit: dbe52200549bdc61fcd94c8c41d56c58d258ad7c
      https://github.com/bluez/bluez/commit/dbe52200549bdc61fcd94c8c41d56c58d258ad7c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-08-21 (Mon, 21 Aug 2023)

  Changed paths:
    M emulator/vhci.c
    M emulator/vhci.h

  Log Message:
  -----------
  vhci: Add function to pause processing input from vhci

Add function to pause (temporarily) reading data from vhci.  This can be
used to synchronously pause handling of btdev commands from the kernel.


  Commit: bfcc3f7bf48fa3c1fdbd3ae9bf6ae671575a4f1c
      https://github.com/bluez/bluez/commit/bfcc3f7bf48fa3c1fdbd3ae9bf6ae671575a4f1c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-08-21 (Mon, 21 Aug 2023)

  Changed paths:
    M emulator/hciemu.c
    M emulator/hciemu.h

  Log Message:
  -----------
  hciemu: Add hciemu_flush_client_events for ordering VHCI vs bthost

bthost commands execute with a delay because events may be sitting in
the socketpair queues.  This makes it difficult to ensure, when writing
tests, that certain bthost commands have been handled, before any new
events from VHCI are processed.

To make event ordering possible, add a function that flushes client
bthost/btdev socketpair queues, before processing any new VHCI events.
This is done by pausing VHCI input processing until the kernel
socketpair queues are empty.


  Commit: 465108814db2b7ba3037a83cb91f7de1cc2f7366
      https://github.com/bluez/bluez/commit/465108814db2b7ba3037a83cb91f7de1cc2f7366
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-08-21 (Mon, 21 Aug 2023)

  Changed paths:
    M tools/sco-tester.c

  Log Message:
  -----------
  sco-tester: add test for ACL disconnect before SCO established

Simulate ACL being disconnected before SCO is established.  Kernel shall
not crash.

eSCO ACL Disconnect - Failure

Link: https://lore.kernel.org/linux-bluetooth/00000000000013b93805fbbadc50@google.com/


  Commit: 70b4db6803b46d5f9ad08a3f72eef9186b25e50a
      https://github.com/bluez/bluez/commit/70b4db6803b46d5f9ad08a3f72eef9186b25e50a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-08-21 (Mon, 21 Aug 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: add test for ACL disconnect before ISO created

Simulate ACL being disconnected when connecting ISO, before LE Create
CIS got sent.  The kernel shall indicate connection failure for the ISO
socket immediately when the ACL is gone, since connecting the ISO can no
longer proceed.

ISO Connect ACL Disconnect - Failure


  Commit: e93094977f08442d13d120a6154f8236dcc491dc
      https://github.com/bluez/bluez/commit/e93094977f08442d13d120a6154f8236dcc491dc
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-08-21 (Mon, 21 Aug 2023)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: wait for kernel exp features in adapter initialization

Things like BAP depend on ISO sockets being enabled in kernel.  It is
possible the MGMT commands enabling experimental kernel features do not
complete, before BAP etc. initialization and probing starts, in which
case BAP will be mostly nonfunctional.

This was observed to occur always when running BlueZ in a Fedora VM,
requiring bluetoothd restart after every boot for BAP to work,
log containing lines in the order:

bluetoothd[981]: src/adapter.c:read_exp_features_complete() 6fbaf188-05e0-496a-9885-d6ddfdb4e03e flags 0 action 1
bluetoothd[981]: src/adapter.c:read_info_complete() index 0 status 0x00
bluetoothd[981]: profiles/audio/bap.c:bap_probe() BAP requires ISO Socket which is not enabled
bluetoothd[981]: src/adapter.c:iso_socket_complete() ISO Socket successfully set

Fix by waiting in adapter initialization that all MGMT exp feature
requests are done, before proceeding to read adapter information.

Also fix canceling MGMT_OP_SET_EXP_FEATURE for ISO sockets.


Compare: https://github.com/bluez/bluez/compare/0004eb06d5d9...e93094977f08
