Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F07136E37
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 17:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725901669; cv=none; b=jVyh1qw6Db5O6lVYjjYe1tOnbAvmhfl+DZStRamueuKQZoPdSJ88LthKCjjO2V+BSIRQAREmpw94lqzcf3jHWYGLchKRQO0y5SB29FIbykhdVFaSGSW1n8+fVTUf9jTa4fK9DcU/VafVfG+BuAm9agGICmTWpEMi0QMl1WXqqCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725901669; c=relaxed/simple;
	bh=PLXF0VjaeNLigdKX5PmiuM3vlBVLrkw3hcYPoZ3eO20=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=lbXqJN6sGRCe0T9TApTIpN2qC6RBAXoWHzfV6JQHWJFY6dltxW/4M5OwcLFXl6lBUj9ulevi8Xrt5wtDV5DQEV78aVPGYKNCnZ6L0VAERLb+5tRlrg5YCMUBAy7WyNseEohSaPx7mBLSUOz6rJtvL2hC1h/xzX94fbfki7/1fM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fa5hQAlk; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fa5hQAlk"
Received: from github.com (hubbernetes-node-2f4b2f8.ash1-iad.github.net [10.56.150.22])
	by smtp.github.com (Postfix) with ESMTPA id 7F82E6C130B
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Sep 2024 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1725901666;
	bh=o1Q7lcO6e9fnGoSq5KFDpO9KJegKP8VnVPZe6v3nmAo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fa5hQAlkl9bsaFnjpqG0aoxuOqKLmLai0m2cYw705io7hIiKvyxPHffAWa8dg/mL7
	 1C5SR2DEVZn3GNWcPHG86rDRQQtG92UO0XIJdR7qPVHA1u/c4nyl/5aPBDpPG+Dx0k
	 g5nJWAa3ucrlPbpWZQPjFtQo/Pbfa6t1f2LwVqKc=
Date: Mon, 09 Sep 2024 10:07:46 -0700
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4ecfde-dfcbc2@github.com>
Subject: [bluez/bluez] 38b7dc: shared/bass: Register ATT disconnect cb
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
  Commit: 38b7dc7d17b441c8fc5a0ee6fc8fff8e70c27bcb
      https://github.com/bluez/bluez/commit/38b7dc7d17b441c8fc5a0ee6fc8fff8e70c27bcb
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M src/shared/bass.c

  Log Message:
  -----------
  shared/bass: Register ATT disconnect cb

This registers an ATT disconnect callback with bass, to properly
clean uo the session if the ATT connection is removed.


  Commit: 25119b6a72aa4fae99066ecbe57196a2169db674
      https://github.com/bluez/bluez/commit/25119b6a72aa4fae99066ecbe57196a2169db674
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M src/shared/bass.c
    M src/shared/bass.h

  Log Message:
  -----------
  shared/bass: Make bt_bcast_src private

The bt_bcast_src structure holds information for the BASS Broadcast Audio
Receive State characteristic. This commit makes this structure private
for shared/bass, since this is the only place where GATT characteristics
should be handled.


  Commit: 8abcfd7028e87dd3cb3232f654325eb182629daa
      https://github.com/bluez/bluez/commit/8abcfd7028e87dd3cb3232f654325eb182629daa
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M src/shared/bass.c

  Log Message:
  -----------
  shared/bass: Remove io handling

Socket connect/listen procedures should not be handled inside src/shared.
The BASS plugin should be the one to handle these socket operations.
This removes IO handling from shared/bass.


  Commit: 30c190089ffe6460b3a67b251edf10dbab76aecf
      https://github.com/bluez/bluez/commit/30c190089ffe6460b3a67b251edf10dbab76aecf
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M src/shared/bass.c
    M src/shared/bass.h

  Log Message:
  -----------
  shared/bass: Add support to register cp handlers

The BASS Broadcast Audio Scan Control Point characteristic defines a
number of commands that require the BASS Server to sync to Broadcasters.
This should be handled inside the BASS plugin.

