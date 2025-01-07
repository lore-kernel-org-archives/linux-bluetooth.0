Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B4E1AD3E0
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736262458; cv=none; b=FI4uZBxEn9Fl/lAO78wF7lk1rOgc3eOgv0L92Zh8MEfEIO6Q6f6C6X0SVTKR69hDHn1xDh5y5/m7iyLe2Y7WwKEp0AgK9BItgnav2Lxk8BaL1r4e2awLNd3UY5WGoAkwtT3/BEtnkOx9p3RI9Y0bae3cYIsI45dmJ7AvVc7e1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736262458; c=relaxed/simple;
	bh=hLrjx7+sBrjNRhozgo3sM40ECNxXRnIm0NEXsHw63Ag=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VWRZHk74Pysgd3fWvdsjK8gv24lxlMP+1wyPDmS6yh/qM73HRBiiEhS3pKIvyib/UAF7kh5Bw6nH3dZ8IQMqc2i6D+xh1MS14C+m+oM7x2jrduU9wedgFwYc/UK1Li8MINNXZ6hlfX0R5gZ6In3K7RKiyBoFsNfLRmxRyGqjLco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KZHo3+yI; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KZHo3+yI"
Received: from github.com (hubbernetes-node-193b158.va3-iad.github.net [10.48.143.37])
	by smtp.github.com (Postfix) with ESMTPA id 9F9B58C0FB2
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 07:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1736262454;
	bh=KvTukkHaME3zcmu4AaAr2MwzghbdpYReNMaVlU9jytE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KZHo3+yIpIx4X0uooeMG8CGLq3jQTCbkqmDFcZlIdO9UmkEp8FouuBhDqDpgZYSN1
	 2/MfBDmQjKRjLAlEvF0hSV9uX8AUnThdrRF2HlAgVd0VdNf4uteL10eb0IOnzq5OAy
	 I2zLL6v76JbEREtF8nSoAlrRGYtzeaW5juWoVEB4=
Date: Tue, 07 Jan 2025 07:07:34 -0800
From: Ahrotahn <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/dfb1ff-79900d@github.com>
Subject: [bluez/bluez] 9b094c: shared/bass: Fix clearing BIS sync index
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
  Commit: 9b094c56fcf2f684506636bc05d4e45b46fb6367
      https://github.com/bluez/bluez/commit/9b094c56fcf2f684506636bc05d4e45b46fb6367
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-01-07 (Tue, 07 Jan 2025)

  Changed paths:
    M src/shared/bass.c

  Log Message:
  -----------
  shared/bass: Fix clearing BIS sync index

This fixes bt_bass_clear_bis_sync by checking the bitmask which contains
synced BIS indeces, instead of the mask holding pending BISes.


  Commit: 86081a10bdbf9a7712eead9e6c6b9b820e8a24b3
      https://github.com/bluez/bluez/commit/86081a10bdbf9a7712eead9e6c6b9b820e8a24b3
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-01-07 (Tue, 07 Jan 2025)

  Changed paths:
    M src/shared/bass.c
    M src/shared/bass.h

  Log Message:
  -----------
  shared/bass: Add API to set sync state

This adds an API to set the PA sync state of o Broadcast Receive State
characteristic.


  Commit: 547b009107355e673a69d0dfedf44bf56b148677
      https://github.com/bluez/bluez/commit/547b009107355e673a69d0dfedf44bf56b148677
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-01-07 (Tue, 07 Jan 2025)

  Changed paths:
    M src/shared/bass.c

  Log Message:
  -----------
  shared/bass: Add handler for Modify Source opcode

