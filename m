Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51BCBA49
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734387077; cv=none; b=DFfo+yTSSRAyrRzBNAz/gf1vf0YTw5lWx7msbakiHC4YB9jilXK3CuVbzIt2cD3F3V3/nVl3Hv5IytVtre5FiYpfI50bPEZ8qep3zGBsjta5oYn+MpcqwoAlQmGLkStdWSvxMGMfmpUyuG36x3VxCbOdGHSm5Nod3VDPs3jM/4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734387077; c=relaxed/simple;
	bh=lGawXV5apI8/5H2f4e9Cc4hfrU7WcjwykxmHHuuMcws=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=W7v6LM8kgzI/FIbk0bVsX+QK7m9+twM+ZDPu7t2LP9/5vJqYCG/NemGSYl9743Xj95ECfYCdBF7/s56uMpLTgJL3oKtY98Vw2ZDL3fqO15lmWKCVGnUSjXW5MtZGEyT36fecO18Zqr4LugovbUklmNQVMSY5lYqoUFILCjkK5Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AnloQ+dJ; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AnloQ+dJ"
Received: from github.com (hubbernetes-node-698ae7f.va3-iad.github.net [10.48.155.35])
	by smtp.github.com (Postfix) with ESMTPA id EAC23E0162
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Dec 2024 14:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1734387074;
	bh=cRGEAwmGXy9plWIhM/yobWZU/ACngEriBTDmnFjNF3k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AnloQ+dJa38u3ULjkxkEiEIhbAezmls1EhmmMVXbXzSrHpBBTSlR1Z/IqRO3VJr99
	 kx9h3Ayr4BNSBuZrwubP/VoMIyKpEZ7YyD/vqEqv4xaiPTS4/qtXSPxQZbgRTzikjS
	 jMXkRkOEqHKaA7DnSYhQIVpezYJlJF/u6v8RjUts=
Date: Mon, 16 Dec 2024 14:11:13 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/92f3a3-c2caa2@github.com>
Subject: [bluez/bluez] 9b631e: lib: Add constant for 16 bits transparent voice
 se...
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 9b631e09e943d6a3b248f0210e4f785a1cc48c25
      https://github.com/bluez/bluez/commit/9b631e09e943d6a3b248f0210e4f7=
85a1cc48c25
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-12-16 (Mon, 16 Dec 2024)

  Changed paths:
    M lib/bluetooth.h

  Log Message:
  -----------
  lib: Add constant for 16 bits transparent voice setting

Add 16 bits, 2s complement, transparent air coding format for mSBC.
Corresponding commit implements functionality on kernel side.

The voice setting is used by sco_connect() or sco_conn_defer_accept()
after being set by sco_sock_setsockopt().

The PCM part of the voice setting is used for offload mode through PCM
chipset port.
This commits add support for mSBC 16 bits offloading, i.e. audio data
not transported over HCI.

The BCM4349B1 supports 16 bits transparent data on its I2S port.
If BT_VOICE_TRANSPARENT is used when accepting a SCO connection, this
gives only garbage audio while using BT_VOICE_TRANSPARENT_16BIT gives
correct audio.
This has been tested with connection to iPhone 14 and Samsung S24.


  Commit: ff07f10ee4da3d16b3be84c0acff231d2b152948
      https://github.com/bluez/bluez/commit/ff07f10ee4da3d16b3be84c0acff2=
31d2b152948
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-12-16 (Mon, 16 Dec 2024)

  Changed paths:
    M tools/sco-tester.c

  Log Message:
  -----------
  sco-tester: Add test for BT_VOICE_TRANSPARENT_16BIT constant

This test checks that BT_VOICE_TRANSPARENT_16BIT voice settings can
be set and get using [set|get]sockopt().


  Commit: 3db67f12c69e8914d3e47ff727b6d992ff31ccca
      https://github.com/bluez/bluez/commit/3db67f12c69e8914d3e47ff727b6d=
992ff31ccca
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-12-16 (Mon, 16 Dec 2024)

  Changed paths:
    M lib/bluetooth.h
    M profiles/audio/bap.c

  Log Message:
  -----------
  lib: Add BT_ISO_SYNC_FACTOR

This defines the default sync factor value to be used by ISO Broadcasters=
.


  Commit: bd2f851be865e8c1718e6397f390dd000f8121fd
      https://github.com/bluez/bluez/commit/bd2f851be865e8c1718e6397f390d=
