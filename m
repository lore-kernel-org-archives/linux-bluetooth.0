Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B2515E7FA
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 21:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712091898; cv=none; b=CHluyaUgBiRYSnu+FUuGxarq+2ogM90tL223Jf9P0OJKQwFwkotsNXhrbLt2aors8VVIlpDPJoWue/QgzT4sCPL/QRe4CSjyqo97JQsdbNKCbORUGlZFdryctuUVNj1aXdC33TtCwCGGaHOvMocmkBK0o/1N92WHpED/90dH4KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712091898; c=relaxed/simple;
	bh=VPk/hPp14izc+dcHXpmfNdnoa8NZBpOgWOd4uMzbV6U=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bTNimwDpol+wIKhLTy0BwiDdkmCqSXYWaW5AwPmh0b0Wu/LOau4aIYKeSKKSvbzEqrZeyvwf4CT9lJXcBlK4d3no3y4N3lRhqBl3en51Q/G1Nsc49+ZT7szbBtvR25T5QMgU/s+8KuVLMxP/EU9LVz8g6wGqHMCOIaJxp8DWtPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jllXV9FE; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jllXV9FE"
Received: from github.com (hubbernetes-node-79efdbb.ac4-iad.github.net [10.52.144.34])
	by smtp.github.com (Postfix) with ESMTPA id 71C8D5E0384
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 14:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1712091896;
	bh=GGXcihkz9hUQMHsXt92VTSwyslvkjDo2wwgMN9mnj4k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jllXV9FEqD8Nht0KwT6xfbDqGQmGjFTHix+LcZZB7Tv17p3cJUhA2eN7+BU/nhmxU
	 BJTZ+lDxGdKwCw+2F+znQIqssIb12uD5m3ecFGanTqlt/niqD7j3U1dxKOjAl5sK88
	 N0vdxorMJ+fU2QDbZLj0DlgTz7YH4Glj3ouP91BY=
Date: Tue, 02 Apr 2024 14:04:56 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4520ec-b8b408@github.com>
Subject: [bluez/bluez] 0d3822: bap: Fix endpoint unregister for BAP broadcast
 source
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
  Commit: 0d38224bf566cb48e412a06a48b370ad1897f0a9
      https://github.com/bluez/bluez/commit/0d38224bf566cb48e412a06a48b370ad1897f0a9
  Author: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
  Date:   2024-04-02 (Tue, 02 Apr 2024)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix endpoint unregister for BAP broadcast source

Fix endpoint not being removed when endpoint unregister
 is called for BAP broadcast source


  Commit: 32a3591b706af613552b425fecc58ee2463ae724
      https://github.com/bluez/bluez/commit/32a3591b706af613552b425fecc58ee2463ae724
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-04-02 (Tue, 02 Apr 2024)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h
    M src/shared/ad.h

  Log Message:
  -----------
  bthost: Add support for Set PA data

This adds bthost_set_pa_data.


  Commit: 8c8ac6f13c1a8c94bfcc6111822bf2cc0019ac04
      https://github.com/bluez/bluez/commit/8c8ac6f13c1a8c94bfcc6111822bf2cc0019ac04
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-02 (Tue, 02 Apr 2024)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  bthost: Add bthost_set_base

This adds bthost_set_base which takes create of creating the PA data
using bt_ad to add BAA service data and then generating the PA data
which is then passed to bthost_set_pa_data.


  Commit: 9684bba494dfc78a0aa267f1989c3469a3d5d960
      https://github.com/bluez/bluez/commit/9684bba494dfc78a0aa267f1989c3469a3d5d960
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-04-02 (Tue, 02 Apr 2024)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add test for Broadcast Receiver Get BASE

This adds a new Broadcast Receiver test, to validate that a Broadcast
Sink is able to sync to the PA transmitted by a Source (when no BIG
is active) and is able to successfully detect the BASE:

ISO Broadcaster Receiver Defer Get BASE - Success


  Commit: f74f6a5cfd50c7a14a4bce6a7bed937e3dd4559a
      https://github.com/bluez/bluez/commit/f74f6a5cfd50c7a14a4bce6a7bed937e3dd4559a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-02 (Tue, 02 Apr 2024)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix framenting PA reports

PA reports can carry up to 247 bytes of data instead of just 31 bytes:

> HCI Event: LE Meta Event (0x3e) plen 46
      LE Periodic Advertising Report (0x0f)
        Sync handle: 1
        TX power: 127 dbm (0x7f)
        RSSI: not available (0x7f)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x26
        25 16 51 18 28 00 00 01 01 06 00 00 00 00 11 02  %.Q.(...........
        01 03 02 02 01 05 03 01 00 00 00 03 04 28 00 04  .............(..
        03 02 02 00 01 00


  Commit: 33af0ce949310a740154b7e20966d27990e73a3b
      https://github.com/bluez/bluez/commit/33af0ce949310a740154b7e20966d27990e73a3b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-02 (Tue, 02 Apr 2024)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Fix Codec Configuration length

The length is actually 16 (0x10) bytes not 17 (0x17).


  Commit: b8b4083c179e93e1a0ee1c3f784313a3f60ad6fe
      https://github.com/bluez/bluez/commit/b8b4083c179e93e1a0ee1c3f784313a3f60ad6fe
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-02 (Tue, 02 Apr 2024)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Decode PA data

This attempts to decode the PA data content:

Before:

> HCI Event: LE Meta Event (0x3e) plen 46
      LE Periodic Advertising Report (0x0f)
        Sync handle: 1
        TX power: 127 dbm (0x7f)
        RSSI: not available (0x7f)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x26
        25 16 51 18 28 00 00 01 01 06 00 00 00 00 11 02  %.Q.(...........
        01 03 02 02 01 05 03 01 00 00 00 03 04 28 00 04  .............(..
        03 02 02 00 01 00

After:

> HCI Event: LE Meta Event (0x3e) plen 46
      LE Periodic Advertising Report (0x0f)
        Sync handle: 1
        TX power: 127 dbm (0x7f)
        RSSI: not available (0x7f)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x26
        Service Data: Basic Audio Announcement (0x1851)
          Presetation Delay: 40
          Number of Subgroups: 1
            Subgroup #0:
            Number of BIS(s): 1
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
            Codec Specific Configuration: Sampling Frequency: 16 Khz (0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
            Codec Specific Configuration: Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x05 type 0x03
            Codec Specific Configuration: Location: 0x00000001
            Codec Specific Configuration: Location: Front Left (0x00000001)
            Codec Specific Configuration: #3: len 0x03 type 0x04
            Codec Specific Configuration: Frame Length: 40 (0x0028)
            Metadata: #0: len 0x03 type 0x02
            Metadata: Context: 0x0002
            Metadata: Context	Conversational (0x0002)
              BIS #0:
              Index: 1


Compare: https://github.com/bluez/bluez/compare/4520eca3e5d8...b8b4083c179e

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