This commit adds shared/bass APIs to register control point handlers
with bt_bass. The BASS plugin will use these APIs to register a control
point callback to handle each operation based on opcode and parameters.


  Commit: 0446d1eef9ef8d6b919bcc5620d6462a110808f1
      https://github.com/bluez/bluez/commit/0446d1eef9ef8d6b919bcc5620d6462a110808f1
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M src/shared/bass.c

  Log Message:
  -----------
  shared/bass: Call cp handler for the Add Source cmd

This updates the Add Source control point handler inside shared/bass to
call the handlers queued inside bt_bass, so the required sync operations
will be properly handled by the plugins that registered callbacks.


  Commit: b65767c5dab5d0146f0e268a138bfe5a2ad72bef
      https://github.com/bluez/bluez/commit/b65767c5dab5d0146f0e268a138bfe5a2ad72bef
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Add support for long-lived PA sync

This adds BAP support for long-lived PA sync.

A BAP Broadcast Sink might probe Broadcasters autonomoulsy (by performing
short-lived PA sync to parse the BASE and discover streams), or it might
act as a Scan Delegator, probing Broadcasters added by a Broadcast
Assistant. If the Assistant requested the Delegator to establish PA sync
with a Broadcaster, the PA sync should be long-lived (it should remain
active until requested otherwise by the Assistant).


  Commit: b8530f0d26727f905304e84c3efd51aec6c7426f
      https://github.com/bluez/bluez/commit/b8530f0d26727f905304e84c3efd51aec6c7426f
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/bap.h

  Log Message:
  -----------
  bap: Add API for Scan Delegator probe

Since a BAP Broadcast Sink might probe Broadcasters autonomously or with
the help of a Broadcast Assistant, BAP needs to support 2 types of
Broadcaster probing: short-lived and long-lived.

This adds a BAP API for Scan Delegators probe Broadcaster devices
long-lived.


  Commit: 4191ff1c40454402dcd3f4bf3e1d6ed72edd1d8c
      https://github.com/bluez/bluez/commit/4191ff1c40454402dcd3f4bf3e1d6ed72edd1d8c
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Register cp handler for Add Source cmd

This registers a control point handler with shared/bass, for each
eastablished BASS session. For now, only the Add Source opcode is
handled.

Using the parameters provided from shared/bass, a device
is created for the Broadcaster address. The device is then
probed with BAP, where long-lived PA sync will be established.
After parsing the BASE, transports are created for each BIS,
as if the Broadcast Sink scanned the Broadacaster autonomously.

Below is a bluetoothctl log which shows a Scan Delegator starting
to advertise, connecting to a Broadcast Assistant, receiving the
Add Source command for a Broadcaster streaming one BIS, creating
a device for the Broadcaster and then creating a transport for
the BIS:

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 1
[/local/endpoint/ep0] Supported Context (value): 1
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# advertise on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
[00-60-37-31-7E-3F]# [NEW] Device 03:E2:C0:11:57:DA 03-E2-C0-11-57-DA
[00-60-37-31-7E-3F]# [NEW] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0

The btmon log below shows the GATT write command with the Add Source
opcode, which was received from the Broadcast Assistant. It also
shows the long-lived PA sync performed by BAP:

> ACL Data RX: Handle 0 flags 0x01 dlen 1
      ATT: Write Command (0x52) len 23
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[21]: 0201da5711c0e203001a2d5602ffff010100000000
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 03:E2:C0:11:57:DA
            Source_Adv_SID: 0
            Broadcast_ID: 0x562d1a
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000001
< HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044)
        Options: 0x0000
        Use advertising SID, Advertiser Address Type and address
        Reporting initially enabled
        SID: 0x00
        Adv address type: Random (0x01)
        Adv address: 03:E2:C0:11:57:DA (Non-Resolvable)
        Skip: 0x0000
        Sync timeout: 20000 msec (0x07d0)
        Sync CTE type: 0x0000
