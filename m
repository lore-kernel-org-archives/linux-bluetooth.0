Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF3C4C66
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 16:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716308210; cv=none; b=GnH5Ooa3f1xl9dHTsEjeXgFFFh8/QpBVkQMzX4ogoc/cVuKLgv7UDrgsLjCr3PcQJygfeGrrxP6fRHlSqhfvmf5uUKMedQOW/U4uqW9DUs9tlAhy3vM/ugolSic7GIclwStAwUZDDK3JzUWGD+lqK1N/bICSAb+qXn/DJU4L75M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716308210; c=relaxed/simple;
	bh=lTIQoZyjetoT9WTrmJ23Q/vUiN/BQeJzLk6FFu9uz1I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JIiIAYkXqb1lfQKSjIBPBTItc05cACg7lwPxXZnG9HfuwE2PkFQ6nxqQHoHvRNw01rnPF4cddewgay1XbBhIPwUrqV/LlwPRRBXpSRf9qTjJ67SQP1VIvnIXJ3Skk/+o+5ElmFMdDnWH/DWJzttEn5mkWwrChDfp+Jy35W+v0VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=m6/X2HXr; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="m6/X2HXr"
Received: from github.com (hubbernetes-node-38032fe.ac4-iad.github.net [10.52.151.31])
	by smtp.github.com (Postfix) with ESMTPA id 15D14641017
	for <linux-bluetooth@vger.kernel.org>; Tue, 21 May 2024 09:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1716308206;
	bh=KRB+6/JL1x13U8cJZQWSzFXVrW05MhfTW5jELdG9VAI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=m6/X2HXreTV5N6+WPAK/CzaRvAAvkYpCmDqkikknMrjjzIkAgjYpjZNvyJ4CXPq5T
	 axv8rjx++Q5Zs8x/dijw5HeVowUKXxdfLN4myGVyY/4XKtfLErf/OU7RWk0tEF711X
	 yZRJ7BmY9kYjvCq4Sn5caTysNkAOWgZgFbvmOPHc=
