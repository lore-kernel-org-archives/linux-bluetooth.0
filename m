Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="itPmQsLE"
Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845D9CA
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 09:38:08 -0800 (PST)
Received: from github.com (hubbernetes-node-3ae383d.va3-iad.github.net [10.48.221.32])
	by smtp.github.com (Postfix) with ESMTPA id BE5E3E0B30
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Nov 2023 09:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1701193087;
	bh=RjzcdpPoBIUG8Jbi8N0Bkca8BRUWfnn5erGszZtP1rw=;
	h=Date:From:To:Subject:From;
	b=itPmQsLEMb99IBvAyvjTfiSfab/qlUhLnFEB9UXT8wHLbcfLcgKnaz1Yd3r4E1RpW
	 zRiiEWyiDxQG7Hbgz5cFKsgvP90k0S4tyXIprKvI1CJZlBeEpJxu+s8LdhlJu1VFJs
	 cV0KP/FdcPN1Oqjnypm+RfseoTT+UIlQuIAb1tNs=
Date: Tue, 28 Nov 2023 09:38:07 -0800
From: Claudia Draghicescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8b4484-bd5342@github.com>
Subject: [bluez/bluez] 2ba614: iso-tester: Add tests for GMAP broadcast QoS
 presets
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
  Commit: 2ba6148139718a6eb38f14290d04a960c170b8a3
      https://github.com/bluez/bluez/commit/2ba6148139718a6eb38f14290d04a960c170b8a3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-11-28 (Tue, 28 Nov 2023)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Add tests for GMAP broadcast QoS presets

This adds the following tests:

ISO QoS 48_1_g - Success
ISO QoS 48_2_g - Success
ISO QoS 48_3_g - Success
ISO QoS 48_4_g - Success


  Commit: acaf8f866d2906cfb229aa4d8cab599ac8cb7316
      https://github.com/bluez/bluez/commit/acaf8f866d2906cfb229aa4d8cab599ac8cb7316
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-11-28 (Tue, 28 Nov 2023)

  Changed paths:
    M src/shared/bap-debug.c
    M src/shared/util.c
    M src/shared/util.h

  Log Message:
  -----------
  util: Make debugger arg of util_debug_ltv const

This makes the debugger argument of util_debug_ltv const as they are not
suppose to change during its call.


  Commit: c9a1f20808287ecb8db183a537b210e7a26116d9
      https://github.com/bluez/bluez/commit/c9a1f20808287ecb8db183a537b210e7a26116d9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-11-28 (Tue, 28 Nov 2023)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add proper decoding of TLV for BASE

This uses bt_bap_debug_{config, metadata} to decode the TLV entries
found in Basic Audio Announcement:

< HCI Command: LE Set Peri.. (0x08|0x003f) plen 41
        Handle: 1
        Operation: Complete ext advertising data (0x03)
        Data length: 0x26
        Service Data: Basic Audio Announcement (0x1851)
          Presetation Delay: 10000
          Number of Subgroups: 1
            Subgroup #0:
            Number of BIS(s): 1
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
            Codec Specific Configuration: Sampling Frequency: 48 Khz (0x08)
            Codec Specific Configuration: #1: len 0x02 type 0x02
            Codec Specific Configuration: Frame Duration: 7.5 ms (0x00)
            Codec Specific Configuration: #2: len 0x03 type 0x04
            Codec Specific Configuration: Frame Length: 75 (0x004b)
            Metadata: #0: len 0x03 type 0x02
            Metadata: Context: 0x0002
            Metadata: Context	Conversational (0x0002)
              BIS #0:
              Index: 1
              Codec Specific Configuration: #0: len 0x05 type 0x03
              Codec Specific Configuration: Location: 0x00000001
              Codec Specific Configuration: Location: Front Left (0x00000001)


  Commit: ee04d309651c0ca8828c5ae34ae36a707b534a70
      https://github.com/bluez/bluez/commit/ee04d309651c0ca8828c5ae34ae36a707b534a70
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-11-28 (Tue, 28 Nov 2023)

  Changed paths:
    M tools/isotest.c

  Log Message:
  -----------
  isotest: Fix high-reliability QoS presets

This changes the high-reliability QoS presets to be conformant to
BAP[1] specification:

  Table 5.2: QoS configuration support setting requirements for the
  Unicast Client and Unicast Server

[1] https://www.bluetooth.com/specifications/bap-1-0-1/

Fixes: https://github.com/bluez/bluez/issues/665


  Commit: b93690e72d9ea287a730fa271925979c225d6861
      https://github.com/bluez/bluez/commit/b93690e72d9ea287a730fa271925979c225d6861
  Author: Claudia Draghicescu <claudia.rosu@nxp.com>
  Date:   2023-11-28 (Tue, 28 Nov 2023)

  Changed paths:
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Fix source+sink endpoint registration

When registering both sink and source endpoints,
the register endpoint method call results in 2 remote endpoints for each
scanned broadcast source


  Commit: bd5342fdf46af482c851af754cca14c1b51ee2d3
      https://github.com/bluez/bluez/commit/bd5342fdf46af482c851af754cca14c1b51ee2d3
  Author: Claudia Draghicescu <claudia.rosu@nxp.com>
  Date:   2023-11-28 (Tue, 28 Nov 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  audio/bap: Fix source+sink endpoint registration

When registering both sink and source endpoints,
the register endpoint method call results in 2 remote endpoints for each
scanned broadcast source


Compare: https://github.com/bluez/bluez/compare/8b448400ece6...bd5342fdf46a