> HCI Event: Command Status (0x0f) plen 4
      LE Periodic Advertising Create Sync (0x08|0x0044) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 16
      LE Periodic Advertising Sync Established (0x0e)
        Status: Success (0x00)
        Sync handle: 0
        Advertising SID: 0x00
        Advertiser address type: Random (0x01)
        Advertiser address: 03:E2:C0:11:57:DA (Non-Resolvable)
        Advertiser PHY: LE 2M (0x02)
        Periodic advertising interval: 10.00 msec (0x0008)
        Advertiser clock accuracy: 0x07
> HCI Event: LE Meta Event (0x3e) plen 42
      LE Periodic Advertising Report (0x0f)
        Sync handle: 0
        TX power: 127 dbm (0x7f)
        RSSI: -64 dBm (0xc0)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x22
        Service Data: Basic Audio Announcement (0x1851)
          Presetation Delay: 40000
          Number of Subgroups: 1
            Subgroup #0:
            Number of BIS(s): 1
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
            Codec Specific Configuration: Sampling Frequency: 16 Khz
            Codec Specific Configuration: #1: len 0x02 type 0x02
            Codec Specific Configuration: Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
            Codec Specific Configuration: Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
            Codec Specific Configuration: Location: 0x00000001
            Codec Specific Configuration: Location: Front Left
              BIS #0:
              Index: 1
> HCI Event: LE Meta Event (0x3e) plen 20
      LE Broadcast Isochronous Group Info Advertising Report (0x22)
        Sync Handle: 0x0000
        Number BIS: 1
        NSE: 3
        ISO Interval: 10.00 msec (0x0008)
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        SDU Interval: 10000 us (0x002710)
        Maximum SDU: 40
        PHY: LE 2M (0x02)
        Framing: Unframed (0x00)
        Encryption: 0x00


  Commit: 06d20a80249b177ed2c3794c68334e1935eacaec
      https://github.com/bluez/bluez/commit/06d20a80249b177ed2c3794c68334e1935eacaec
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M src/shared/bass.c
    M src/shared/bass.h

  Log Message:
  -----------
  shared/bass: Add API to set PA sync state

This adds a shared/bass API to set the PA sync state field inside
a Broadcast Receive State characteristic. Notifications are then
sent, to inform all peers about the update.


  Commit: f3a43bd0e4af7a6b4265a6664b1bd70a2beaf29e
      https://github.com/bluez/bluez/commit/f3a43bd0e4af7a6b4265a6664b1bd70a2beaf29e
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M profiles/audio/bass.c
    M profiles/audio/bass.h

  Log Message:
  -----------
  bass: Add APIs to probe/remove Broadcasters

This adds BASS APIs to probe/remove Broadcasters probed by BAP.

The BAP plugin might probe Broadcasters that were either scanned
autonomously, or that were added by a Broadcast Assistant through
BASS.

After performing long-lived PA sync with a Broadcaster added by a
Broadcast Assistant, the BAP plugin will call the BASS probe API,
to inform BASS that PA has been established with the Broadcast Source
and to provide a reference to the created bt_bap session. Once a
Broadcaster has been probed, BASS will update the PA sync state inside
the corresponding Broadcast Receive State characteristic and
the peer Broadcast Assistant will be notified about the update.

Once the BAP session with a Broadcaster is deleted, the BASS remove
API will be called, to inform BASS that the Source is no longer active.
The BASS plugin will update the PA sync field of the corresponding
Broadcast Receive State characteristic and it will notify the peer
Broadcast Assistant that PA sync is no longer established with the
Source.


  Commit: ea7b6910243463f475424838db7cd80113b93a4c
      https://github.com/bluez/bluez/commit/ea7b6910243463f475424838db7cd80113b93a4c
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Probe Broadcasters with BASS

After long-lived PA sync, this adds a call to probe the bap session
with the Broadcaster with BASS.

