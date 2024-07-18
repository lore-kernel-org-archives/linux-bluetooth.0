Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68EB14534C
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 19:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721329670; cv=none; b=l5tPbsW84RKqo5Dum74IHKWLpQJHVjvin4MtYEtn5eVeLdoXU5Xn6b1DTFUryluBBVvmw+8RZ8xDr1Wv9ZXYZzuilq2u+Ybv6oUhKfwkIXcMKImfY6s2XYnDSMgr8Wbv+uPHlxN++5iV+HQZ4txI6fE71k/EERmzDEMPadSC+oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721329670; c=relaxed/simple;
	bh=FF3W7nQOW+d3Y0qqnbUXE5Z+KudmjGj5n/zrfQq0uAE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Z/7VkGdXsl8As8txMcpYqLaVFaAzyDmHLNF14bCZBd4Qol6grkmwwGBOxJWtkNlBkkmB9C/mcC4fGi3yNCwNZTR6HG79S1jfVoWhEn1/kQdM5nQsGNeAIwBahGRFgKoGBpgIhnUtWGOUk+/xmeOvAoWL/nxLibWFZqgflYpD8iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=CFaFqRAo; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="CFaFqRAo"
Received: from github.com (hubbernetes-node-c9ad705.va3-iad.github.net [10.48.137.13])
	by smtp.github.com (Postfix) with ESMTPA id B31EF8C06DC
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jul 2024 12:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1721329667;
	bh=eFeY8Ub9rCAKueaPGaqO4HIRyNIIQMn1m3mTusgD28Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=CFaFqRAoNDTQGPbucBW4/GfRqgdtAOxuITTUNTjXS8WlqbCSjrrwQtWfiMcj3n93h
	 2IXvD7cJVREBl7cmCal2OGq5kzsrvDOHGoQbJ6HCwL8XBQ5u/LRFNQIqEfK//85qo6
	 +AbvaqfxlnFDgkeX3aiDL8bbQOiFXKu6PnBtK4Vo=
