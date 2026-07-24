Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18579421233
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 10:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784889434; cv=none; b=oyErCS3PPs7t+r1NcFAExrL7FkEqqA1qKczTTUyndWNzCLFEDSgJeXZGx8191TcSuuFwa6MAr1snI1i15iq77Qt5F+BNzVbGcWLAx8D18ApZznB5wAECckyDgWDQmNcPhLs8UFegsvwFBintfImUmOOYr1CGSvb2E7ToCBTwQ6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784889434; c=relaxed/simple;
	bh=CwKdVSKQlbzAL5vcVMaHwtBymz8KnkIRW6wAVFQ5Qho=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Fp3JCjKT+z2wtk5Mg/dmd8rESV4UFIEzweEnu1FLLCYb3fbOS8ALZoFn96MYIPEGZr+iLPYgUvQicjLOfr/wAZn1S0A/GL4Z/32DfzlLQLqLTRrTPhNoyK3ExmLYZFsi4sNAggHUxYHOydG96iHe6LcrYsnIzZvEpW+RP02qrS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=H8l2Xxkx; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="H8l2Xxkx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784889432;
	bh=oy5xTjJuLTBZBzpgB9L82qdb/EbwiAoYcYhalIvvtOk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=H8l2Xxkx855qJTpuGJpdVTTINEbDC5u7uYARX0ELS9ki9Nf2RYHZ0RHcW0Z8UMwD7
	 yGw4qTt/etcj2cJnTgFoEBMChhPirIPkAHbb43DyVCfPIj9ry0O+pQdDwM2JQsWuiF
	 g6luThZBsw+U1ZzVeO7KzB0C31lTbtu4XkVh+V/A=
Received: from github.com (hubbernetes-node-2e6a5c4.ash1-iad.github.net [10.56.196.58])
	by smtp.github.com (Postfix) with ESMTPA id 271F3180C30
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 03:37:12 -0700 (PDT)
Date: Fri, 24 Jul 2026 03:37:12 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1133845/000000-31c0e0@github.com>
Subject: [bluez/bluez] 31c0e0: bap: Start BIG sync after receiving BIGInfo
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

  Branch: refs/heads/1133845
  Home:   https://github.com/bluez/bluez
  Commit: 31c0e034141e0066a32bdf19f7b29194393c03a5
      https://github.com/bluez/bluez/commit/31c0e034141e0066a32bdf19f7b29194393c03a5
  Author: Yang Li <yang.li@amlogic.com>
  Date:   2026-07-24 (Fri, 24 Jul 2026)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Start BIG sync after receiving BIGInfo

The current implementation starts BIG sync before receiving a BIGInfo
report. According to the Bluetooth Core Specification, BIG sync should
only be initiated after BIGInfo has been received.

Starting BIG sync too early may cause unexpected controller behavior.

Trigger BIG sync from the BIGInfo callback, following the same approach
used by the short PA flow.

Fixes: https://github.com/bluez/bluez/issues/2345

Signed-off-by: Yang Li <yang.li@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
