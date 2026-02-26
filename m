Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03F5A428828
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 20:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137265; cv=none; b=FhGxOqPVOXfHLvg09ZtDPOp6LSqo/BUMKP4XXC0PNTsP6ALkdJWuu3mTI1V334Uw0HJ3YlGf1+gGQs+qvawlgGbIKwMdIPjUkqJL+bZ+qgWLseCToo9IYhvKok7yxXomxBiPb35ejq9mv/hshUo4pgGPMOfrFRn7YyrhVqakeRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137265; c=relaxed/simple;
	bh=elg6uY3ykrY0ZexxaxRBdMcTm7VwRCOP3o5B6Xh/z0E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=huAqH2+Yx9DnDZGIAnLDzcbNql+MWXVetMbAiJ/nfBIR/VPJcEwT3xMjmBPYjj/n5pF4vFvVsqtLEG3VTbrTPT+CECEOdJP+rrFReZMDrlOnFTRJ6aAqAKABH5N/CIAbCUlzBrgjdhARhhrExwash7R5ZBhe74EOuf8OqL285T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=f104jvwJ; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="f104jvwJ"
Received: from github.com (hubbernetes-node-7df5d9e.ac4-iad.github.net [10.52.85.50])
	by smtp.github.com (Postfix) with ESMTPA id 3027840134A
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 12:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772137263;
	bh=7r3o9e3/N5YhlvblvKP3rzKCMcYaEQkEJliLGuE8m+4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=f104jvwJx9+1wABmcUSq751Lwl8W5AC2MFHygg2mxlDx2zLt2wgmqwux74k3gasOg
	 oSeIC6r58kbnQBejdjd42Ulx8Uh+y4JPFgb+G15t9GAzbjWgfW3cCkx17SMuNeZa5I
	 PYt6k0peVFALqTAqopu6fhFKrehXREhF6FrymP84=
Date: Thu, 26 Feb 2026 12:21:03 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1058640/000000-63ee6a@github.com>
Subject: [bluez/bluez] d94844: hciemu: Fix silently dropping packet if writev
 ret...
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

  Branch: refs/heads/1058640
  Home:   https://github.com/bluez/bluez
  Commit: d9484420164c5487b35b696bb5e97e3f0a6d25c1
      https://github.com/bluez/bluez/commit/d9484420164c5487b35b696bb5e97e3f0a6d25c1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-26 (Thu, 26 Feb 2026)

  Changed paths:
    M emulator/hciemu.c

  Log Message:
  -----------
  hciemu: Fix silently dropping packet if writev return -EAGAIN

The code has been silently dropping packets due to lack of buffer
since hciemu design is single threaded it cannot do partial writes
or flushes to force the buffer to be consumed and give space to the
next chunk, so in order to fix this the code will now attempt to
detect if a socket runs out of space and automatically bump the
buffer with use of SO_SNDBUF.


  Commit: 63ee6a0a5629453243dff7477fb127de719e3414
      https://github.com/bluez/bluez/commit/63ee6a0a5629453243dff7477fb127de719e3414
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-26 (Thu, 26 Feb 2026)

  Changed paths:
    M emulator/bthost.c

  Log Message:
  -----------
  bthost: Add segmentation support for L2CAP LE-(E)CRED mode

This fixes the following tests since the kernel now attempts to
check if a segment length is bigger than the MPS:

L2CAP LE Client - Read 32k Success - run
  Connect in progress
  Client connect CID 0x0040 handle 0x0001
  Successfully connected to CID 0x0040
Bluetooth: Too big LE L2CAP MPS: len 672 > 188

L2CAP LE Client - RX Timestamping 32k - run
  Connect in progress
  Client connect CID 0x0040 handle 0x0001
  Successfully connected to CID 0x0040
Bluetooth: Too big LE L2CAP MPS: len 672 > 188


Compare: https://github.com/bluez/bluez/compare/d9484420164c%5E...63ee6a0a5629

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
