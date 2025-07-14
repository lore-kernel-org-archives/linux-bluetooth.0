Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1FBB25B305
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 14:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752502908; cv=none; b=eMMayMLaBEKqZXrgrHNuqnlrbwHifAe8mS6hzo1oNTAvQ3qwf0GQcBT1wndxKSbnmb7bMVoTM8sxJ7hxefUyTeVB8Q+DZ0UIS9qE3AUdYw82mrTUOYH0a7LpVuBnEpSGUT6kKt9Qd9HNy8N7o1PGyB9eqBxjSXXC26oaLOYSjrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752502908; c=relaxed/simple;
	bh=uiWE5XldUwImcr3deKXWRkN3jM6nrvaTnofgTRyCdxM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=unMNwURYiXco0ut81K2tZRz7G2Z4ccq1TxU6n5vziloYGkgpXjx1yO1u4RJiHPcPX+rPYV3RqeHDa6nMH+6+50LMYyhmqUPgHRFVGBo+JcQjXb7qIBcgDYL9Y0YGj3TafrrTv+E8q1ZhMkldAkPVjdpZX0H6hvBfux3cfhzechA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BeohSHzU; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BeohSHzU"
Received: from github.com (hubbernetes-node-5c03966.ac4-iad.github.net [10.52.184.32])
	by smtp.github.com (Postfix) with ESMTPA id 9AEFB6411AE
	for <linux-bluetooth@vger.kernel.org>; Mon, 14 Jul 2025 07:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752502904;
	bh=a5WhFYp2HmDz5agQPHd1OmFVwW4/lWFp/klNYmM9Vcg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BeohSHzU9+fqNE6+acwlGgjcSNkq7U2dZ95bvxrlvF35OR+YvcYTigMhdy/bkbF5x
	 Ki3QbuhC1UwE6B2rzB7/R5nNV5QB8101k/4a/MRNYalF/2aqWt2jdt53i+sIfpfuuS
	 sj1MqzN6+5Ne0y1g0xdHrYKb8E/MZ/8voKsHCbP8=
Date: Mon, 14 Jul 2025 07:21:44 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/982089/000000-19c427@github.com>
Subject: [bluez/bluez] 2822a9: lib: tools: remove POLL_ERRQUEUE
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

  Branch: refs/heads/982089
  Home:   https://github.com/bluez/bluez
  Commit: 2822a98afcd8f0ced64cb28be9046f0fbad6e338
      https://github.com/bluez/bluez/commit/2822a98afcd8f0ced64cb28be9046f0fbad6e338
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-14 (Mon, 14 Jul 2025)

  Changed paths:
    M lib/bluetooth.h
    M src/shared/util.c
    M tools/iso-tester.c

  Log Message:
  -----------
  lib: tools: remove POLL_ERRQUEUE

This experimental feature did not land to mainline kernel, and probably
would need to be done differently.

Remove defines and tests for it.


  Commit: 1130a03286e9108f23345b48f253d0e246f44c5f
      https://github.com/bluez/bluez/commit/1130a03286e9108f23345b48f253d0e246f44c5f
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-14 (Mon, 14 Jul 2025)

  Changed paths:
    M lib/bluetooth.h

  Log Message:
  -----------
  lib: add BT_PKT_SEQNUM and BT_SCM_PKT_SEQNUM

Socket options and CMSG identifier for ISO packet sequence numbers.


  Commit: 19c4271953d20153600b4b46670ffceed2b61c84
      https://github.com/bluez/bluez/commit/19c4271953d20153600b4b46670ffceed2b61c84
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-07-14 (Mon, 14 Jul 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: add tests for BT_PKT_SEQNUM

Add test

ISO Receive Packet Seqnum - Success


Compare: https://github.com/bluez/bluez/compare/2822a98afcd8%5E...19c4271953d2

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
