Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2286A56380
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Dec 2023 21:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="K0Wibevy"
Received: from github.com (hubbernetes-node-de26f92.ac4-iad.github.net [10.52.142.37])
	by smtp.github.com (Postfix) with ESMTPA id 44A361E033D
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Dec 2023 13:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1702674746;
	bh=vWOe8837Hp/BhSnZY3YhTjMfMx+3HDVhOQqjNGs8/WM=;
	h=Date:From:To:Subject:From;
	b=K0WibevyEdFd9VmtTlkTTxm1Qdjx72d95+X+RMN29Uqd7gBdSrHjgiPWmHm9ygOqL
	 NnnmQ2RtmkW9CxUOTpJ/CCrRZKeDbKGLiqQJ/MX/Uvct0vmTStdhBY/qkindg5P2v+
	 xgyl76NPSG9Wh5BwsKNnIHKYHmzsB3Qsr2mGb/FM=
Date: Fri, 15 Dec 2023 13:12:26 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/04ecf6-e01208@github.com>
Subject: [bluez/bluez] 511d58: bap: Allow setup of multiple stream per
 endpoint
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
  Commit: 511d58b06c63c54bccab19b674b473356e755a1e
      https://github.com/bluez/bluez/commit/511d58b06c63c54bccab19b674b473356e755a1e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-15 (Fri, 15 Dec 2023)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Allow setup of multiple stream per endpoint

Remote endpoints actually represents PAC records of the same codec and
their capabilities are merged together thus is should be possible to
create multiple streams depending on the AC configuration.


  Commit: e7e8b2a3d7ca3d8a3a4940b6e14646b2ad3a98bf
      https://github.com/bluez/bluez/commit/e7e8b2a3d7ca3d8a3a4940b6e14646b2ad3a98bf
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-15 (Fri, 15 Dec 2023)

  Changed paths:
    M profiles/audio/bap.c
    M src/shared/bap.c
    M src/shared/bap.h
    M src/shared/util.c
    M src/shared/util.h

  Log Message:
  -----------
  shared/bap: Make bt_bap_select match the channel map

bt_bap_pac may actually map to multiple PAC records and each may have a
different channel count that needs to be matched separately, for
instance when trying with EarFun Air Pro:

