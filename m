Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E759C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Mar 2023 04:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCMEml (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Mar 2023 00:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjCMEmj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Mar 2023 00:42:39 -0400
X-Greylist: delayed 61 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Mar 2023 21:42:34 PDT
Received: from o7.sgmail.github.com (o7.sgmail.github.com [167.89.101.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780EC410AC
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Mar 2023 21:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        h=from:subject:mime-version:content-type:content-transfer-encoding:to:
        cc:content-type:from:subject:to;
        s=smtpapi; bh=kCM2JnIeNXdN6bchtlZ2PE+jA92uQWX44k0uxnpisms=;
        b=sQSn23Cm9PDLA3G08XV4lo0nB7f7PkljIxgNKNuEoxp4cKzz0xEo+ZrYx3N0WyPtESRn
        wrjWfS6nXopII7nYS9QI+swr168rEVnudMmt1YR2Jml3niXVmXZrEIdCm6uvwoPH2pZzIG
        La7pTVHaNWAXrc4QiXTPTDnjG1R+4eZPU=
Received: by filterdrecv-574c9fc7f5-9drdf with SMTP id filterdrecv-574c9fc7f5-9drdf-1-640EA95D-17
        2023-03-13 04:41:01.651792962 +0000 UTC m=+1659994.106683109
Received: from out-25.smtp.github.com (unknown)
        by geopod-ismtpd-15 (SG)
        with ESMTP id fXJ7r_gIQdqCAph3kpoVTw
        for <linux-bluetooth@vger.kernel.org>;
        Mon, 13 Mar 2023 04:41:01.522 +0000 (UTC)
Received: from github.com (hubbernetes-node-67061bd.ash1-iad.github.net [10.56.15.70])
        by smtp.github.com (Postfix) with ESMTPA id 54EA3840473
        for <linux-bluetooth@vger.kernel.org>; Sun, 12 Mar 2023 21:41:00 -0700 (PDT)
Date:   Mon, 13 Mar 2023 04:41:01 +0000 (UTC)
From:   inga-s <noreply@github.com>
Message-ID: <bluez/bluez/push/refs/heads/master/a1736d-40576a@github.com>
Subject: [bluez/bluez] d15997: shared/bap: Fix not detaching streams when PAC
 is ...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All
X-SG-EID: =?us-ascii?Q?fOGNrg1eOlQQOw7V6pTJ+UqwNvYb6YJfn0JinSePTU2G1pIlVynxT5VgFm0pFj?=
 =?us-ascii?Q?MBSO6cvw+UsuiG3l81q3n=2F9CB0kEfskdth=2F540z?=
 =?us-ascii?Q?Q6RfgARyymJxMQxm2hsqF=2FdSvCZfKDyikzUT66S?=
 =?us-ascii?Q?NeY0Hp=2FJyV+SDry38arjKA1pMWGJGvZ3amMZR5t?=
 =?us-ascii?Q?V8+eix0YC1Tg4kR0nXgNgtLF43DIccY+=2FZZLzBV?=
 =?us-ascii?Q?Q=2F+VXYGVLj+BmR0MOKbvc8aGN9dhlqdqaHV0Mc?=
To:     linux-bluetooth@vger.kernel.org
X-Entity-ID: /f+S0XqulHHajbNb6hGdxg==
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: d159973ecec8e65add01cb5ed8213e0ba8703965
      https://github.com/bluez/bluez/commit/d159973ecec8e65add01cb5ed8213e0ba8703965
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-01-23 (Mon, 23 Jan 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix not detaching streams when PAC is removed

When local PAC is removed we attempt to release the streams but we left
it still attached to the endpoint, so this makes sure the stream is
properly detached by setting its state to idle.

Fixes: https://github.com/bluez/bluez/issues/457


  Commit: 414c8650acfe871ea6ae860d7dca1b5fa9044b77
      https://github.com/bluez/bluez/commit/414c8650acfe871ea6ae860d7dca1b5fa9044b77
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-01-23 (Mon, 23 Jan 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix not setting stream to NULL

If the stream state is idle the ep->stream shall be set to NULL
otherwise it may be reused causing the following trace:

==32623==ERROR: AddressSanitizer: heap-use-after-free on address ...
 READ of size 8 at 0x60b000103550 thread T0
    #0 0x7bf7b7 in bap_stream_valid src/shared/bap.c:4065
    #1 0x7bf981 in bt_bap_stream_config src/shared/bap.c:4082
    #2 0x51a7c8 in bap_config profiles/audio/bap.c:584
    #3 0x71b907 in queue_foreach src/shared/queue.c:207
    #4 0x51b61f in select_cb profiles/audio/bap.c:626
    #5 0x4691ed in pac_select_cb profiles/audio/media.c:884
    #6 0x4657ea in endpoint_reply profiles/audio/media.c:369

Fixes: https://github.com/bluez/bluez/issues/457#issuecomment-1399232486


  Commit: 8aed9db4b13fa67babed7f2540d9b4d694f711ce
      https://github.com/bluez/bluez/commit/8aed9db4b13fa67babed7f2540d9b4d694f711ce
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-01-24 (Tue, 24 Jan 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix not removing endpoint if local PAC is unregistered

If local PAC is unregistered it would also notify via pac_removed
callback which shall unregister the endpoint D-Bus object.

Fixes: https://github.com/bluez/bluez/issues/457#issuecomment-1402178691


  Commit: 814e3535a1bc165e05d91c470b38e835c5006ac9
      https://github.com/bluez/bluez/commit/814e3535a1bc165e05d91c470b38e835c5006ac9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-01-25 (Wed, 25 Jan 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  bap: Fix not checking if request fits when grouping

When grouping requests with the same opcode the code was queueing them
without attempt to check that that would fit in the ATT MTU causing the
following trace:

stack-buffer-overflow on address 0x7fffdba951f0 at pc 0x7fc15fc49d21 bp
0x7fffdba95020 sp 0x7fffdba947d0
WRITE of size 9 at 0x7fffdba951f0 thread T0
   #0 0x7fc15fc49d20 in __interceptor_memcpy
(/lib64/libasan.so.8+0x49d20)
   #1 0x71f698 in util_iov_push_mem src/shared/util.c:266
   #2 0x7b9312 in append_group src/shared/bap.c:3424
   #3 0x71ba01 in queue_foreach src/shared/queue.c:207
   #4 0x7b9b66 in bap_send src/shared/bap.c:3459
   #5 0x7ba594 in bap_process_queue src/shared/bap.c:351

Fixes: https://github.com/bluez/bluez/issues/457#issuecomment-1403924708


  Commit: b61044d52917eb44468b46bfcafb191d18418698
      https://github.com/bluez/bluez/commit/b61044d52917eb44468b46bfcafb191d18418698
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-01-26 (Thu, 26 Jan 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix registering multiple endpoint for the same PAC set

This makes sure there is only one endpoint representing a local and
remote PAC set.


  Commit: efba4618dd2d46d842695842b152d2dd33dbcc95
      https://github.com/bluez/bluez/commit/efba4618dd2d46d842695842b152d2dd33dbcc95
  Author: Marcin Kraglak <marcin.kraglak@telink-semi.com>
  Date:   2023-01-30 (Mon, 30 Jan 2023)

  Changed paths:
    M src/shared/util.c

  Log Message:
  -----------
  shared/util: Add CAS, HAS, TMAS and PBAS UUIDs

Add UUIDs for: Common Audio service, Hearing Aid service,
TMAS service and Public Broadcast Announcement service.


  Commit: eee6a75adc93b6146f662c28b8295c9b92e9494a
      https://github.com/bluez/bluez/commit/eee6a75adc93b6146f662c28b8295c9b92e9494a
  Author: Marcin Kraglak <marcin.kraglak@telink-semi.com>
  Date:   2023-01-30 (Mon, 30 Jan 2023)

  Changed paths:
    M AUTHORS

  Log Message:
  -----------
  AUTHORS: Update Marcin's email


  Commit: f367fa3c9fe591792f124db2c9d81b61f296afdf
      https://github.com/bluez/bluez/commit/f367fa3c9fe591792f124db2c9d81b61f296afdf
  Author: Marcin Kraglak <marcin.kraglak@telink-semi.com>
  Date:   2023-01-30 (Mon, 30 Jan 2023)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Fix Set Member Lock decoding

According to CSIS specification v1.0.1: "Allowed values for the Set
Member Lock characteristic are Unlocked (corresponding to the
numeric value 0x01) and Locked (corresponding to the numeric
value 0x02); all other values are RFU".


  Commit: 5845f003ac271d361b699a3d0140ee98fdf11db9
      https://github.com/bluez/bluez/commit/5845f003ac271d361b699a3d0140ee98fdf11db9
  Author: Brian Gix <brian.gix@gmail.com>
  Date:   2023-01-30 (Mon, 30 Jan 2023)

  Changed paths:
    M AUTHORS

  Log Message:
  -----------
  AUTHORS: modify Brian Gix email address


  Commit: 265c12dc96081b969a60e2b5baad6087940cd7be
      https://github.com/bluez/bluez/commit/265c12dc96081b969a60e2b5baad6087940cd7be
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2023-01-30 (Mon, 30 Jan 2023)

  Changed paths:
    M doc/mesh-api.txt

  Log Message:
  -----------
  doc/mesh: Add Remote Provisioning DBus APIs

Remote Provisioning (introduced in Mesh Profile Specification v1.1)

* Allows Provisioners to use a remote server to scan for and
  provision devices.

* Allows Config managers to reprovision existing nodes to:
	* Refresh Device Keys
	* Reassign Node Addresses
	* Refresh Node Composition


  Commit: f3243ecba0a2a062021e461afc4fdc91e480f510
      https://github.com/bluez/bluez/commit/f3243ecba0a2a062021e461afc4fdc91e480f510
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2023-01-30 (Mon, 30 Jan 2023)

  Changed paths:
    M Makefile.mesh
    M mesh/cfgmod-server.c
    M mesh/keyring.c
    M mesh/keyring.h
    M mesh/manager.c
    M mesh/mesh-config-json.c
    M mesh/mesh-config.h
    M mesh/model.c
    M mesh/node.c
    M mesh/node.h
    M mesh/pb-adv.c
    M mesh/pb-adv.h
    M mesh/prov-acceptor.c
    M mesh/prov-initiator.c
    M mesh/prov.h
    M mesh/provision.h
    A mesh/remprv-server.c
    A mesh/remprv.h

  Log Message:
  -----------
  mesh: Add Remote Provisioning

Add Remote Provisioning Server
Add Remote Provisioning Client
Remove local scanning/provisioning
Add delete-all dev key function
Add NPPI procedures


  Commit: c50ecca56654f3c1c4b3cc9f9402a64cca9164f8
      https://github.com/bluez/bluez/commit/c50ecca56654f3c1c4b3cc9f9402a64cca9164f8
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2023-01-30 (Mon, 30 Jan 2023)

  Changed paths:
    M tools/mesh-cfgclient.c
    M tools/mesh/cfgcli.c
    M tools/mesh/mesh-db.c
    M tools/mesh/mesh-db.h
    M tools/mesh/remote.c
    M tools/mesh/remote.h

  Log Message:
  -----------
  tools/mesh: Optimize for multiple RPR servers and NPPI

These changes allow the mesh-cfgclient tool to request remote node
compositions from page 128. Depending on the differences between
there and what is stored in the local configuration database, it may
recomend reprovisioning with NPPI-1 (Address Refresh) or NPPI-2
(Composition Refresh).

Additionally, NPPI-0 may be performed to refresh the Device Key only.


  Commit: 9923c09de57e558a8b85df12bed31b9be4d2ec9f
      https://github.com/bluez/bluez/commit/9923c09de57e558a8b85df12bed31b9be4d2ec9f
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2023-01-30 (Mon, 30 Jan 2023)

  Changed paths:
    M mesh/crypto.c
    M mesh/crypto.h

  Log Message:
  -----------
  mesh: Rename parameter list per crypto usage

The derived key generated by the "nkpk" salt and network master key is
used to create Private Beacons as of Mesh Profile Specification v1.1


  Commit: 2ff937b6aa5030f4330851e8c1140af88c03c752
      https://github.com/bluez/bluez/commit/2ff937b6aa5030f4330851e8c1140af88c03c752
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2023-01-30 (Mon, 30 Jan 2023)

  Changed paths:
    M unit/test-mesh-crypto.c

  Log Message:
  -----------
  unit/mesh:  Add unit testing of Mesh Private Beaconing

This includes the Sample Data from the Mesh Profile specification v1.1,
and validates that the beacon crypto functions work as expected.


  Commit: cbeca2fba171efc51cd1d84026c282d1247c40f8
      https://github.com/bluez/bluez/commit/cbeca2fba171efc51cd1d84026c282d1247c40f8
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2023-01-30 (Mon, 30 Jan 2023)

  Changed paths:
    M mesh/mesh-config-json.c
    M mesh/mesh-config.h

  Log Message:
  -----------
  mesh: Add storage of Mesh Private Beacon settings

If current storage does not exist in node.json, the Mesh Private
Beacon will be disabled.


  Commit: 6619b24cc23710c3074fe90c6510cb3688bee701
      https://github.com/bluez/bluez/commit/6619b24cc23710c3074fe90c6510cb3688bee701
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2023-01-30 (Mon, 30 Jan 2023)

  Changed paths:
    M Makefile.mesh
    A mesh/prv-beacon.h
    A mesh/prvbeac-server.c

  Log Message:
  -----------
  mesh: Add Mesh Private Beacon server

This initial server supports only the Mesh Private Beacon and returns
"Not Suppoerted" for Get/Set of Private GATT Proxy and Private Node
Identity beacons.


  Commit: 5ba57cf85140e2087fef0e617608ee33a04c5449
      https://github.com/bluez/bluez/commit/5ba57cf85140e2087fef0e617608ee33a04c5449
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2023-01-30 (Mon, 30 Jan 2023)

  Changed paths:
    M mesh/net-keys.c
    M mesh/net-keys.h
    M mesh/net.c
    M mesh/net.h
    M mesh/node.c

  Log Message:
  -----------
  mesh: Add Tx/Rx support of Mesh Private Beacons

With this change, we start evaluating received Mesh Private Beacons in
addition to the legacy Secure Network Beacons. We also add the ability
to request Tx of Mesh Private Beacons, which are regenerated with new
Random Nonce a minimum of every 0 - 2550 seconds.


  Commit: ebb219614108b3e227b9fde2ff3fdb8ec99512f7
      https://github.com/bluez/bluez/commit/ebb219614108b3e227b9fde2ff3fdb8ec99512f7
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2023-01-30 (Mon, 30 Jan 2023)

  Changed paths:
    M mesh/model.c
    M mesh/net-keys.c
    M mesh/net-keys.h
    M mesh/node.c
    M mesh/node.h
    M mesh/prvbeac-server.c

  Log Message:
  -----------
  mesh: Add internal Mesh Private Beacon model

Adds recgnition that the Mesh Private Beacon model is internal
and foundational, without bindings.


  Commit: cc8a4d858bccccc03899faf9bd5e25439813e15e
      https://github.com/bluez/bluez/commit/cc8a4d858bccccc03899faf9bd5e25439813e15e
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2023-01-30 (Mon, 30 Jan 2023)

  Changed paths:
    M tools/mesh-cfgclient.c
    M tools/mesh/cfgcli.c
    M tools/mesh/util.c

  Log Message:
  -----------
  tools/mesh: Add support for Mesh Private Beacons

This allows generation of Mesh Private Beacon server commands, and
recognition of the resulting Status messages.


  Commit: e71d0e802629bb939c7d518a2e33571fb996b72b
      https://github.com/bluez/bluez/commit/e71d0e802629bb939c7d518a2e33571fb996b72b
  Author: Brian Gix <brian.gix@intel.com>
  Date:   2023-01-30 (Mon, 30 Jan 2023)

  Changed paths:
    M mesh/net.c

  Log Message:
  -----------
  mesh: Switch beaconing net key

When transitioning from Phase 1 to Phase 2 of a network key and we are
beaconing, we need to halt the beaconing on the old key version, and
begin beaconing on the new key version.


  Commit: 4bdd7090f0dfd0692dcc410340ff831d4f89d27f
      https://github.com/bluez/bluez/commit/4bdd7090f0dfd0692dcc410340ff831d4f89d27f
  Author: Brian Gix <brian.gix@gmail.com>
  Date:   2023-01-30 (Mon, 30 Jan 2023)

  Changed paths:
    M mesh/crypto.c

  Log Message:
  -----------
  mesh: Fix Checksmatch warning


  Commit: 5045e9845b9fbe105ce833267184e7876721fd3b
      https://github.com/bluez/bluez/commit/5045e9845b9fbe105ce833267184e7876721fd3b
  Author: Brian Gix <brian.gix@gmail.com>
  Date:   2023-01-30 (Mon, 30 Jan 2023)

  Changed paths:
    M mesh/crypto.c

  Log Message:
  -----------
  mesh: Remove unused byte swap for ScanBuild


  Commit: 8787aed7fe0089c079884784131e630ddacc6d26
      https://github.com/bluez/bluez/commit/8787aed7fe0089c079884784131e630ddacc6d26
  Author: Inga Stotland <inga.stotland@intel.com>
  Date:   2023-01-30 (Mon, 30 Jan 2023)

  Changed paths:
    M tools/mesh-cfgtest.c

  Log Message:
  -----------
  tools/mesh-cfgtest: Support extended device composition

This adds support for extended device composition to account for
new fundamental models supported by bluetooth-meshd daemon.
Also, update to include explicit element locations and handle
different ordering of model IDs in the composition data.


  Commit: ca6546fe521360fcf905bc115b893f322e706cb2
      https://github.com/bluez/bluez/commit/ca6546fe521360fcf905bc115b893f322e706cb2
  Author: Sam James <sam@gentoo.org>
  Date:   2023-01-31 (Tue, 31 Jan 2023)

  Changed paths:
    M src/shared/util.c

  Log Message:
  -----------
  shared: define MAX_INPUT for musl

musl systems don't have MAX_INPUT. Just define it to _POSIX_MAX_INPUT
which musl does have if it's not already defined.

Note that on glibc, the values match anyway (as of glibc-2.36), and
indeed POSIX_MAX_INPUT has the same value on musl too.

Bug: https://bugs.gentoo.org/888467


  Commit: 17bcd2a37629cc12b683cc92dc51d124e0ab3fe1
      https://github.com/bluez/bluez/commit/17bcd2a37629cc12b683cc92dc51d124e0ab3fe1
  Author: Maheta, Abhay <abhay.maheshbhai.maheta@intel.com>
  Date:   2023-01-31 (Tue, 31 Jan 2023)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/media.c
    M profiles/audio/transport.c

  Log Message:
  -----------
  profiles: Add Support for Metadata, CID and VID

This adds support for Metadata, Company ID and Vendor Codec ID


  Commit: 33d99e12c37f6075d2b3819c30c1cf17fa52c57f
      https://github.com/bluez/bluez/commit/33d99e12c37f6075d2b3819c30c1cf17fa52c57f
  Author: Abhay Maheta <abhay.maheshbhai.maheta@intel.com>
  Date:   2023-01-31 (Tue, 31 Jan 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add support for Company ID, Vendor ID

This adds support for Company ID and Vendor Codec ID in  BAP profile.
This also adds handling of Vendor Specific Coding format for BAP
Profile.

Now it allows to enter zero codec capabilities for vendor codec.
In order to register zero codec capabilities, 0 shall be
entered when prompted.


  Commit: be5c49385e4d8403d773b2838369a5987e732ff0
      https://github.com/bluez/bluez/commit/be5c49385e4d8403d773b2838369a5987e732ff0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-01-31 (Tue, 31 Jan 2023)

  Changed paths:
    M src/shared/util.c

  Log Message:
  -----------
  shared/util: Check arguments on util_memcpy

This avoids having to check for !src or !len before calling util_memcpy
since otherwise it can cause runtime errors.


  Commit: d611a40ffc7bdc6b2e727550369a5aee7ffdb4cf
      https://github.com/bluez/bluez/commit/d611a40ffc7bdc6b2e727550369a5aee7ffdb4cf
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-01-31 (Tue, 31 Jan 2023)

  Changed paths:
    M doc/media-api.txt

  Log Message:
  -----------
  media-api: Make Vendor a uint32_t

Using two uint16_t requires the use of a container which makes things a
lot more complicated so this switch to use a single uint32_t.


  Commit: dcbdf5e67f3e4cba29f2fb9f0e5fcdad06540738
      https://github.com/bluez/bluez/commit/dcbdf5e67f3e4cba29f2fb9f0e5fcdad06540738
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-01-31 (Tue, 31 Jan 2023)

  Changed paths:
    M client/player.c
    M profiles/audio/media.c

  Log Message:
  -----------
  media: Rework support of Vendor to use uint32_t as type

This reworks the handlings of Vendor property to use a single uint32_t.


  Commit: 67395a3b357d492089e0606e7a5168e48651703d
      https://github.com/bluez/bluez/commit/67395a3b357d492089e0606e7a5168e48651703d
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-02-01 (Wed, 01 Feb 2023)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: set default value for BAP endpoint Vendor field

The "Vendor" field is optional, and should have an initialized valid
default value.

It has the default values in register_endpoint, but not in
app_register_endpoint, so make the latter match the former.


  Commit: f56205e3056428e2f9d49c8805d52240214c4915
      https://github.com/bluez/bluez/commit/f56205e3056428e2f9d49c8805d52240214c4915
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-02-13 (Mon, 13 Feb 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: fix local endpoint state to be per-client

ASCS v1.0 Sec. 4.1: "For each ASE characteristic (distinguished by their
attribute handles), the server shall expose separate ASE characteristic
values for each client."  In shared/bap.c, the ASE chrc value is
contained in bt_bap_endpoint struct.

As implemented currently, the same local ASE chrc value is shared
between all clients, in contradiction with the above.  Namely, the
bt_bap_endpoint is looked up based on the gatt_db_attribute handles, in
bap_get_endpoint and bap_get_endpoint_id, but the handles correspond to
the ASCS registrations, and do not depend on which client is in
question.

Fix this by moving the endpoint states to the bt_bap BAP session struct,
so that the ASE state is associated with the sessions, and each session
has separate state.


  Commit: 7b1b1a499cf334efa6b190ccaa8fb9ef223f66b4
      https://github.com/bluez/bluez/commit/7b1b1a499cf334efa6b190ccaa8fb9ef223f66b4
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-02-13 (Mon, 13 Feb 2023)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: clear the right transport when clearing BAP endpoint

Each configured BAP stream is associated with a transport, and only that
transport should be cleared when the stream's configuration is cleared.

This is required for multiple BAP clients to use the same Media1
endpoint, which is what we should aim for to follow the spirit in which
the endpoints work in ASCS.  Sound servers generally can handle this,
since the *Configuration calls provide the transport paths, and for
different clients they are associated with different devices.


  Commit: 3e2e3aa739040605e0fb0f8f1e69bfd9a7e607d1
      https://github.com/bluez/bluez/commit/3e2e3aa739040605e0fb0f8f1e69bfd9a7e607d1
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-02-13 (Mon, 13 Feb 2023)

  Changed paths:
    M doc/mgmt-api.txt

  Log Message:
  -----------
  doc: remove unimplemented Quality Report from MGMT settings

The Set Quality Report command was removed in
commit 0454e2d09570 ("mgmt: Add support for Mesh in the kernel"),
but the settings bit was not removed. It's also not implemented on
kernel side, so remove it now.


  Commit: 97ad0ecbfdd4934860e46984dc83aa876d7e448c
      https://github.com/bluez/bluez/commit/97ad0ecbfdd4934860e46984dc83aa876d7e448c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-02-13 (Mon, 13 Feb 2023)

  Changed paths:
    M doc/mgmt-api.txt

  Log Message:
  -----------
  doc: add MGMT setting for CIS features

Add definitions for new MGMT Controller Information settings bits,
indicating adapter Connected Isochronous Stream - Central/Peripheral
feature support.


  Commit: c35d32b19989a26a584d87e2639fe8abd0f7e63c
      https://github.com/bluez/bluez/commit/c35d32b19989a26a584d87e2639fe8abd0f7e63c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-02-13 (Mon, 13 Feb 2023)

  Changed paths:
    M lib/mgmt.h

  Log Message:
  -----------
  lib: Add defines for MGMT setting bits for CIS feature support


  Commit: 0f2f7a8fe270e30c49343849a284eb29116b5487
      https://github.com/bluez/bluez/commit/0f2f7a8fe270e30c49343849a284eb29116b5487
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-02-13 (Mon, 13 Feb 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: add MGMT setting bit names for CIS feature support

Add names for CIS Central/Peripheral MGMT bits:

@ MGMT Event: Command Complete (0x0001) plen 283  {0x0002} [hci0] 3.745117
      Read Controller Information (0x0004) plen 280
        Status: Success (0x00)
        Address: XX:XX:XX:XX:XX:XX (Intel Corporate)
        Version: Bluetooth 5.3 (0x0c)
        Manufacturer: Intel Corp. (2)
        Supported settings: 0x000ffeff
          Powered
          Connectable
          Fast Connectable
          Discoverable
          Bondable
          Link Security
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Advertising
          Secure Connections
          Debug Keys
          Privacy
          Controller Configuration
          Static Address
          PHY Configuration
          Wideband Speech
          CIS Central
          CIS Peripheral
        Current settings: 0x000c0ad1
          Powered
          Bondable
          Secure Simple Pairing
          BR/EDR
          Low Energy
          Secure Connections
          CIS Central
          CIS Peripheral
        Class: 0x7c0104
          Major class: Computer (desktop, notebook, PDA, organizers)
          Minor class: Desktop workstation
          Rendering (Printing, Speaker)
          Capturing (Scanner, Microphone)
          Object Transfer (v-Inbox, v-Folder)
          Audio (Speaker, Microphone, Headset)
          Telephony (Cordless telephony, Modem, Headset)
        Name: xxx
        Short name:


  Commit: 6f131929b832e9b9fbb2df301d31b4154a1b213b
      https://github.com/bluez/bluez/commit/6f131929b832e9b9fbb2df301d31b4154a1b213b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-02-13 (Mon, 13 Feb 2023)

  Changed paths:
    M tools/btmgmt.c

  Log Message:
  -----------
  tools/btmgmt: add MGMT setting bit names for CIS feature support

Add names for CIS Central/Peripheral MGMT setting bits:

[mgmt]# info
Index list with 1 item
hci0:	Primary controller
	addr XX:XX:XX:XX:XX:XX version 12 manufacturer 2 class 0x7c0104
	supported settings: powered connectable fast-connectable discoverable bondable link-security ssp br/edr le advertising secure-conn debug-keys privacy configuration static-addr phy-configuration wide-band-speech cis-central cis-peripheral
	current settings: powered bondable ssp br/edr le secure-conn cis-central cis-peripheral
	name xxx
	short name
hci0:	Configuration options
	supported options: public-address
	missing options:


  Commit: 94af45bc09a79443322e8f8bbbe0e7875856188f
      https://github.com/bluez/bluez/commit/94af45bc09a79443322e8f8bbbe0e7875856188f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-02-13 (Mon, 13 Feb 2023)

  Changed paths:
    M src/adapter.c
    M src/adapter.h

  Log Message:
  -----------
  adapter: Add function for checking adapter settings

Add function for checking adapter current settings.


  Commit: f2a29899297aa55307fe12521dca637f9080f683
      https://github.com/bluez/bluez/commit/f2a29899297aa55307fe12521dca637f9080f683
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-02-13 (Mon, 13 Feb 2023)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: Check adapter CIS support to add BAP in SupportedUUIDs

Don't indicate BAP support in SupportedUUIDs, if adapter supports
neither CIS Central nor Peripheral.


  Commit: 5d63ee2a58c60fdd9f73298d0686e63ef9e16273
      https://github.com/bluez/bluez/commit/5d63ee2a58c60fdd9f73298d0686e63ef9e16273
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-02-13 (Mon, 13 Feb 2023)

  Changed paths:
    M lib/mgmt.h

  Log Message:
  -----------
  mgmt: Use BIT macro when defining bitfields

This makes use of BIT macro when defining bitfields which makes it
clearer what bit it is toggling.


  Commit: 89f535894e59b66e70213ec9ab33fd158e8f54f1
      https://github.com/bluez/bluez/commit/89f535894e59b66e70213ec9ab33fd158e8f54f1
  Author: Dave Nicolson <david.nicolson@gmail.com>
  Date:   2023-02-14 (Tue, 14 Feb 2023)

  Changed paths:
    M attrib/gatttool.c

  Log Message:
  -----------
  gatttool: Use consistent spacing before brackets


  Commit: aa50506c9f40fa4f221583e2a8e99e513ebf9630
      https://github.com/bluez/bluez/commit/aa50506c9f40fa4f221583e2a8e99e513ebf9630
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-02-14 (Tue, 14 Feb 2023)

  Changed paths:
    M monitor/att.c

  Log Message:
  -----------
  monitor/att: Fix ASE frequency values

This fixes the printed hex value of some of the frequencies.


  Commit: f7d0599afe9b94aef494613acf10abe6af15342b
      https://github.com/bluez/bluez/commit/f7d0599afe9b94aef494613acf10abe6af15342b
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-02-15 (Wed, 15 Feb 2023)

  Changed paths:
    M profiles/audio/transport.c
    M profiles/audio/transport.h

  Log Message:
  -----------
  audio/transport: add media_transport_get_stream method for transports

Add a method for getting the audio stream associated with a media
transport.


  Commit: e9163b09a3dff9d33362ebccfe9eb031e8f8cdda
      https://github.com/bluez/bluez/commit/e9163b09a3dff9d33362ebccfe9eb031e8f8cdda
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-02-15 (Wed, 15 Feb 2023)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: look up BAP transports by their associated stream

To look up transports, use BAP stream pointers associated with them, not
the path strings stored in the stream user data. This makes it clearer
that transports presented to the sound server correspond to the actual
streams.  The Acquire/etc. of BAP transports are already tied to the
associated stream.

This fixes use-after-free crashes in pac_clear.  They occur because the
lifetime of the path string was either that of media transport or media
endpoint, which may be shorter than that of the BAP stream.  In such
case, pac_clear is entered with invalid pointer in stream user data,
leading to crash.  There are a few code paths for this, e.g. making
sound server delay its SetConfiguration response (e.g. gdb breakpoint)
to get dbus timeout, then disconnecting:

ERROR: AddressSanitizer: heap-use-after-free on address XXXX
READ of size 3 at 0x606000031640 thread T0
...
    #4 0x559891 in btd_debug src/log.c:117
    #5 0x46abfd in pac_clear profiles/audio/media.c:1096
    #6 0x79fcaf in bap_stream_clear_cfm src/shared/bap.c:914
    #7 0x7a060d in bap_stream_detach src/shared/bap.c:987
    #8 0x7a25ea in bap_stream_state_changed src/shared/bap.c:1210
    #9 0x7a29cd in stream_set_state src/shared/bap.c:1254
    #10 0x7be824 in stream_foreach_detach src/shared/bap.c:3820
    #11 0x71d15d in queue_foreach src/shared/queue.c:207
    #12 0x7beb98 in bt_bap_detach src/shared/bap.c:3836
    #13 0x5228cb in bap_disconnect profiles/audio/bap.c:1342
    #14 0x63247c in btd_service_disconnect src/service.c:305
freed by thread T0 here:
    #0 0x7f16708b9388 in __interceptor_free.part.0 (/lib64/libasan.so.8+0xb9388)
    #1 0x7f167071b8cc in g_free (/lib64/libglib-2.0.so.0+0x5b8cc)
    #2 0x7047b7 in remove_interface gdbus/object.c:660
    #3 0x70aef6 in g_dbus_unregister_interface gdbus/object.c:1394
    #4 0x47be30 in media_transport_destroy profiles/audio/transport.c:217
    #5 0x464ab9 in endpoint_remove_transport profiles/audio/media.c:270
    #6 0x464d26 in clear_configuration profiles/audio/media.c:292
    #7 0x464e69 in clear_endpoint profiles/audio/media.c:300
    #8 0x46516e in endpoint_reply profiles/audio/media.c:325
...

Fixes: 7b1b1a499cf3 ("media: clear the right transport when clearing BAP endpoint")


  Commit: 5d347b54714e0f2d750253be09b68b0c3119dd0a
      https://github.com/bluez/bluez/commit/5d347b54714e0f2d750253be09b68b0c3119dd0a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-02-15 (Wed, 15 Feb 2023)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: fix ASAN crash in pac_config_cb

Don't call configuration callback if stream's transport was cleared in
the meantime.  The clear callback is called just before the stream is
freed.

Fixes ASAN crash on disconnect while waiting for SetConfiguration DBus
reply:

ERROR: AddressSanitizer: heap-use-after-free on address 0x60b00002eb90
READ of size 8 at 0x60b00002eb90 thread T0
    #0 0x7a4892 in bap_stream_config_cfm_cb src/shared/bap.c:3201
    #1 0x4688fb in pac_config_cb profiles/audio/media.c:1010
    #2 0x462164 in media_endpoint_cancel profiles/audio/media.c:157
    #3 0x462243 in media_endpoint_cancel_all profiles/audio/media.c:165
    #4 0x46365b in clear_endpoint profiles/audio/media.c:297
    #5 0x463a21 in endpoint_reply profiles/audio/media.c:325
...
freed by thread T0 here:
    #0 0x7eff644b9388 in __interceptor_free.part.0 (/lib64/libasan.so.8+0xb9388)
    #1 0x78d8cc in bap_stream_free src/shared/bap.c:974
    #2 0x78dbc8 in bap_stream_detach src/shared/bap.c:991
    #3 0x78fa43 in bap_stream_state_changed src/shared/bap.c:1210
    #4 0x78fe26 in stream_set_state src/shared/bap.c:1254
    #5 0x7ab5ce in stream_foreach_detach src/shared/bap.c:3820
    #6 0x70ce06 in queue_foreach src/shared/queue.c:207
    #7 0x7ab942 in bt_bap_detach src/shared/bap.c:3836
    #8 0x51da7a in bap_disconnect profiles/audio/bap.c:1342
    #9 0x626e57 in btd_service_disconnect src/service.c:305


  Commit: 1bfd597fe8817c2cb4c710270f5a82511a9f94f4
      https://github.com/bluez/bluez/commit/1bfd597fe8817c2cb4c710270f5a82511a9f94f4
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-02-21 (Tue, 21 Feb 2023)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  audio/transport: update BAP transport QOS values when changed

Currently, BAP transport publishes on DBus QOS values obtained at
transport creation time. For BAP server the transport creation usually
occurs before stream QOS is configured, and these values are then all
zero. bap->sdu is also never set.

Update transport QOS values in DBus when stream state changes.  Since
nearly all QOS values are exposed in the transport, use bt_bap_qos to
store them there for simplicity.


  Commit: 1106b28be85ac9586d1758839226e163e9030ee2
      https://github.com/bluez/bluez/commit/1106b28be85ac9586d1758839226e163e9030ee2
  Author: Tedd Ho-Jeong An <tedd.an@intel.com>
  Date:   2023-02-21 (Tue, 21 Feb 2023)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  configure: Check ell path

If the 'enable-external-ell' is not specified in the configure parameter,
the build system assumes that the ELL source is located same level where
the bluez source is cloned. But the configure doens't check the folder
and user will get the build error while building the source.

This patch checks if the ELL source path if the 'enable-external-ell'
flag is not set and throws an error if the ELL doesn't exist.


  Commit: 46a5d2beccb2ea73f28502950f52032cf4811d37
      https://github.com/bluez/bluez/commit/46a5d2beccb2ea73f28502950f52032cf4811d37
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-02-23 (Thu, 23 Feb 2023)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: wait GATT client ready before service accept() if no cache

On device ATT attach, do not immediately call accept() for profiles, if
there is no cached data in GATT database. Instead, wait for service
resolution to complete, as likely accept() cannot succeed before that.

Several profiles (bap, vcp, midi, deviceinfo) assume that GATT
attributes are available when their accept() is called, returning
success even if not.  In this case, the services never find the remote
attributes and are not operable.  Other profiles (hog, batt, ...) fail
their accept which prompts core to retry after discovery, and work
correctly also in this case.

Fix the failing services by waiting for service resolution as necessary,
so profiles can assume the GATT DB has some content.


  Commit: fcdd38acf6b2cf6b81be1dd7ec3a240757f90728
      https://github.com/bluez/bluez/commit/fcdd38acf6b2cf6b81be1dd7ec3a240757f90728
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-02-27 (Mon, 27 Feb 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: fix crash unregistering media endpoint while streaming

Always free BAP stream in bt_bap_stream_release if it is not attached to
a client session, simplifying the cleanup.

Fixes the following ASAN crash is observed when media endpoint is
unregistered (stopping sound server) while streaming from remote BAP
client:

ERROR: AddressSanitizer: heap-use-after-free on address 0x60b0000474d8
READ of size 8 at 0x60b0000474d8 thread T0
    #0 0x7a27c6 in stream_set_state src/shared/bap.c:1227
    #1 0x7aff61 in remove_streams src/shared/bap.c:2483
    #2 0x71d2d0 in queue_foreach src/shared/queue.c:207
    #3 0x7b0152 in bt_bap_remove_pac src/shared/bap.c:2501
    #4 0x463cda in media_endpoint_destroy profiles/audio/media.c:179
    ...
0x60b0000474d8 is located 8 bytes inside of 112-byte region
freed by thread T0 here:
    #0 0x7f93b12b9388 in __interceptor_free.part.0 (/lib64/libasan.so.8+0xb9388)
    #1 0x7a0504 in bap_stream_free src/shared/bap.c:972
    #2 0x7a0800 in bap_stream_detach src/shared/bap.c:989
    #3 0x7a26d1 in bap_stream_state_changed src/shared/bap.c:1208
    #4 0x7a2ab4 in stream_set_state src/shared/bap.c:1252
    #5 0x7ab18a in stream_release src/shared/bap.c:1985
    #6 0x7c6919 in bt_bap_stream_release src/shared/bap.c:4572
    #7 0x7aff50 in remove_streams src/shared/bap.c:2482
    ...
previously allocated by thread T0 here:
    #0 0x7f93b12ba6af in __interceptor_malloc (/lib64/libasan.so.8+0xba6af)
    #1 0x71e9ae in util_malloc src/shared/util.c:43
    #2 0x79c2f5 in bap_stream_new src/shared/bap.c:766
    #3 0x7a4863 in ep_config src/shared/bap.c:1446
    #4 0x7a4f22 in ascs_config src/shared/bap.c:1481
    ...


  Commit: 80a45cb6a2402c820359dba593d9f5c68c30fb6e
      https://github.com/bluez/bluez/commit/80a45cb6a2402c820359dba593d9f5c68c30fb6e
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-02-27 (Mon, 27 Feb 2023)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h
    M tools/iso-tester.c

  Log Message:
  -----------
  bthost: Allow sending ISO packets with sequence number and timestamp

Change bthost_send_iso to take packet sequence number and timestamp, and
allow it to send timestamped HCI ISO data packets.

Currently, btdev passes through ISO packets, so this can also be used to
test RX timestamping.


  Commit: 2be849c2398bb57424053ffd6ca408ef907469bc
      https://github.com/bluez/bluez/commit/2be849c2398bb57424053ffd6ca408ef907469bc
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-02-27 (Mon, 27 Feb 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add test for central receiving timestamped ISO packet

This attempts to receive a timestamped HCI ISO data packet on central.

With kernel 6.2 HCI ISO packet parsing this test fails with
Bluetooth: Frame malformed (len 40, expected len 0)

Link: https://lore.kernel.org/linux-bluetooth/1fd2d4523c139deda93aab2c31f1508d79c32472.1676921889.git.pav@iki.fi/


  Commit: 1923f5dd9068308e880eab5609becc601b41d286
      https://github.com/bluez/bluez/commit/1923f5dd9068308e880eab5609becc601b41d286
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-02 (Thu, 02 Mar 2023)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Don't attempt to connect LE if ATT is already connected

This checks if an att instance already exists before attempting to
connect it once again.


  Commit: 24aeb319610b96f938ff7772e15bf0409813eaa4
      https://github.com/bluez/bluez/commit/24aeb319610b96f938ff7772e15bf0409813eaa4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-02 (Thu, 02 Mar 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client: Allow transport.send command to work with multiple transports

This enables transport.send to work with multiple transports instead of
sending one by one which can create synchronization problems.


  Commit: 36c234625bda881bc9d5bd99305706b86d117716
      https://github.com/bluez/bluez/commit/36c234625bda881bc9d5bd99305706b86d117716
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-02 (Thu, 02 Mar 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Cleanup requests on detach

If session is being detached any ongoing/queue request shall be
cancelled as well otherwise when the session is attach again they would
be invalid.


  Commit: d6f790f82de117fc16f5a6a8879be90599f85c8f
      https://github.com/bluez/bluez/commit/d6f790f82de117fc16f5a6a8879be90599f85c8f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-02 (Thu, 02 Mar 2023)

  Changed paths:
    M src/shared/gatt-client.c
    M src/shared/gatt-client.h

  Log Message:
  -----------
  share/gatt-client: Introduce idle callback

This introduces the concept of idle callback which can be used to get
notified when there is no more pending requests by the client.


  Commit: 15458c5e1071fa9fa23c373e3330ff45d1792e3f
      https://github.com/bluez/bluez/commit/15458c5e1071fa9fa23c373e3330ff45d1792e3f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-02 (Thu, 02 Mar 2023)

  Changed paths:
    M profiles/audio/media.c

  Log Message:
  -----------
  media: Fix not checking BREDR support for A2DP

A2DP shall depend on MGMT_SETTING_BREDR setting so the likes of
bluetoothctl -e don't attempt to register A2DP with controller that
are on LE only mode.


  Commit: 07bd8e3a720af1ff7cee85d771dfd39065d5ac11
      https://github.com/bluez/bluez/commit/07bd8e3a720af1ff7cee85d771dfd39065d5ac11
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-02 (Thu, 02 Mar 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Make use of bt_gatt_client_idle_register

This uses bt_gatt_client_idle_register to track when instance is ready
instead of using a dedicated queue to track requests.

Fixes: https://github.com/bluez/bluez/issues/485


  Commit: 57f15616abdef2a7a300018c9d32c723b2f9f743
      https://github.com/bluez/bluez/commit/57f15616abdef2a7a300018c9d32c723b2f9f743
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-02 (Thu, 02 Mar 2023)

  Changed paths:
    M profiles/audio/bap.c
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  bap: Fix crash on unexpected disconnect

If an unexpected disconnect happens while bt_bap_config is pending the
following trace can be observed, to fix it bt_bap_config is reworked so
it no longer attempts to create and config the stream in place, instead
it just return the new stream and the function is renamed to
bt_bap_stream_new:

Invalid write of size 4
   at 0x3980D8: config_cb (bap.c:395)
   by 0x4DF5A3: bap_req_complete (bap.c:3471)
   by 0x4E9D33: bap_req_detach (bap.c:3807)
   by 0x4E9D33: bt_bap_detach (bap.c:3819)
   by 0x4E9D33: bt_bap_detach (bap.c:3810)
   by 0x397AA9: bap_disconnect (bap.c:1342)
   by 0x4223E0: btd_service_disconnect (service.c:305)
   by 0x4974D8F: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.7200.3)
   by 0x438FC3: att_disconnected_cb (device.c:5160)
   by 0x49A6C6: queue_foreach (queue.c:207)
   by 0x4B463B: disconnect_cb (att.c:701)
   by 0x5054DF: watch_callback (io-glib.c:157)
   by 0x495BFAE: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.7200.3)
   by 0x49B12C7: ??? (in /usr/lib64/libglib-2.0.so.0.7200.3)
 Address 0x6576940 is 96 bytes inside a block of size 112 free'd
   at 0x48480E4: free (vg_replace_malloc.c:872)
   by 0x48F78D: remove_interface (object.c:660)
   by 0x490489: g_dbus_unregister_interface (object.c:1394)
   by 0x397BA8: ep_remove (bap.c:1330)
   by 0x49ACF4: queue_remove_if (queue.c:279)
   by 0x49B0AC: queue_remove_all (queue.c:321)
   by 0x397A7C: bap_disconnect (bap.c:1339)
   by 0x4223E0: btd_service_disconnect (service.c:305)
   by 0x4974D8F: g_slist_foreach (in /usr/lib64/libglib-2.0.so.0.7200.3)
   by 0x438FC3: att_disconnected_cb (device.c:5160)
   by 0x49A6C6: queue_foreach (queue.c:207)
   by 0x4B463B: disconnect_cb (att.c:701)
 Block was alloc'd at
   at 0x484586F: malloc (vg_replace_malloc.c:381)
   by 0x49B432: util_malloc (util.c:43)
   by 0x39A1D9: ep_register (bap.c:563)
   by 0x39A1D9: pac_found (bap.c:664)
   by 0x4E5FEA: bap_foreach_pac (bap.c:3980)
   by 0x4EA437: bap_notify_ready (bap.c:2736)
   by 0x4EA437: bap_idle (bap.c:3711)
   by 0x4B52F0: idle_notify (gatt-client.c:171)
   by 0x49ACF4: queue_remove_if (queue.c:279)
   by 0x49B0AC: queue_remove_all (queue.c:321)
   by 0x4C092C: notify_client_idle (gatt-client.c:180)
   by 0x4C092C: request_unref (gatt-client.c:199)
   by 0x4AACB5: destroy_att_send_op (att.c:209)
   by 0x4B2B88: handle_rsp (att.c:862)
   by 0x4B2B88: can_read_data (att.c:1052)
   by 0x5054DF: watch_callback (io-glib.c:157)


  Commit: 96ab7296cb92705de8aabcdc14d81386b564d452
      https://github.com/bluez/bluez/commit/96ab7296cb92705de8aabcdc14d81386b564d452
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-07 (Tue, 07 Mar 2023)

  Changed paths:
    M src/shared/att.c

  Log Message:
  -----------
  shared/att: Always queue BT_ATT_OP_MTU_REQ on the fixed channel

BT_ATT_OP_MTU_REQ shall only be sent on the so called fixed channel
since EATT channels shall use L2CAP procedure to update its MTU.


  Commit: 581aae6a2722e69479f4846e7b00c43fdf112b4c
      https://github.com/bluez/bluez/commit/581aae6a2722e69479f4846e7b00c43fdf112b4c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-07 (Tue, 07 Mar 2023)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix not always storing device info

When updating the device address check if the device is marked as
temporary before attempting to call store_device_info otherwise it will
have no effect and instead btd_device_set_temporary must be called.


  Commit: 3842320f450e0b40b205b8fd0ce13b8821d49b51
      https://github.com/bluez/bluez/commit/3842320f450e0b40b205b8fd0ce13b8821d49b51
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-07 (Tue, 07 Mar 2023)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt: Fix creating duplicated objects

This checks cid before attempting to create device, if the device is
using an RPA it could be that the MGMT event has not been processed yet
which would lead to create a second copy of the same device using its
identity address.


  Commit: ab3ff0d2cd5aab8bde5a99cf76e4771eefa7f7a0
      https://github.com/bluez/bluez/commit/ab3ff0d2cd5aab8bde5a99cf76e4771eefa7f7a0
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-09 (Thu, 09 Mar 2023)

  Changed paths:
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main: Disable EATT by default

EATT is causing some problem with some platforms as they also attempt to
configure it may cause a connection collision which needs to be handled
by the kernel.


  Commit: 1033a462377d9374e9240878357620a8ad368bbf
      https://github.com/bluez/bluez/commit/1033a462377d9374e9240878357620a8ad368bbf
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-09 (Thu, 09 Mar 2023)

  Changed paths:
    M src/device.c
    M src/device.h
    M src/gatt-client.c
    M src/gatt-database.c

  Log Message:
  -----------
  gatt: Use DEFER_SETUP for EATT channels

This makes use of DEFER_SETUP mechanism to do the following checks
before accepting the connection:

 - Checks a valid device object exits
 - Checks if initiator/central as if the peripheral start connecting it
   may cause collisions.
 - Checks if the limit of allowed connections has been reached.


  Commit: 4f34eeba1f5d39d1bb5d95f673ff5f02f47b0fce
      https://github.com/bluez/bluez/commit/4f34eeba1f5d39d1bb5d95f673ff5f02f47b0fce
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-09 (Thu, 09 Mar 2023)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  l2cap-tester: Add server tests for Ext-Flowctl

This adds the following tests:

L2CAP Ext-Flowctl Server - Success
L2CAP Ext-Flowctl Server - Nval SCID
L2CAP LE EATT Client - Success
L2CAP LE EATT Server - Success
L2CAP LE EATT Server - Reject


  Commit: a0847e005d33e40e8032207fd894f8422a943d91
      https://github.com/bluez/bluez/commit/a0847e005d33e40e8032207fd894f8422a943d91
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-10 (Fri, 10 Mar 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Update High Reliability presets

This updates High Reliability presets as published in BAP 1.0.1:

https://www.bluetooth.com/specifications/bap-1-0-1/


  Commit: 31ab084f072c335b5fbaab1c44ecaf899f5d5dda
      https://github.com/bluez/bluez/commit/31ab084f072c335b5fbaab1c44ecaf899f5d5dda
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-10 (Fri, 10 Mar 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Update High Reliability presets

This updates High Reliability presets as published in BAP 1.0.1:

https://www.bluetooth.com/specifications/bap-1-0-1/


  Commit: c1dd94cc7f810e72ded5ef3886208fbe7b35483c
      https://github.com/bluez/bluez/commit/c1dd94cc7f810e72ded5ef3886208fbe7b35483c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-10 (Fri, 10 Mar 2023)

  Changed paths:
    M src/shared/crypto.c
    M src/shared/crypto.h

  Log Message:
  -----------
  shared/crypto: Add bt_crypto_sirk

This adds bt_crypto_sirk which attempts to generate a unique SIRK using
the following steps:

 - Generate a hash (k) using the str as input
 - Generate a hash (sirk) using vendor, product, version and source as input
 - Encrypt sirk using k as LTK with sef function.


  Commit: c2e99aefd33790a1784cb3d9d80fef748961d423
      https://github.com/bluez/bluez/commit/c2e99aefd33790a1784cb3d9d80fef748961d423
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-10 (Fri, 10 Mar 2023)

  Changed paths:
    M src/shared/ad.h

  Log Message:
  -----------
  shared/ad: Add RSI data type

This adds BT_AD_CSIP_RSI advertising data type.


  Commit: 6477522e92e33da26d27064970ab0c183ab50166
      https://github.com/bluez/bluez/commit/6477522e92e33da26d27064970ab0c183ab50166
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-10 (Fri, 10 Mar 2023)

  Changed paths:
    A doc/set-api.rst

  Log Message:
  -----------
  doc: Add set-api

This adds set-api.rst which documents DeviceSet interface.


  Commit: 5bac4cddb191c8ce28ca40747b5d7b0247ae504c
      https://github.com/bluez/bluez/commit/5bac4cddb191c8ce28ca40747b5d7b0247ae504c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-10 (Fri, 10 Mar 2023)

  Changed paths:
    M doc/device-api.txt

  Log Message:
  -----------
  device-api: Add Set property

This adds Set property so clients are able to identify when a device
belongs to a set.


  Commit: 3815ad119dcdc03df2a027f0eda4979d8d601846
      https://github.com/bluez/bluez/commit/3815ad119dcdc03df2a027f0eda4979d8d601846
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-10 (Fri, 10 Mar 2023)

  Changed paths:
    M Makefile.am
    M src/adapter.c
    M src/device.c
    M src/device.h
    A src/set.c
    A src/set.h

  Log Message:
  -----------
  core: Add initial implementation of DeviceSet interface

This adds the initial implementation of DeviceSet interface as
documented in doc/set-api.rst.


  Commit: f95ffcc8b1fe67c4b0443747c08f8e9d853025cf
      https://github.com/bluez/bluez/commit/f95ffcc8b1fe67c4b0443747c08f8e9d853025cf
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-10 (Fri, 10 Mar 2023)

  Changed paths:
    M src/adapter.c
    M src/eir.c
    M src/eir.h

  Log Message:
  -----------
  core: Check if device has RSI

This checks if device is advertising an RSI and if so disregards if it
is not discoverable since other members can be.


  Commit: 7111c0039f5c14e46c6d26c60fec2091d69549c6
      https://github.com/bluez/bluez/commit/7111c0039f5c14e46c6d26c60fec2091d69549c6
  Author: Sathish Narasimman <sathish.narasimman@intel.com>
  Date:   2023-03-10 (Fri, 10 Mar 2023)

  Changed paths:
    M src/btd.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  main.conf: Add CSIP profile configurable options

This introduces option to configure main.conf that can be used to
configure co-ordinated set identification profile.


  Commit: d297a03b7a6169cb556f7fcdbb1ee81648bb2b5f
      https://github.com/bluez/bluez/commit/d297a03b7a6169cb556f7fcdbb1ee81648bb2b5f
  Author: Sathish Narasimman <sathish.narasimman@intel.com>
  Date:   2023-03-10 (Fri, 10 Mar 2023)

  Changed paths:
    M Makefile.am
    A src/shared/csip.c
    A src/shared/csip.h

  Log Message:
  -----------
  shared/csip: Add initial code for handling CSIP

This adds initial code for Coordinated Set Identification Profile.


  Commit: 9e1eb0a62b3f91d04fed6f79919f51684b4bdf1f
      https://github.com/bluez/bluez/commit/9e1eb0a62b3f91d04fed6f79919f51684b4bdf1f
  Author: Sathish Narasimman <sathish.narasimman@intel.com>
  Date:   2023-03-10 (Fri, 10 Mar 2023)

  Changed paths:
    M Makefile.plugins
    M configure.ac
    A profiles/audio/csip.c

  Log Message:
  -----------
  profiles: Add initial code for csip plugin

This adds initial code for csip plugin which handles Coordinated
set identification Profile and Coordinated Set Identification
Service.


  Commit: c446a64d461b7597ccb2b6bef0dd858b8ef01fd9
      https://github.com/bluez/bluez/commit/c446a64d461b7597ccb2b6bef0dd858b8ef01fd9
  Author: Sathish Narasimman <sathish.narasimman@intel.com>
  Date:   2023-03-10 (Fri, 10 Mar 2023)

  Changed paths:
    M tools/advtest.c

  Log Message:
  -----------
  tools: Add support to generate RSI using SIRK

The patch helps to generate Resolvable set identifier adv data.
which can be used as ADV data during advertisement.
It will be used to identify the device as part of setmember for
Coordinated set identification profile.
Example:
$<path to advtest/>advtest -i "761FAE703ED681F0C50B34155B6434FB"
SIRK: 761FAE703ED681F0C50B34155B6434FB
  RSI:  0x71 0xcb 0xbc 0x7e 0x01 0x84
    Random: bccb71
    Hash:   84017e


  Commit: 373bafc34ce6ed8a4dbd4276ae0d96d5753147c8
      https://github.com/bluez/bluez/commit/373bafc34ce6ed8a4dbd4276ae0d96d5753147c8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-10 (Fri, 10 Mar 2023)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Add support for DeviceSet proxy


  Commit: 815f779aa8e477e399b78f03c0ea0e75f0270c4a
      https://github.com/bluez/bluez/commit/815f779aa8e477e399b78f03c0ea0e75f0270c4a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-03-10 (Fri, 10 Mar 2023)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Use AdvertisingFlags when available

This prints devices not discoverable in grey so the user are able to
distict when for example set members are actually visible.


  Commit: 40576ac1badffb151ada76a90b89e85aa2ed9934
      https://github.com/bluez/bluez/commit/40576ac1badffb151ada76a90b89e85aa2ed9934
  Author: Inga Stotland <inga.stotland@gmail.com>
  Date:   2023-03-12 (Sun, 12 Mar 2023)

  Changed paths:
    M mesh/node.c

  Log Message:
  -----------
  mesh: Fix node when loading from storage

This fixes adding mandatory models (config server, remote provisioner)
to a node whose configuration is being loaded from storage:
mesh_model_add() was called with a wrong argument.

Was:     mesh_model_add(..., PRIMARY_ELE_IDX, ...);
Correct: mesh_model_add(..., ele->models, ...);


Compare: https://github.com/bluez/bluez/compare/a1736d8990ff...40576ac1badf