Date: Tue, 21 May 2024 09:16:46 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/a2438e-6e51ac@github.com>
Subject: [bluez/bluez] 41340a: test-bap: Keep streams queue in test_data
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
  Commit: 41340a74bf83b16304cf6ed388bf6341f41c7ed1
      https://github.com/bluez/bluez/commit/41340a74bf83b16304cf6ed388bf6341f41c7ed1
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-05-21 (Tue, 21 May 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Keep streams queue in test_data

Some BAP test configurations require multiple streams to be created
(for example, 4.14.4 Broadcast Sink Receives Audio Data Over Multiple
BISes).

This replaces the stream pointer inside test_data with a queue of
streams, where each created stream is pushed.

Unicast callbacks where the created stream needs to be accessed
already pass the stream reference as parameter, so there is no need
to access it from test_data.


  Commit: 25eaeeb7e1bc9a35091a1bb21c0fb20581fcbe8a
      https://github.com/bluez/bluez/commit/25eaeeb7e1bc9a35091a1bb21c0fb20581fcbe8a
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-05-21 (Tue, 21 May 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Add support for multiple bcast streams

This adds support for implementing Broadcast tests that require multiple
streams to be configured (for example, 4.14.4 Broadcast Sink Receives
Audio Data Over Multiple BISes).

The number of required streams is added inside the test_config struct.
The bsnk_pac_added and the bsnk_state_str callbacks have been updated
to support multiple streams.


  Commit: c41943fe392dec833ce7c0b5e37de40d07c51b61
      https://github.com/bluez/bluez/commit/c41943fe392dec833ce7c0b5e37de40d07c51b61
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-05-21 (Tue, 21 May 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Add Broadcast Sink STR MBIS tests

4.14.4 Broadcast Sink Receives Audio Data Over Multiple BISes (page 193):

    Test Purpose:
    Verify that a Broadcast Sink IUT can receive audio data over
    multiple BISes from a Broadcast Source. The verification is
    performed for each set of parameters in turn.

    Test Case Configuration:
    BAP/BSNK/STR/BV-18-C [BSNK, Multiple BISes, LC3 8_1]
    BAP/BSNK/STR/BV-19-C [BSNK, Multiple BISes, LC3 8_2]
    BAP/BSNK/STR/BV-20-C [BSNK, Multiple BISes, LC3 16_1]
    BAP/BSNK/STR/BV-21-C [BSNK, Multiple BISes, LC3 16_2]
    BAP/BSNK/STR/BV-22-C [BSNK, Multiple BISes, LC3 24_1]
    BAP/BSNK/STR/BV-23-C [BSNK, Multiple BISes, LC3 24_2]
    BAP/BSNK/STR/BV-24-C [BSNK, Multiple BISes, LC3 32_1]
    BAP/BSNK/STR/BV-25-C [BSNK, Multiple BISes, LC3 32_2]
    BAP/BSNK/STR/BV-26-C [BSNK, Multiple BISes, LC3 44.1_1]
    BAP/BSNK/STR/BV-27-C [BSNK, Multiple BISes, LC3 44.1_2]
    BAP/BSNK/STR/BV-28-C [BSNK, Multiple BISes, LC3 48_1]
    BAP/BSNK/STR/BV-29-C [BSNK, Multiple BISes, LC3 48_2]
    BAP/BSNK/STR/BV-30-C [BSNK, Multiple BISes, LC3 48_3]
    BAP/BSNK/STR/BV-31-C [BSNK, Multiple BISes, LC3 48_4]
    BAP/BSNK/STR/BV-32-C [BSNK, Multiple BISes, LC3 48_5]
    BAP/BSNK/STR/BV-33-C [BSNK, Multiple BISes, LC3 48_6]
    BAP/BSNK/STR/BV-34-C [BSNK, Multiple BISes, VS]

    Pass verdict:
    The IUT synchronizes to the Lower Tester (the Link Layer
    receives a BIS Data PDU). The host on the IUT receives an
    LE BIG Sync Established event.

    If the Codec ID is LC3, the IUT receives encoded LC3 audio
    data in BIS Data PDUs on each synchronized BIS. The audio
    data is formatted using the LC3 Media Packet format.

    If the Codec ID is a vendor-specific Codec ID, the IUT receives
    BIS Data PDUs on each synchronized BIS. The parameters included
    in the Codec_Specific_Configuration data are as defined in
    TSPX_VS_Codec_Specific_Configuration.

    If the Codec ID is LC3, each parameter included in
    Codec_Specific_Configuration data is formatted in an LTV structure
    with the length, type, and value specified in Table 4.85.

Test Summary
------------
BAP/BSNK/STR/BV-18-C [BSNK, Multiple BISes, LC3 8_1]    Passed
BAP/BSNK/STR/BV-19-C [BSNK, Multiple BISes, LC3 8_2]    Passed
BAP/BSNK/STR/BV-20-C [BSNK, Multiple BISes, LC3 16_1]   Passed
BAP/BSNK/STR/BV-21-C [BSNK, Multiple BISes, LC3 16_2]   Passed
BAP/BSNK/STR/BV-22-C [BSNK, Multiple BISes, LC3 24_1]   Passed
BAP/BSNK/STR/BV-23-C [BSNK, Multiple BISes, LC3 24_2]   Passed
BAP/BSNK/STR/BV-24-C [BSNK, Multiple BISes, LC3 32_1]   Passed
BAP/BSNK/STR/BV-25-C [BSNK, Multiple BISes, LC3 32_2]   Passed
BAP/BSNK/STR/BV-26-C [BSNK, Multiple BISes, LC3 44.1_1] Passed
BAP/BSNK/STR/BV-27-C [BSNK, Multiple BISes, LC3 44.1_2] Passed
BAP/BSNK/STR/BV-28-C [BSNK, Multiple BISes, LC3 48_1]   Passed
BAP/BSNK/STR/BV-29-C [BSNK, Multiple BISes, LC3 48_2]   Passed
BAP/BSNK/STR/BV-30-C [BSNK, Multiple BISes, LC3 48_3]   Passed
BAP/BSNK/STR/BV-31-C [BSNK, Multiple BISes, LC3 48_4]   Passed
BAP/BSNK/STR/BV-32-C [BSNK, Multiple BISes, LC3 48_5]   Passed
BAP/BSNK/STR/BV-33-C [BSNK, Multiple BISes, LC3 48_6]   Passed
BAP/BSNK/STR/BV-34-C [BSNK, Multiple BISes, VS]         Passed


  Commit: 6e51acb0e846a141e3a1ccd0f243b7fe9de7c111
      https://github.com/bluez/bluez/commit/6e51acb0e846a141e3a1ccd0f243b7fe9de7c111
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-05-21 (Tue, 21 May 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Rename num_str to streams

This renames test_config.num_str to test_config.streams just be clearer
on what is the intent of the field.


Compare: https://github.com/bluez/bluez/compare/a2438e46f812...6e51acb0e846

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
