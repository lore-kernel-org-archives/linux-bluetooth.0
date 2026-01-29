Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015E1376BD1
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769730049; cv=none; b=OEZjKFGleXOhCqdJeEddggdENYJOW1IFtWoZgD8tccP2bdYPY1ExP804GyHdl5kGP5hcOdspDWwL08Vm+OoTjcrqclXxpHQo9uULEBrjM+478GDE2ETnQoqMjpsGw2VizUSXEusi0w0GtDPHO6jhPKYgOScgupG5ymfk9iza8GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769730049; c=relaxed/simple;
	bh=l1XLa5TjNVFcaMwF40PpPbpYH7kSYFpylsd4ARTWK8Q=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=apa2WrBVrtG6nR+SawRjCivxMUO0w1ARt1Bu7k2/h3LskY6L2a6D+hBA+3rKshvtQWKDqwWjI4zrqsDn5mIeGS+RRsqDA+rrdjbzOe2oouI+T1MEx281iW2BUsSDYt57qA+1kMs6T3YDAJ5f3KATEP2CJozvOPNS3AWDw7bhQlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HBJNQlOQ; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HBJNQlOQ"
Received: from github.com (hubbernetes-node-d99c119.ash1-iad.github.net [10.56.202.70])
	by smtp.github.com (Postfix) with ESMTPA id 24BED14121A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Jan 2026 15:40:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769730047;
	bh=XQFjR/POR2D7KlXTf+vV4Gxf03OaXDGUEN+pJgF8Z2g=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HBJNQlOQttzrqPW44stSNUbgKNSDPDziyQ0TFEA8pN7FSL3pQg4k5OVHaAM3xRUfN
	 vuCsJrnmWq6tuxeCTsjMMum3u0WukLsyJlbrYvf8e5VvYL/nVwXtcEuH1aByEq1JE6
	 VMzrknQxZ1ogZfJvsxxwRDI5JfdYCCzs9n5uN55s=
Date: Thu, 29 Jan 2026 15:40:47 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1048745/000000-b5d9f1@github.com>
Subject: [bluez/bluez] f439eb: doc/bluetoothctl: Document arguments and add
 examples
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

  Branch: refs/heads/1048745
  Home:   https://github.com/bluez/bluez
  Commit: f439eb4431dfb80e73da8e6366433ec8323323de
      https://github.com/bluez/bluez/commit/f439eb4431dfb80e73da8e6366433ec8323323de
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M doc/bluetoothctl.rst

  Log Message:
  -----------
  doc/bluetoothctl: Document arguments and add examples

This commit adds comprehensive parameter documentation for all commands
that accept arguments in the main bluetoothctl interface including show,
select, devices, power, advertise, scan, pair, connect, disconnect,
trust, untrust, block, unblock, remove, info, bearer and agent commands.


  Commit: 81fefbc86b7b7093ef4bece129c9557fed60c1fe
      https://github.com/bluez/bluez/commit/81fefbc86b7b7093ef4bece129c9557fed60c1fe
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-mgmt.rst

  Log Message:
  -----------
  doc/bluetoothctl-mgmt: Document arguments and add examples

Add comprehensive parameter documentation for all management interface
commands including select, power, discov, class, name, pair, privacy,
scan-params, phy and other mgmt commands with detailed descriptions
of required vs optional parameters and acceptable values.


  Commit: f223e568a07f4ec982d34671b284b42f55fdae98
      https://github.com/bluez/bluez/commit/f223e568a07f4ec982d34671b284b42f55fdae98
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-admin.rst

  Log Message:
  -----------
  doc/bluetoothctl-admin: Document arguments and add examples

Add parameter documentation for the allow command explaining the UUID
and clear parameter options for admin policy management. Documents
how to allow specific service UUIDs or clear all restrictions.


  Commit: 21cf218ce62d271f8ae3b811a07d27366680defe
      https://github.com/bluez/bluez/commit/21cf218ce62d271f8ae3b811a07d27366680defe
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-advertise.rst

  Log Message:
  -----------
  doc/bluetoothctl-advertise: Document arguments and add examples

Fix critical syntax errors in tx-power and interval commands and add
comprehensive parameter documentation. Corrects tx-power to use only
on/off parameters and updates interval to use min/max format. Adds
parameter documentation for all advertising commands.


  Commit: 9738bc13a6197a78fd7178431692c0195182fccd
      https://github.com/bluez/bluez/commit/9738bc13a6197a78fd7178431692c0195182fccd
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-assistant.rst

  Log Message:
  -----------
  doc/bluetoothctl-assistant: Document arguments and add examples

Add parameter documentation for show and push commands explaining
BAP Broadcast Assistant path parameters for media assistant operations.
Documents optional vs required parameters for assistant management.


  Commit: 25ab718b497c3c50bd4ad53a7195fccea22fdbe8
      https://github.com/bluez/bluez/commit/25ab718b497c3c50bd4ad53a7195fccea22fdbe8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-bredr.rst

  Log Message:
  -----------
  doc/bluetoothctl-bredr: Document arguments and add examples