Date: Thu, 18 Jul 2024 12:07:47 -0700
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9cc587-a3f997@github.com>
Subject: [bluez/bluez] 732663: shared/bap: Fix ASE notification order
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
  Commit: 73266377b0185c56c921b8cece257df428612d73
      https://github.com/bluez/bluez/commit/73266377b0185c56c921b8cece257df428612d73
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-07-15 (Mon, 15 Jul 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix ASE notification order

When processing a CP operation the CP shall be notified ahead of
the ASE itself:

  'If the server successfully completes a client-initiated ASE Control
  operation for an ASE, the server shall send a notification of the ASE
  Control Point characteristic value formatted as defined in Table 4.7.
  The server shall then perform the behavior defined in Section 5.1
  through Section 5.8 for that ASE Control operation and send
  notifications of any ASE characteristic values written during that
  ASE Control operation.'

So this delays the processing of notifications of ASE states so the CP
responses always appears first in the notification e.g:

> ACL Data RX: Handle 42 flags 0x02 dlen 59
      ATT: Handle Multiple Value Notification (0x23) len 54
        Length: 0x0008
        Handle: 0x0036 Type: ASE Control Point (0x2bc6)
          Data[8]: 0202030000010000
            Opcode: QoS Configuration (0x02)
            Number of ASE(s): 2
            ASE: #0
            ASE ID: 0x03
            ASE Response Code: Success (0x00)
            ASE Response Reason: None (0x00)
            ASE: #1
            ASE ID: 0x01
            ASE Response Code: Success (0x00)
            ASE Response Reason: None (0x00)
        Length: 0x0011
        Handle: 0x0030 Type: Source ASE (0x2bc5)
          Data[17]: 0302000010270000022800020a00409c00
            ASE ID: 3
            State: QoS Configured (0x02)
            CIG ID: 0x00
            CIS ID: 0x00
            SDU Interval: 10000 usec
            Framing: Unframed (0x00)
            PHY: 0x02
            LE 2M PHY (0x02)
            Max SDU: 40
            RTN: 2
            Max Transport Latency: 10
            Presentation Delay: 40000 us
        Length: 0x0011
        Handle: 0x002a Type: Sink ASE (0x2bc4)
          Data[17]: 0102000010270000025000020a00409c00
            ASE ID: 1
            State: QoS Configured (0x02)
            CIG ID: 0x00
            CIS ID: 0x00
            SDU Interval: 10000 usec
            Framing: Unframed (0x00)
            PHY: 0x02
            LE 2M PHY (0x02)
            Max SDU: 80
            RTN: 2
            Max Transport Latency: 10
            Presentation Delay: 40000 us


  Commit: 025f07ec0d0ebfb5e83c07d2918a6c01b0ae49a6
      https://github.com/bluez/bluez/commit/025f07ec0d0ebfb5e83c07d2918a6c01b0ae49a6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-07-18 (Thu, 18 Jul 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add support for name custom presets

This adds support for naming custom presets instead of always having
just one "custom" codec preset which needs to be overwriten everytime
a new set of settings needs to be entered.


  Commit: 957c956112cc2bba528fe8df4a0a21d221a617ca
      https://github.com/bluez/bluez/commit/957c956112cc2bba528fe8df4a0a21d221a617ca
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-07-18 (Thu, 18 Jul 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix printing errors when transport->filename is not set

If transport->filename is not set don't attempt to write to the
transport->fd.


  Commit: 0bad3d5cbea84b24d53e86de7c419e893bb19a93
      https://github.com/bluez/bluez/commit/0bad3d5cbea84b24d53e86de7c419e893bb19a93
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-07-18 (Thu, 18 Jul 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix crash in bap_bcast_remove

This adds a check for the PA request dequeued in bap_bcast_remove,
to avoid accessing a member within a NULL pointer.


  Commit: caa4202a7ee3423211733f7883641c77666dfbbf
      https://github.com/bluez/bluez/commit/caa4202a7ee3423211733f7883641c77666dfbbf
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-07-18 (Thu, 18 Jul 2024)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Add separate API to merge caps

This moves the logic to merge L2 and L3 capabilities discovered
inside a BASE structure in a public API.


  Commit: 679349fbc9f2eaf4216cca0ca45f25e4d2829c9d
      https://github.com/bluez/bluez/commit/679349fbc9f2eaf4216cca0ca45f25e4d2829c9d
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-07-18 (Thu, 18 Jul 2024)

  Changed paths:
    M profiles/audio/bap.c
    M src/shared/bap.c
    M src/shared/bap.h
    M unit/test-bap.c

  Log Message:
  -----------
  shared/bap: Update bt_bap_verify_bis to receive caps

This updates bt_bap_verify_bis to receive the already merged L2 and L3
capabilities, instead of computing it internally.


  Commit: bbcf4891cd46f53e35761db808155dc0fb89b175
      https://github.com/bluez/bluez/commit/bbcf4891cd46f53e35761db808155dc0fb89b175
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-07-18 (Thu, 18 Jul 2024)

  Changed paths:
    M profiles/audio/bap.c
    M src/shared/bap.c
    M src/shared/bap.h
    M unit/test-bap.c

  Log Message:
  -----------
  shared/bap: Remove unused param from bt_bap_verify_bis

This removes the codec parameter from bt_bap_verify_bis,
since it is not used.


  Commit: 662aee4357f8975763280fec0e6cd35b2082200d
      https://github.com/bluez/bluez/commit/662aee4357f8975763280fec0e6cd35b2082200d
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-07-18 (Thu, 18 Jul 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Allow checking bis caps against peer caps

A BAP Broadcast Assistant needs to match stream capabilities with
capabilities discovered in the Sink PAC characteristic on the peer.

This updates bt_bap_verify_bis to check the provided stream capabilities
against local or remote capabilities, depending on the bap structure
provided:

If the device is acting as a BAP Broadcast Sink and the bap session was
created after scanning a Broadcast Source, the stream caps will be matched
with the local broadcast sink PAC.

If the device is acting as a Broadcast Assistant and the bap session is a
client session with a BAP Scan Delegator, the stream caps will be matched
with the PAC records populated in the rdb at service discovery.


  Commit: 2c98c478863ee9e213a4129f0f4fee2b16b678da
      https://github.com/bluez/bluez/commit/2c98c478863ee9e213a4129f0f4fee2b16b678da
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-07-18 (Thu, 18 Jul 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Append bcast sink pacs to Sink PAC char

It is mandatory for a BAP Broadcast Sink to support the PACS Server role.
The Sink PAC characteristic should contain PAC records that expose
supported audio capabilities for receiving both unicast and broadcast
streams.

A BAP Broadcast Assistant acting as a GATT Client needs to discover the
Sink PAC characteristic on the BAP Scan Delegator peer (BAP Broadcast
Sink), in order to discover supported capabilities for receiving streams.

This commit updates the callback for handling read requests for the Sink
PAC characteristic, to also append Broadcast Sink pac structures to the
read response.


  Commit: f163913488106929081026c56c236800aa6f8269
      https://github.com/bluez/bluez/commit/f163913488106929081026c56c236800aa6f8269
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-07-18 (Thu, 18 Jul 2024)

  Changed paths:
    M Makefile.plugins
    M profiles/audio/bap.c
    A profiles/audio/bap.h

  Log Message:
  -----------
  bap: Add API to get bt_bap matching device

This adds a public BAP API to obtain a reference to the bt_bap session
with a peer device.


  Commit: 88bf423eb525655e15890bdca84d9acb5afab122
      https://github.com/bluez/bluez/commit/88bf423eb525655e15890bdca84d9acb5afab122
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-07-18 (Thu, 18 Jul 2024)

  Changed paths:
    M src/shared/bass.c
    M src/shared/bass.h

  Log Message:
  -----------
  shared/bass: Add API to get GATT client reference

Some use cases require the BASS plugin to differentiate between client and
server BASS sessions - for example, the BAP Broadcast Assistant role only
considers client BASS sessions.

This adds a BASS API to obtain a reference to the bt_gatt_client structure
attached to the bt_bass session.


  Commit: 77e4c0976c0d342e45f0ad1b485efd7e60863e30
      https://github.com/bluez/bluez/commit/77e4c0976c0d342e45f0ad1b485efd7e60863e30
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-07-18 (Thu, 18 Jul 2024)

  Changed paths:
    M Makefile.plugins
    M profiles/audio/bass.c
    A profiles/audio/bass.h

  Log Message:
  -----------
  bass: Register MediaAssistant objects

This adds an initial implementation of the BAP Broadcast Assistant role
in the BASS plugin, by introducing the MediaAssistant DBus object.

The BAP plugin implements the callback to probe Broadcast Sources and
parse the BASE. This commit adds 2 BASS APIs, that will be called by the
BAP plugin to notify BISes discovered in the BASE of a broadcaster to
BASS, or to inform the BASS plugin that a broadcaster has been removed.

For each BASS client session, the BASS plugin checks BIS caps against
the peer caps, and registers a MediaAssistant object for each match.


  Commit: 22779f0bce61cfd5cd72f4e2c199aaa385067248
      https://github.com/bluez/bluez/commit/22779f0bce61cfd5cd72f4e2c199aaa385067248
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-07-18 (Thu, 18 Jul 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Notify scanned BISes to BASS

This updates the BAP implementation to also notify the BASS plugin about
scanned broadcast streams, or when a scanned broadcaster is removed. This
is needed for the BAP Broadcast Assistant role - the BASS plugin registers
MediaAssistant objects for each detected stream that matches the audio
capabilities of peer Scan Delegator devices.


  Commit: a3f9970f7a8b62b426e7a00303ddb66acb79aadd
      https://github.com/bluez/bluez/commit/a3f9970f7a8b62b426e7a00303ddb66acb79aadd
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-07-18 (Thu, 18 Jul 2024)

  Changed paths:
    M Makefile.tools
    A client/assistant.c
    A client/assistant.h
    M client/main.c

  Log Message:
  -----------
  client: Add assistant submenu

This adds the initial implementation for the assistant menu in
bluetoothctl, to detect and print MediaAssistant objects.

The current BAP Broadcast Assistant implementation can be tested
by running bluetoothctl, connecting to a BASS Server, scanning
a Broadcast Source that is streaming a number of BISes with
audio capabilities matching the capabilities of the peer device,
and noticing the MediaAssistant objects being created:

client/bluetoothctl
[bluetooth]# [CHG] Controller 00:60:37:31:7E:3F Pairable: yes
[bluetooth]# AdvertisementMonitor path registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 00:60:37:94:A6:A3 00-60-37-94-A6-A3
[bluetooth]# connect 00:60:37:94:A6:A3
Attempting to connect to 00:60:37:94:A6:A3
[CHG] Device 00:60:37:94:A6:A3 Connected: yes
[00-60-37-94-A6-A3]# Connection successful
[00-60-37-94-A6-A3]# [NEW] Device 15:65:78:B6:52:F6 15-65-78-B6-52-F6
[00-60-37-94-A6-A3]# [NEW] Assistant
       /org/bluez/hci0/src_15_65_78_B6_52_F6/dev_00_60_37_94_A6_A3/bis1
[00-60-37-94-A6-A3]# [NEW] Assistant
       /org/bluez/hci0/src_15_65_78_B6_52_F6/dev_00_60_37_94_A6_A3/bis2
[00-60-37-94-A6-A3]# scan off
[00-60-37-94-A6-A3]# Diovery stopped
[00-60-37-94-A6-A3]# disconnect
Attempting to disconnect from 00:60:37:94:A6:A3
[00-60-37-94-A6-A3]# Successful disconnected
[CHG] Device 00:60:37:94:A6:A3 Connected: no
[bluetooth]# [DEL] Assistant
       /org/bluez/hci0/src_15_65_78_B6_52_F6/dev_00_60_37_94_A6_A3/bis1
[bluetooth]# [DEL] Assistant
       /org/bluez/hci0/src_15_65_78_B6_52_F6/dev_00_60_37_94_A6_A3/bis2


Compare: https://github.com/bluez/bluez/compare/9cc587947b6a...a3f9970f7a8b

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
