Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B63D529
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 May 2025 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285555; cv=none; b=sxhpXd/k70S4MVM77bZUkMX9/9C7VD1XGuEQlb7E1t3dQS/6PXSlx3ss9U9cPVNznwFDnbr+SyDe4sb0Hs1CMoAMMZWj0xo87CCGhm9iA70rr8Q9lyDVzY1OOi/LPiHoILuRFK7pgB0XTAgD2KTkALHU+dE3oKrf0Jp7/wVpUlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285555; c=relaxed/simple;
	bh=yZG0MOD1w6FEk1oeHT9w30eka6k7jNQrQ4ZVQAwKizM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OinFzrvGcbU6TQEbFcRricxC5gxnPmjvNI4hRUVr2poTEwB+1UqAEjpVzC5fMHqhZ8/mhw9Ph+MVuaEb+w5b8V6Zo7CnWh0roAOkRZf731GuM7mV/Ji9wCq0frvNvU8NJYxy1kKwAcjMlySqQaeoCb3pjqR4Leu9Gkr1mXFdKsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=USOEdihW; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="USOEdihW"
Received: from github.com (hubbernetes-node-2b794c4.ac4-iad.github.net [10.52.161.16])
	by smtp.github.com (Postfix) with ESMTPA id 1858320374
	for <linux-bluetooth@vger.kernel.org>; Sat,  3 May 2025 08:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746285553;
	bh=2Z2pcW5lBKU3z9OCvAfQjGkn5rjpTN1JnN6uSmBAlJs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=USOEdihWeqBXtEg+tSbTDXS2WG4R4C42KDmnE8STn1ZHG+dsU3N/3c1dxjYPfdJ1o
	 neF1O2geMh0LOFilQ6WSKGzqZCKweuq4bHdQm4K/lnATnc0GUWNATeQiBCLjXc+XVo
	 wcfvMyVanQC3XPEQh8tw/B7j86CfdojGPSP7k8vg=
Date: Sat, 03 May 2025 08:19:13 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/959339/000000-3faa27@github.com>
Subject: [bluez/bluez] 3faa27: shared/vcp: use iov_pull in input parsing
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

  Branch: refs/heads/959339
  Home:   https://github.com/bluez/bluez
  Commit: 3faa27fd30ce85d0190fe05a3c3409216ce456db
      https://github.com/bluez/bluez/commit/3faa27fd30ce85d0190fe05a3c3409216ce456db
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-05-03 (Sat, 03 May 2025)

  Changed paths:
    M src/shared/vcp.c

  Log Message:
  -----------
  shared/vcp: use iov_pull in input parsing

Check input is right size by using iov_pull* when parsing.

Also replace custom iov_pull_mem by equivalent util_iov_pull_mem, and
add iov_pull_string.

Fixes handling of zero-length string-valued descriptors, !value is not
error.

Fixes crashes like:

ERROR: AddressSanitizer: stack-buffer-overflow
WRITE of size 3 at 0x7b878bb77161 thread T0
    #0 0x7f878eee4821 in memcpy
    #1 0x0000009544d4 in read_aics_aud_ip_type src/shared/vcp.c:2713
    #2 0x000000950cec in vcp_pending_complete src/shared/vcp.c:2394
    #3 0x00000088b2ce in read_cb src/shared/gatt-client.c:2717



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
