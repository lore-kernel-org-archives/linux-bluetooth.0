Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E626175D53
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 15:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787844467; cv=none; b=kW7KTR1xLFgrGDEM/gtI64VPmJ+Y/DOTtVN6WMSTY2Oo52uKPKg1YuxpIgHqVeM/uNYwWS8bo5pjt6EmCeictXL0x1iKRVkS0ciESDb/+4pE65RC+00XyXPje73VXd+/MPtXpN/oMQR8+DvXm1QA6SybjWA3XvwVv9CRA5CyEJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787844467; c=relaxed/simple;
	bh=2wHJBSyBWtIqVWPJUZgJI3c56QO0m8rXWfFJqrVeLRo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=GiucspAT3Yazi20cqft8vra4TrNOI2F6m0gfoJns+whdSTiOMcGB8QqeRXGZhv2fxfNO1xDbmu45AkhjUFkDnyofUza5AGl1dZKXf1EEq9QnKcBQNUgxHqMkqTgeqvNkc6ec6WoT6+Jzu6nn1iaV2bm7PN+IC8fKXk7Lr4DsCoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NZeaBnXn; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NZeaBnXn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787844465;
	bh=M7POaDjTcCbXnkya7pjDq41heVKTtomCMLDkPmI0VKo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NZeaBnXnR3lKrdIAX8zYMlrSS/NLbW98WsiLTt1Out9QvAcfhXP2ZSBlQjvIEKW3T
	 WBVzKfEmKxCW6xfIuyzgBR8ZrHCgoXF6Rn1CIZpuKYUPmpkPefD3ryx6FG/KRNU+Nd
	 cU7mLecGUufz43DWEbPgHjJgPwBBXI8/1zCBgtYg=
Received: from github.com (hubbernetes-node-31e80f5.va3-iad.github.net [10.48.81.64])
	by smtp.github.com (Postfix) with ESMTPA id 9C408801176
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Aug 2026 08:27:45 -0700 (PDT)
Date: Thu, 27 Aug 2026 08:27:45 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1152525/000000-a0f261@github.com>
Subject: [bluez/bluez] a0f261: gobex: Fix ABORT response being discarded
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

  Branch: refs/heads/1152525
  Home:   https://github.com/bluez/bluez
  Commit: a0f26144ab32f4f10e0f1b9171e212e86f459f17
      https://github.com/bluez/bluez/commit/a0f26144ab32f4f10e0f1b9171e212e86f459f17
  Author: Jinwang Li <jinwang.li@oss.qualcomm.com>
  Date:   2026-08-27 (Thu, 27 Aug 2026)

  Changed paths:
    M gobex/gobex-transfer.c

  Log Message:
  -----------
  gobex: Fix ABORT response being discarded

g_obex_drop_tx_queue() in transfer_complete() clears any pending tx,
so the ABORT success response should be enqueued after transfer_complete().

Fixes the following PTS test cases:
- OPP/SR/OPH/BV-27-I
- FTP/SR/OTR/BV-02-C
- PBAP/PSE/PDF/BV-06-I
- PBAP/PSE/PBF/BV-03-I

Fixes: 7a35c12a6ceb ("gobex: Fix segfault caused by interrupted transfer")
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