d000f8121fd
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-12-16 (Mon, 16 Dec 2024)

  Changed paths:
    M client/player.c
    M client/scripts/broadcast-source.bt

  Log Message:
  -----------
  client/player: Make QoS sync_factor configurable

This adds a new user input prompt when configuring a Broadcast Source
endpoint, to configure a QoS sync_factor value. This is useful for the
user to adjust how frequent PA announcements should be sent by the
Source, depending on scenario, instead of always using a hardcoded
value.

[bluetooth]# endpoint.config /org/bluez/hci0/pac_bcast0
                             /local/endpoint/ep0 16_2_1
[/local/endpoint/ep0] BIG (auto/value): 1
[/local/endpoint/ep0] Enter sync factor (value/auto): 2
[/local/endpoint/ep0] Enter channel location (value/no): 1
[/local/endpoint/ep0] Enter Metadata (value/no): no

The PA interval is chosen as the BIG SDU interval multiplied by
sync_factor:

< HCI Command: LE Set Periodic Advertising Parameters (0x08|0x003e)
        Handle: 1
        Min interval: 20.00 msec (0x0010)
        Max interval: 20.00 msec (0x0010)
        Properties: 0x0000
> HCI Event: Command Complete (0x0e)
      LE Set Periodic Advertising Parameters (0x08|0x003e)
        Status: Success (0x00)

< HCI Command: LE Create Broadcast Isochronous Group (0x08|0x0068)
        Handle: 0x01
        Advertising Handle: 0x01
        Number of BIS: 1
        SDU Interval: 10000 us (0x002710)
        Maximum SDU size: 40
        Maximum Latency: 10 ms (0x000a)
        RTN: 0x02
        PHY: LE 2M (0x02)
        Packing: Sequential (0x00)
        Framing: Unframed (0x00)
        Encryption: 0x00
        Broadcast Code[16]: 0102680553f1415aa265bbafc6ea03b8
> HCI Event: Command Status (0x0f)
      LE Create Broadcast Isochronous Group (0x08|0x0068)
        Status: Success (0x00)
> HCI Event: LE Meta Event (0x3e)
      LE Broadcast Isochronous Group Complete (0x1b)
        Status: Success (0x00)
        Handle: 0x01
        BIG Synchronization Delay: 912 us (0x000390)
        Transport Latency: 912 us (0x000390)
        PHY: LE 2M (0x02)
        NSE: 3
        BN: 1
        PTO: 0
        IRC: 3
        Maximum PDU: 40
        ISO Interval: 10.00 msec (0x0008)
        Connection Handle #0: 6

This also updates the broadcast-source.bt script, to include a new
input value for sync_factor.


  Commit: ead7f4028a1033d02e675e23c653f63218027349
      https://github.com/bluez/bluez/commit/ead7f4028a1033d02e675e23c653f=
63218027349
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-12-16 (Mon, 16 Dec 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Do not allow BIS QoS mismatch

For Broadcast Source streams, QoS parameters are used for configuring
the PA and BIG. All parameters provided to the LE Create BIG command
are the same for all BISes (Core v5.3, vol.4, part E, page 2573).
Likewise, since the PA train is associated with the BIG, it is unique
for all included BISes. Thus, a stream should not be configured if the
QoS parameters do not match the global BIG configuration.

This commit adds a QoS check before a new stream is configured, to make
sure that all streams share the same settings.


  Commit: c2caa26a4d621ad9fc2def9325d7ef8fad81ebdc
      https://github.com/bluez/bluez/commit/c2caa26a4d621ad9fc2def9325d7e=
f8fad81ebdc
  Author: Amisha Jain <quic_amisjain@quicinc.com>
  Date:   2024-12-16 (Mon, 16 Dec 2024)

  Changed paths:
    M tools/obexctl.c

  Log Message:
  -----------
  obexctl: Enable Map folderlisting operation from obexctl

This change is required for passing below PTS testcase -

1) MAP/MCE/MMB/BV-01-C
Verify that the MCE can retrieve a Folders Listing on the MSE.

As of now, user is able to initiate only map messagelisting
operation with command 'ls <folder_name>' and there is no way to initiate=

folder listing with 'ls' command as second argument <options> is
set as compulsary.
In the obexctl code, map folderlisting gets triggered only when there is =
no
arguments followed by 'ls' command.
Therefore in 'ls' command, make the second argument as optional.

This change will also enable pbap vcard listing operation which also
gets triggered with 'ls' command with no args.


Compare: https://github.com/bluez/bluez/compare/92f3a3b108c2...c2caa26a4d=
62

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
