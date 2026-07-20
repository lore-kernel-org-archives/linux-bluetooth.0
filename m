Received: from out-42.smtp.github.com (out-42.smtp.github.com [192.30.252.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8162FB97D
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577373; cv=none; b=FELXV1GwyfVJQQH7CZQbOXr7TTfMkqAJh7up9Eh7UIsWtGpQ4ehOpHjt/kRjMP83DizdMwcSvboEf102YuzywcFNU471vOWrjlZJNN05/p9c08pyv+KzULgJV7hnUcJl8CpJvs7dUMHoCQ6oVgRZK0wP4ESySIp0cUHf7Txodn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577373; c=relaxed/simple;
	bh=+KxS+LULwMvnGrKTMN2H+Et3QQJNfxusAFhZob5+Fj0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=q5CYXxPjThbuMjatRex+BgSXoHQm9l1ITG/36btgJSIHmj+zEZWH3m4ijpD0gnwnn9oV997EgFYEyDeyJuZit4iPV14eaAyteC9steLnhGAHJbw3CnV+EE2OcBnvnd6L2F2fo06yCo/VafApeAj9/zjjH5ybgBgWgivwxUAbDSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=izF5iT55; arc=none smtp.client-ip=192.30.252.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="izF5iT55"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784577370;
	bh=o3w0O33Tp8CgN8697Ci9a3meycAvTsNogXmemrZ8j6o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=izF5iT55nL1lcGbufstlECh02fDqTEjnUDzLyvKMY0qxDWl2a4L2Ckdd/g0vy0tQg
	 59vl7xjhbICleHTpUcbCI6iaOGV6wq3TnZjhellik2Q9mt/VZVBNfCVON9gYc5l7VC
	 fsIcNodM8mdKqv+xirRbj6FaDPn752LunRxGHvEQ=
Received: from github.com (hubbernetes-node-2dc1abb.ash1-iad.github.net [10.56.178.34])
	by smtp.github.com (Postfix) with ESMTPA id 69D08841186
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 12:56:10 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:56:10 -0700
From: uos-eng <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/efd216-f3f03d@github.com>
Subject: [bluez/bluez] e00441: adapter: restrict delta=0 RSSI to proximity
 filters
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
  Commit: e004414a1751d29216ccab976d6c7174ec48d11c
      https://github.com/bluez/bluez/commit/e004414a1751d29216ccab976d6c7174ec48d11c
  Author: Xiuzhuo Shang <xiuzhuo.shang@oss.qualcomm.com>
  Date:   2026-07-20 (Mon, 20 Jul 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: restrict delta=0 RSSI to proximity filters

When a discovery filter is active (filtered_discovery=true), BlueZ
unconditionally calls device_set_rssi_with_delta(..., delta=0),
causing every BLE advertisement to emit a PropertiesChanged(RSSI)
signal regardless of whether the RSSI value changed.

delta=0 is only needed when a client has expressed explicit proximity
interest by setting an RSSI or pathloss threshold in its discovery
filter. Filters that specify only transport type or UUIDs do not
require per-packet RSSI precision; for those, the standard
RSSI_THRESHOLD=8 rate-limiting is both correct and desirable.

The problem is triggered on dual-mode adapters by a transport-only
filter (e.g. Transport=le). In merge_discovery_filters(), the
transport-specific scan type (SCAN_TYPE_LE=6) does not equal the
adapter scan type (SCAN_TYPE_DUAL=7), so has_filtered_discovery is
set, filtered_discovery becomes true, and delta=0 is applied even
though no proximity condition was requested. With hundreds of BLE
devices advertising simultaneously this generates hundreds of
unnecessary PropertiesChanged(RSSI) signals per second.

Confirmed on QCS6490 (BlueZ 5.72) with Transport=le filter:

  adapter.c: filtered_discovery=1 (current_discovery_filter=set)
  device.c:  device_set_rssi_with_delta() rssi=-86 delta_threshold=0
  device.c:  device_set_rssi_with_delta() rssi=-79 delta_threshold=0

Add discovery_filter_has_proximity() which walks discovery_list and
returns true only when at least one active filter carries a real
proximity condition (rssi != DISTANCE_VAL_INVALID or pathloss !=
DISTANCE_VAL_INVALID). Use this to gate the delta=0 path.

Other filter fields (transport, uuids, duplicate, discoverable)
express capability or content criteria and carry no proximity
implication, so they are intentionally excluded from the check.


  Commit: 004e1b5d245e2c3497780ab60b728cd0a9c14cf7
      https://github.com/bluez/bluez/commit/004e1b5d245e2c3497780ab60b728cd0a9c14cf7
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-07-20 (Mon, 20 Jul 2026)

  Changed paths:
    M tools/test-runner.c

  Log Message:
  -----------
  test-runner: use virtio for the default kernel console

Serial as console is slow when commands produce large amounts of output,
e.g. for the -d debug option of the testers.

Use virtio console=hvc0 as the console, requiring
CONFIG_VIRTIO_CONSOLE=y which is already in tester config.

For capturing the early boot messages, retain the qemu serial, kernel
will switch to hvc0 during boot when the HVC driver initializes.

For: time tools/test-runner -k ../../linux -- tools/sco-tester -d
Before: real 0m32,094s, After: real 0m8,967s


  Commit: 9965f36c6318e3a6f9879f5b0d842791a290e3ee
      https://github.com/bluez/bluez/commit/9965f36c6318e3a6f9879f5b0d842791a290e3ee
  Author: Philipp Dunkel <pip@pipobscure.com>
  Date:   2026-07-20 (Mon, 20 Jul 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Infer BR/EDR only at public LE addresses

btd_adapter_device_found() records BR/EDR support for any LE device
whose advertising Flags lack "BR/EDR Not Supported" (EIR_BREDR_UNSUP).
The address type is not considered:

    if (bdaddr_type != BDADDR_BREDR && eir_data.flags &&
                    !(eir_data.flags & EIR_BREDR_UNSUP)) {
            device_set_bredr_support(dev);

When the advertisement uses a random address the device gets a BR/EDR
bearer whose address is that random address, and start_discovery_cb()
then prefers SDP over GATT:

    if (device->bredr)
            device_browse_sdp(device, NULL);
    else
            device_browse_gatt(device, NULL);

SDP requires a BR/EDR ACL, so bluetoothd pages the random address. A
random address is not a BD_ADDR and cannot be paged, so the attempt
always ends in Page Timeout, and the failure tears down the working LE
link:

  connect_failed_callback() hci0 5A:B4:98:1F:CC:04 status 4
  bonding_attempt_complete() hci0 bdaddr 5A:B4:98:1F:CC:04
      type 0 status 0x4
  device_bonding_complete() bonding (nil) status 0x04
  browse_request_cancel()
  btd_gatt_database_att_disconnected()

Nothing requested the connection ("bonding (nil)") and the LE link was
healthy. Any LE association that outlives the page timeout is killed by
it; measured on one host, applications get about 4.7 s from connect
before the link disappears, of which GATT discovery already takes 2.3 s.

Current phones advertise Flags 0x1a (LE General Discoverable plus
Simultaneous LE and BR/EDR, with BR/EDR Not Supported clear) from
resolvable private addresses, so this triggers routinely rather than in
some corner case.

The Flags bits describe what the device supports. They do not promise
that the address it is advertising from is a BD_ADDR. A dual-mode device
uses the same Public Device Address for BR/EDR and LE, so the inference
is sound only for BDADDR_LE_PUBLIC. Restrict it to that.

The other two device_set_bredr_support() callers already require the
device to have been seen over BR/EDR (bdaddr_type == BDADDR_BREDR), so
they are unaffected. A device later seen over BR/EDR, or whose RPA is
resolved to a public identity, still gets BR/EDR support recorded there.


  Commit: f3f03d728542f76599385cf82348ba4f87264dcc
      https://github.com/bluez/bluez/commit/f3f03d728542f76599385cf82348ba4f87264dcc
  Author: Chengyi Zhao <zhaochengyi@uniontech.com>
  Date:   2026-07-20 (Mon, 20 Jul 2026)

  Changed paths:
    M plugins/policy.c
    M src/adapter.c
    M src/adapter.h

  Log Message:
  -----------
  policy: Connect profiles for bonded inbound ACL connections

When a bonded device initiates an inbound ACL connection (e.g. after
resume, the remote wins the page race), BlueZ accepts the ACL link
but does not establish AVDTP/AVCTP profiles. The remote's subsequent
L2CAP connect for PSM 25 fails with "security block" because the link
is not yet encrypted, and the kernel does not retry. The ACL link
stays up with no audio.

Add btd_connect_cb callback infrastructure to the adapter core
mirroring the existing btd_disconnect_cb pattern, invoked from
connected_callback so it only fires on new MGMT_EV_DEVICE_CONNECTED
events. Register a callback in the policy plugin that starts a
2-second grace timer for bonded BR/EDR connections. If an audio
profile connects naturally within the window the timer is cancelled;
otherwise btd_device_connect_services is called as a fallback, but
only if no audio profile is connected yet. The grace timer is also
cancelled on disconnect to avoid racing with device removal.

Outbound L2CAP is queued by the kernel until encryption completes,
surviving the race. The fallback is safe when the host already won
since btd_device_connect_services returns -EBUSY if a connection is
already in progress.


Compare: https://github.com/bluez/bluez/compare/efd216fe280b...f3f03d728542

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
