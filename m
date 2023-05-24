Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4622C77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 May 2023 19:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjEXTb3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 24 May 2023 15:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjEXTb2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 24 May 2023 15:31:28 -0400
Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A0AA4
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 12:31:26 -0700 (PDT)
Received: from github.com (hubbernetes-node-05fbcf7.ac4-iad.github.net [10.52.135.36])
        by smtp.github.com (Postfix) with ESMTPA id 31FFD520083
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 May 2023 12:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
        s=pf2023; t=1684956686;
        bh=RzHXqeuiU+p6mTulvPwC8hdEqxObflWVsiCXJTUFPY4=;
        h=Date:From:To:Subject:From;
        b=Mo2brjQZ8kXvMjQ7ml+Rkvlt9+NLaNPRvgNYW/gKkb5nPEDGjtXPey5Y1BW9BkqN/
         OtYtrGcN/PLP6zTBbnoseNm0+7uvaR2j+Ov/VlbbAZUH8mynTQjQSmgB9KCT3QMVBf
         eSz3Qw7l8gWUy6CxFgjP7hhRqPp9P5IIaREIxkZc=
Date:   Wed, 24 May 2023 12:31:26 -0700
From:   Luiz Augusto von Dentz <noreply@github.com>
To:     linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8c452c-718f27@github.com>
Subject: [bluez/bluez] 93d0d8: mesh: Update the behavior of --io option
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
  Commit: 93d0d8b2fc696212743be2fe9cedcf0edb1073d4
      https://github.com/bluez/bluez/commit/93d0d8b2fc696212743be2fe9cedcf0edb1073d4
  Author: Inga Stotland <inga.stotland@gmail.com>
  Date:   2023-05-12 (Fri, 12 May 2023)

  Changed paths:
    M mesh/bluetooth-meshd.rst.in
    M mesh/main.c
    M mesh/mesh-io-generic.c
    M mesh/mesh-io.c
    M mesh/mesh-mgmt.c
    M mesh/mesh-mgmt.h

  Log Message:
  -----------
  mesh: Update the behavior of --io option

This aligns the behavior of command line option --io to
add new "auto" value and modify the behavior of "generic"
value:

*auto* - Use first available controller: via MGMT interface
if kernel supports it, otherwise, via raw HCI socket (i.e.,
default to *generic*).

*generic:[hci]<index>* - Use generic HCI io on interface hci<index>

