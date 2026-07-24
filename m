Received: from out-38.smtp.github.com (out-38.smtp.github.com [192.30.252.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A23367B73
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784923273; cv=none; b=O7QkHdLSA5E4/NTj6F/tvPYPq0veW8e3RrQrJfe2iF7V5E3mUn5v937vyk72tJl38hwdmdsD9zjvKBWnvqkFaiYgW6iSagmQNi1eRia0m/DEqTYNHVFbUYj+5BtL/fOce4ltsNeLdO/SAYqkShmeQb0Js4WbLrzX3P5t8fXErkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784923273; c=relaxed/simple;
	bh=bsy1IIlPdE51cPUVLIzD03+DD5M3SvM6VWa8NyLqmtw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=MHJvD46zR9ej1ufpdiMkCUNuWvcsbHGvIRvSHKW3i/K6OOqgF6wAK5Bw8kSuJO8rLhVK0UILd8j2ssQDCgMr4m7EMdwNitILpU3TdMLXb7QXiQaEfqjhyg8hxb6ckFQFVtRsIB4756oZb3EmgDuO9B1jAMuf+uvMOH1cx40kCs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CdOfbWLh; arc=none smtp.client-ip=192.30.252.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CdOfbWLh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784923270;
	bh=kWLfsMZSsLBFgd9KTQX4DRKL2mog40vzpyeNqbw6u64=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CdOfbWLhxIjeBmo1NOjUf0k1EHSRvusqW73CC61DkeTSREfgmTiqjhFSDb1Fyg6pC
	 A938mSNvBNHB5yNAbZqWmfdaEIsNIdO6AeW+hOogjhO8KpJVOrVmHXlb35hCCN7CyI
	 vv/iQWxsGjoFste5z5BCyLG2KDK3dYoga6zu9sCU=
Received: from github.com (hubbernetes-node-e0000f4.ash1-iad.github.net [10.56.130.67])
	by smtp.github.com (Postfix) with ESMTPA id 2C32F920AF8
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 13:01:10 -0700 (PDT)
Date: Fri, 24 Jul 2026 13:01:10 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1134176/000000-802bba@github.com>
Subject: [bluez/bluez] b8079b: input/hog-lib: Add discovery support for HIDS
 1.1 ...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1134176
  Home:   https://github.com/bluez/bluez
  Commit: b8079b7eda9c20118cb3e6d6300143f81f6b4598
      https://github.com/bluez/bluez/commit/b8079b7eda9c20118cb3e6d6300143f81f6b4598
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-24 (Fri, 24 Jul 2026)

  Changed paths:
    M profiles/input/hog-lib.c

  Log Message:
  -----------
  input/hog-lib: Add discovery support for HIDS 1.1 SCI attributes

Add support for discovering and reading HIDS 1.1 SCI (Subrated
Connection Interval) characteristics:

 - HID SCI Mode (0x2c39)
 - HID SCI Information (0x2c3a)

When the HID Information flags indicate SCI is supported (bit 2),
the SCI Mode and SCI Information characteristics are read after
the HID Information is obtained.


  Commit: bf1800e6990e665681d4574d6caf5b9da50bb195
      https://github.com/bluez/bluez/commit/bf1800e6990e665681d4574d6caf5b9da50bb195
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-24 (Fri, 24 Jul 2026)

  Changed paths:
    M emulator/btdev.c
    M emulator/btdev.h
    M emulator/hciemu.c
    M emulator/hciemu.h

  Log Message:
  -----------
  emulator/btdev: Add emulation support for HIDS 1.1 SCI commands

Add BTDEV_TYPE_BREDRLE62 device type with support for Shorter
Connection Interval (SCI) feature from Bluetooth 6.2 spec:

 - LE Connection Rate Request (0x20a1)
 - LE Set Default Rate Parameters (0x20a2)
 - LE Read Minimum Supported Connection Interval (0x20a3)
 - LE Connection Rate Change event (0x37)
 - Shorter Connection Intervals feature bits


  Commit: 9e95653a2579228b4c96c561d1728b770e22a715
      https://github.com/bluez/bluez/commit/9e95653a2579228b4c96c561d1728b770e22a715
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-24 (Fri, 24 Jul 2026)

  Changed paths:
    M doc/mgmt-protocol.rst
    M lib/bluetooth/mgmt.h

  Log Message:
  -----------
  mgmt: Add Shorter Connection Interval setting and Load Connection Subrate

Add the Shorter Connection Interval setting bit (25) to indicate
controller support for SCI feature.

Add the Load Connection Subrate command (0x005C) which allows
loading connection subrate parameters for devices that support
shorter connection intervals as defined in Bluetooth 6.2.


  Commit: e548c2088f85d1f1d14c46368440520aa83d09a8
      https://github.com/bluez/bluez/commit/e548c2088f85d1f1d14c46368440520aa83d09a8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-24 (Fri, 24 Jul 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add tests for SCI setting and Load Connection Subrate

Add HCIEMU_TYPE_BREDRLE62 device type for testing Bluetooth 6.2
features and add test cases:

- Set Low Energy on 6.2 - SCI Setting: verifies that the SCI
  setting bit (25) is reported in supported/current settings
  for a 6.2 controller.
- Load Connection Subrate - Invalid Params 1: verifies invalid
  parameters are rejected.
- Load Connection Subrate - Success 1: verifies loading valid
  connection subrate parameters succeeds.


  Commit: 8e759525973b6437d95789f50cfe9b1fae0a1b5c
      https://github.com/bluez/bluez/commit/8e759525973b6437d95789f50cfe9b1fae0a1b5c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-24 (Fri, 24 Jul 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Add support for loading connection subrate parameters

Implement load_conn_subrate() to load per-device connection subrate
parameters via the new MGMT_OP_LOAD_CONN_SUBRATE command. Parameters
are read from the [ConnectionSubrate] section of device info files
and sent to the kernel when the SCI setting is supported.

The subrate parameters include connection interval range, subrate
factor range, max latency, continuation number, and supervision
timeout as defined in the Bluetooth 6.2 SCI feature.


  Commit: 1957f90b8d6e892f26d7b9b2b207df8fac160367
      https://github.com/bluez/bluez/commit/1957f90b8d6e892f26d7b9b2b207df8fac160367
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-24 (Fri, 24 Jul 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding for Load Connection Subrate, SCI setting and event

Add decoding support for the new MGMT_OP_LOAD_CONN_SUBRATE (0x005C)
command, the MGMT_EV_CONN_SUBRATE (0x0033) event and the Shorter
Connection Interval setting bit (25) to btmon.


  Commit: 86c95a54bdd553e812dfa0b4de8fe3fbeeb1d18e
      https://github.com/bluez/bluez/commit/86c95a54bdd553e812dfa0b4de8fe3fbeeb1d18e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-24 (Fri, 24 Jul 2026)

  Changed paths:
    M doc/settings-storage.txt

  Log Message:
  -----------
  doc: Document ConnectionSubrate storage format

Document the [ConnectionSubrate] group in the device info file which
stores per-device connection subrate parameters for the SCI feature.


  Commit: 1368303ac4cadb18e4f216487a4bce2fa81caa4e
      https://github.com/bluez/bluez/commit/1368303ac4cadb18e4f216487a4bce2fa81caa4e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-24 (Fri, 24 Jul 2026)

  Changed paths:
    M client/mgmt.c
    M doc/bluetoothctl-mgmt.rst

  Log Message:
  -----------
  client/mgmt: Add conn-subrate command

Add conn-subrate command to load connection subrate parameters
for a device via MGMT_OP_LOAD_CONN_SUBRATE.

Usage:
  conn-subrate [-t type] <address> <min_interval> <max_interval> \
               <subrate_min> <subrate_max> <max_latency> \
               <cont_num> <supv_timeout>


  Commit: 66abad66bda8b2576586341d2e0c0ab9a259979c
      https://github.com/bluez/bluez/commit/66abad66bda8b2576586341d2e0c0ab9a259979c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-24 (Fri, 24 Jul 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add HIDS recommended SCI parameter tests

Add Load Connection Subrate test cases using the recommended
connection subrate parameters from the HOGP v1.2 specification for
each of the four HID modes:

 - Fast: interval 1.25-5 ms, latency 0, subrate 1-4, cont_num 3
 - Default: interval 7.5-15 ms, latency 0, subrate 1-4, cont_num 0
 - Low Power: interval 7.5-15 ms, latency 100, subrate 1-4, cont_num 0
 - Full Range: interval 1.25-15 ms, latency 0, subrate 1-4, cont_num 1

Supervision timeouts are computed as (1 + Peripheral Latency) *
Subrate Max * Connection Interval Max * 2 per the spec.


  Commit: 8d456530d8681ec9034def6892634273d71f6634
      https://github.com/bluez/bluez/commit/8d456530d8681ec9034def6892634273d71f6634
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-24 (Fri, 24 Jul 2026)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  l2cap-tester: Add SCI mode tests for LE client connections

Add L2CAP LE client connection tests that load Connection Subrate
parameters (via MGMT_OP_LOAD_CONN_SUBRATE) before establishing the
connection, using the HOGP v1.2 recommended values for each of the
four HID SCI modes:

 - Fast: interval 1.25-5 ms, latency 0, subrate 1-4, cont_num 3
 - Default: interval 7.5-15 ms, latency 0, subrate 1-4, cont_num 0
 - Low Power: interval 7.5-15 ms, latency 100, subrate 1-4, cont_num 0
 - Full Range: interval 1.25-15 ms, latency 0, subrate 1-4, cont_num 1

Add the test_l2cap_le_62 macro (HCIEMU_TYPE_BREDRLE62) since SCI
requires a 6.2 controller. The subrate parameters are loaded with
the client's runtime bdaddr during setup_powered_client before the
outgoing LE connection is initiated.


  Commit: 97358b9ca2ce3c7bcdb2f4bd50a68b4c83bd43a2
      https://github.com/bluez/bluez/commit/97358b9ca2ce3c7bcdb2f4bd50a68b4c83bd43a2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-24 (Fri, 24 Jul 2026)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  emulator/bthost: Add LE Connection Rate Request support

Add bthost_le_conn_rate() to send the LE Connection Rate Request
(0x20a1) command for a given connection handle.

Also handle the LE Connection Rate Change event (0x37).

This allows testing a peripheral (server) handling of the Shorter
Connection Interval feature by having the emulated central initiate
the connection rate request on connect.


  Commit: 802bba740135156256ceff6b8d127c75a83c0dc4
      https://github.com/bluez/bluez/commit/802bba740135156256ceff6b8d127c75a83c0dc4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-24 (Fri, 24 Jul 2026)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  l2cap-tester: Add SCI mode tests for LE server connections

Add L2CAP LE server connection tests that exercise the peripheral
side of the Shorter Connection Interval feature. The emulated client
(central) is configured via bthost_le_conn_rate() to send an LE
Connection Rate Request once connected, using the HOGP v1.2
recommended values for each of the four HID SCI modes (Fast, Default,
Low Power, Full Range).


Compare: https://github.com/bluez/bluez/compare/b8079b7eda9c%5E...802bba740135

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
