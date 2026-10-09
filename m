Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2324E77E3
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791557453; cv=none; b=UIDOcAXHPqaqvU78prm1kDoEXKwOKpQZoc/u+PbhvRJL8+1cxFclmRHah5HxEL7u2B4fUJ6vJKrFGdwEEcRb9JXCxX2wIo4DhvAiyABwcdS/S0rL0EqAfrTRWWA28QUOK7mXSfYSiSYDrIEtUw+bXiDGWMxDQOlgZrFMzTgmw8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791557453; c=relaxed/simple;
	bh=M6pIQkGywmkRZ3iVtN7bZRiuF3xf+3Alkngpc8zpB2E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Q14wf9ahOKlNCcsgmXHED4lFkWX7ThyesUrJ1bIcdY1Ur5hiqV2LXAo0IfuAND/1TdZNguefuqKn9b1UwOBLy7OixuqciwVlK7jzkAer8yUSrVnyLD4zJkmo9nb5UXuVKJLW7t0PnkxN8QiU4kbR+DAYbAx9l3JA3oroCiN5F4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=iASN/WQK; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="iASN/WQK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791557450;
	bh=qK0gdBCRg/nlj8rMvC2G0cLKhVSWWoYRKEkIiLKUcFM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iASN/WQKznK/bIaqMW9ZQi3CIqHcELLDrLIK06crhCBTK1blfummSn0TjSMQt6sXC
	 DIaWFZ7sS0rLqLNZGdhcj1ih3WMpuaS8ZSvgIJCP6fz1vcGp2Vz8cGe28exRjP/Aws
	 lw4x65i2CXTfCizZwityJadXFRciEyWNuevnppNuqY7jPmsL+puX8IzUy/VVywwVhG
	 1zwlCukwlcBdpBMVq61GkOta4uwen1458x6UnNWQB5Yb+q/rt1CT/fcEEWQlWmlIHI
	 5vKxqpNn1VOazKryaVGJBMMuKqcn2HxYti5bq8zF0iHM+jGQm9ULToRNwu/Es61226
	 PO5sJv2jRwSKw==
Received: from github.com (hubbernetes-node-934842e.ac4-iad.github.net [10.52.153.31])
	by smtp.github.com (Postfix) with ESMTPA id BC9BD780AAC
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 07:50:50 -0700 (PDT)
Date: Fri, 09 Oct 2026 07:50:50 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1182244/000000-65db76@github.com>
Subject: [bluez/bluez] 24a146: shared/gatt-client: Allow registering notify
 with ...
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

  Branch: refs/heads/1182244
  Home:   https://github.com/bluez/bluez
  Commit: 24a146ee5c9295d91698b239df1d4282032572ad
      https://github.com/bluez/bluez/commit/24a146ee5c9295d91698b239df1d4282032572ad
  Author: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M src/shared/gatt-client.c
    M src/shared/gatt-client.h

  Log Message:
  -----------
  shared/gatt-client: Allow registering notify with explicit CCC value

bt_gatt_client_register_notify() picks the CCC value to write based on
the characteristic properties, preferring notifications over indications
when both are supported. A client that specifically needs one of the two
- for example the Ranging Service, which distinguishes notification and
indication transports - has no way to request it.

Add bt_gatt_client_register_notify_with_ccc() which takes the desired
CCC value (0x0001 for notifications, 0x0002 for indications) and writes
it verbatim. register_notify() gains a ccc_value argument and rejects a
value the characteristic does not support. The existing entry point
keeps its behaviour by passing 0, which restores the property-based
selection.

Assisted-by: Claude:claude-opus-4.8


  Commit: 793e44346c2b2ee3a4ced0ad0bbebdfc40f0d152
      https://github.com/bluez/bluez/commit/793e44346c2b2ee3a4ced0ad0bbebdfc40f0d152
  Author: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M src/gatt-database.c
    M src/shared/gatt-db.c
    M src/shared/gatt-db.h

  Log Message:
  -----------
  shared/gatt-db: Pass the ATT opcode to the notify callback

gatt_db_read_t and gatt_db_write_t both tell the callback which ATT
operation it is serving through an opcode argument. gatt_db_notify_t does
not, so a notify callback can only assume a notification.