This adds a control point handler for the Modify Source opcode.


  Commit: ac06953bc200f96bdea3acbfa0831c838e52699f
      https://github.com/bluez/bluez/commit/ac06953bc200f96bdea3acbfa0831c838e52699f
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-01-07 (Tue, 07 Jan 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Create setups for all BISes in BASE

A BAP Scan Delegator (BASS Server) might be instructed by BAP Broadcast
Assistants (BASS Clients) to change sync between streams, via the Modify
Source operation. A Scan Delegator should create setups for all BISes
discovered in the BASE of a Broadcast Source, and create associated
streams based on Add Source/Modify Source commands received from
Assistants.


  Commit: 614f2fc800f52780a6a03c090de402ca7dbc8c33
      https://github.com/bluez/bluez/commit/614f2fc800f52780a6a03c090de402ca7dbc8c33
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-01-07 (Tue, 07 Jan 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Pass delegator reference to connect_cb

The connect_cb callback should receive more generic user_data instead
of the stream reference, since the event source is not removed after
connected fds are notified, and the same event might be generated
multiple times for the same io, expecting to connect different streams.


  Commit: e83d3021e1308a0ad3a84df0cf49b71ee1b1a7c6
      https://github.com/bluez/bluez/commit/e83d3021e1308a0ad3a84df0cf49b71ee1b1a7c6
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-01-07 (Tue, 07 Jan 2025)

  Changed paths:
    M profiles/audio/bass.c

  Log Message:
  -----------
  bass: Handle Modify Source opcode

This adds a handler for the Modify Source opcode.

A Broadcast Assistant might write the Modify Source opcode to request
the Scan Delegator to terminate or establish sync with some BISes.

If required to terminate sync with specific BISes, the Scan Delegator
must unlink and release the streams, leaving the others active. If
required to sync to a new BIS, the Scan Delegator must redo BIG sync
with a new array of BIS indeces. All active streams must be unlinked
and disabled, and the new stream should be configured. Then, the
user can select and acquire the streams, which will recreate the ios.


  Commit: d3018fe2dc589dd0ac1e3d3ef45e40106769f579
      https://github.com/bluez/bluez/commit/d3018fe2dc589dd0ac1e3d3ef45e40106769f579
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2025-01-07 (Tue, 07 Jan 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Rework transport select for encrypted streams

This fixes the transport select flow in bluetoothctl: If the user tries
to select multiple encrypted transports, the prompts for the Broadcast
Code overlap, causing the UI to be distorted:

[11-AE-0A-C1-F4-30]# transport.select
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd0
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd1
[] Enter brocast code[value/no]: Successfully linked transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd1
[] Enter brocast code[value/no]: Borne House
(null)Setting broadcast code succeeded
(null)[CHG] Transport /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd0
                     State: broadcasting
(null)Select successful
(null)

This commit updates the transport select command handler to first
link all transports before setting the Broadcast Code only on the
primary link (the Broadcast Code is common for all BISes in the BIG).
After the Broadcast Code is successfully set, each link is selected
one by one. The bluetoothctl log below shows the updated output:

client/bluetoothctl
[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[/local/endpoint/ep0] Auto Accept (yes/no): y
[/local/endpoint/ep0] Max Transports (auto/value): a
[/local/endpoint/ep0] Locations: 1
[/local/endpoint/ep0] Supported Context (value): 1
[bluetooth]# Endpoint /local/endpoint/ep0 registered
[bluetooth]# scan on
[bluetooth]# [NEW] Device 11:16:BD:36:58:3F 11-16-BD-36-58-3F
[11-16-BD-36-58-3F]# [CHG] Device 11:16:BD:36:58:3F Connected: yes
[11-16-BD-36-58-3F]# [NEW] Transport
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis1/fd0
[11-16-BD-36-58-3F]# [NEW] Transport
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis2/fd1
[11-16-BD-36-58-3F]# transport.select
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis1/fd0
                     /org/bluez/hci0/dev_11_16_BD_36_58_3F/bis2/fd1
[11-AE-0A-C1-F4-30]# Successfully linked transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
[] Enter brocast code[value/no]: Borne House
[11-AE-0A-C1-F4-30]# Setting broadcast code succeeded
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     State: broadcasting
[11-AE-0A-C1-F4-30]# Select successful
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
                     State: broadcasting
[11-AE-0A-C1-F4-30]# Select successful
[11-AE-0A-C1-F4-30]# transport.acquire
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
auto acquiring...
Transport /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2 acquiring
auto acquiring...
Transport /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3 acquiring
[11-AE-0A-C1-F4-30]# Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     acquiring complete
[11-AE-0A-C1-F4-30]# Acquire successful: fd 11 MTU 40:0
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis1/fd2
                     State: active
[11-AE-0A-C1-F4-30]# Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
                     acquiring complete
[11-AE-0A-C1-F4-30]# Acquire successful: fd 7 MTU 40:0
[11-AE-0A-C1-F4-30]# [CHG] Transport
                     /org/bluez/hci0/dev_11_AE_0A_C1_F4_30/bis2/fd3
                     State: active

The BIG Create Sync command is sent with the correct Broadcast Code,
for the 2 acquired BISes:

< HCI Command: LE Broadcast Isochronous Group Create Sync (0x08|0x006b)
        BIG Handle: 0x00
        BIG Sync Handle: 0x0000
        Encryption: Encrypted (0x01)
        Broadcast Code[16]: 426f726e6520486f7573650000000000
        Maximum Number Subevents: 0x00
        Timeout: 20000 ms (0x07d0)
        Number of BIS: 2
        BIS ID: 0x01
        BIS ID: 0x02
> HCI Event: Command Status (0x0f)
      LE Broadcast Isochronous Group Create Sync (0x08|0x006b) ncmd 1
        Status: Success (0x00)


  Commit: 79900d49ac68eb8deeaf6108a97abf26f00daacd
      https://github.com/bluez/bluez/commit/79900d49ac68eb8deeaf6108a97abf26f00daacd
  Author: Blaise Duszynski <blaised@gmail.com>
  Date:   2025-01-07 (Tue, 07 Jan 2025)

  Changed paths:
    M src/plugin.c

  Log Message:
  -----------
  plugin: Order plugin init by priority

The init order matters for some plugins, e.g. wiimote
Add them to a sorted list before calling add_plugin

Fixes: https://github.com/bluez/bluez/issues/911


Compare: https://github.com/bluez/bluez/compare/dfb1ffdc95a0...79900d49ac68

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