This also adds a call to notify BASS about a session with a Broadcaster
being removed, in bap_bcast_remove.

The bluetoothctl log below shows a Scan Delegator creating a media
transport for a BIS added by a Broadcast Assistant through the
Add Source command, and then disconnecting from the Broadcaster:

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 1
[/local/endpoint/ep0] Supported Context (value): 1
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# advertise on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
[00-60-37-31-7E-3F]# [NEW] Device 03:E2:C0:11:57:DA 03-E2-C0-11-57-DA
[00-60-37-31-7E-3F]# [NEW] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# disconnect 03:E2:C0:11:57:DA
Attempting to disconnect from 03:E2:C0:11:57:DA
[00-60-37-31-7E-3F]# [DEL] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# [DEL] Device 03:E2:C0:11:57:DA 03-E2-C0-11-57-DA

The btmon log below shows that after PA sync is established inside
the BAP plugin, the Scan Delegator sends a GATT notification to
inform the Broadcast Assistant that PA sync has been established.
Once the Broadcaster device is deleted, PA sync is terminated and
the Scan Delegator once again notifies the peer about the update:

> ACL Data RX: Handle 0 flags 0x01 dlen 1
      ATT: Write Command (0x52) len 23
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[21]: 0201da5711c0e203001a2d5602ffff010100000000
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 03:E2:C0:11:57:DA
            Source_Adv_SID: 0
            Broadcast_ID: 0x562d1a
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000001
< HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044)
        Options: 0x0000
        Use advertising SID, Advertiser Address Type and address
        Reporting initially enabled
        SID: 0x00
        Adv address type: Random (0x01)
        Adv address: 03:E2:C0:11:57:DA (Non-Resolvable)
        Skip: 0x0000
        Sync timeout: 20000 msec (0x07d0)
        Sync CTE type: 0x0000
> HCI Event: Command Status (0x0f) plen 4
      LE Periodic Advertising Create Sync (0x08|0x0044) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 16
      LE Periodic Advertising Sync Established (0x0e)
        Status: Success (0x00)
        Sync handle: 0
        Advertising SID: 0x00
        Advertiser address type: Random (0x01)
        Advertiser address: 03:E2:C0:11:57:DA (Non-Resolvable)
        Advertiser PHY: LE 2M (0x02)
        Periodic advertising interval: 10.00 msec (0x0008)
        Advertiser clock accuracy: 0x07
> HCI Event: LE Meta Event (0x3e) plen 42
      LE Periodic Advertising Report (0x0f)
        Sync handle: 0
        TX power: 127 dbm (0x7f)
        RSSI: -64 dBm (0xc0)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x22
        Service Data: Basic Audio Announcement (0x1851)
          Presetation Delay: 40000
          Number of Subgroups: 1
            Subgroup #0:
            Number of BIS(s): 1
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
            Codec Specific Configuration: Sampling Frequency: 16 Khz
            Codec Specific Configuration: #1: len 0x02 type 0x02
            Codec Specific Configuration: Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
            Codec Specific Configuration: Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
            Codec Specific Configuration: Location: 0x00000001
            Codec Specific Configuration: Location: Front Left
              BIS #0:
              Index: 1
> HCI Event: LE Meta Event (0x3e) plen 20
      LE Broadcast Isochronous Group Info Advertising Report (0x22)
        Sync Handle: 0x0000
        Number BIS: 1
        NSE: 3
        ISO Interval: 10.00 msec (0x0008)
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        SDU Interval: 10000 us (0x002710)
        Maximum SDU: 40
        PHY: LE 2M (0x02)
        Framing: Unframed (0x00)
        Encryption: 0x00
bluetoothd[4636]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 0101da5711c0e203001a2d560200010000000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 03:E2:C0:11:57:DA
          Source_Adv_SID: 0
          Broadcast_ID: 0x562d1a
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
bluetoothd[70621]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 0101dd7c8046f72a00f863f00000010000000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 2A:F7:46:80:7C:DD
          Source_Adv_SID: 0
          Broadcast_ID: 0xf063f8
          PA_Sync_State: Not synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