Pass the opcode the same way, set to BT_ATT_OP_HANDLE_NFY, which is what
gatt_db_attribute_notify() has always meant. No caller behaviour changes
yet; it gives the callback somewhere to read the transport from once there
is more than one.

Assisted-by: Claude:claude-opus-4.8


  Commit: 8a8a531b945ea28217640697a93d5fd0d1caad0c
      https://github.com/bluez/bluez/commit/8a8a531b945ea28217640697a93d5fd0d1caad0c
  Author: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M unit/test-bap.c
    M unit/test-bass.c
    M unit/test-mcp.c
    M unit/test-micp.c
    M unit/test-rap.c
    M unit/test-vcp.c

  Log Message:
  -----------
  unit: Take the ATT opcode in the notify callbacks

gatt_db_notify_t now passes the opcode of the operation it is serving.
Update the test callbacks to match; none of them needs to look at it.

Assisted-by: Claude:claude-opus-4.8


  Commit: cc663efe212c4e39adcfea3ca0051e5c8df51764
      https://github.com/bluez/bluez/commit/cc663efe212c4e39adcfea3ca0051e5c8df51764
  Author: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M src/gatt-database.c
    M src/shared/gatt-db.c
    M src/shared/gatt-db.h

  Log Message:
  -----------
  shared/gatt-db: Add gatt_db_attribute_indicate()

gatt_db_attribute_notify() leaves the choice between a notification and an
indication to the CCC value the client wrote, preferring notifications
whenever the client enabled them. A server cannot therefore honour a
characteristic that has to be indicated: the Ranging Service requires
Ranging Data Ready and Ranging Data Overwritten to be indicated even when
the client subscribed to both transports (RAS 3.4.2, 3.5.2).

Add gatt_db_attribute_indicate() next to it. The two share a helper and
differ only in the opcode handed to the notify callback, so the CCC lookup
stays in one place, and a callback that does not care keeps working
unchanged.

gatt-database honours the request by skipping the notification branch and
sending an indication instead, provided the client enabled indications.

Assisted-by: Claude:claude-opus-4.8


  Commit: c3d697150833f4999e78d2cc1b90f4609dbf1325
      https://github.com/bluez/bluez/commit/c3d697150833f4999e78d2cc1b90f4609dbf1325
  Author: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M src/shared/rap.c

  Log Message:
  -----------
  shared/rap: Honor CCCD transport for RAS on-demand ranging data

Complete the RAS responder handling of On-demand Ranging Data so the
transport used for each notified characteristic follows the peer's CCCD
subscription. The On-demand Ranging Data, RAS Control Point, Ranging
Data Ready and Ranging Data Overwritten characteristics are delivered
as notifications or indications according to how the client configured
their CCCDs. Ready and Overwritten gain a CCC write callback so their
subscribed transport is tracked, and a Ranging Counter each so a read
returns the value last notified.

When a client enables both transports (0x0003) the spec does not pick the
same one everywhere, so the two rules are kept in separate helpers:
Ranging Data Ready and Ranging Data Overwritten are indicated per RAS
3.4.2 and 3.5.2, while On-demand and Real-time Ranging Data are notified
per RAS 3.2.2 and 3.2.3.1. The RAS Control Point is indicate-only.

Ranging data is segmented across ATT PDUs, and it was queued a whole
transfer at a time. Notifications land on the att write queue, which
pick_next_send_op() drains ahead of the request queue and with no flow
control of its own, so doing that starves incoming ATT operations until the
last segment has been written: a Control Point write arriving mid-transfer
is only answered once the transfer ends.

Send one segment at a time instead. Indications go out with bt_att_send()
and the next segment is queued from the confirmation callback;
notifications have no confirmation to gate on, so the next one is queued
from a short timeout. Either way a single segment is outstanding, so an
Abort Operation stops the transfer rather than letting a queued one drain
out.

The notification delay cannot be zero: a zero timeout yields the event loop
without waiting, so a Control Point write is only seen once it has already
arrived, and a short transfer can finish before an Abort crosses the air
interface. Against RAS/SR/SPE/BI-05-C, which writes an invalid Abort
Operation mid-transfer, 0 ms fails and 5 ms passes, so use that.

