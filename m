Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D579FEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jul 2023 18:07:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231308AbjGESHc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jul 2023 14:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjGESHb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jul 2023 14:07:31 -0400
Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6467D170B
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 11:07:30 -0700 (PDT)
Received: from github.com (hubbernetes-node-7514cd4.va3-iad.github.net [10.48.135.31])
        by smtp.github.com (Postfix) with ESMTPA id 9D5E29411C4
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jul 2023 11:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1688580449;
        bh=/9DoS9dTBMTZnxpH2QM8k5TevmBfmcQHFIaBf9ZWIB4=;
        h=Date:From:To:Subject:From;
        b=GsBbtyWMRu3i/riNfrt1t6a8iQSb6pnFT7lgKqg0xSIeEqvIKcDlk3leRAyF8sE9s
         N6iIUk/TI9JKCjrciYJJmK26+LrBN0aIs1SenvGArrnmgD/Kn/hue2DCuY98mX9ibP
         i0gjfmUk6TdzTspCVrscF2iSv9wskmAQxB3dxfog=
Date:   Wed, 05 Jul 2023 11:07:29 -0700
From:   vlad-pruteanu <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d764f7-b74146@github.com>
Subject: [bluez/bluez] 466fce: transport: handle BAP Enabling state correctly
 whe...
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
  Commit: 466fce0209a3878512672159168943047a9e2323
      https://github.com/bluez/bluez/commit/466fce0209a3878512672159168943047a9e2323
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-07-05 (Wed, 05 Jul 2023)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: handle BAP Enabling state correctly when resuming

If BAP stream is in Enabling state when transport acquire is attempted,
we should wait for bap_state_changed to emit the completion event.

transport->resume() is only called with new owner with no
owner->pending, and shall return nonzero completion id on success.
Currently if BAP stream is Enabling, it returns zero which fails the
acquire operation.

To fix this, return valid completion id in this case instead.  Also keep
track of the g_idle_add resume id, so that we don't try to give it to
bt_bap_stream_cancel.

Fixes sound server getting spurious Not Authorized errors when trying to
acquire a pending transport.  This can happen on BAP server: linked
transports become pending when the first of the two enters Streaming. If
sound server tries to acquire the other linked transport whose stream is
still Enabling, the acquire fails (media_owner_free +
btd_error_not_authorized).

Log:
===============================================================
profiles/audio/transport.c:bap_state_changed() stream 0x25c2880: qos(2) -> enabling(3)
...
profiles/audio/transport.c:bap_state_changed() stream 0x25cc590: qos(2) -> enabling(3)
...
src/shared/bap.c:bap_stream_state_changed() stream 0x25cc590 dir 0x01: enabling -> streaming
profiles/audio/bap.c:bap_state() stream 0x25cc590: enabling(3) -> streaming(4)
profiles/audio/transport.c:bap_state_changed() stream 0x25cc590: enabling(3) -> streaming(4)
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/fd1: fd(36) ready
profiles/audio/transport.c:transport_update_playing() /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/fd1 State=TRANSPORT_STATE_IDLE Playing=1
profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/fd1: TRANSPORT_STATE_IDLE -> TRANSPORT_STATE_PENDING
profiles/audio/transport.c:transport_set_state() State changed /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/fd0: TRANSPORT_STATE_IDLE -> TRANSPORT_STATE_PENDING
profiles/audio/transport.c:media_owner_create() Owner created: sender=:1.1242
profiles/audio/transport.c:media_owner_free() Owner :1.1242
===============================================================


  Commit: 8fd0c76b41d35e24e10e45fcf57262482cb978a2
      https://github.com/bluez/bluez/commit/8fd0c76b41d35e24e10e45fcf57262482cb978a2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-07-05 (Wed, 05 Jul 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: use only nonzero req->id

In bap_req_new, use same pattern as elsewhere to not use zero as
a valid id.


  Commit: 80f2fa14b6d431fba9402e5efae0ac7bd98892bf
      https://github.com/bluez/bluez/commit/80f2fa14b6d431fba9402e5efae0ac7bd98892bf
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-07-05 (Wed, 05 Jul 2023)

  Changed paths:
    M doc/test-runner.txt
    M doc/tester.config

  Log Message:
  -----------
  doc/tester-config: enable DEBUG_KERNEL, PROVE_RCU, DEBUG_ATOMIC_SLEEP

Add more lock/sleep debugging to the default tester config.