< HCI Command: LE Periodic Advertising Terminate Sync (0x08|0x0046) plen 2
        Sync handle: 0x0000
> HCI Event: Command Complete (0x0e) plen 4
      LE Periodic Advertising Terminate Sync (0x08|0x0046) ncmd 1
        Status: Success (0x00


  Commit: c6278d24d9d298789f4931bb99bb2004aec53fb2
      https://github.com/bluez/bluez/commit/c6278d24d9d298789f4931bb99bb2004aec53fb2
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M src/shared/bass.c
    M src/shared/bass.h

  Log Message:
  -----------
  shared/bass: Add APIs to set/clear BIS sync bits

This adds shared/bass APIs to set/clear bits inside the BIS sync bitmask
of Broadcast Receive State characteristics. Notifications are sent to the
peers each time the characteristic is updated.


  Commit: a032a570489b31aced3ad8de61aeccadc0179e55
      https://github.com/bluez/bluez/commit/a032a570489b31aced3ad8de61aeccadc0179e55
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Register BAP state changed cb

This registers a BAP stream state changed callback inside BASS, to monitor
the state of BAP streams created by the Scan Delegator and to notify
the peer Broadcast Assistants about updates.

The bluetoothctl log below shows a Scan Delegator creating a media
transport for a BIS added by a Broadcast Assistant through the
Add Source operation. The transport is then acquired and then
released:

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 1
[/local/endpoint/ep0] Supported Context (value): 1
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# advertise on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
[00-60-37-31-7E-3F]# [NEW] Device 03:E2:C0:11:57:DA 03-E2-C0-11-57-DA
[00-60-37-31-7E-3F]# [NEW] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# Endpoint: SetConfiguration
[00-60-37-31-7E-3F]# Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# Properties.Device:
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA
[00-60-37-31-7E-3F]# Auto Accepting...
[00-60-37-31-7E-3F]# transport.select
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# [CHG] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 State: broadcasting
[00-60-37-31-7E-3F]# transport.acquire
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
auto acquiring...
Transport /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 acquiring
[00-60-37-31-7E-3F]# Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 acquiring complete
[00-60-37-31-7E-3F]# Acquire successful: fd 8 MTU 40:0
[00-60-37-31-7E-3F]# [CHG] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 State: active
[00-60-37-31-7E-3F]# transport.release
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0
[00-60-37-31-7E-3F]# Transport fd disconnected
[00-60-37-31-7E-3F]# [CHG] Transport
    /org/bluez/hci1/dev_03_E2_C0_11_57_DA/bis1/fd0 State: idle
[00-60-37-31-7E-3F]# Release successful

The btmon log below shows the Scan Delegator notifying the
peer each time the state of the stream changes:

> ACL Data RX: Handle 0 flags 0x01 dlen 1
      ATT: Write Command (0x52) len 23
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[21]: 0201da5711c0e203001a2d5602ffff010100000000
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 03:E2:C0:11:57:DA
            Source_Adv_SID: 0
            Broadcast_ID: 0x562d1a
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000001
< HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044)
        Options: 0x0000
        Use advertising SID, Advertiser Address Type and address
        Reporting initially enabled
        SID: 0x00
        Adv address type: Random (0x01)
        Adv address: 03:E2:C0:11:57:DA (Non-Resolvable)
        Skip: 0x0000
        Sync timeout: 20000 msec (0x07d0)
        Sync CTE type: 0x0000
> HCI Event: Command Status (0x0f) plen 4
      LE Periodic Advertising Create Sync (0x08|0x0044) ncmd 1
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e) plen 16
      LE Periodic Advertising Sync Established (0x0e)
        Status: Success (0x00)
        Sync handle: 0
        Advertising SID: 0x00
        Advertiser address type: Random (0x01)
        Advertiser address: 03:E2:C0:11:57:DA (Non-Resolvable)
        Advertiser PHY: LE 2M (0x02)
        Periodic advertising interval: 10.00 msec (0x0008)
        Advertiser clock accuracy: 0x07
