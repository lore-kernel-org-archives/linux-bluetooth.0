Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B9C54673
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 15:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715960175; cv=none; b=UMbSVWVns/QijiOmkFzObF4nKOitoF9Vrr33CuPx6v64YGWLc+9Z0hDNxCgjDmH17EQnGRelbR/gL+nPl8EI+SONMXUPB/ANOzE7HjUWe6CSVEASozTOUsKtFQ7QwZD5BnAxGvhb38wP8B32D5JvtrgMiB0DkOVn5j4JCzw27cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715960175; c=relaxed/simple;
	bh=frpy0WpzFrQU2JvZxs/2GDKtWc80NTEddqyWcqvLI9w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=dlyNib/FR3d0OeKmdpT0DmYj8f2OzktBkhOLXbFJCXF2JM+UKLQvT2B9gdNGZ3FvyWzGsuLcsvE9QKOuQ4LHzwX1yF0tZlI4CUhzWmv7zmXmFKMCGdpxyLXoq+XDjgGliKIdCbRVNhLLeJnKlsyQxPuQLkQ2F/n3jutjcpizSXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dn601apd; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dn601apd"
Received: from github.com (hubbernetes-node-afee3a5.ash1-iad.github.net [10.56.131.38])
	by smtp.github.com (Postfix) with ESMTPA id 695B96008D5
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 May 2024 08:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1715960173;
	bh=nUKZyOpweTimJCW/suc2G18X1igaBLNuiVolD4+sqAY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dn601apdY6Pm4bg2LIb2Ev4fRajT7mc8qH9sd23fIRqNofjjv971QUwAEj6D8JaY9
	 ehjjNn0QGZEiDJaihEa22vqqzUTUU2NQlerWalwof3i51zNkKNLDm06gJR0st4VFjD
	 t3spP8IYxMddQZawJbmU/+x9M7VYBzfEI0k5615M=
