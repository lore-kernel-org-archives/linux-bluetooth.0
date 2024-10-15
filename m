Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379C01CBA08
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 15:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729005500; cv=none; b=tbfVk/amieVidRrZzQ/FX1y7Hz0IKL8VEE5cbjZG/OFXrNXE5JDU24VPXctNpuycPoGcs5QQcGVU1yxSthRxiYVdvqECH0txqK6CN+cYIjBh/vSjfzck2hv811AnBkyPV9nakLBYT8PWu276v8goCviiWZSreatChmJ19sHheKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729005500; c=relaxed/simple;
	bh=cgDHzGzs9yfdqyylbJAZjAuauo/iDFHEwkgh+NF5vFM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=U80Faolkm86B/tlnISHe2fhaz6rxB8jbi8vzfW6cZM3z8EykqgxtnahZ0Dplg32BdtTW2DISG44Kcblwdzb+os0IZHV6VCOV+nV4Bfcx95WbjXeDZKSs979Sc2eKA+BLRODUgdSVRnJCyDqjDDTCS0RaFMHFPA0YNN6KIMn76ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KF7naXn3; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KF7naXn3"
Received: from github.com (hubbernetes-node-60eceb4.ac4-iad.github.net [10.52.156.33])
	by smtp.github.com (Postfix) with ESMTPA id 59D1E6411A8
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Oct 2024 08:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1729005497;
	bh=+69FA32YfAou1++58eqNjsJONd7Pp0oOZKe7glgXCCI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KF7naXn3ovfhYzswwnC0TGAL9JMwJwBVkKmfCrRR1DDKiPwYFTuDiVLlmZ57Prp3G
	 8fAO1Wwa3c0cuOt0a+3wuDTGGPG6mBZKEZLfYStqwwRctowALRw8uV7LQfdKU2H82Z
	 bgPNVvr8x5tFRtd76am0uyJgFAUG7oQUY82YB5a8=