> HCI Event: LE Meta Event (0x3e) plen 42
      LE Periodic Advertising Report (0x0f)
        Sync handle: 0
        TX power: 127 dbm (0x7f)
        RSSI: -64 dBm (0xc0)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x22
        Service Data: Basic Audio Announcement (0x1851)
          Presetation Delay: 40000
          Number of Subgroups: 1
            Subgroup #0:
            Number of BIS(s): 1
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
            Codec Specific Configuration: Sampling Frequency: 16 Khz
            Codec Specific Configuration: #1: len 0x02 type 0x02
            Codec Specific Configuration: Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
            Codec Specific Configuration: Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
            Codec Specific Configuration: Location: 0x00000001
            Codec Specific Configuration: Location: Front Left
              BIS #0:
              Index: 1
> HCI Event: LE Meta Event (0x3e) plen 20
      LE Broadcast Isochronous Group Info Advertising Report (0x22)
        Sync Handle: 0x0000
        Number BIS: 1
        NSE: 3
        ISO Interval: 10.00 msec (0x0008)
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        SDU Interval: 10000 us (0x002710)
        Maximum SDU: 40
        PHY: LE 2M (0x02)
        Framing: Unframed (0x00)
        Encryption: 0x00
bluetoothd[4636]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 0101da5711c0e203001a2d560200010000000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 03:E2:C0:11:57:DA
          Source_Adv_SID: 0
          Broadcast_ID: 0x562d1a
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b)
        BIG Handle: 0x00
        BIG Sync Handle: 0x0000
        Encryption: Unencrypted (0x00)
        Broadcast Code[16]: 00000000000000000000000000000000
        Maximum Number Subevents: 0x00
        Timeout: 20000 ms (0x07d0)
        Number of BIS: 1
        BIS ID: 0x01