Date: Fri, 17 May 2024 08:36:13 -0700
From: iulia-tanasescu <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/46c0e3-62d38d@github.com>
Subject: [bluez/bluez] f473d4: shared/bap: Handle NULL caps at bis verify
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
  Commit: f473d4404679cb8b40cad14cf792360931d630e3
      https://github.com/bluez/bluez/commit/f473d4404679cb8b40cad14cf792360931d630e3
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-05-17 (Fri, 17 May 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Handle NULL caps at bis verify

This updates bt_bap_verify_bis to handle NULL L2 and/or L3 caps.


  Commit: cd3540107f256602e04da3e09abce5d1f783525e
      https://github.com/bluez/bluez/commit/cd3540107f256602e04da3e09abce5d1f783525e
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-05-17 (Fri, 17 May 2024)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Add detach stream op

Since a Broadcast Sink stream is not attached to an endpoint,
bap_stream_detach must be adapted accordingly.

This splits bap_stream_detach into dedicated stream op functions
for ucast, bcast source and bcast sink.


  Commit: 61ed4b4b60c3638ef2db660d54536f0ff3027f69
      https://github.com/bluez/bluez/commit/61ed4b4b60c3638ef2db660d54536f0ff3027f69
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-05-17 (Fri, 17 May 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Update caps to accommodate 8_1 config

This adjusts the min SDU size in lc3_caps, to accommodate the 8_1 config.


  Commit: 94c1c776ca252a6c30516d83bd816ac753970fc8
      https://github.com/bluez/bluez/commit/94c1c776ca252a6c30516d83bd816ac753970fc8
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-05-17 (Fri, 17 May 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Make test_bsrc generic

This makes test_bsrc more generic, to accommodate Broadcast Sink tests
as well, following the unicast design for handling source/sink
configurations.


  Commit: 62d38d6c9ef4017ff6a84af0a9cd9242a7f6a211
      https://github.com/bluez/bluez/commit/62d38d6c9ef4017ff6a84af0a9cd9242a7f6a211
  Author: Iulia Tanasescu <iulia.tanasescu@nxp.com>
  Date:   2024-05-17 (Fri, 17 May 2024)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Add Broadcast Sink SCC tests

4.13.2 Broadcast Sink Synchronizes to PA (page 177)

     Test Purpose:
     Verify that a Broadcast Sink IUT can synchronize to the PA
     associated with a broadcast Audio Stream transmitted by a
     Broadcast Source.

     Test Case Configuration:
     BAP/BSNK/SCC/BV-01-C [Sync to PA, LC3 8_1_1]
     BAP/BSNK/SCC/BV-02-C [Sync to PA, LC3 8_2_1]
     BAP/BSNK/SCC/BV-03-C [Sync to PA, LC3 16_1_1]
     BAP/BSNK/SCC/BV-04-C [Sync to PA, LC3 16_2_1]
     BAP/BSNK/SCC/BV-05-C [Sync to PA, LC3 24_1_1]
     BAP/BSNK/SCC/BV-06-C [Sync to PA, LC3 24_2_1]
     BAP/BSNK/SCC/BV-07-C [Sync to PA, LC3 32_1_1]
     BAP/BSNK/SCC/BV-08-C [Sync to PA, LC3 32_2_1]
     BAP/BSNK/SCC/BV-09-C [Sync to PA, LC3 44.1_1_1]
     BAP/BSNK/SCC/BV-10-C [Sync to PA, LC3 44.1_2_1]
     BAP/BSNK/SCC/BV-11-C [Sync to PA, LC3 48_1_1]
     BAP/BSNK/SCC/BV-12-C [Sync to PA, LC3 48_2_1]
     BAP/BSNK/SCC/BV-13-C [Sync to PA, LC3 48_3_1]
     BAP/BSNK/SCC/BV-14-C [Sync to PA, LC3 48_4_1]
     BAP/BSNK/SCC/BV-15-C [Sync to PA, LC3 48_5_1]
     BAP/BSNK/SCC/BV-16-C [Sync to PA, LC3 48_6_1]
     BAP/BSNK/SCC/BV-17-C [Sync to PA, LC3 8_1_2]
     BAP/BSNK/SCC/BV-18-C [Sync to PA, LC3 8_2_2]
     BAP/BSNK/SCC/BV-19-C [Sync to PA, LC3 16_1_2]
     BAP/BSNK/SCC/BV-20-C [Sync to PA, LC3 16_2_2]
     BAP/BSNK/SCC/BV-21-C [Sync to PA, LC3 24_1_2]
     BAP/BSNK/SCC/BV-22-C [Sync to PA, LC3 24_2_2]
     BAP/BSNK/SCC/BV-23-C [Sync to PA, LC3 32_1_2]
     BAP/BSNK/SCC/BV-24-C [Sync to PA, LC3 32_2_2]
     BAP/BSNK/SCC/BV-25-C [Sync to PA, LC3 44.1_1_2]
     BAP/BSNK/SCC/BV-26-C [Sync to PA, LC3 44.1_2_2]
     BAP/BSNK/SCC/BV-27-C [Sync to PA, LC3 48_1_2]
     BAP/BSNK/SCC/BV-28-C [Sync to PA, LC3 48_2_2]
     BAP/BSNK/SCC/BV-29-C [Sync to PA, LC3 48_3_2]
     BAP/BSNK/SCC/BV-30-C [Sync to PA, LC3 48_4_2]
     BAP/BSNK/SCC/BV-31-C [Sync to PA, LC3 48_5_2]
     BAP/BSNK/SCC/BV-32-C [Sync to PA, LC3 48_6_2]
     BAP/BSNK/SCC/BV-33-C [Sync to PA, VS]

     Pass verdict:
     The received AdvData field of AUX_SYNC_IND and optionally
     AUX_CHAIN_IND PDUs contains the configured BASE information.

Test Summary
------------
BAP/BSNK/SCC/BV-01-C [Sync to PA, LC3 8_1_1]         Passed
BAP/BSNK/SCC/BV-02-C [Sync to PA, LC3 8_2_1]         Passed
BAP/BSNK/SCC/BV-03-C [Sync to PA, LC3 16_1_1]        Passed
BAP/BSNK/SCC/BV-04-C [Sync to PA, LC3 16_2_1]        Passed
BAP/BSNK/SCC/BV-05-C [Sync to PA, LC3 24_1_1]        Passed
BAP/BSNK/SCC/BV-06-C [Sync to PA, LC3 24_2_1]        Passed
BAP/BSNK/SCC/BV-07-C [Sync to PA, LC3 32_1_1]        Passed
BAP/BSNK/SCC/BV-08-C [Sync to PA, LC3 32_2_1]        Passed
BAP/BSNK/SCC/BV-09-C [Sync to PA, LC3 44.1_1_1]      Passed
BAP/BSNK/SCC/BV-10-C [Sync to PA, LC3 44.1_2_1]      Passed
BAP/BSNK/SCC/BV-11-C [Sync to PA, LC3 48_1_1]        Passed
BAP/BSNK/SCC/BV-12-C [Sync to PA, LC3 48_2_1]        Passed
BAP/BSNK/SCC/BV-13-C [Sync to PA, LC3 48_3_1]        Passed
BAP/BSNK/SCC/BV-14-C [Sync to PA, LC3 48_4_1]        Passed
BAP/BSNK/SCC/BV-15-C [Sync to PA, LC3 48_5_1]        Passed
BAP/BSNK/SCC/BV-16-C [Sync to PA, LC3 48_6_1]        Passed
BAP/BSNK/SCC/BV-17-C [Sync to PA, LC3 8_1_2]         Passed
BAP/BSNK/SCC/BV-18-C [Sync to PA, LC3 8_2_2]         Passed
BAP/BSNK/SCC/BV-19-C [Sync to PA, LC3 16_1_2]        Passed
BAP/BSNK/SCC/BV-20-C [Sync to PA, LC3 16_2_2]        Passed
BAP/BSNK/SCC/BV-21-C [Sync to PA, LC3 24_1_2]        Passed
BAP/BSNK/SCC/BV-22-C [Sync to PA, LC3 24_2_2]        Passed
BAP/BSNK/SCC/BV-23-C [Sync to PA, LC3 32_1_2]        Passed
BAP/BSNK/SCC/BV-24-C [Sync to PA, LC3 32_2_2]        Passed
BAP/BSNK/SCC/BV-25-C [Sync to PA, LC3 44.1_1_2]      Passed
BAP/BSNK/SCC/BV-26-C [Sync to PA, LC3 44.1_2_2]      Passed
BAP/BSNK/SCC/BV-27-C [Sync to PA, LC3 48_1_2]        Passed
BAP/BSNK/SCC/BV-28-C [Sync to PA, LC3 48_2_2]        Passed
BAP/BSNK/SCC/BV-29-C [Sync to PA, LC3 48_3_2]        Passed
BAP/BSNK/SCC/BV-30-C [Sync to PA, LC3 48_4_2]        Passed
BAP/BSNK/SCC/BV-31-C [Sync to PA, LC3 48_5_2]        Passed
BAP/BSNK/SCC/BV-32-C [Sync to PA, LC3 48_6_2]        Passed
BAP/BSNK/SCC/BV-33-C [Sync to PA, VS]                Passed


Compare: https://github.com/bluez/bluez/compare/46c0e376fe13...62d38d6c9ef4

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
