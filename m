Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA4C38B14D
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 16:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785427687; cv=none; b=LK8pA86mrDVIVG0GAHMWKuiLx64kjsPse5yW+rMfXMptICL1NkkXHA9u+0j/21ZWK5wX28QaTqEZobWphlIumikeiHX5qgIQcAVdPbO91ZyLONdYBbny9ttbqB2eZ++wcCdIc99bd5/uv0GODskowux3TWqldrQc17fNu3X5S0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785427687; c=relaxed/simple;
	bh=DON+xAdKEmmim4qThnafUBdhRgpjD/0tKvb6wVZmFBs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lXaAMtBT13n2j7fJy2c4wiRhZObaGUuPWxM/u8WMUKhG6nHdw95RYhWQqbFYYW2wRqb3DAtNlz3IeB6XfsNswhAYWogIVGjXsqVhM1FvSDmby4yTFuwhCkfLPvm8m9Z2/0ZGkp5/WPUMaLV9Wv1Rzt1KvjgH9pbXTKg8BzjHYCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=f39NhbQn; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="f39NhbQn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785427684;
	bh=pQBXCSv5vYKsO3vOgDeeAKoG+CtxXsk331Q3f2/VPRk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=f39NhbQnEBZmArvuIYle7rbmsXmoMNbtTE6ulcua4tWlfQ3Nx7TFdxGajbmTdZhKj
	 Tz56gHU60Qy9Wy0BkKUpIl3PsONWw3g5m2JEHgxBIn/yMl9ciQOdC8V3omomrEuYXb
	 Qnq0zFdixEQ4iBDPLR4y4qr0Y6/zaAEtsQeldedg=
Received: from github.com (hubbernetes-node-c3a9ba1.va3-iad.github.net [10.48.167.54])
	by smtp.github.com (Postfix) with ESMTPA id DDAEA800B8E
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 09:08:04 -0700 (PDT)
Date: Thu, 30 Jul 2026 09:08:04 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/98e5a7-e45128@github.com>
Subject: [bluez/bluez] 2f94d6: shared: Add bcs_procedure_data aggregation and
 pro...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 2f94d65b8c80a879fffb0e82be391423d4992da6
      https://github.com/bluez/bluez/commit/2f94d65b8c80a879fffb0e82be391423d4992da6
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

  Changed paths:
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  shared: Add bcs_procedure_data aggregation and procedure data API

Define bcs_procedure_data to hold per-procedure CS results from both
the local initiator and remote reflector, including subevent step data,
selected TX powers, procedure enable config, CS config, sw_time values,
and BLE connection interval.

Add cs_proc_state with a 16-entry ring buffer in cstracker to track
procedures keyed by procedure counter, accumulating results
independently from each side until both report all-results-complete.

Update parse_mode_{0,1,2,3}, parse_step, and parse_subevent_steps with
output pointer parameters to capture remote reflector step data.
Introduce parse_cs_local_initiator_data() to store local HCI subevent
results, handling both initial and continuation events. Update
parse_ras_data_segments() to route decoded RAS subevent data into the
matching cs_proc_state as reflector results.

Add bt_rap_set_procedure_data_cb() to register a callback fired once
both local and remote results are complete for a given procedure.
Add bt_rap_set_local_sw_time(), bt_rap_set_remote_sw_time(), and
bt_rap_set_conn_interval() so callers such as rap_hci.c can supply the
CS capability sw_time and connection interval required by upper-layer
distance calculation algorithms.

Remove unwanted function rap_detached , fix for rap profile level
disconnections


  Commit: 6b74b0bb1f0077f9440016d235dd9aa0da23c2ff
      https://github.com/bluez/bluez/commit/6b74b0bb1f0077f9440016d235dd9aa0da23c2ff
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

  Changed paths:
    M profiles/ranging/rap.c
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles/ranging: Emit CS ProcedureData signal over D-Bus