Enable DEBUG_KERNEL since olddefconfig won't enable PROVE_LOCKING
without it. Enable PROVE_RCU to also check RCU usage. Enable
DEBUG_ATOMIC_SLEEP to catch those as well.


  Commit: 19ce052d35d367005bfcf63461e43758301556f1
      https://github.com/bluez/bluez/commit/19ce052d35d367005bfcf63461e43758301556f1
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-07-05 (Wed, 05 Jul 2023)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add a regression test hitting hci_sync bug

Add a test "Add + Remove Device Nowait - Success" that hits a race
condition in kernel hci_sync.c.  On current kernels this causes

BUG: KASAN: slab-use-after-free in hci_update_passive_scan_sync+0x857/0x1230

due to unsafe iteration of hdev->pend_le_conns (in Linux <= 6.4-rc4).

This seems to hit the race condition also without the added emulator
delay (since the emulator runs in the same thread), but it's better to
add the delay since otherwise it'll depend on timings on kernel side.


  Commit: 7b10e72de6f41585f087e6fc338106b44d3e69c9
      https://github.com/bluez/bluez/commit/7b10e72de6f41585f087e6fc338106b44d3e69c9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-07-05 (Wed, 05 Jul 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: detach io for source ASEs only after Stop Ready

The Client may terminate a CIS when sink is in QOS and source in
Disabling states (BAP v1.0.1 Sec 5.6.5).  It may also terminate it when
Receiver Stop Ready has completed successfully (BAP v1.0.1 Sec 5.6.5.1).

It appears Samsung Galaxy Buds2 Pro (R510XXUOAWA5) ignores the Receiver
Stop Ready command if CIS is already disconnected, and then gets stuck
in disabling state. It works if CIS is disconnected after Receiver Stop
Ready.

For better compatibility as client for this device, and since it
shouldn't matter for us in which order we do it, disconnect CIS after
completion of Receiver Stop Ready, instead of immediately in Disabling.

We disconnect also if Receiver Stop Ready fails, given that
disconnecting in Disabled state should be OK.

Link: https://github.com/bluez/bluez/issues/516


  Commit: 8c3170190d6f626869f1f382138caf3a16030462
      https://github.com/bluez/bluez/commit/8c3170190d6f626869f1f382138caf3a16030462
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-07-05 (Wed, 05 Jul 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: wait for CIG to become configurable before recreating CIS

ISO sockets cannot be reconnected before all sockets in the same CIG
have been closed, if the CIG was previously active.

Keep track which endpoints have active CIG, and postpone connecting CIS
until their CIG is no longer active.

This addresses getting EBUSY from connect() when multiple CIS in the
same CIG move streaming -> qos at the same time, which disconnects CIS
and recreates them.  The EBUSY originates from COMMAND_DISALLOWED
response to Set CIG Parameters.

This requires the kernel side do the Disconnect CIS / Remove CIG / Set
CIG Parameters HCI command steps in the right order, when all old
sockets are closed first before connecting new ones.


  Commit: f9557931ad361e08f1f1537ea670fedd1dd0138d
      https://github.com/bluez/bluez/commit/f9557931ad361e08f1f1537ea670fedd1dd0138d
  Author: Claudia Draghicescu <claudia.rosu@nxp.com>
  Date:   2023-07-05 (Wed, 05 Jul 2023)

  Changed paths:
    M lib/mgmt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding support for Sync Receiver events

This commit adds decoding support for PA Sync Established,
BIG Sync Established and BIG Sync Lost events.


  Commit: b741460688925448807c7532fe96182e4d32ec42
      https://github.com/bluez/bluez/commit/b741460688925448807c7532fe96182e4d32ec42
  Author: Vlad Pruteanu <vlad.pruteanu@nxp.com>
  Date:   2023-07-05 (Wed, 05 Jul 2023)

  Changed paths:
    M plugins/admin.c

  Log Message:
  -----------
  plugins/admin: Fix heap-use-after-free when using 2 controllers

This commit fixes the heap-use-after-free error when connecting 2
controllers. When a controller is connected
admin_policy_adapter_probe is called. If policy_data was already
allocated it gets freed, if not, it only gets allocated. Eventually
add_interface is called. Here policy_data is put in the "data" variable
(specific for each controller) and the process_changes task is called
with idle priority. This function ultimately accesses policy_data from
the "data" variable.

When Bluez crashes the flow is:
1)first controller is attached
2)admin_policy_adapter_probe is called and policy_data is allocated
4)second controller is attached
5)admin_policy_adapter_probe is called and policy_data is freed, then
allocated again
6)process_changes runs and the policy_data for the first controller is
read, but it was already freed, thus the crash


Compare: https://github.com/bluez/bluez/compare/d764f78f2765...b74146068892