< ACL Data TX: Handle 2048 flags 0x00 dlen 85
      ATT: Write Command (0x52) len 80
        Handle: 0x0098 Type: ASE Control Point (0x2bc6)
          Data: 010405020206000000000a020103020201030428000602020600000
	  0000a0201030202010304280001020206000000000a020103020201030428
	  0002020206000000000a02010302020103042800
            Opcode: Codec Configuration (0x01)
            Number of ASE(s): 4
            ASE: #0
            ASE ID: 0x05
            Target Latency: Balance Latency/Reliability (0x02)
            PHY: 0x02
            LE 2M PHY (0x02)
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
              Sampling Frequency: 16 Khz (0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
              Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
              Frame Length: 40 (0x0028)
            ASE: #1
            ASE ID: 0x06
            Target Latency: Balance Latency/Reliability (0x02)
            PHY: 0x02
            LE 2M PHY (0x02)
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
              Sampling Frequency: 16 Khz (0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
              Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
              Frame Length: 40 (0x0028)
            ASE: #2
            ASE ID: 0x01
            Target Latency: Balance Latency/Reliability (0x02)
            PHY: 0x02
            LE 2M PHY (0x02)
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
              Sampling Frequency: 16 Khz (0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
              Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
              Frame Length: 40 (0x0028)
            ASE: #3
            ASE ID: 0x02
            Target Latency: Balance Latency/Reliability (0x02)
            PHY: 0x02
            LE 2M PHY (0x02)
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
              Sampling Frequency: 16 Khz (0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
              Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
              Frame Length: 40 (0x0028)

Fixes: https://github.com/bluez/bluez/issues/612


  Commit: 07efa6d35b261d7d0bde1ef6d19c841afa620946
      https://github.com/bluez/bluez/commit/07efa6d35b261d7d0bde1ef6d19c841afa620946
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-15 (Fri, 15 Dec 2023)

  Changed paths:
    M doc/org.bluez.MediaEndpoint.rst

  Log Message:
  -----------
  org.bluez.MediaEndpoint: Add ChannelAllocation to SelectProperties

This adds ChannelAllocation to SelectProperties which when set can be
used by Endpoint implementation in the response as part of
Capabilities, note that it is not mandatory to use it so the Endpoint
may have its on logic to allocate channels.


  Commit: 4bed5da57861f831a40452f1035fa6a3c8012ba8
      https://github.com/bluez/bluez/commit/4bed5da57861f831a40452f1035fa6a3c8012ba8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-15 (Fri, 15 Dec 2023)

  Changed paths:
    M profiles/audio/media.c
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Make bt_bap_select select a location

This makes bt_bap_select select a location based on the PAC channel
count and PACS locations, this is then passed to the Endpoint as a
recommended ChannelAllocation.


  Commit: 4b5b4f0767c69718292fc826ec87e1fcbb232f84
      https://github.com/bluez/bluez/commit/4b5b4f0767c69718292fc826ec87e1fcbb232f84
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-15 (Fri, 15 Dec 2023)

  Changed paths:
    M profiles/audio/media.c
    M profiles/audio/transport.c
    M src/shared/bap.c
    M src/shared/bap.h

  Log Message:
  -----------
  shared/bap: Fix stream IO linking

IO linking shall only be possible once, for the oposite direction as ISO
channels are bidirection, and not many times as that means multiplexing
would be used which is done within the transport payload, so this get rid
of queue links list and just use single link point instead.


  Commit: e01208dac67f5204794ad8a93470b20536949320
      https://github.com/bluez/bluez/commit/e01208dac67f5204794ad8a93470b20536949320
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-15 (Fri, 15 Dec 2023)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Use ChannelAllocation given on SelectProperties

This makes use of ChannelAllocation when present on SelectProperties
dictionary which is then passed on to bluetoothd and send over as part
of Codec Configuration:

< ACL Data TX: Handle 2048 flags 0x00 dlen 109
      ATT: Write Command (0x52) len 104
        Handle: 0x0098 Type: ASE Control Point (0x2bc6)
          Data: 0104050202060000000010020103020201030428000503010000000
	  6020206000000001002010302020103042800050302000000010202060000
	  0000100201030202010304280005030100000002020206000000001002010
	  302020103042800050302000000
            Opcode: Codec Configuration (0x01)
            Number of ASE(s): 4
            ASE: #0
            ASE ID: 0x05
            Target Latency: Balance Latency/Reliability (0x02)
            PHY: 0x02
            LE 2M PHY (0x02)
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
              Sampling Frequency: 16 Khz (0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
              Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
              Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
           Location: 0x00000001
              Front Left (0x00000001)
            ASE: #1
            ASE ID: 0x06
            Target Latency: Balance Latency/Reliability (0x02)
            PHY: 0x02
            LE 2M PHY (0x02)
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
              Sampling Frequency: 16 Khz (0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
              Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
              Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
           Location: 0x00000002
              Front Right (0x00000002)
            ASE: #2
            ASE ID: 0x01
            Target Latency: Balance Latency/Reliability (0x02)
            PHY: 0x02
            LE 2M PHY (0x02)
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
              Sampling Frequency: 16 Khz (0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
              Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
              Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
           Location: 0x00000001
              Front Left (0x00000001)
            ASE: #3
            ASE ID: 0x02
            Target Latency: Balance Latency/Reliability (0x02)
            PHY: 0x02
            LE 2M PHY (0x02)
            Codec: LC3 (0x06)
            Codec Specific Configuration: #0: len 0x02 type 0x01
              Sampling Frequency: 16 Khz (0x03)
            Codec Specific Configuration: #1: len 0x02 type 0x02
              Frame Duration: 10 ms (0x01)
            Codec Specific Configuration: #2: len 0x03 type 0x04
              Frame Length: 40 (0x0028)
            Codec Specific Configuration: #3: len 0x05 type 0x03
           Location: 0x00000002
              Front Right (0x00000002)


Compare: https://github.com/bluez/bluez/compare/04ecf635ffaa...e01208dac67f
