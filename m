Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29E61D63FF
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744121724; cv=none; b=YuBK0JjE1HBDtQDXW1cHYx9egMN6G2j4HsltV5yDCu1ZXfStaQfKpo9VL2V59JlS80kfybvcg8D0N/5kuQahv81VAkwoj6TwSWjqimmR8LILhx7O96MaD/D/8LZxyCxKAavfUouHZe10ZaxdveL0We9YXnEqQcNiSmBUGlq/EJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744121724; c=relaxed/simple;
	bh=FbSGYyPDh1tB6DG3pnG64rya8IOmSgOAgHgCGTPPQ1k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=idr0XQhZIv2LzdQB0QadrFVYzKNsrcZoVAThBsPkVY9ElFrUjaRxgy58WMHCY/e8c2VI5FEyEC+hIEGie7lp/QrpUT3lq9RsZ+vTCGoDrPIgdNotKEp3Dh2CF74O5H14Hs2Ya4lbXLVpHK1eBvK8khOvbmqZPa8cNW+GpIzZsOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Sk6v+uXL; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Sk6v+uXL"
Received: from github.com (hubbernetes-node-4946d85.va3-iad.github.net [10.48.164.10])
	by smtp.github.com (Postfix) with ESMTPA id F34524E0928
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Apr 2025 07:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1744121721;
	bh=22/FeHaUEw+6Ul9n5viAnyNNnkuSKLplDzKpQx2okjA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Sk6v+uXLhM3x9ycMqWTPDU7AnHM0nCO9sjwAFdWnMgl1rnNRkDyHyoLKzpLI6fHZJ
	 ITrWXy0m+hrktfwgwF7YXTve1cWpps6F6fbnyxUqaXVDimoDQNdpAwYd9HlFQPA+XA
	 VWqY812cLAFTlnYl5qMrEyHRl2IUueD9xy2cbhuk=
Date: Tue, 08 Apr 2025 07:15:20 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0efa20-e36724@github.com>
Subject: [bluez/bluez] ad5f31: test-bap: Introduce DISC tests for LC3
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
  Commit: ad5f318cd71a90891742794475534d1417dfdf8b
      https://github.com/bluez/bluez/commit/ad5f318cd71a90891742794475534=
d1417dfdf8b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-03 (Thu, 03 Apr 2025)

  Changed paths:
    M src/shared/lc3.h
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Introduce DISC tests for LC3

4.7.2 Unicast Server =E2=80=93 Audio Capability Exposure (Page 32):

Test Purpose
Verify that a Unicast Server IUT can allow audio capability discovery
with an Audio Sink reading the values of the Sink PAC characteristic
and the Sink Audio Locations characteristic on the IUT, or with an
Audio Source reading the values of the Source PAC characteristic and
the Source Audio Locations characteristic on the IUT.

Test Summary
------------
BAP/USR/DISC/BV-01-C                                 Passed
BAP/USR/DISC/BV-02-C                                 Passed
BAP/USR/DISC/BV-06-C                                 Passed
BAP/USR/DISC/BV-07-C                                 Passed
BAP/USR/DISC/BV-03-C                                 Passed
BAP/USR/DISC/BV-04-C                                 Passed
BAP/USR/DISC/BV-05-C                                 Passed
Total: 7, Passed: 7 (100.0%), Failed: 0, Not Run: 0


  Commit: 9d6138923ad88aac4dfbc3259899395848b3ffb1
      https://github.com/bluez/bluez/commit/9d6138923ad88aac4dfbc32598993=
