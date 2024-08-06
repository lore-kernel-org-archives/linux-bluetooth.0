Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291DE5B1FB
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Aug 2024 18:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722969542; cv=none; b=gWNlAjvdsKUimr3OUBB03DnWgc9gwzD8jE0Bd/YEYdvSiwqnqF7xGVz57mbraaTOayfxRpyxknsSr/Db+0m5Icf+7MKb6W1fepinOwIJ46IiAv1THIG7WgX0GWEOjZ82r2MdZnbkhN89rcBXOXPA1W6ehLVT2nPUVtu+UhVaKFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722969542; c=relaxed/simple;
	bh=43Gd3BP7rYcbn3p6h9RDA5bpfxNVnNjcd1hlI/9MsFw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UNFysfcIXd9PDJeUF/x7rSb/RskvchLJlrOzUOSU5cA53DraBkhp2ipDeeQKsRLn17ouC7T2CVqSv8raX9drn+7fuYdScxtCt1cu4518MDaIG4MXu3l/t1UEhCUhp/f1iGBU9N9V5rd5tEjqFdux5RejsLRa3hM/MkC+S7gkzYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ia7IbS6h; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ia7IbS6h"
Received: from github.com (hubbernetes-node-ede310f.va3-iad.github.net [10.48.14.22])
	by smtp.github.com (Postfix) with ESMTPA id 2FB58E108C
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Aug 2024 11:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1722969540;
	bh=nwpvndVNwBYi9tZV51IEaULUlzxOh6V3oPSzFT2/AK8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ia7IbS6hU0iOy1evQXH6ffCtczJW95Dek+3sIrI/s1U7FEqhC/R7EE7EILPEWGoGH
	 mcVI73Xke68iwsl/e4iuNkgH6W0sTWcJf1IdtkQLUhzPCqQz17+MBegbaHHqQPYWtU
	 0FB0un2Gla2DiI3IoFGBk8G6uTS3XiJAUeQ6tSaQ=
Date: Tue, 06 Aug 2024 11:39:00 -0700
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/100c84-e1aa24@github.com>
Subject: [bluez/bluez] a626ae: shared/bass: Add API to send GATT write command
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
  Commit: a626ae163fd716932838477c5d9d1d6ff23f6b0e
      https://github.com/bluez/bluez/commit/a626ae163fd716932838477c5d9d1d6ff23f6b0e
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-08-06 (Tue, 06 Aug 2024)

  Changed paths:
    M src/shared/bass.c
    M src/shared/bass.h

  Log Message:
  -----------
  shared/bass: Add API to send GATT write command

This adds a BASS API to send a GATT write command for the
Broadcast Audio Scan Control Point characteristic.


  Commit: 11fce8b098979b3ce12c52da5a018fe01c24ce27
      https://github.com/bluez/bluez/commit/11fce8b098979b3ce12c52da5a018fe01c24ce27
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-08-06 (Tue, 06 Aug 2024)

  Changed paths:
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Add support to iterate through service data

Some usecases require iterating through the service data structures
advertised by a scanned device - for example, a Broadcast Source
advertises the Broadcast Audio Announcement Service UUID, with the
Broadcast ID as service data. The Broadcast ID is used by audio
profiles to uniquely identify the Broadcast Source.

This adds an API to iterate through the service data advertised by
a device.


  Commit: a426c36171091b75c49226b4bb4a2563606e19f5
      https://github.com/bluez/bluez/commit/a426c36171091b75c49226b4bb4a2563606e19f5
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-08-06 (Tue, 06 Aug 2024)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Store Broadcast ID inside assistant struct

A Broadcast Source is uniquely identified by its Broadcast ID, which
is being advertised in the Extended Advertising Data.

After discovering a Broadcast Source, a BAP Broadcast Assistant needs
to internally store the Broadcast ID, which will be transmitted to the
peer Scan Delegator via the BASS "Add Source" operation.


  Commit: fc9c4f2313b71ea476de71f96e1f23f742ee08d6
      https://github.com/bluez/bluez/commit/fc9c4f2313b71ea476de71f96e1f23f742ee08d6
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-08-06 (Tue, 06 Aug 2024)

  Changed paths:
    M src/shared/bass.c
    M src/shared/bass.h

  Log Message:
  -----------
  shared/bass: Add APIs to register bcast src changed cb

A BAP Broadcast Assistant (BASS Client) needs to listen for GATT
notifications for Broadcast Receive State characteristics from peer
Scan Delegators (BASS Servers), in order to learn about updates in
Broadcasters known by the peer - for example, the Assistant can be
informed if the peer requires a Broadcast Code to decrypt an encrypted
stream.