Date: Tue, 15 Oct 2024 08:18:17 -0700
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/bd7d49-3d9900@github.com>
Subject: [bluez/bluez] 1c681c: client/player: Add support to set empty bcode
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
  Commit: 1c681c553f4590ed7e4cba13185bbdc0d070cc81
      https://github.com/bluez/bluez/commit/1c681c553f4590ed7e4cba13185bbdc0d070cc81
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-15 (Tue, 15 Oct 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add support to set empty bcode

A Broadcast Sink might scan encrypted streams, and the user might not
know the Broadcast Code to decrypt them.

This commit adds the option to set an empty Broadcast Code when prompted
for it after transport.select, if the Code is unknown. In this case, if
the Broadcast Sink is acting as a Scan Delegator, it can ask its peer
Broadcast Assistants to provide the Code through BASS.


  Commit: f5c0fe68539fbfa7eefcc6088c5bbcc9f369a0e8
      https://github.com/bluez/bluez/commit/f5c0fe68539fbfa7eefcc6088c5bbcc9f369a0e8
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-15 (Tue, 15 Oct 2024)

  Changed paths:
    M src/shared/bass.c
    M src/shared/bass.h

  Log Message:
  -----------
  shared/bass: Add API to set BIG enc state

This adds a shared/bass API to set the BIG encryption state field inside
a Broadcast Receive State characteristic. Notifications are then sent to
inform all peers about the update.


  Commit: 4bc20f9df4056956d059750635be3faaabd88c05
      https://github.com/bluez/bluez/commit/4bc20f9df4056956d059750635be3faaabd88c05
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-15 (Tue, 15 Oct 2024)

  Changed paths:
    M profiles/audio/bass.c
    M profiles/audio/bass.h

  Log Message:
  -----------
  bass: Add support to request bcode

This adds support for a Scan Delegator to request the Broadcast Code
from peer Broadcast Assistants and to update a BAP stream QoS with the
value.

A BASS API is added to update the BIG encryption status of a Broadcast
Receive State characteristic and to notify peers. When a peer provides
the Code using the BASS "Set Broadcast Code" operation, the BAP stream
QoS is updated. The driver calling this API will pass a callback as
parameter, which will be called to signal that the Broadcast Code has
been received and stored in the stream QoS.

A timeout is set to wait for Broadcast Assistants to provide the Code.
If the timeout expires, the callback will be code with the appropriate
error status.


  Commit: 29cb1b0b10fd3ab94cf38c059f7bcdb8ba2933bd
      https://github.com/bluez/bluez/commit/29cb1b0b10fd3ab94cf38c059f7bcdb8ba2933bd
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-15 (Tue, 15 Oct 2024)

  Changed paths:
    M src/shared/bass.c

  Log Message:
  -----------
  shared/bass: Call cp handler for the Set Broadcast Code op

This updates the Set Broadcast Code control point handler inside
shared/bass to call the handlers queued inside bt_bass.


  Commit: c5616c255b138d26af32ac306a6622825803ee69
      https://github.com/bluez/bluez/commit/c5616c255b138d26af32ac306a6622825803ee69
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-15 (Tue, 15 Oct 2024)

  Changed paths:
    M src/shared/bass.c

  Log Message:
  -----------
  shared/bass: Set correct BIG enc state after sync

A Scan Delegator might set the BIG encryption state of a Broadcast
Receive State characteristic to "Broadcast Code Required", to notify
Broadcast Assistants that the value is needed to decrypt the streams.

If the Broadcast Code was received and BIG sync was established, the
BIG encryption state must be transitioned to "Decrypting" state, to
inform Assistants that BIG sync was successfully established with the
correct Code.


  Commit: c7119b4f4e427a310e675261e30e4d9ea67a08b5
      https://github.com/bluez/bluez/commit/c7119b4f4e427a310e675261e30e4d9ea67a08b5
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-15 (Tue, 15 Oct 2024)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Add support to request bcode from Assistant

A Broadcast Sink might scan an encrypted stream, but the user might
not know the Broadacst Code to decrypt it. However, if the Broadcast
Sink is acting as a Scan Delegator, it can request the Code from
Broadcast Assistants.

This adds support to ask for the Broadcast Code through BASS, if an
empty Code was entered by the user at transport select.

The bluetoothctl log below shows a Scan Delegator creating a media
transport for an encrypted BIS added by a Broadcast Assistant through
the Add Source operation. The user is asked to enter the Broadcast Code
at transport.select, and the "no" option is chosen, since the Code is
unknown. However, the Code is received from the Broadcast Assistant and
the transport is successfully acquired.

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 1
[/local/endpoint/ep0] Supported Context (value): 1
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# advertise on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
[00-60-37-31-7E-3F]# [NEW] Device 23:E1:A6:85:D9:11 23-E1-A6-85-D9-11
[00-60-37-31-7E-3F]# [NEW] Transport
    /org/bluez/hci2/dev_23_E1_A6_85_D9_11/bis1/fd0
[00-60-37-31-7E-3F]# transport.select
    /org/bluez/hci2/dev_23_E1_A6_85_D9_11/bis1/fd0
[] Enter brocast code[value/no]: no
[00-60-37-31-7E-3F]# Setting broadcast code succeeded
[00-60-37-31-7E-3F]# [CHG] Transport
    /org/bluez/hci2/dev_23_E1_A6_85_D9_11/bis1/fd0 State: broadcasting
[00-60-37-31-7E-3F]# transport.acquire
    /org/bluez/hci2/dev_23_E1_A6_85_D9_11/bis1/fd0
[00-60-37-31-7E-3F]# Transport
    /org/bluez/hci2/dev_23_E1_A6_85_D9_11/bis1/fd0 acquiring complete
[00-60-37-31-7E-3F]# [CHG] Transport
    /org/bluez/hci2/dev_23_E1_A6_85_D9_11/bis1/fd0 State: active

The btmon log shows the BASS GATT write commands and notifications
exchanged between the Scan Delegator and the Broadcast Assistant:

> ACL Data RX: Handle 0 flags 0x01 dlen 1
      ATT: Write Command (0x52) len 23
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[21]: 020111d985a6e12300f9bb8502ffff010100000000
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 23:E1:A6:85:D9:11
            Source_Adv_SID: 0
            Broadcast_ID: 0x85bbf9
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000001
< HCI Command: LE Periodic Advertising Create Sync (0x08|0x0044) plen 14
        Options: 0x0000
        Use advertising SID, Advertiser Address Type and address
        Reporting initially enabled
        SID: 0x00
        Adv address type: Random (0x01)
        Adv address: 23:E1:A6:85:D9:11 (Non-Resolvable)
        Skip: 0x0000
        Sync timeout: 20000 msec (0x07d0)
        Sync CTE type: 0x0000
> HCI Event: LE Meta Event (0x3e) plen 16
      LE Periodic Advertising Sync Established (0x0e)
        Status: Success (0x00)
        Sync handle: 0
        Advertising SID: 0x00
        Advertiser address type: Random (0x01)
        Advertiser address: 23:E1:A6:85:D9:11 (Non-Resolvable)
        Advertiser PHY: LE 2M (0x02)
        Periodic advertising interval: 10.00 msec (0x0008)
        Advertiser clock accuracy: 0x07
> HCI Event: LE Meta Event (0x3e) plen 42
      LE Periodic Advertising Report (0x0f)
        Sync handle: 0
        TX power: 127 dbm (0x7f)
        RSSI: -57 dBm (0xc7)
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
            Codec Specific Configuration: Sampling Frequency: 16 Khz (0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
            Codec Specific Configuration: Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
            Codec Specific Configuration: Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
            Codec Specific Configuration: Location: 0x00000001
            Codec Specific Configuration: Location: Front Left (0x00000001)
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
        Encryption: 0x01
bluetoothd[5431]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 010111d985a6e12300f9bb850200010000000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 23:E1:A6:85:D9:11
          Source_Adv_SID: 0
          Broadcast_ID: 0x85bbf9
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
bluetoothd[5431]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 010111d985a6e12300f9bb850201010000000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 23:E1:A6:85:D9:11
          Source_Adv_SID: 0
          Broadcast_ID: 0x85bbf9
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Broadcast_Code required
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
> ACL Data RX: Handle 0 flags 0x02 dlen 25
      ATT: Write Command (0x52) len 20
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[18]: 040161616100000000000000000000000000
            Opcode: Set Broadcast_Code (0x04)
            Source_ID: 1
            Broadcast_Code[16]: 61616100000000000000000000000000
< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b)
        BIG Handle: 0x00
        BIG Sync Handle: 0x0000
        Encryption: Encrypted (0x01)
        Broadcast Code[16]: 61616100000000000000000000000000
        Maximum Number Subevents: 0x00
        Timeout: 20000 ms (0x07d0)
        Number of BIS: 1
        BIS ID: 0x01
> HCI Event: LE Meta Event (0x3e) plen 17
      LE Broadcast Isochronous Group Sync Estabilished (0x1d)
        Status: Success (0x00)
        BIG Handle: 0x00
        Transport Latency: 960 us (0x0003c0)
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
bluetoothd[5431]: < ACL Data TX: Handle 0 flags 0x00 dlen 29
      ATT: Handle Multiple Value Notification (0x23) len 24
        Length: 0x0014
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[20]: 010111d985a6e12300f9bb850202010100000000
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 23:E1:A6:85:D9:11
          Source_Adv_SID: 0
          Broadcast_ID: 0x85bbf9
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Decrypting
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000001


  Commit: 5d7e6a64b2fcfcfbabe46b9587f11de2989eff71
      https://github.com/bluez/bluez/commit/5d7e6a64b2fcfcfbabe46b9587f11de2989eff71
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-10-15 (Tue, 15 Oct 2024)

  Changed paths:
    M client/scripts/broadcast-assistant.bt
    M client/scripts/scan-delegator.bt

  Log Message:
  -----------
  client: Update scripts to include encrypted stream scenario

This updates the broadcast-assistant/scan-delegator scripts to include
the encrypted stream scenario.


  Commit: 3d9900eb754d277ef6abf21bed827cdc9e79ddb4
      https://github.com/bluez/bluez/commit/3d9900eb754d277ef6abf21bed827cdc9e79ddb4
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2024-10-15 (Tue, 15 Oct 2024)

  Changed paths:
    M profiles/audio/avdtp.c
    M profiles/audio/avdtp.h
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Delay existence based on delay reporting capability

In case when the existence of the delay property is based on its value
not being zero it is not possible to read the delay if sink sets it to
zero on purpose (or it was not updated by the sink at all). However,
client might expect it to be readable, if SEP reports delay reporting
as available.

Instead of checking the value, we should check the capabilities of
the AVDTP stream. Also, by doing that we can allow this property to
be writable in the future - the exists() callback is used in the
properties_set() function as well.


Compare: https://github.com/bluez/bluez/compare/bd7d49d54aa3...3d9900eb754d

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
