Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85812F7F01
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 09:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785317407; cv=none; b=fAp82vHsFY0gKCg48T6xpscfwaNjkWaC2NpKbVf0kZ4FjNNQBSIOW5CmqO72RjlEEfHxM5HwofqoDjQLww9RE9PDtclkqcjp/dKPoXxrW57zFiT4WEz5Ht0nTtpPcobSPWUSfJF8cQNnR3nPfE98Yi2HHZCdLPylWS8S+mghB/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785317407; c=relaxed/simple;
	bh=JMB7IRO1WZUD2pnlej+8yBH7HkhBoOBLl5JOfI4Q7IU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VhBJzkhd/Ka8G8OAoQNfrv2N2wRfK/J50TXeMtS/MsvxvGzOxd4UQAx2T0FHEYD+0QB0I7Z6GOEFIoH8JAK1TS90APJ8y7mA+1wWRO3vEbaSWZSqwo1Ct7Nte8oVcya2C0f3ZQA3mMBTx7xggL7w5HcBdhJ6O3rE7003LRm2mhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=T9ge20qv; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="T9ge20qv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1785317404;
	bh=SkSdi1iOk2GfEPk/4Uh5tjQEm8/ssvlUo8t1a8ih3CM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=T9ge20qvQv6UvKIsItyYSXJ/zeUJI3XGkAGlhxNoR5btoq8Qe8aXFNgoBWl4Z0kXh
	 fNtQx2KUhh241jMmAWCJGT1wICga2FJExA7C4MSoZVSuPOalT1hzJazumou5UsE9+k
	 AZGzoYubkLfNgYo6i4e15fgjK8ExWKDl2VIfG4v0=
Received: from github.com (hubbernetes-node-2c3739e.ac4-iad.github.net [10.52.138.48])
	by smtp.github.com (Postfix) with ESMTPA id B323DA1331
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 02:30:04 -0700 (PDT)
Date: Wed, 29 Jul 2026 02:30:04 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1136408/000000-102aa8@github.com>
Subject: [bluez/bluez] 102aa8: bap: fixed the return value of GIOFunc
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

  Branch: refs/heads/1136408
  Home:   https://github.com/bluez/bluez
  Commit: 102aa8f4db1b3a666cf02e29dcf7704743cfeb5b
      https://github.com/bluez/bluez/commit/102aa8f4db1b3a666cf02e29dcf7704743cfeb5b
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2026-07-29 (Wed, 29 Jul 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: fixed the return value of GIOFunc

The GIOFunc should return FALSE if the event source should be removed.

Fixes: 322c39a64 ("bap: Start BIG sync after receiving BIGInfo")

Signed-off-by: Yang Li <yang.li@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