Add parameter documentation for show, connect and disconnect commands
explaining device address and object path parameters for BR/EDR
operations. Documents optional vs required device parameters.


  Commit: 0c0a4774c831bd82171578da2dfd990ae0e55f9b
      https://github.com/bluez/bluez/commit/0c0a4774c831bd82171578da2dfd990ae0e55f9b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-endpoint.rst

  Log Message:
  -----------
  doc/bluetoothctl-endpoint: Document arguments and add examples

Add comprehensive parameter documentation for all endpoint commands
including list, show, register, unregister, config and presets.
Documents UUID, codec, capabilities and preset parameters for
Bluetooth audio endpoint management.


  Commit: 999d4721a698cbd2b63c6ab3a70a850faeeec288
      https://github.com/bluez/bluez/commit/999d4721a698cbd2b63c6ab3a70a850faeeec288
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-gatt.rst

  Log Message:
  -----------
  doc/bluetoothctl-gatt: Document arguments and add examples

Add comprehensive parameter documentation for all GATT commands
including list-attributes, select-attribute, read, write, register
operations and descriptor management. Documents attribute paths,
UUIDs, data formats and handle parameters.


  Commit: 40a84a9d0115cec38b62f06df30fc4db6ceee214
      https://github.com/bluez/bluez/commit/40a84a9d0115cec38b62f06df30fc4db6ceee214
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-hci.rst

  Log Message:
  -----------
  doc/bluetoothctl-hci: Document arguments and add examples

Add parameter documentation for all HCI commands including open, cmd,
send, register, unregister and close. Documents controller indices,
command opcodes, packet types, handles and event codes for low-level
HCI operations.


  Commit: 9aa8faf322d6d8278b530c2b32ff1f914eaf76ff
      https://github.com/bluez/bluez/commit/9aa8faf322d6d8278b530c2b32ff1f914eaf76ff
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-le.rst

  Log Message:
  -----------
  doc/bluetoothctl-le: Document arguments and add examples

Add parameter documentation for show, connect and disconnect commands
explaining device address and object path parameters for LE operations.
Documents optional vs required device parameters for Low Energy
Bluetooth device management.


  Commit: 59fe6488822b7e150d114e329669029cc0568755
      https://github.com/bluez/bluez/commit/59fe6488822b7e150d114e329669029cc0568755
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-monitor.rst

  Log Message:
  -----------
  doc/bluetoothctl-monitor: Document arguments and add examples

Add parameter documentation for all monitor commands including RSSI
threshold, timeout and sampling period settings. Documents pattern
management, monitor ID parameters and threshold values for
advertisement monitoring.


  Commit: ee1e2443d37a63555e83530553958b31549377d9
      https://github.com/bluez/bluez/commit/ee1e2443d37a63555e83530553958b31549377d9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-player.rst

  Log Message:
  -----------
  doc/bluetoothctl-player: Document arguments and add examples

Add comprehensive parameter documentation for all media player commands
including show, select, play, equalizer, repeat, shuffle, scan, search,
queue and folder navigation. Documents player paths, item selection
and media control parameters.


  Commit: 98827185cf9e187857c6451755ec934746947dc5
      https://github.com/bluez/bluez/commit/98827185cf9e187857c6451755ec934746947dc5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-scan.rst

  Log Message:
  -----------
  doc/bluetoothctl-scan: Document arguments and add examples

Add comprehensive parameter documentation for all scan filter commands
including uuids, rssi, pathloss, transport, duplicate-data, discoverable,
pattern, auto-connect and clear options. Documents filter parameters
and threshold values for device discovery.


  Commit: 03011cacb26c35024712c1243bfb48839688b1c4
      https://github.com/bluez/bluez/commit/03011cacb26c35024712c1243bfb48839688b1c4
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-telephony.rst

  Log Message:
  -----------
  doc/bluetoothctl-telephony: Document arguments and add examples

Add parameter documentation for telephony commands including show,
select, dial, show-call, answer and hangup. Documents audio gateway
paths, phone numbers and call object parameters for telephony
operations.


  Commit: b5d9f11789bf1441c771e1a32d2690ddf6596f59
      https://github.com/bluez/bluez/commit/b5d9f11789bf1441c771e1a32d2690ddf6596f59
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-29 (Thu, 29 Jan 2026)

  Changed paths:
    M doc/bluetoothctl-transport.rst

  Log Message:
  -----------
  doc/bluetoothctl-transport: Document arguments and add examples

Add parameter documentation for all transport commands including show,
acquire, release, send, receive, volume, select and unselect. Documents
transport object paths, file parameters and volume settings for
media transport operations.


Compare: https://github.com/bluez/bluez/compare/f439eb4431df%5E...b5d9f11789bf

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