Serialize completed BCS procedure data (subevent/step results,
CS config, and procedure-enable parameters) into a byte blob and
emit it via a new ProcedureData D-Bus signal on the CS interface,
so an external ranging estimation daemon can consume raw controller
measurements


  Commit: 1896d365decbb1f6c584a3a7827417c6057b10e7
      https://github.com/bluez/bluez/commit/1896d365decbb1f6c584a3a7827417c6057b10e7
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

  Changed paths:
    M doc/org.bluez.ChannelSounding1.rst

  Log Message:
  -----------
  doc: Update ProcedureData signal doc for byte-blob format

Document the create_context CS configuration parameter added
alongside the CS Create Config command.

Update the ProcedureData signal signature from dict to array{byte},
matching the byte-blob serialization now used in rap.c, and drop
the per-field dict documentation (procedureCounter, subevent
results, csConfigParam, etc.) that no longer applies since the
signal now carries an opaque binary blob instead of a structured
dict.


  Commit: 92f6ea8766d06e164ec3addfe75e7fdaa3e760ad
      https://github.com/bluez/bluez/commit/92f6ea8766d06e164ec3addfe75e7fdaa3e760ad
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

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


  Commit: a938cf48d0830a73833a15217f2f3f3191b91d8d
      https://github.com/bluez/bluez/commit/a938cf48d0830a73833a15217f2f3f3191b91d8d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

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


  Commit: 794eea61584650457aaf2ffa8ec9c8cb7a278e57
      https://github.com/bluez/bluez/commit/794eea61584650457aaf2ffa8ec9c8cb7a278e57
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

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


  Commit: 46f08703a1522fffd73261cac252ccdac23b51d6
      https://github.com/bluez/bluez/commit/46f08703a1522fffd73261cac252ccdac23b51d6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

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


  Commit: 071c21873dfab3286dc2895ebafd80357f256cf5
      https://github.com/bluez/bluez/commit/071c21873dfab3286dc2895ebafd80357f256cf5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

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


  Commit: 594eaab8e50e837fd9aa87e9ae49bfaeb35d5d06
      https://github.com/bluez/bluez/commit/594eaab8e50e837fd9aa87e9ae49bfaeb35d5d06
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding for Load Connection Subrate, SCI setting and event

Add decoding support for the new MGMT_OP_LOAD_CONN_SUBRATE (0x005C)
command, the MGMT_EV_CONN_SUBRATE (0x0033) event and the Shorter
Connection Interval setting bit (25) to btmon.


  Commit: 062bf7b40f9fdd61eac8a72adcab0ce87e4a44cd
      https://github.com/bluez/bluez/commit/062bf7b40f9fdd61eac8a72adcab0ce87e4a44cd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

  Changed paths:
    M doc/settings-storage.txt

  Log Message:
  -----------
  doc: Document ConnectionSubrate storage format

Document the [ConnectionSubrate] group in the device info file which
stores per-device connection subrate parameters for the SCI feature.


  Commit: db7e82d95f3110256ef0973c3bb2376c5a1317ec
      https://github.com/bluez/bluez/commit/db7e82d95f3110256ef0973c3bb2376c5a1317ec
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

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


  Commit: 9122389484228e430d621318e90d20baeb4fba64
      https://github.com/bluez/bluez/commit/9122389484228e430d621318e90d20baeb4fba64
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

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


  Commit: c76fbeb918d34843fecd1a701d6e6111e048ad8d
      https://github.com/bluez/bluez/commit/c76fbeb918d34843fecd1a701d6e6111e048ad8d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

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


  Commit: 3aefec4b4151753dfcdaf6912a40f9432203474c
      https://github.com/bluez/bluez/commit/3aefec4b4151753dfcdaf6912a40f9432203474c
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

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


  Commit: e45128f029ce4017fbee4e1c7d4b79ca3555cfe4
      https://github.com/bluez/bluez/commit/e45128f029ce4017fbee4e1c7d4b79ca3555cfe4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-07-30 (Thu, 30 Jul 2026)

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


Compare: https://github.com/bluez/bluez/compare/98e5a74736e2...e45128f029ce

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