> HCI Event: Command Status (0x0f) plen 4
      LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
        Status: Success (0x00
> HCI Event: LE Meta Event (0x3e) plen 17
      LE Broadcast Isochronous Group Sync Estabilished (0x1d)
        Status: Success (0x00)
        BIG Handle: 0x00
        Transport Latency: 912 us (0x000390)
        NSE: 3
        BN: 1
        PTO: 1
        IRC: 3
        Maximum PDU: 40
        ISO Interval: 10.00 msec (0x0008)
        Connection Handle #0: 10
< HCI Command: LE Setup Isochronous Data Path (0x08|0x006e) plen 13
        Handle: 10
        Data Path Direction: Output (Controller to Host) (0x01)
        Data Path: HCI (0x00)
        Coding Format: Transparent (0x03)
        Company Codec ID: Ericsson Technology Licensing (0)
        Vendor Codec ID: 0
        Controller Delay: 0 us (0x000000)
        Codec Configuration Length: 0
        Codec Configuration[0]:
> HCI Event: Command Complete (0x0e) plen 6
      LE Setup Isochronous Data Path (0x08|0x006e) ncmd 1
        Status: Success (0x00)
        Handle: 10
bluetoothd[4636]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 0101da5711c0e203001a2d560200010100000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 03:E2:C0:11:57:DA
          Source_Adv_SID: 0
          Broadcast_ID: 0x562d1a
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000001
bluetoothd[4636]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 0101da5711c0e203001a2d560200010000000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 03:E2:C0:11:57:DA
          Source_Adv_SID: 0
          Broadcast_ID: 0x562d1a
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
< HCI Command: LE Broadcast Isochronous Group Terminate Sync (0x08|0x006c)
        BIG Handle: 0x00
> HCI Event: Command Complete (0x0e) plen 5
      LE Broadcast Isochronous Group Terminate Sync (0x08|0x006c) ncmd 1
        Status: Success (0x00)


  Commit: 7c3821f822f8a895ccaeebf56eb4426ba677be3f
      https://github.com/bluez/bluez/commit/7c3821f822f8a895ccaeebf56eb4426ba677be3f
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M src/shared/bass.c
    M src/shared/bass.h

  Log Message:
  -----------
  shared/bass: Add API to check BIS required for sync

This adds a shared/bass API to check if a BIS index of a Broadcast Source
has been requested by the Broadcast Assistant to be synced with. This will
be used by BAP after parsing the BASE, to filter out the streams that don't
need to be created.


  Commit: df4e11fab68b392f0f8c12b496199db6ece2a26e
      https://github.com/bluez/bluez/commit/df4e11fab68b392f0f8c12b496199db6ece2a26e
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M profiles/audio/bass.c
    M profiles/audio/bass.h

  Log Message:
  -----------
  bass: Add API to check BIS required for sync

This adds a wrapper over bt_bass_check_bis, which receives a Broadcaster
device and a BIS index and checks is the Delegator has been instructed
to sync with the specific BIS transmitted by the Source.


  Commit: dfcbc2d3c0115e37b20158bdd716cdad466191a8
      https://github.com/bluez/bluez/commit/dfcbc2d3c0115e37b20158bdd716cdad466191a8
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-09-09 (Mon, 09 Sep 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Create streams for required BISes

If a BAP Broadcast Sink is acting as a Scan Delegator and it has performed
long-lived PA sync with a Broadcaster added by a Broadcast Assistant, the
BASE should be parsed and streams need to be created only for BISes
requested by the Assistant.

This adds a BASS check inside parse_base, to filter out BISes that do not
require streams.

The bluetoothctl log below shows a Scan Delegator registering a Broadcast
Sink PAC and connecting to a Broadcast Assistant:

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 3
[/local/endpoint/ep0] Supported Context (value): 1
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# advertise on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F

The btmon log shows the Scan Delegator receiving the Add Source command
from a Broadcast Assistant, requesting to sync to BIS index 2 of the
provided Broadcaster. After PA sync, the BASE shows that the Broadcaster
is streaming 2 BISes, both matching the audio capabilities supported by
the Scan Delegator:

> ACL Data RX: Handle 0 flags 0x01 dlen 1
      ATT: Write Command (0x52) len 23
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[21]: 02014605638ad50e004dda9b02ffff010200000000
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 0E:D5:8A:63:05:46
            Source_Adv_SID: 0
            Broadcast_ID: 0x9bda4d
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000002
> HCI Event: LE Meta Event (0x3e) plen 50
      LE Periodic Advertising Report (0x0f)
        Sync handle: 0
        TX power: 127 dbm (0x7f)
        RSSI: -60 dBm (0xc4)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x2a
        Service Data: Basic Audio Announcement (0x1851)
          Presetation Delay: 40000
          Number of Subgroups: 1
            Subgroup #0:
            Number of BIS(s): 2
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
            Codec Specific Configuration: Sampling Frequency: 16 Khz
                                          (0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
            Codec Specific Configuration: Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
            Codec Specific Configuration: Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
            Codec Specific Configuration: Location: 0x00000001
            Codec Specific Configuration: Location: Front Left
                                          (0x00000001)
              BIS #0:
              Index: 1
              BIS #1:
              Index: 2
              Codec Specific Configuration: #0: len 0x05 type 0x03
              Codec Specific Configuration: Location: 0x00000002
              Codec Specific Configuration: Location: Front Right
                                            (0x00000002)

Only one transport will be created, for BIS index 2, since it was
the only one requested in the Add Source command:

[00-60-37-31-7E-3F]# [NEW] Device 0E:D5:8A:63:05:46 0E-D5-8A-63-05-46
[00-60-37-31-7E-3F]# [NEW] Transport
    /org/bluez/hci0/dev_0E_D5_8A_63_05_46/bis2/fd0


Compare: https://github.com/bluez/bluez/compare/4ecfdef3b52f...dfcbc2d3c011

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
