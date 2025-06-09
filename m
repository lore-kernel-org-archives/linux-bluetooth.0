Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B703225A63D
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 13:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749476766; cv=none; b=uLVdGNTL5pG4xyHi8v690TVc/NWU2F4DmncEwuIgkyxx7B6Xh9QsnEGd5dKTVvMGimvwNxB1ucg0JK7bVfxUGOgYQ3laRpQKiUb0UGCX9NHPBizXmWziwLbyjcZgpTCWDz+LPXn4inkodK1HOGezI+ZJO8xIV2hipin4FGCBhOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749476766; c=relaxed/simple;
	bh=wHDOEtWyRkIlCnR4Koo6LFS5OX/FU44tnK9biuEDKxE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KQHp+scEmAJJVN5yJBBDSdHfNUtmkzKWm/dOjfGw1j35T5xfH6T77o7hGGMT28J1viWYmnxNXEkhq47IMg23kZKlqqIC8OCduTenHEuffKqDOrOYsOnzRd9BdgicSQ/99JiLZwPwDasA/U2Z1bKdNmxTfCAMYriXTGVvVa/vUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UgMxI63N; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UgMxI63N"
Received: from github.com (hubbernetes-node-9f6e463.ash1-iad.github.net [10.56.185.35])
	by smtp.github.com (Postfix) with ESMTPA id DC25E6006B4
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jun 2025 06:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749476763;
	bh=L6WrYd2mmDKXDGP+dCYuy8olk1d4FGh7fPVIyNN3LQ0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UgMxI63N2lFOthg4q1TNrkM3ltUjs0fguIFeZtWkQfCEXdWgeSIXOGfYdFBvdTwlq
	 kG2D5boUUuJbF0IyvJsDMT1BHE6WZVkeRMiknBlKdwFMFI2WfxfTQJpvSzIMzOlpQN
	 0f5sdiM09Y16Frbb9hX2XLBkv39Qlvzi70OlJUjc=
Date: Mon, 09 Jun 2025 06:46:03 -0700
From: mkasenberg <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/bbd10b-b39c37@github.com>
Subject: [bluez/bluez] 457343: shared/bap: check lpac type in
 bap_bcast_stream_new()
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
  Commit: 45734349087e909aa5cfb7149da2dd6c1d739bb9
      https://github.com/bluez/bluez/commit/45734349087e909aa5cfb7149da2dd6c1d739bb9
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: check lpac type in bap_bcast_stream_new()

bap_bcast_stream_new() shall refuse to create streams if lpac is not of
broadcast type.


  Commit: b39c37d2179ff63f4d2ced3de7065a4c6616faf5
      https://github.com/bluez/bluez/commit/b39c37d2179ff63f4d2ced3de7065a4c6616faf5
  Author: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
  Date:   2025-06-09 (Mon, 09 Jun 2025)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add support for decoding Channel Sounding

Add initial support for decoding commands and events of Channel
Sounding, a new feature introduced in Bluetooth Core Specification
Version 6.0 | Vol 1, Part A, Section 9 "Channel Sounding Using
Bluetooth Low Energy".

Testing:

To test the feature you need a hardware that supports Channel Sounding.
Channel Sounding can be tested using Nordic Semiconductor's sample
applications for the Initiator and Reflector roles, which are available
as part of the nRF Connect SDK and require an nRF54L15 development kit.
See tutorials:
https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/samples/bluetooth/channel_sounding_ras_initiator/README.html
https://docs.nordicsemi.com/bundle/ncs-latest/page/nrf/samples/bluetooth/channel_sounding_ras_reflector/README.html

Example output from btmon:
> HCI Event: LE Meta Event (0x3e) plen 250                        #102 7.954000
      LE CS Subevent Result (0x31)
        Connection handle: 0
        Config ID: 0
        Start ACL Conn Event Counter: 53
        Procedure Counter: 0
        Frequency Compensation: 49152
        Reference Power Level: 237
        Procedure Done Status: Partial results with more to follow for the CS procedure (0x01)
        Subevent Done Status: Partial results with more to follow for the CS subevent (0x01)
        Abort reason: 0x00
          Procedure: Report with no abort (0x00)
          Subevent: Report with no abort (0x00)
        Num Antenna Paths: 1
        Num Steps Reported: 22
        Steps data: [234]: 00e801024709000702f4000aa2f420022e0900d05df900d0edf820021009007251e400e27f001201100600ffe8f8ff01022d0900c5fd0200c7fd0220023c090029b11d0015911e2002030900bc002200e8effe1201030600ffe7f6ff01022b0900646f220041bf2120022c0900a75f23000820fe1202210900d93ee1001d80001202230900e00ee10000dfdf2001230600ffe71c0001023d090029d2fa00e24f0012021f0900c04d0100c18d022002050900674023005780232001050600ffe80f0001020e090077b0dc005c60dc20022209001f3eec00fcff01120000000000000f0003000005082800
        Step 0
          Mode: 0
          Channel: 3
          Step data len: 3
          Raw step data: [3]: 00e801
          Packet Quality: 0x00
            CS Access Address check is successful, and all bits match the expected sequence
            Bit errors: 0
          Packet RSSI: -24
          Packet Antenna: 1
...
        Step 3
          Mode: 2
          Channel: 71
          Step data len: 9
          Raw step data: [9]: 000702f4000aa2f420
          Antenna Permutation Index: 0
          Path 0
            PCT: 0xf40207
              I: 0x207
              Q: 0xf40
            Tone quality indicator: 0x00
              Tone quality is high (0x00)
              Not tone extension slot (0x00)
          Path 1
            PCT: 0xf4a20a
              I: 0x20a
              Q: 0xf4a
            Tone quality indicator: 0x20
              Tone quality is high (0x00)
              Tone extension slot; tone expected to be present (0x02)
...
        Step 6
          Mode: 1
          Channel: 16
          Step data len: 6
          Raw step data: [6]: 00ffe8f8ff01
          Packet Quality: 0x00
            CS Access Address check is successful, and all bits match the expected sequence
            Bit errors: 0
          Packet NADM: Unknown NADM (0xff)
          Packet RSSI: -24
          ToA_ToD: 0xfffffff8
          Packet Antenna: 1


Compare: https://github.com/bluez/bluez/compare/bbd10bb9bc5e...b39c37d2179f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
