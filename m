Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE033B9D84
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788541679; cv=none; b=p3Q0zoybGgLSHAorcXU1/h/atGOiLSJ+VnbrNMAEy1o5woOkerdLvzmSXwJUlWlIT/Yii8k2fx8deotPHdKS8cPDYBVcvgbq/a7V33VIP+Jff2hQylwwnA66xh9e1BoIRo0Z0VdLramgPPvHa4aQ7yQ5AIUY0RR5oLqXd0vb3i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788541679; c=relaxed/simple;
	bh=hAHx6oBhwtCa6ted7j6gsdXs12UwUj0K1VZkkJWYU1A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CCdoas9eDJ5cqkmgWIWxoagh6yFU9EncKd22/2FkLs2RfhimYELkUhF+CYvGS9l6qklkTNbAJptAcSCGL8l7LoN+TPFpdv2IWXEs3kRMNDNjEXCghgGla6sX58+OFTbxKuMcbu9cmQl1j3hoDOxsYNU/Uzaam/Ekev8qnSPC+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Xd2iwHKb; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Xd2iwHKb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788541677;
	bh=veFjXZdo97ccWsExctGrLdNvIqjLUYOflr5vaSU86yI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Xd2iwHKbaepI1PEb0YFLmDDqdciaFJXPtvllsYid1YFUY9L9jh1GEs5B0Ey1gKPk0
	 gBZW+m+HC+IMvv26ieIks5LhsFgdC5mkdFf+pWjLrhTHLwBfHOBqPMSKbI1nqe6UoY
	 c7nc1k6Sg+F1KqxIiRZ6K0/eYoUU6v3LneF3CDuc=
Received: from github.com (hubbernetes-node-75620f1.ash1-iad.github.net [10.59.97.31])
	by smtp.github.com (Postfix) with ESMTPA id A62F8601467
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Sep 2026 10:07:57 -0700 (PDT)
Date: Fri, 04 Sep 2026 10:07:57 -0700
From: raghava447 <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1158246/000000-c7a20d@github.com>
Subject: [bluez/bluez] 9db173: profiles/audio: Support MCS track position
 writes
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

  Branch: refs/heads/1158246
  Home:   https://github.com/bluez/bluez
  Commit: 9db1732402fc80263721882d90f66f1aeb9c98ae
      https://github.com/bluez/bluez/commit/9db1732402fc80263721882d90f66f1aeb9c98ae
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M profiles/audio/mcp.c
    M profiles/audio/media.c
    M profiles/audio/media.h

  Log Message:
  -----------
  profiles/audio: Support MCS track position writes

Use MPRIS Seek to handle MCS Track Position writes.

This is required by PTS GMCS/SR/SP/BV-02-C test.


  Commit: b6e189629a6ce5ed2b4ffdc2314a9fdf79d9a529
      https://github.com/bluez/bluez/commit/b6e189629a6ce5ed2b4ffdc2314a9fdf79d9a529
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  profiles/audio: Support MCS fast seeking

Map Fast Rewind and Fast Forward to relative MPRIS Seek calls.

Report direction through Seeking Speed until Seeked restores player
state.

This is required by PTS tests GMCS/SR/MCP/BV-05-C to BV-08-C.


  Commit: 4098dfadf887b6c622e38fec0c80ca2c2d2e3727
      https://github.com/bluez/bluez/commit/4098dfadf887b6c622e38fec0c80ca2c2d2e3727
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M src/shared/mcp.c

  Log Message:
  -----------
  shared/mcp: Notify unsupported RFU opcodes

Use the ATT result to suppress responses for malformed writes while
allowing opcode 0x00 to report Operation Not Supported.

This is required by GMCS/SR/SPE/BI-01-C.


  Commit: c7a20dce06a2ac3737e89754dd81a16122767957
      https://github.com/bluez/bluez/commit/c7a20dce06a2ac3737e89754dd81a16122767957
  Author: raghavendra <raghavendra.rao@collabora.com>
  Date:   2026-09-04 (Fri, 04 Sep 2026)

  Changed paths:
    M unit/test-mcp.c

  Log Message:
  -----------
  unit/test-mcp: Test unsupported RFU opcode

Verify that GMCS/SR/SPE/BI-01-C opcode 0x00 produces an Operation Not
Supported notification.


Compare: https://github.com/bluez/bluez/compare/9db1732402fc%5E...c7a20dce06a2

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