This adds APIs that the BASS plugin can use to register/unregister
callbacks to be called on each received notification.


  Commit: 15811387144ca2f8274932204a54ff2fc6e36cff
      https://github.com/bluez/bluez/commit/15811387144ca2f8274932204a54ff2fc6e36cff
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-08-06 (Tue, 06 Aug 2024)

  Changed paths:
    M src/shared/bass.h

  Log Message:
  -----------
  shared/bass: Add additional defines

This adds BASS macros for Broadcast Source address types and for the
unknown PA interval value. These values are to be used as parameters
for the "Add Source" command.


  Commit: 117b993f3d680385b2634608d41e8e466911f439
      https://github.com/bluez/bluez/commit/117b993f3d680385b2634608d41e8e466911f439
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-08-06 (Tue, 06 Aug 2024)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Implement MediaAssistant Push method

This implements the MediaAssistant "Push" method, which sends a GATT
write command for the Broadcast Audio Scan Control Point characteristic
with the "Add Source" opcode.

This also registers a callback with shared/bass, to handle GATT
notifications from the peer. A MediaAssistant object transitions
to different states, depending on information received in the
callback. The callback is also useful to check if the peer requires
a Broadcast Code to decrypt the stream - in this case, the Assistant
uses the "Set Broadcast_Code" operation to provide the code.


  Commit: e1aa24a4394993375c381740c59f5292a32f6d4d
      https://github.com/bluez/bluez/commit/e1aa24a4394993375c381740c59f5292a32f6d4d
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-08-06 (Tue, 06 Aug 2024)

  Changed paths:
    M client/assistant.c

  Log Message:
  -----------
  assistant: Implement MediaAssistant Push command

This implements the MediaAssistant "Push" command, to trigger the
BlueZ Broadcast Assistant to send stream information to the peer.

After issuing the "Push" command, the user is prompted to enter
any stream metadata to be sent to the peer. If the "auto" value
is chosen, the default metadata found in the BASE will be sent.
Otherwise, the LTVs found in the BASE will be overwritten by the
user input.

If the stream is encrypted, the user is also prompted to enter the
Broadcast Code for decrypting. If the "auto" value is chosen, a zero
filled array will be provided over DBus.

Below is a bluetoothctl log to exercise the "Push" command for an
unencrypted stream:

client/bluetoothctl
[bluetooth]# [CHG] Controller 00:60:37:31:7E:3F Pairable: yes
[bluetooth]# AdvertisementMonitor path registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
[bluetooth]# connect 00:60:37:31:7E:3F
Attempting to connect to 00:60:37:31:7E:3F
[CHG] Device 00:60:37:31:7E:3F Connected: yes
[00-60-37-31-7E-3F]# Connection successful
[00-60-37-31-7E-3F]# [NEW] Device 15:19:44:63:76:7A 15-19-44-63-76-7A
[00-60-37-31-7E-3F]# [NEW] Assistant
      /org/bluez/hci0/src_15_19_44_63_76_7A/dev_00_60_37_31_7E_3F/bis1
[00-60-37-31-7E-3F]# assistant.push
      /org/bluez/hci0/src_15_19_44_63_76_7A/dev_00_60_37_31_7E_3F/bis1
[Assistant] Enter Metadata (auto/value): 0x03 0x02 0x04 0x00
[00-60-37-31-7E-3F]# [CHG] Assistant
      /org/bluez/hci0/src_15_19_44_63_76_7A/dev_00_60_37_31_7E_3F/bis1
      State: pending
[00-60-37-31-7E-3F]# Assistant
      /org/bluez/hci0/src_15_19_44_63_76_7A/dev_00_60_37_31_7E_3F/bis1
      pushed
[00-60-37-31-7E-3F]# [CHG] Assistant
      /org/bluez/hci0/src_15_19_44_63_76_7A/dev_00_60_37_31_7E_3F/bis1
      State: active

The btmon log below shows the GATT write command sent by the Assistant
and the GATT notification received from the peer:

< ACL Data TX: Handle 0 flags 0x00 dlen 32
      ATT: Write Command (0x52) len 27
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[25]: 02017a766344191500c21a3702ffff01010000000403020400
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 15:19:44:63:76:7A
            Source_Adv_SID: 0
            Broadcast_ID: 0x371ac2
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000001
              Metadata: #0: len 0x03 type 0x02
              Metadata:   04 00