The default value is now *auto*, whereas *generic* is used
only if the specific HCI controller is explicitly specified.


  Commit: 67fd8479f11c12e396494fe80cd1965ee7ff4500
      https://github.com/bluez/bluez/commit/67fd8479f11c12e396494fe80cd1965ee7ff4500
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-12 (Fri, 12 May 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix crashes accessing metadata

If metadata is not set the respective iovec is left NULL so it needs to
be checked before accessing its fields.


  Commit: 24b4ba1a393618b0c6b3b33f6eaa1371bfe97a6f
      https://github.com/bluez/bluez/commit/24b4ba1a393618b0c6b3b33f6eaa1371bfe97a6f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-12 (Fri, 12 May 2023)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix not sending ASE Receiver Stop Ready

This fixes not sending ASE Receiver Stop Ready if stream is on disabling
state when CIS is disconnected.

Fixes: https://github.com/bluez/bluez/issues/516


  Commit: fe16cf2a7ee343e6741bc1ef8f45f4f9dbf5c8a2
      https://github.com/bluez/bluez/commit/fe16cf2a7ee343e6741bc1ef8f45f4f9dbf5c8a2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-12 (Fri, 12 May 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add support to Max Transports in endpoint.register

[bluetooth]# endpoint.register 00002bc9-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): 1
[/local/endpoint/ep0] CIG (auto/value): a
[/local/endpoint/ep0] CIS (auto/value): a


  Commit: 1707c35771b447e39d19ebcc477e46e26d5870b5
      https://github.com/bluez/bluez/commit/1707c35771b447e39d19ebcc477e46e26d5870b5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-12 (Fri, 12 May 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix not checking for SupportedUUIDs

When registering an endpoint it should always check for SupportedUUIDs.


  Commit: f3977023f93d1ccfe301ed18a8b7aa866a52ebd2
      https://github.com/bluez/bluez/commit/f3977023f93d1ccfe301ed18a8b7aa866a52ebd2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-12 (Fri, 12 May 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add codec as parameter to endpoint.presets

This changes endpoint.presets command to take codec as parameter.


  Commit: 67c5824fd071a758756bbb96f167a0d18c4c8520
      https://github.com/bluez/bluez/commit/67c5824fd071a758756bbb96f167a0d18c4c8520
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-15 (Mon, 15 May 2023)

  Changed paths:
    M src/profile.c
    M src/profile.h

  Log Message:
  -----------
  profile: Add support for experimental flag

This adds experimental field to btd_profile so the plugin can indicate
drivers that depends on experimental to be enabled.


  Commit: da762dfa0255aed6f05a2b83fb967eefdccbf194
      https://github.com/bluez/bluez/commit/da762dfa0255aed6f05a2b83fb967eefdccbf194
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-15 (Mon, 15 May 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Mark driver as experimental

This uses the btd_profile.experimental to mark the driver as
experimental.


  Commit: bd14ad2e1f50a9ecd6c17f6f1b819866e06e0cea
      https://github.com/bluez/bluez/commit/bd14ad2e1f50a9ecd6c17f6f1b819866e06e0cea
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-15 (Mon, 15 May 2023)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Mark driver as experimental

This uses the btd_profile.experimental to mark the driver as
experimental.


  Commit: 16da92601f4af95b24f60abf3c72bcc5136ddd52
      https://github.com/bluez/bluez/commit/16da92601f4af95b24f60abf3c72bcc5136ddd52
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-15 (Mon, 15 May 2023)

  Changed paths:
    M profiles/audio/csip.c

  Log Message:
  -----------
  csip: Mark driver as experimental

This uses the btd_profile.experimental to mark the driver as
experimental.


  Commit: 62cbb2a9f57dc2b4ebeb33e5f8fb9841c3f32f96
      https://github.com/bluez/bluez/commit/62cbb2a9f57dc2b4ebeb33e5f8fb9841c3f32f96
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-15 (Mon, 15 May 2023)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  mcp: Mark driver as experimental

This uses the btd_profile.experimental to mark the driver as
experimental.


  Commit: 2fa20fe9fc4a9e986667d35d3cb2b40d89c9ad9b
      https://github.com/bluez/bluez/commit/2fa20fe9fc4a9e986667d35d3cb2b40d89c9ad9b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-15 (Mon, 15 May 2023)

  Changed paths:
    M profiles/audio/vcp.c

  Log Message:
  -----------
  vcp: Mark driver as experimental

This uses the btd_profile.experimental to mark the driver as
experimental.


  Commit: ce7cd9fb0611eb3ddf74707268d82005161ffb99
      https://github.com/bluez/bluez/commit/ce7cd9fb0611eb3ddf74707268d82005161ffb99
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-15 (Mon, 15 May 2023)

  Changed paths:
    M src/plugin.c

  Log Message:
  -----------
  plugin: Treat -ENOTSUP as -ENOSYS

If plugin .init returns -ENOTSUP treat it as the system doesn't
support the driver since that is the error returned by
btd_profile_register when experimental is disabled.


  Commit: 28917a3c7a4ec1078e5cb4adf2652e36f65f6034
      https://github.com/bluez/bluez/commit/28917a3c7a4ec1078e5cb4adf2652e36f65f6034
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-16 (Tue, 16 May 2023)

  Changed paths:
    M src/adapter.c
    M src/adapter.h

  Log Message:
  -----------
  adapter: Add support for experimental flag

This adds experimental field to btd_adapter_driver so the plugin can
indicate drivers that depends on experimental to be enabled.


  Commit: 943be6271d77ff7847ead05c0f7ade5565073979
      https://github.com/bluez/bluez/commit/943be6271d77ff7847ead05c0f7ade5565073979
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-16 (Tue, 16 May 2023)

  Changed paths:
    M plugins/admin.c

  Log Message:
  -----------
  admin: Mark driver as experimental

This uses the btd_profile.experimental to mark the driver as
experimental.


  Commit: 2c94ab92cb0e9e8c2493340378d6d29ef467a6ac
      https://github.com/bluez/bluez/commit/2c94ab92cb0e9e8c2493340378d6d29ef467a6ac
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-16 (Tue, 16 May 2023)

  Changed paths:
    M src/btd.h
    M src/main.c

  Log Message:
  -----------
  main: Rework config option parsing

This rework config option parsing adding helper function to make it
simpler to parse new options.


  Commit: a0a10f8c9d78d9add578d9ff79c7ad7e5e681f1a
      https://github.com/bluez/bluez/commit/a0a10f8c9d78d9add578d9ff79c7ad7e5e681f1a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-05-17 (Wed, 17 May 2023)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: revert udevd and audio support

Tests running inside the VM don't need access to sound cards running on
the host.

This reverts commit 91a48af52efb0751fab396b2b9026c9186b10b88
This reverts commit e20e7e0b05c7edb74255c9b092916ac5bb99c97f


  Commit: 86b8d4192dbd00b7c1d4f75e4536636070c2f4e7
      https://github.com/bluez/bluez/commit/86b8d4192dbd00b7c1d4f75e4536636070c2f4e7
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-05-17 (Wed, 17 May 2023)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  tools/test-runner: add option to start Pipewire inside the VM

Add option for launching Pipewire inside the VM to serve Bluetooth
endpoints, which can be used in tests.

Make the option to optionally take path to the audio daemon, so e.g.
Pulseaudio support can be added later.


  Commit: 9526ef46e4655ceead94fca04baf7060bd68bf22
      https://github.com/bluez/bluez/commit/9526ef46e4655ceead94fca04baf7060bd68bf22
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-17 (Wed, 17 May 2023)

  Changed paths:
    M monitor/main.c
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Fix using PACKET_FILTER_SHOW_SCO_DATA for ISO packets

This fixes the uses of PACKET_FILTER_SHOW_SCO_DATA for ISO packets and
introduce a dedicated flag for it in the form of
PACKET_FILTER_SHOW_ISO_DATA which can be enabled with use of -I/--iso.


  Commit: e99fbb5e4eead6c1d667b55355940d0a88616465
      https://github.com/bluez/bluez/commit/e99fbb5e4eead6c1d667b55355940d0a88616465
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-18 (Thu, 18 May 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix not parsing BT_HCI_EVT_NUM_COMPLETED_PACKETS properly

BT_HCI_EVT_NUM_COMPLETED_PACKETS may contain multiple handles but the
code was just parsing the very first one.


  Commit: cd176eb2d444eee0255f32c26dec0308179e5f2e
      https://github.com/bluez/bluez/commit/cd176eb2d444eee0255f32c26dec0308179e5f2e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-18 (Thu, 18 May 2023)

  Changed paths:
    M monitor/broadcom.c
    M monitor/intel.c
    M monitor/msft.c
    M monitor/packet.c
    M monitor/packet.h
    M monitor/vendor.h

  Log Message:
  -----------
  monitor: Add latency when decoding BT_HCI_EVT_NUM_COMPLETED_PACKETS

This adds latency, min-max, and median information when decoding
BT_HCI_EVT_NUM_COMPLETED_PACKETS so it works similarly to --analyze:

> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 256 Address: XX:XX:XX:XX:XX:XX
        Count: 1
        Latency: 23 msec (2-66 msec ~19 msec)


  Commit: a88c74e29b6ed7bc1e7e15ed4da2a58dc9b1bdf8
      https://github.com/bluez/bluez/commit/a88c74e29b6ed7bc1e7e15ed4da2a58dc9b1bdf8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-05-22 (Mon, 22 May 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: always use DEFER_SETUP for multiple CIS in same CIG

There is a race between multiple connect() for CIS in the same CIG.
connect() will both reconfigure the CIG and connect the CIS, but CIG
cannot be reconfigured once one CIS has already connected.  That these
tests pass currently relies on some timing/event ordering in the
emulator.

Connecting multiple CIS in same CIG is meant to be done using
DEFER_SETUP, so change the tests to use it, so we test the intended
usage.


  Commit: 195b9abbae0e0a17e9f8217c67f7c12ccefa521a
      https://github.com/bluez/bluez/commit/195b9abbae0e0a17e9f8217c67f7c12ccefa521a
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-05-22 (Mon, 22 May 2023)

  Changed paths:
    M src/shared/tester.c

  Log Message:
  -----------
  shared/tester: retain test failure status

If a test has called tester_test_failed, consider the test failed, even
if the test also called tester_test_passed/abort.

This avoids reporting success for misbehaving tests that call the
status report functions multiple times.


  Commit: 678265f37c2800b73c1ff354fb1ef860c24b041f
      https://github.com/bluez/bluez/commit/678265f37c2800b73c1ff354fb1ef860c24b041f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-05-22 (Mon, 22 May 2023)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: support multiple CIG

Add support for more than one CIG simultaneously.


  Commit: 0c32cfdf94624fcfc3ac329f313d9e48311b52a7
      https://github.com/bluez/bluez/commit/0c32cfdf94624fcfc3ac329f313d9e48311b52a7
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-05-22 (Mon, 22 May 2023)

  Changed paths:
    M emulator/btdev.c
    M monitor/bt.h

  Log Message:
  -----------
  btdev: report right reason for local Disconnect complete

Disconnect initiated by local host should get Connection Terminated by
Local Host (0x16) as termination reason.


  Commit: 06aa422145de456ec153a0d062a7e7ef8630cdc0
      https://github.com/bluez/bluez/commit/06aa422145de456ec153a0d062a7e7ef8630cdc0
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2023-05-22 (Mon, 22 May 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add tests for AC 1 + 2

Add tests connecting two CIS using different CIG_ID, with fixed and
auto-allocated IDs.

ISO AC 1 + 2 - Success
ISO AC 1 + 2 CIG 0x01/0x02 - Success

The CIS are connected sequentially so that the first is closed after the
second is connected. In the auto/auto case the kernel shall pick a new
CIG_ID since the first CIG_ID is no longer in a configurable state.


  Commit: 98a9a3c48ce8ce6017672a05176f949ea9f40980
      https://github.com/bluez/bluez/commit/98a9a3c48ce8ce6017672a05176f949ea9f40980
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-23 (Tue, 23 May 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Make QoS parameters reflect the tests names

AC 1 + 2 tests shall use their respective QoS parameters.


  Commit: 718f27d09fc129d0b94ef61192482ac7e18cbaed
      https://github.com/bluez/bluez/commit/718f27d09fc129d0b94ef61192482ac7e18cbaed
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-05-23 (Tue, 23 May 2023)

  Changed paths:
    M monitor/l2cap.c
    M monitor/l2cap.h
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Add latency information per channel

This attempts to print latency information per channel in addition to
per connection/handle:

> HCI Event: Number of Completed Packets (0x13) plen 5
        Num handles: 1
        Handle: 256 Address: XX:XX:XX:XX:XX:XX
        Count: 1
        Latency: 15 msec (3-39 msec ~18 msec)
        Channel: 68 [PSM 25 mode Basic (0x00)] {chan 2}
        Channel Latency: 15 msec (6-35 msec ~18 msec)


Compare: https://github.com/bluez/bluez/compare/8c452c2ec173...718f27d09fc1
