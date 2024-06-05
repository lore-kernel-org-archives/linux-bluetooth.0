Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BA713A3EF
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jun 2024 19:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717614723; cv=none; b=qUwH3IhmAzzE3jIRuw+OK8YT7Y+oZqzDfeD8O2/m9NIH0GpHjvD9lFf1comMqmLoJO7tu07hQNN1tVUoWdjDASkNrQef8kISYWdjA4LarYd16JcF21JpXIlMvQAB7l6CvZqRGQnOF9qKUjicZ5zXCqmEjMA2EsH+Whq78BD7Xec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717614723; c=relaxed/simple;
	bh=gd4RpVSwynS1oGFVcR8gl3w7V8S0ys2Ir3ZNgsLg9d4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=f8z9Cd6bn4DTaAWiBXWp2zIr5DnhQsLXmB+7TG9CkHdIpCL61lYf10GW0PRNNmqJkbypvp5DYSYpEesJRmCpE3gvsf7xRdrovFizDw3YDB/DAj/KyxHmfPPQMlNsUjEUHkxCfujflarWhBgRu5r2V6Z5DtjracGz026hkoHrGF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hRFp3QYP; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hRFp3QYP"
Received: from github.com (hubbernetes-node-0144f6d.ac4-iad.github.net [10.52.148.35])
	by smtp.github.com (Postfix) with ESMTPA id E80EA640BF1
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jun 2024 12:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1717614720;
	bh=kHG4/CAUFkCsScH2pkCsl/q7QzpryOnicBNUASl3N5Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hRFp3QYPVs9BpMGe4mpK9Zbhn/NigCrbyt6og8HINcVhegMSAqPxbYdJsr4vN+psK
	 UA0wWsodcBbU0AzAwS41bLI/FIXitKAhN9PqAKBirRbhoZQRWfeA118jpn84081MGU
	 nNzgX603ts8bC2DAV24q3uj2jZAMBmP9n3A85m/w=
Date: Wed, 05 Jun 2024 12:12:00 -0700
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/61776f-7c619d@github.com>
Subject: [bluez/bluez] f63c6e: Revert "adapter: add support for setting
 POLL_ERRQ...
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
  Commit: f63c6e9fa069dd82c6dda521f64294bb4f872ff9
      https://github.com/bluez/bluez/commit/f63c6e9fa069dd82c6dda521f64294bb4f872ff9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-05 (Wed, 05 Jun 2024)

  Changed paths:
    M src/adapter.c
    M src/adapter.h
    M src/main.c
    M src/main.conf

  Log Message:
  -----------
  Revert "adapter: add support for setting POLL_ERRQUEUE experimental feature"

This reverts commit e1c178f96a07fc43ad7523fdd4c93967843e4f60 as the
changes required in the kernel were reverted as well.


  Commit: 7c619d864afd01df6a98baeffe7030a3d144b22a
      https://github.com/bluez/bluez/commit/7c619d864afd01df6a98baeffe7030a3d144b22a
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-06-05 (Wed, 05 Jun 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Add Broadcast Source STR one BIS tests

4.14.1 Broadcast Audio Stream with One BIS - Source (page 180):

    Test Purpose:
    Verify that a Broadcast Source IUT can stream one BIS
    to a Broadcast Sink. The verification is performed for
    each Config Settings in turn.

    Test Case Configuration:
    BAP/BSRC/STR/BV-01-C [BSRC, LC3 8_1]
    BAP/BSRC/STR/BV-02-C [BSRC, LC3 8_2]
    BAP/BSRC/STR/BV-03-C [BSRC, LC3 16_1]
    BAP/BSRC/STR/BV-04-C [BSRC, LC3 16_2]
    BAP/BSRC/STR/BV-05-C [BSRC, LC3 24_1]
    BAP/BSRC/STR/BV-06-C [BSRC, LC3 24_2]
    BAP/BSRC/STR/BV-07-C [BSRC, LC3 32_1
    BAP/BSRC/STR/BV-08-C [BSRC, LC3 32_2]
    BAP/BSRC/STR/BV-09-C [BSRC, LC3 44.1_1]
    BAP/BSRC/STR/BV-10-C [BSRC, LC3 44.1_2]
    BAP/BSRC/STR/BV-11-C [BSRC, LC3 48_1]
    BAP/BSRC/STR/BV-12-C [BSRC, LC3 48_2]
    BAP/BSRC/STR/BV-13-C [BSRC, LC3 48_3]
    BAP/BSRC/STR/BV-14-C [BSRC, LC3 48_4]
    BAP/BSRC/STR/BV-15-C [BSRC, LC3 48_5]
    BAP/BSRC/STR/BV-16-C [BSRC, LC3 48_6]
    BAP/BSRC/STR/BV-17-C [BSRC, VS]

    Pass verdict:
    If the Codec ID is LC3, the IUT sends encoded LC3 audio
    data in BIS Data PDUs on the broadcast Audio Stream. The
    audio data is formatted using the LC3 Media Packet format.

    If the Codec ID is a vendor-specific Codec ID, the IUT
    sends BIS Data PDUs on the broadcast Audio Stream. The
    parameters included in the Codec_Specific_Configuration
    data are as defined in TSPX_VS_Codec_Specific_Configuration.

    If the Codec ID is LC3, each parameter included in
    Codec_Specific_Configuration data is formatted in an LTV
    structure with the length, type, and value specified in
    Table 4.79.

Test Summary
------------
BAP/BSRC/STR/BV-01-C [BSRC, LC3 8_1]                 Passed
BAP/BSRC/STR/BV-02-C [BSRC, LC3 8_2]                 Passed
BAP/BSRC/STR/BV-03-C [BSRC, LC3 16_1]                Passed
BAP/BSRC/STR/BV-04-C [BSRC, LC3 16_2]                Passed
BAP/BSRC/STR/BV-05-C [BSRC, LC3 24_1]                Passed
BAP/BSRC/STR/BV-06-C [BSRC, LC3 24_2]                Passed
BAP/BSRC/STR/BV-07-C [BSRC, LC3 32_1]                Passed
BAP/BSRC/STR/BV-08-C [BSRC, LC3 32_2]                Passed
BAP/BSRC/STR/BV-09-C [BSRC, LC3 44.1_1]              Passed
BAP/BSRC/STR/BV-10-C [BSRC, LC3 44.1_2]              Passed
BAP/BSRC/STR/BV-11-C [BSRC, LC3 48_1]                Passed
BAP/BSRC/STR/BV-12-C [BSRC, LC3 48_2]                Passed
BAP/BSRC/STR/BV-13-C [BSRC, LC3 48_3]                Passed
BAP/BSRC/STR/BV-14-C [BSRC, LC3 48_4]                Passed
BAP/BSRC/STR/BV-15-C [BSRC, LC3 48_5]                Passed
BAP/BSRC/STR/BV-16-C [BSRC, LC3 48_6]                Passed
BAP/BSRC/STR/BV-17-C [BSRC, VS]                      Passed


Compare: https://github.com/bluez/bluez/compare/61776f0de7b2...7c619d864afd

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