> ACL Data RX: Handle 0 flags 0x01 dlen 6
      ATT: Handle Multiple Value Notification (0x23) len 28
        Length: 0x0018
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[24]: 01017a766344191500c21a37020001010000000403020400
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 15:19:44:63:76:7A
          Source_Adv_SID: 0
          Broadcast_ID: 0x371ac2
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Not encrypted
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000001
            Metadata: #0: len 0x03 type 0x02
            Metadata:   04 00

The bluetoothctl log below shows the "Push" command flow for an
encrypted stream:

client/bluetoothctl
[bluetooth]# [CHG] Controller 00:60:37:31:7E:3F Pairable: yes
[bluetooth]# AdvertisementMonitor path registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 00:60:37:31:7E:3F 00-60-37-31-7E-3F
[bluetooth]# connect 00:60:37:31:7E:3F
Attempting to connect to 00:60:37:31:7E:3F
[CHG] Device 00:60:37:31:7E:3F Connected: yes
[00-60-37-31-7E-3F]# Connection successful
[00-60-37-31-7E-3F]# [NEW] Device 05:1F:EE:F3:F8:7D 05-1F-EE-F3-F8-7D
[00-60-37-31-7E-3F]# [NEW] Assistant
      /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1
[00-60-37-31-7E-3F]# assistant.push
      /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1
[Assistant] Enter Metadata (auto/value): 0x03 0x02 0x04 0x00
[Assistant] Enter Broadcast Code (auto/value): 0x01 0x02 0x68 0x05 0x53
      0xf1 0x41 0x5a 0xa2 0x65 0xbb 0xaf 0xc6 0xea 0x03 0xb8
[00-60-37-31-7E-3F]# [CHG] Assistant
      /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1
      State: pending
[00-60-37-31-7E-3F]# Assistant
      /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1
      pushed
[00-60-37-31-7E-3F]# [CHG] Assistant
      /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1
      State: requesting
[00-60-37-31-7E-3F]# [CHG] Assistant
      /org/bluez/hci0/src_05_1F_EE_F3_F8_7D/dev_00_60_37_31_7E_3F/bis1
      State: active

The GATT write commands and notifications for this scenario are shown
in the btmon log below:

< ACL Data TX: Handle 0 flags 0x00 dlen 32
      ATT: Write Command (0x52) len 27
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[25]: 02017df8f3ee1f0500f4015d02ffff01010000000403020400
            Opcode: Add Source (0x02)
            Source_Address_Type: 1
            Source_Address: 05:1F:EE:F3:F8:7D
            Source_Adv_SID: 0
            Broadcast_ID: 0x5d01f4
            PA_Sync_State: Synchronize to PA - PAST not available
            PA_Interval: 0xffff
            Num_Subgroups: 1
            Subgroup #0:
              BIS_Sync State: 0x00000001
              Metadata: #0: len 0x03 type 0x02
              Metadata:   04 00

> ACL Data RX: Handle 0 flags 0x01 dlen 6
      ATT: Handle Multiple Value Notification (0x23) len 28
        Length: 0x0018
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[24]: 01017df8f3ee1f0500f4015d020101000000000403020400
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 05:1F:EE:F3:F8:7D
          Source_Adv_SID: 0
          Broadcast_ID: 0x5d01f4
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Broadcast_Code required
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000000
            Metadata: #0: len 0x03 type 0x02
            Metadata:   04 00

< ACL Data TX: Handle 0 flags 0x00 dlen 25
      ATT: Write Command (0x52) len 20
        Handle: 0x0040 Type: Broadcast Audio Scan Control Point (0x2bc7)
          Data[18]: 04010102680553f1415aa265bbafc6ea03b8
            Opcode: Set Broadcast_Code (0x04)
            Source_ID: 1
            Broadcast_Code[16]: 0102680553f1415aa265bbafc6ea03b8

> ACL Data RX: Handle 0 flags 0x01 dlen 6
      ATT: Handle Multiple Value Notification (0x23) len 28
        Length: 0x0018
        Handle: 0x003a Type: Broadcast Receive State (0x2bc8)
          Data[24]: 01017df8f3ee1f0500f4015d020201010000000403020400
          Source_ID: 1
          Source_Address_Type: 1
          Source_Address: 05:1F:EE:F3:F8:7D
          Source_Adv_SID: 0
          Broadcast_ID: 0x5d01f4
          PA_Sync_State: Synchronized to PA
          BIG_Encryption: Decrypting
          Num_Subgroups: 1
          Subgroup #0:
            BIS_Sync State: 0x00000001
            Metadata: #0: len 0x03 type 0x02
            Metadata:   04 00


Compare: https://github.com/bluez/bluez/compare/100c845b2d20...e1aa24a43949

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
