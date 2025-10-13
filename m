Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B412D8371
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381587; cv=none; b=WEfD9h8/lLoPEMMSWXfsFRbEflNtx/I0pfCZnSgBngxwDT5xKDk3O9AI0UTRxw/3/bztesQnlzYW8JsAPwwUhjhqhdydPeCWRvny1FtMZ7VKbP9KRVVqIvwDgb0uOPJLpDNW8BAww971xjpGUif3g6Xhb21Bs7nC6JrsWzXwbm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381587; c=relaxed/simple;
	bh=ghrbq/8xIScG9XuXcwM0OsQ5gugayGj9Vc8hk7tK+yQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kh/ukDDVfGu92fn3Th5Vo+BbGyfjT+MShaC/+AfAwZVTSUliLedNXc8K7nlTRuSs6oOducNgYK/IhmnlCJBIrU5sLQF0XxCb0rvEMENol7WIPU7WnXntzq0BRSJRkLwFHXNnNQTRb/+MC5gRS5BxHp0hQeWkp6mROBz+4F9K2qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=h5U+Lq1c; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="h5U+Lq1c"
Received: from github.com (hubbernetes-node-4c48f75.ac4-iad.github.net [10.52.206.65])
	by smtp.github.com (Postfix) with ESMTPA id 96B12401255
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Oct 2025 11:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760381585;
	bh=uZNqWfmD1mSlWKCS2ET3SOaIgyX/+TgF7ZyxJxCq4Kw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=h5U+Lq1c0c3dcebnCFuqzIWaGGis8Cpd4/Bwu2dxpbTzn6j8BQG/J1vc7ioES57KH
	 NnddDoxyjyiBXVgq035c/uug8fjT1kSTWtIX00Lbqf0Qpv04Rs+U4ud2cKgVmKkMmE
	 cSRbWmIP1VvgHuqspWQeq9k10gMkQkRgpLnbtG+M=
Date: Mon, 13 Oct 2025 11:53:05 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9e76fb-2db2d3@github.com>
Subject: [bluez/bluez] 8f0aa4: tools: add 6lowpan-tester
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
  Commit: 8f0aa430bfb939cad6dff17c91fac7f8bf3ebec2
      https://github.com/bluez/bluez/commit/8f0aa430bfb939cad6dff17c91fac7f8bf3ebec2
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M Makefile.tools
    A tools/6lowpan-tester.c

  Log Message:
  -----------
  tools: add 6lowpan-tester

Add 6lowpan smoke testing. It only exercises the kernel 6lowpan L2CAP
connection handling, ipv6 testing is mostly out of scope for the tester.

Add tests:

Basic Framework - Success
Client Connect - Terminate
Client Connect - Disable
Client Connect - Disconnect
Client Recv Dgram - Success
Client Recv Raw - Success


  Commit: 2db2d35937997d6098fa89bd1945206a0d23beb8
      https://github.com/bluez/bluez/commit/2db2d35937997d6098fa89bd1945206a0d23beb8
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2025-10-13 (Mon, 13 Oct 2025)

  Changed paths:
    M doc/test-runner.rst
    M doc/tester.config

  Log Message:
  -----------
  doc: enable 6lowpan in tester.config and explain in test-runner.rst

Now that there is a 6lowpan-tester, enable requirements in tester
config, and explain what is needed in test-runner.rst


Compare: https://github.com/bluez/bluez/compare/9e76fb9f6ce8...2db2d3593799

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