95848b3ffb1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-03 (Thu, 03 Apr 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Introduce USR/SCC tests for LC3

4.9.1 Unicast Server as Audio Sink Performs Config Codec =E2=80=93 LC3

Test Purpose:
Verify that a Unicast Server Audio Sink IUT can perform a Config
Codec operation initiated by a Unicast Client for an ASE in the Idle
state, the Codec Configured state.

Pass Veridict:
The IUT sends a Response_Code of 0x00 (Success) in response to each
Config Codec operation.

4.9.2 Unicast Server as Audio Source Performs Config Codec =E2=80=93 LC3

Test Purpose:
Verify that a Unicast Server Audio Source IUT can perform a Config
Codec operation initiated by a Unicast Client for an ASE in the Idle
state, the Codec Configured state.

Pass verdict:
The IUT sends a Response_Code of 0x00 (Success) in response to each
Config Codec operation.

Test Summary
------------
BAP/USR/SCC/BV-001-C [USR SNK Config Codec, LC3 8_1] Passed
BAP/USR/SCC/BV-002-C [USR SNK Config Codec, LC3 8_2] Passed
BAP/USR/SCC/BV-003-C [USR SNK Config Codec, LC3 16_1] Passed
BAP/USR/SCC/BV-004-C [USR SNK Config Codec, LC3 16_2] Passed
BAP/USR/SCC/BV-005-C [USR SNK Config Codec, LC3 24_1] Passed
BAP/USR/SCC/BV-006-C [USR SNK Config Codec, LC3 24_2] Passed
BAP/USR/SCC/BV-007-C [USR SNK Config Codec, LC3 32_1] Passed
BAP/USR/SCC/BV-008-C [USR SNK Config Codec, LC3 32_2] Passed
BAP/USR/SCC/BV-009-C [USR SNK Config Codec, LC3 44.1_1] Passed
BAP/USR/SCC/BV-010-C [USR SNK Config Codec, LC3 44.1_2] Passed
BAP/USR/SCC/BV-011-C [USR SNK Config Codec, LC3 48_1] Passed
BAP/USR/SCC/BV-012-C [USR SNK Config Codec, LC3 48_2] Passed
BAP/USR/SCC/BV-013-C [USR SNK Config Codec, LC3 48_3] Passed
BAP/USR/SCC/BV-014-C [USR SNK Config Codec, LC3 48_4] Passed
BAP/USR/SCC/BV-015-C [USR SNK Config Codec, LC3 48_5] Passed
BAP/USR/SCC/BV-016-C [USR SNK Config Codec, LC3 48_6] Passed
BAP/USR/SCC/BV-017-C [USR SRC Config Codec, LC3 8_1] Passed
BAP/USR/SCC/BV-018-C [USR SRC Config Codec, LC3 8_2] Passed
BAP/USR/SCC/BV-019-C [USR SRC Config Codec, LC3 16_1] Passed
BAP/USR/SCC/BV-020-C [USR SRC Config Codec, LC3 16_2] Passed
BAP/USR/SCC/BV-021-C [USR SRC Config Codec, LC3 24_1] Passed
BAP/USR/SCC/BV-022-C [USR SRC Config Codec, LC3 24_2] Passed
BAP/USR/SCC/BV-023-C [USR SRC Config Codec, LC3 32_1] Passed
BAP/USR/SCC/BV-024-C [USR SRC Config Codec, LC3 32_2] Passed
BAP/USR/SCC/BV-025-C [USR SRC Config Codec, LC3 44.1_1] Passed
BAP/USR/SCC/BV-026-C [USR SRC Config Codec, LC3 44.1_2] Passed
BAP/USR/SCC/BV-027-C [USR SRC Config Codec, LC3 48_1] Passed
BAP/USR/SCC/BV-028-C [USR SRC Config Codec, LC3 48_2] Passed
BAP/USR/SCC/BV-029-C [USR SRC Config Codec, LC3 48_3] Passed
BAP/USR/SCC/BV-030-C [USR SRC Config Codec, LC3 48_4] Passed
BAP/USR/SCC/BV-031-C [USR SRC Config Codec, LC3 48_5] Passed
BAP/USR/SCC/BV-032-C [USR SRC Config Codec, LC3 48_6] Passed
Total: 32, Passed: 32 (100.0%), Failed: 0, Not Run: 0


  Commit: 7a3be1992b271609a7aa1efca9a2b05a6976803b
      https://github.com/bluez/bluez/commit/7a3be1992b271609a7aa1efca9a2b=
05a6976803b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-03 (Thu, 03 Apr 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Introduce USR/SCC - VS tests for LC3

BAP/USR/SCC/BV-033-C [USR SNK Config Codec, VS]

Test Purpose:
Verify that a Unicast Server Audio Sink IUT can perform a Config
Codec operation initiated by a Unicast Client for a vendor-specific
codec for an ASE in the Idle state, the Codec Configured state, and
the QoS Configured state.

Pass verdict:
The IUT sends a notification of the ASE Control Point characteristic
with the Response_Code field set to 0x00 (Success) for the requested
ASE_ID and opcode.

Test Summary
------------
BAP/USR/SCC/BV-033-C [USR SNK Config Codec, VS]      Passed
BAP/USR/SCC/BV-034-C [USR SRC Config Codec, VS]      Passed
Total: 2, Passed: 2 (100.0%), Failed: 0, Not Run: 0


  Commit: 8890cd714fc0c4eceb62fffd188bbfeacdb1494e
      https://github.com/bluez/bluez/commit/8890cd714fc0c4eceb62fffd188bb=
feacdb1494e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-04 (Fri, 04 Apr 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Introduce USR/SCC QoS tests for LC3

Unicast Server Performs Config QoS =E2=80=93 LC3

Test Purpose:
Verify that a Unicast Server IUT can perform a Config QoS operation
initiated by a Unicast Client for the LC3 codec.

Pass verdict:
In step 2, the IUT sends a notification of the ASE Control Point
characteristic with Response_Code set to Success (0x00) for the requested=

ASE_ID and opcode.
In step 3, the notified ASE characteristic value is correctly formatted, =
has
the ASE_ID field set to Test_ASE_ID, the ASE_State field set to 0x02
(QoS Configured), and the Additional_ASE_Parameters field containing the
CIG_ID, CIS_ID, and QoS configuration values requested in step 2.

Test Summary
------------
BAP/USR/SCC/BV-069-C [USR SNK Config QoS, LC3 8_1_1] Passed
BAP/USR/SCC/BV-070-C [USR SNK Config QoS, LC3 8_2_1] Passed
BAP/USR/SCC/BV-071-C [USR SNK Config QoS, LC3 16_1_1] Passed
BAP/USR/SCC/BV-072-C [USR SNK Config QoS, LC3 16_2_1] Passed
BAP/USR/SCC/BV-073-C [USR SNK Config QoS, LC3 24_1_1] Passed
BAP/USR/SCC/BV-074-C [USR SNK Config QoS, LC3 24_2_1] Passed
BAP/USR/SCC/BV-075-C [USR SNK Config QoS, LC3 32_1_1] Passed
BAP/USR/SCC/BV-076-C [USR SNK Config QoS, LC3 32_2_1] Passed
BAP/USR/SCC/BV-077-C [USR SNK Config QoS, LC3 44.1_1_1] Passed
BAP/USR/SCC/BV-078-C [USR SNK Config QoS, LC3 44.1_2_1] Passed
BAP/USR/SCC/BV-079-C [USR SNK Config QoS, LC3 48_1_1] Passed
BAP/USR/SCC/BV-080-C [USR SNK Config QoS, LC3 48_2_1] Passed
BAP/USR/SCC/BV-081-C [USR SNK Config QoS, LC3 48_3_1] Passed
BAP/USR/SCC/BV-082-C [USR SNK Config QoS, LC3 48_4_1] Passed
BAP/USR/SCC/BV-083-C [USR SNK Config QoS, LC3 48_5_1] Passed
BAP/USR/SCC/BV-084-C [USR SNK Config QoS, LC3 48_6_1] Passed
BAP/USR/SCC/BV-085-C [USR SRC Config QoS, LC3 8_1_1] Passed
BAP/USR/SCC/BV-086-C [USR SRC Config QoS, LC3 8_2_1] Passed
BAP/USR/SCC/BV-087-C [USR SRC Config QoS, LC3 16_1_1] Passed
BAP/USR/SCC/BV-088-C [USR SRC Config QoS, LC3 16_2_1] Passed
BAP/USR/SCC/BV-089-C [USR SRC Config QoS, LC3 24_1_1] Passed
BAP/USR/SCC/BV-090-C [USR SRC Config QoS, LC3 24_2_1] Passed
BAP/USR/SCC/BV-091-C [USR SRC Config QoS, LC3 32_1_1] Passed
BAP/USR/SCC/BV-092-C [USR SRC Config QoS, LC3 32_2_1] Passed
BAP/USR/SCC/BV-093-C [USR SRC Config QoS, LC3 44.1_1_1] Passed
BAP/USR/SCC/BV-094-C [USR SRC Config QoS, LC3 44.1_2_1] Passed
BAP/USR/SCC/BV-095-C [USR SRC Config QoS, LC3 48_1_1] Passed
BAP/USR/SCC/BV-096-C [USR SRC Config QoS, LC3 48_2_1] Passed
BAP/USR/SCC/BV-097-C [USR SRC Config QoS, LC3 48_3_1] Passed
BAP/USR/SCC/BV-098-C [USR SRC Config QoS, LC3 48_4_1] Passed
BAP/USR/SCC/BV-099-C [USR SRC Config QoS, LC3 48_5_1] Passed
BAP/USR/SCC/BV-100-C [USR SRC Config QoS, LC3 48_6_1] Passed
BAP/USR/SCC/BV-101-C [USR SNK Config QoS, LC3 8_1_2] Passed
BAP/USR/SCC/BV-102-C [USR SNK Config QoS, LC3 8_2_2] Passed
BAP/USR/SCC/BV-103-C [USR SNK Config QoS, LC3 16_1_2] Passed
BAP/USR/SCC/BV-104-C [USR SNK Config QoS, LC3 16_2_2] Passed
BAP/USR/SCC/BV-105-C [USR SNK Config QoS, LC3 24_1_2] Passed
BAP/USR/SCC/BV-106-C [USR SNK Config QoS, LC3 24_2_2] Passed
BAP/USR/SCC/BV-107-C [USR SNK Config QoS, LC3 32_1_2] Passed
BAP/USR/SCC/BV-108-C [USR SNK Config QoS, LC3 32_2_2] Passed
BAP/USR/SCC/BV-109-C [USR SNK Config QoS, LC3 44.1_1_2] Passed
BAP/USR/SCC/BV-110-C [USR SNK Config QoS, LC3 44.1_2_2] Passed
BAP/USR/SCC/BV-111-C [USR SNK Config QoS, LC3 48_1_2] Passed
BAP/USR/SCC/BV-112-C [USR SNK Config QoS, LC3 48_2_2] Passed
BAP/USR/SCC/BV-113-C [USR SNK Config QoS, LC3 48_3_2] Passed
BAP/USR/SCC/BV-114-C [USR SNK Config QoS, LC3 48_4_2] Passed
BAP/USR/SCC/BV-115-C [USR SNK Config QoS, LC3 48_5_2] Passed
BAP/USR/SCC/BV-116-C [USR SNK Config QoS, LC3 48_6_2] Passed
BAP/USR/SCC/BV-117-C [USR SRC Config QoS, LC3 8_1_2] Passed
BAP/USR/SCC/BV-118-C [USR SRC Config QoS, LC3 8_2_2] Passed
BAP/USR/SCC/BV-119-C [USR SRC Config QoS, LC3 16_1_2] Passed
BAP/USR/SCC/BV-120-C [USR SRC Config QoS, LC3 16_2_2] Passed
BAP/USR/SCC/BV-121-C [USR SRC Config QoS, LC3 24_1_2] Passed
BAP/USR/SCC/BV-122-C [USR SRC Config QoS, LC3 24_2_2] Passed
BAP/USR/SCC/BV-123-C [USR SRC Config QoS, LC3 32_1_2] Passed
BAP/USR/SCC/BV-124-C [USR SRC Config QoS, LC3 32_2_2] Passed
BAP/USR/SCC/BV-125-C [USR SRC Config QoS, LC3 44.1_1_2] Passed
BAP/USR/SCC/BV-126-C [USR SRC Config QoS, LC3 44.1_2_2] Passed
BAP/USR/SCC/BV-127-C [USR SRC Config QoS, LC3 48_1_2] Passed
BAP/USR/SCC/BV-128-C [USR SRC Config QoS, LC3 48_2_2] Passed
BAP/USR/SCC/BV-129-C [USR SRC Config QoS, LC3 48_3_2] Passed
BAP/USR/SCC/BV-130-C [USR SRC Config QoS, LC3 48_4_2] Passed
BAP/USR/SCC/BV-131-C [USR SRC Config QoS, LC3 48_5_2] Passed
BAP/USR/SCC/BV-132-C [USR SRC Config QoS, LC3 48_6_2] Passed
Total: 64, Passed: 64 (100.0%), Failed: 0, Not Run: 0


  Commit: fd45490650ba2e461f5f72b9c8e042f651c4a765
      https://github.com/bluez/bluez/commit/fd45490650ba2e461f5f72b9c8e04=
2f651c4a765
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-04 (Fri, 04 Apr 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Introduce USR/SCC QoS tests for VS

Unicast Server Performs Config QoS =E2=80=93 Vendor-Specific

Test Purpose:
Verify that a Unicast Server IUT can handle a Config QoS operation for a
vendor-specific codec.

Pass verdict:
The IUT sends a notification of the ASE Control Point characteristic with=

Response_Code set to Success (0x00) for the requested ASE_ID and opcode

Test Summary
------------
BAP/USR/SCC/BV-133-C [USR SNK Config QoS, VS]        Passed
BAP/USR/SCC/BV-134-C [USR SRC Config QoS, VS]        Passed
Total: 2, Passed: 2 (100.0%), Failed: 0, Not Run: 0


  Commit: f2e717548f1d453e29e45c03fea5cca621c8c16e
      https://github.com/bluez/bluez/commit/f2e717548f1d453e29e45c03fea5c=
ca621c8c16e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-04 (Fri, 04 Apr 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Introduce USR/SCC Enable tests for LC3

Unicast Server Performs Client-Initiated Enable Operation

Test Purpose:
Verify that a Unicast Server IUT can handle a client-initiated Enable
operation for an ASE with a Unicast Client that is either in the Audio Si=
nk
role or the Audio Source role.

Pass verdict:
The IUT sends a notification of the ASE Control Point characteristic with=

Response_Code set to 0x00 (Success) for the requested ASE_ID and opcode.

Test Summary
------------
BAP/USR/SCC/BV-135-C [USR SNK Enable]                Passed
BAP/USR/SCC/BV-136-C [UCL SRC Enable]                Passed
Total: 2, Passed: 2 (100.0%), Failed: 0, Not Run: 0


  Commit: 88cacb8fd38e45961da453f704aa397d58a72090
      https://github.com/bluez/bluez/commit/88cacb8fd38e45961da453f704aa3=
97d58a72090
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-04 (Fri, 04 Apr 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Introduce USR/SCC Enable tests for LC3

Unicast Server Performs Client-Initiated Disable Operation

Test Purpose:
Verify that a Unicast Server IUT can perform a client-initiated Disable
operation for an ASE in the Enabling or Streaming state.

Pass verdict:
The IUT sends a notification of the ASE Control Point characteristic.

Test Summary
------------
BAP/USR/SCC/BV-137-C [USR SRC Disable in Enabling State] Passed
BAP/USR/SCC/BV-138-C [USR SNK Disable in Enabling or Streaming state] Pas=
sed
BAP/USR/SCC/BV-139-C [USR SRC Disable in Streaming State] Passed
Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0


  Commit: dfebcc9c100cdf59d4c00516b02cb72fe0d5e435
      https://github.com/bluez/bluez/commit/dfebcc9c100cdf59d4c00516b02cb=
72fe0d5e435
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-07 (Mon, 07 Apr 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix not always sending Releasing state

In order for states to be sent the stream cannot be freed since
pending_states could be pending due to be processing a CP operation, so
this attempts to grap a reference to the stream so it is not freed
while states are pending.


  Commit: 15fd57f26079d7bfd7b5797dd1cbd0192e68ac1f
      https://github.com/bluez/bluez/commit/15fd57f26079d7bfd7b5797dd1cbd=
0192e68ac1f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-07 (Mon, 07 Apr 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix not notifying idle state

The idle state must be notified like any other state.


  Commit: da110920dda8cdc3af99001e1a4062f8e2032144
      https://github.com/bluez/bluez/commit/da110920dda8cdc3af99001e1a406=
2f8e2032144
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-07 (Mon, 07 Apr 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Introduce USR/SCC Release tests for LC3

Unicast Server Performs Client-Initiated Release Operation

Test Purpose:
Verify the behavior of a Unicast Server IUT when a Unicast Client initiat=
es
a Release operation.

Pass verdict:
The IUT sends a notification of the ASE Control Point characteristic valu=
e.

Test Summary
------------
BAP/USR/SCC/BV-143-C [USR SRC Release in Codec Configured state] Passed
BAP/USR/SCC/BV-144-C [USR SNK Release in Codec Configured state] Passed
BAP/USR/SCC/BV-145-C [USR SRC Release in QoS Configured state] Passed
BAP/USR/SCC/BV-146-C [USR SNK Release in QoS Configured state] Passed
BAP/USR/SCC/BV-147-C [USR SRC Release in Enabling state] Passed
BAP/USR/SCC/BV-148-C [USR SNK Release in Enabling or Streaming state] Pas=
sed
BAP/USR/SCC/BV-149-C [USR SRC Release in Streaming state] Passed
BAP/USR/SCC/BV-150-C [USR SRC Release in Disabling state] Passed
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0


  Commit: ae5fe4aafe8113579b2d3307254e92bbde81455e
      https://github.com/bluez/bluez/commit/ae5fe4aafe8113579b2d3307254e9=
2bbde81455e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-07 (Mon, 07 Apr 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix not sending ASE Notication in case of Metadata update

Tests such if metadata update requires the server to generate ASE
notification on Update Metadata operation.


  Commit: 7d4fc80216529399d2d3c3143757d737d2c7729b
      https://github.com/bluez/bluez/commit/7d4fc80216529399d2d3c3143757d=
737d2c7729b
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-07 (Mon, 07 Apr 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Introduce USR/SCC Metadata tests for LC3

Unicast Server Performs Update Metadata Operation

Test Purpose:
Verify that a Unicast Server IUT can perform an Update Metadata operation=

initiated by a Unicast Client.

Pass verdict:
The IUT sends a notification of the ASE Control Point characteristic with=

Response_Code set to Success (0x00) for the requested ASE_ID and opcode.

Test Summary
------------
BAP/USR/SCC/BV-161-C [USR SRC Update Metadata in Enabling State] Passed
BAP/USR/SCC/BV-162-C [USR SNK Update Metadata in Enabling or Streaming st=
ate] Passed
BAP/USR/SCC/BV-163-C [USR SRC Update Metadata in Streaming State] Passed
Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0


  Commit: 713655c10fe268a548ec0186f0c5d84cd59beeb9
      https://github.com/bluez/bluez/commit/713655c10fe268a548ec0186f0c5d=
84cd59beeb9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-07 (Mon, 07 Apr 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix notifying with the wrong state

stream_notify_metadata is reused by a couple of states so it needs to
pass on the actual state to be notified rather than using ep->state
which may have been transitioned already.


  Commit: ed9fb8ae7acdf7908d00e683987a6f81d2e017d9
      https://github.com/bluez/bluez/commit/ed9fb8ae7acdf7908d00e683987a6=
f81d2e017d9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-07 (Mon, 07 Apr 2025)

  Changed paths:
    M src/shared/tester.c

  Log Message:
  -----------
  shared/tester: Fix not detecting NULL packets

When receiving packets if the iovec is NULL it means it shall be
skipped.


  Commit: e367244efccedbfad937fd9428c4bedb8e355725
      https://github.com/bluez/bluez/commit/e367244efccedbfad937fd9428c4b=
edb8e355725
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-07 (Mon, 07 Apr 2025)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Introduce USR/STR tests for LC3

Unicast Server Streaming =E2=80=93 1 Stream, 1 CIS =E2=80=93 LC3

Test Purpose:
Verify that a Unicast Server IUT can stream LC3-encoded audio data over o=
ne
unicast Audio Stream to/from a Unicast Client.

Pass verdict:
If the IUT is in the Audio Source role, the IUT sends SDUs with a zero or=

more length, using the LC3 Media Packet format (defined in [3] Section 4.=
2).
If the IUT is in the Audio Sink role, the IUT receives SDUs with a zero o=
r
more length, using the LC3 Media Packet format (defined in [3] Section 4.=
2)

Test Summary
------------
BAP/USR/STR/BV-001-C [USR, AC 2, LC3 8_1_1]          Passed
BAP/USR/STR/BV-002-C [USR, AC 10, LC3 8_1_1]         Passed
BAP/USR/STR/BV-003-C [USR, AC 2, LC3 8_2_1]          Passed
BAP/USR/STR/BV-004-C [USR, AC 10, LC3 8_2_1]         Passed
BAP/USR/STR/BV-005-C [USR, AC 2, LC3 16_1_1]         Passed
BAP/USR/STR/BV-006-C [USR, AC 10, LC3 16_1_1]        Passed
BAP/USR/STR/BV-007-C [USR, AC 2, LC3 16_2_1]         Passed
BAP/USR/STR/BV-008-C [USR, AC 10, LC3 16_2_1]        Passed
BAP/USR/STR/BV-009-C [USR, AC 2, LC3 24_1_1]         Passed
BAP/USR/STR/BV-010-C [USR, AC 10, LC3 24_1_1]        Passed
BAP/USR/STR/BV-011-C [USR, AC 2, LC3 24_2_1]         Passed
BAP/USR/STR/BV-012-C [USR, AC 10, LC3 24_2_1]        Passed
BAP/USR/STR/BV-013-C [USR, AC 2, LC3 32_1_1]         Passed
BAP/USR/STR/BV-014-C [USR, AC 10, LC3 32_1_1]        Passed
BAP/USR/STR/BV-015-C [USR, AC 2, LC3 32_2_1]         Passed
BAP/USR/STR/BV-016-C [USR, AC 10, LC3 32_2_1]        Passed
BAP/USR/STR/BV-017-C [USR, AC 2, LC3 441_1_1]        Passed
BAP/USR/STR/BV-018-C [USR, AC 10, LC3 441_1_1]       Passed
BAP/USR/STR/BV-019-C [USR, AC 2, LC3 44_2_1]         Passed
BAP/USR/STR/BV-020-C [USR, AC 10, LC3 44_2_1]        Passed
BAP/USR/STR/BV-021-C [USR, AC 2, LC3 48_1_1]         Passed
BAP/USR/STR/BV-022-C [USR, AC 10, LC3 48_1_1]        Passed
BAP/USR/STR/BV-023-C [USR, AC 2, LC3 48_2_1]         Passed
BAP/USR/STR/BV-024-C [USR, AC 10, LC3 48_2_1]        Passed
BAP/USR/STR/BV-025-C [USR, AC 2, LC3 48_3_1]         Passed
BAP/USR/STR/BV-026-C [USR, AC 10, LC3 48_3_1]        Passed
BAP/USR/STR/BV-027-C [USR, AC 2, LC3 48_4_1]         Passed
BAP/USR/STR/BV-028-C [USR, AC 10, LC3 48_4_1]        Passed
BAP/USR/STR/BV-029-C [USR, AC 2, LC3 48_5_1]         Passed
BAP/USR/STR/BV-030-C [USR, AC 10, LC3 48_5_1]        Passed
BAP/USR/STR/BV-031-C [USR, AC 2, LC3 48_6_1]         Passed
BAP/USR/STR/BV-032-C [USR, AC 10, LC3 48_6_1]        Passed
BAP/USR/STR/BV-033-C [USR, SRC, AC 1, LC3 8_1_1]     Passed
BAP/USR/STR/BV-034-C [USR, SRC, AC 4, LC3 8_1_1]     Passed
BAP/USR/STR/BV-035-C [USR, SRC, AC 1, LC3 8_2_1]     Passed
BAP/USR/STR/BV-036-C [USR, SRC, AC 4, LC3 8_2_1]     Passed
BAP/USR/STR/BV-037-C [USR, SRC, AC 1, LC3 16_1_1]    Passed
BAP/USR/STR/BV-038-C [USR, SRC, AC 4, LC3 16_1_1]    Passed
BAP/USR/STR/BV-039-C [USR, SRC, AC 1, LC3 16_2_1]    Passed
BAP/USR/STR/BV-040-C [USR, SRC, AC 4, LC3 16_2_1]    Passed
BAP/USR/STR/BV-041-C [USR, SRC, AC 1, LC3 24_1_1]    Passed
BAP/USR/STR/BV-042-C [USR, SRC, AC 4, LC3 24_1_1]    Passed
BAP/USR/STR/BV-043-C [USR, SRC, AC 1, LC3 24_2_1]    Passed
BAP/USR/STR/BV-044-C [USR, SRC, AC 4, LC3 24_2_1]    Passed
BAP/USR/STR/BV-045-C [USR, SRC, AC 1, LC3 32_1_1]    Passed
BAP/USR/STR/BV-046-C [USR, SRC, AC 4, LC3 32_1_1]    Passed
BAP/USR/STR/BV-047-C [USR, SRC, AC 1, LC3 32_2_1]    Passed
BAP/USR/STR/BV-048-C [USR, SRC, AC 4, LC3 32_2_1]    Passed
BAP/USR/STR/BV-049-C [USR, SRC, AC 1, LC3 44_1_1]    Passed
BAP/USR/STR/BV-050-C [USR, SRC, AC 4, LC3 44_1_1]    Passed
BAP/USR/STR/BV-051-C [USR, SRC, AC 1, LC3 44_2_1]    Passed
BAP/USR/STR/BV-052-C [USR, SRC, AC 4, LC3 44_2_1]    Passed
BAP/USR/STR/BV-053-C [USR, SRC, AC 1, LC3 48_1_1]    Passed
BAP/USR/STR/BV-054-C [USR, SRC, AC 4, LC3 48_1_1]    Passed
BAP/USR/STR/BV-055-C [USR, SRC, AC 1, LC3 48_2_1]    Passed
BAP/USR/STR/BV-056-C [USR, SRC, AC 4, LC3 48_2_1]    Passed
BAP/USR/STR/BV-057-C [USR, SRC, AC 1, LC3 48_3_1]    Passed
BAP/USR/STR/BV-058-C [USR, SRC, AC 4, LC3 48_3_1]    Passed
BAP/USR/STR/BV-059-C [USR, SRC, AC 1, LC3 48_4_1]    Passed
BAP/USR/STR/BV-060-C [USR, SRC, AC 4, LC3 48_4_1]    Passed
BAP/USR/STR/BV-061-C [USR, SRC, AC 1, LC3 48_5_1]    Passed
BAP/USR/STR/BV-062-C [USR, SRC, AC 4, LC3 48_5_1]    Passed
BAP/USR/STR/BV-063-C [USR, SRC, AC 1, LC3 48_6_1]    Passed
BAP/USR/STR/BV-064-C [USR, SRC, AC 4, LC3 48_6_1]    Passed
BAP/USR/STR/BV-065-C [USR, AC 2, LC3 8_1_2]          Passed
BAP/USR/STR/BV-066-C [USR, AC 10, LC3 8_1_2]         Passed
BAP/USR/STR/BV-067-C [USR, AC 2, LC3 8_2_2]          Passed
BAP/USR/STR/BV-068-C [USR, AC 10, LC3 8_2_2]         Passed
BAP/USR/STR/BV-069-C [USR, AC 2, LC3 16_1_2]         Passed
BAP/USR/STR/BV-070-C [USR, AC 10, LC3 16_1_2]        Passed
BAP/USR/STR/BV-071-C [USR, AC 2, LC3 16_2_2]         Passed
BAP/USR/STR/BV-072-C [USR, AC 10, LC3 16_2_2]        Passed
BAP/USR/STR/BV-073-C [USR, AC 2, LC3 24_1_2]         Passed
BAP/USR/STR/BV-074-C [USR, AC 10, LC3 24_1_2]        Passed
BAP/USR/STR/BV-075-C [USR, AC 2, LC3 24_2_2]         Passed
BAP/USR/STR/BV-076-C [USR, AC 10, LC3 24_2_2]        Passed
BAP/USR/STR/BV-077-C [USR, AC 2, LC3 32_1_2]         Passed
BAP/USR/STR/BV-078-C [USR, AC 10, LC3 32_1_2]        Passed
BAP/USR/STR/BV-079-C [USR, AC 2, LC3 32_2_2]         Passed
BAP/USR/STR/BV-080-C [USR, AC 10, LC3 32_2_2]        Passed
BAP/USR/STR/BV-081-C [USR, AC 2, LC3 44_1_2]         Passed
BAP/USR/STR/BV-082-C [USR, AC 10, LC3 44_1_2]        Passed
BAP/USR/STR/BV-083-C [USR, AC 2, LC3 44_2_2]         Passed
BAP/USR/STR/BV-084-C [USR, AC 10, LC3 44_2_2]        Passed
BAP/USR/STR/BV-085-C [USR, AC 2, LC3 48_1_2]         Passed
BAP/USR/STR/BV-086-C [USR, AC 10, LC3 48_1_2]        Passed
BAP/USR/STR/BV-087-C [USR, AC 2, LC3 48_2_2]         Passed
BAP/USR/STR/BV-088-C [USR, AC 10, LC3 48_2_2]        Passed
BAP/USR/STR/BV-089-C [USR, AC 2, LC3 48_3_2]         Passed
BAP/USR/STR/BV-090-C [USR, AC 10, LC3 48_3_2]        Passed
BAP/USR/STR/BV-091-C [USR, AC 2, LC3 48_4_2]         Passed
BAP/USR/STR/BV-092-C [USR, AC 10, LC3 48_4_2]        Passed
BAP/USR/STR/BV-093-C [USR, AC 2, LC3 48_5_2]         Passed
BAP/USR/STR/BV-094-C [USR, AC 10, LC3 48_5_2]        Passed
BAP/USR/STR/BV-095-C [USR, AC 2, LC3 48_6_2]         Passed
BAP/USR/STR/BV-096-C [USR, AC 10, LC3 48_6_2]        Passed
BAP/USR/STR/BV-097-C [USR, SRC, AC 1, LC3 8_1_2]     Passed
BAP/USR/STR/BV-098-C [USR, SRC, AC 4, LC3 8_1_2]     Passed
BAP/USR/STR/BV-099-C [USR, SRC, AC 1, LC3 8_2_2]     Passed
BAP/USR/STR/BV-100-C [USR, SRC, AC 4, LC3 8_2_2]     Passed
BAP/USR/STR/BV-101-C [USR, SRC, AC 1, LC3 16_1_2]    Passed
BAP/USR/STR/BV-102-C [USR, SRC, AC 4, LC3 16_1_2]    Passed
BAP/USR/STR/BV-103-C [USR, SRC, AC 1, LC3 16_2_2]    Passed
BAP/USR/STR/BV-104-C [USR, SRC, AC 4, LC3 16_2_2]    Passed
BAP/USR/STR/BV-105-C [USR, SRC, AC 1, LC3 24_1_2]    Passed
BAP/USR/STR/BV-106-C [USR, SRC, AC 4, LC3 24_1_2]    Passed
BAP/USR/STR/BV-107-C [USR, SRC, AC 1, LC3 24_2_2]    Passed
BAP/USR/STR/BV-108-C [USR, SRC, AC 4, LC3 24_2_2]    Passed
BAP/USR/STR/BV-109-C [USR, SRC, AC 1, LC3 32_1_2]    Passed
BAP/USR/STR/BV-110-C [USR, SRC, AC 4, LC3 32_1_2]    Passed
BAP/USR/STR/BV-111-C [USR, SRC, AC 1, LC3 32_2_2]    Passed
BAP/USR/STR/BV-112-C [USR, SRC, AC 4, LC3 32_2_2]    Passed
BAP/USR/STR/BV-113-C [USR, SRC, AC 1, LC3 44_1_2]    Passed
BAP/USR/STR/BV-114-C [USR, SRC, AC 4, LC3 44_1_2]    Passed
BAP/USR/STR/BV-115-C [USR, SRC, AC 1, LC3 44_2_2]    Passed
BAP/USR/STR/BV-116-C [USR, SRC, AC 4, LC3 44_2_2]    Passed
BAP/USR/STR/BV-117-C [USR, SRC, AC 1, LC3 48_1_2]    Passed
BAP/USR/STR/BV-118-C [USR, SRC, AC 4, LC3 48_1_2]    Passed
BAP/USR/STR/BV-119-C [USR, SRC, AC 1, LC3 48_2_2]    Passed
BAP/USR/STR/BV-120-C [USR, SRC, AC 4, LC3 48_2_2]    Passed
BAP/USR/STR/BV-121-C [USR, SRC, AC 1, LC3 48_3_2]    Passed
BAP/USR/STR/BV-122-C [USR, SRC, AC 4, LC3 48_3_2]    Passed
BAP/USR/STR/BV-123-C [USR, SRC, AC 1, LC3 48_4_2]    Passed
BAP/USR/STR/BV-124-C [USR, SRC, AC 4, LC3 48_4_2]    Passed
BAP/USR/STR/BV-121-C [USR, SRC, AC 1, LC3 48_5_2]    Passed
BAP/USR/STR/BV-122-C [USR, SRC, AC 4, LC3 48_5_2]    Passed
BAP/USR/STR/BV-123-C [USR, SRC, AC 1, LC3 48_6_2]    Passed
BAP/USR/STR/BV-124-C [USR, SRC, AC 4, LC3 48_6_2]    Passed
Total: 128, Passed: 128 (100.0%), Failed: 0, Not Run: 0


Compare: https://github.com/bluez/bluez/compare/0efa20cbf3fb...e367244efc=
ce

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