Assisted-by: Claude:claude-opus-4.8


  Commit: 1583380065c363532b0ddaede646067edaa4e785
      https://github.com/bluez/bluez/commit/1583380065c363532b0ddaede646067edaa4e785
  Author: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M src/shared/rap.c

  Log Message:
  -----------
  shared/rap: Add RAS Control Point Abort Operation

Implement the Abort_Operation procedure (Op Code 0x03) so a client can
cancel an On-demand Ranging Data transfer that is already in progress,
and advertise it through bit 2 of the RAS Features characteristic.

Abort clears the sending state and removes the pending segment timer.
Since the transfer keeps at most one segment outstanding, dropping that
timer stops the transfer instead of letting a queued backlog drain out.
The Control Point busy check lets Abort through while every other Op Code
is answered with Server Busy, so an abort is accepted mid-transfer.

On the requester side, an Abort is written when a Get_Ranging_Data
request times out and the peer advertises Abort support, so the responder
does not keep sending data for a request the requester gave up on.

Assisted-by: Claude:claude-opus-4.8


  Commit: e9907f9638ae48f621f653724afd2ac843951cbb
      https://github.com/bluez/bluez/commit/e9907f9638ae48f621f653724afd2ac843951cbb
  Author: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M unit/test-rap.c

  Log Message:
  -----------
  unit/test-rap: Expect Abort Operation in RAS Features

The RAS Features characteristic now advertises Abort Operation, so the
value the Features read returns is 0x05 rather than 0x01.

Assisted-by: Claude:claude-opus-4.8


  Commit: a5da698498fdecc919303c13612ec76e5d461523
      https://github.com/bluez/bluez/commit/a5da698498fdecc919303c13612ec76e5d461523
  Author: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M src/shared/rap.c

  Log Message:
  -----------
  shared/rap: Shorten the requester Control Point response timeout

RAP 4.5.4.1 gives the Requester two deadlines once it has written Get
Ranging Data, both enforced by sending Abort Operation: no On-demand
Ranging Data at all within 5 seconds of the command
(RAP/REQ/ORD/BI-01-C), and no following segment within 1 second of the
previous one (RAP/REQ/ORD/BI-02-C).

The watchdog the requester arms while waiting for a Control Point
response covered the first of those, but ran for 10 seconds, so it
would abort well after the specified deadline. Arm it for 5 seconds
instead. The per-segment deadline is handled separately by
ras_cp_arm_segment_timeout(), which uses RAS_SEGMENT_TIMEOUT.

Assisted-by: Claude:claude-opus-4.8


  Commit: 0cb8b5802772337ca3b0d5a65b23f81b0502dbdd
      https://github.com/bluez/bluez/commit/0cb8b5802772337ca3b0d5a65b23f81b0502dbdd
  Author: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M src/shared/rap.c

  Log Message:
  -----------
  shared/rap: Add real-time ranging data delivery on the responder

Implement the RAS responder side of Real-time Ranging Data. Completed
ranging-data segments are queued in a per-connection FIFO and delivered
on the Real-time Ranging Data characteristic, honoring the transport
selected by the client's CCCD: notifications are paced with a fixed
inter-segment interval, while indications are driven by ATT confirmations
so the next segment is only sent once the previous one is acknowledged.

The pending real-time segment queue is cleared when a new CS procedure
starts, so stale segments from an aborted or superseded procedure are
never delivered to the peer.

Assisted-by: Claude:claude-opus-4.8


  Commit: 581405316dbb9e95344dfd24c13f5825f8ceba16
      https://github.com/bluez/bluez/commit/581405316dbb9e95344dfd24c13f5825f8ceba16
  Author: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  shared/rap: Add requester ranging data subscription API

Give the RAS requester control over how Ranging Data is received from the
peer. bt_rap_set_ranging_data_mode() picks Real-time, On-demand or neither,
together with the CCC value to write on the peer, and
bt_rap_disable_realtime_ranging() drops a Real-time subscription again.
bt_rap_set_ondemand_ranging() selects the mode to use before GATT discovery
has completed.

Setting a mode first unsubscribes whatever is currently subscribed, so the
modes do not stack, and fails when the RAS Features read has not completed
or the peer does not advertise the mode being asked for.

The requested transport applies to the RAS Control Point, Ranging Data
Ready and Ranging Data Overwritten characteristics. On-demand Ranging Data
itself stays on notifications whatever is asked for: it carries the
segmented transfer, and gating each segment on a confirmation would slow a
large one down for no benefit on the receiving side. On-demand mode also
reads Ranging Data Ready once subscribed, to pick up a counter published
before the subscription existed.

Real-time reception is guarded by the deadlines RAP 4.4.1.1 sets for the
Requester: the CCCD is disabled again if no first segment arrives within
5 seconds, or if more than 1 second passes between continuation segments,
so a peer that stops sending does not leave the subscription open.

Assisted-by: Claude:claude-opus-4.8


  Commit: 7f610b7500926f33417a09c2b68ac1d1c99230b5
      https://github.com/bluez/bluez/commit/7f610b7500926f33417a09c2b68ac1d1c99230b5
  Author: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M profiles/ranging/rap.c

  Log Message:
  -----------
  profiles/ranging: Expose requester ranging data mode over D-Bus

Add a SetRangingDataMode method to the Channel Sounding interface so a
client can select how Ranging Data is received from the peer (Real-time
or On-demand) and the CCCD transport to use, wiring through to
bt_rap_set_ranging_data_mode().

When a measurement stops, disable the Real-time Ranging Data
subscription so the peer receives the CCCD disable that the requester
owns.

Assisted-by: Claude:claude-opus-4.8


  Commit: 3ac3ac83d71b2bcc26c58aa0eab73788ed488d46
      https://github.com/bluez/bluez/commit/3ac3ac83d71b2bcc26c58aa0eab73788ed488d46
  Author: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M client/cs.c

  Log Message:
  -----------
  client: Add Channel Sounding ranging data mode control

Add a "ranging-data-mode" command to the Channel Sounding submenu that
selects how Ranging Data is received from a peer (disabled, real-time or
on-demand) and the CCCD transport (notify or indicate), invoking the
ChannelSounding1.SetRangingDataMode method on the device.

Add an advertising helper so the Responder can advertise the Ranging
Service UUID for discovery, together with a getter for the default
LEAdvertisingManager proxy it needs.

Assisted-by: Claude:claude-opus-4.8


  Commit: 15cfe781200730a504fe31e03c292ace4071d845
      https://github.com/bluez/bluez/commit/15cfe781200730a504fe31e03c292ace4071d845
  Author: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M doc/bluetoothctl-cs.rst
    M doc/org.bluez.ChannelSounding1.rst

  Log Message:
  -----------
  doc: Document Channel Sounding ranging data mode control

Document the ChannelSounding1.SetRangingDataMode method and the
bluetoothctl "ranging-data-mode" and "advertise-rangeservice" commands
added for RAP Requester and Responder control.

Assisted-by: Claude:claude-opus-4.8


  Commit: 65db76d0d96a0ea8b12be038da5b7f3c484590ff
      https://github.com/bluez/bluez/commit/65db76d0d96a0ea8b12be038da5b7f3c484590ff
  Author: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    A doc/qualification/rap-pts.rst
    A doc/qualification/ras-pts.rst

  Log Message:
  -----------
  doc/qualification: Add RAP/RAS PTS qualification results

Record the PTS results for the Ranging Profile and the Ranging Service.
Both are split per case prefix, as the other qualification documents are:
rap-pts.rst keeps the 19 RAP Requester and Responder cases, and the new
ras-pts.rst carries the 31 RAS Server cases.

Every case is listed on its own row rather than collapsed into a range, so
the file states which cases were actually run. RAS/SR/SPE/BI-02-C is
listed as not applicable: RAS.TS Table 5.1 selects it only when Abort
Operation is unsupported (NOT RAS 3/4), and the IUT supports it, so
RAS/SR/RCP/BV-03-C and RAS/SR/SPE/BI-05-C cover that path instead.

ras-pts.rst also records which transport the server must pick when a
client enables both notifications and indications, since the rule differs
per characteristic and each variant has its own case.

Assisted-by: Claude:claude-opus-4.8


Compare: https://github.com/bluez/bluez/compare/24a146ee5c92%5E...65db76d0d96a

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
