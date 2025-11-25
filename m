Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD1A2E093C
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764064191; cv=none; b=fo8S6Edyc0DbKu8OIMKvHRE7hebIAiLdrXSqLT81IKtmG48neStt/qW1D0+uPvdsp2GlO/j1+SM/p6kjh3QVhYY5EGHLgUFTYr0uK/f+UC53zshfgDU4gRUjyLt6EobJ7pIWw8Ms/8tdzOLzO6T/85g0Akts5BbWrFg4k5npP0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764064191; c=relaxed/simple;
	bh=+sjVe5CEp2ayml2pXkuq4MMKVaROYv7FB8HaEE+XdXA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hNodD4zWBWWO3s0shtxgPyUVdfKO0ybpEKwAWf7g8JG4AWevI/WHKmL9kBexStOlVQAt6g5YJ9I5F1jgD4QKo9ox2jGbeOqaImQ/zZLvpCWZUuebyDeOKjP4JAql0WRyAgIqvqBsFiz41bF4HpkH4+JrHMJsTgTB3OBDFcbKo9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IZrwzkse; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IZrwzkse"
Received: from github.com (hubbernetes-node-41d45f5.va3-iad.github.net [10.48.206.75])
	by smtp.github.com (Postfix) with ESMTPA id 476E7E0D76
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Nov 2025 01:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764064189;
	bh=WEJpdWfFHhlPZ0jVxwoERHNKwGbLyQ8Ka4eP26dzx2Y=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IZrwzksew4lrFzDHpeE/hCF5P6MFYok2TBgEnyO5Tbb8D1heHJCELM57VtSmEBfEo
	 s0lZd4jkk6AW59c35XG8vv8tnxpnB6L5QUi57Y3ixHYNU79hDi/aMl4eNOe3n05YuY
	 AzT5jevKs7IRzOy7dcpGmtdAK70mobBQA7B0fOSw=
Date: Tue, 25 Nov 2025 01:49:49 -0800
From: Kirill Samburskiy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1027279/000000-a7a5a3@github.com>
Subject: [bluez/bluez] a7a5a3: obexd: Always flush tranfser status changes.
 Set s...
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

  Branch: refs/heads/1027279
  Home:   https://github.com/bluez/bluez
  Commit: a7a5a3e1cfa6d58fa6013472c1bae341085c1a7f
      https://github.com/bluez/bluez/commit/a7a5a3e1cfa6d58fa6013472c1bae341085c1a7f
  Author: Kirill Samburskiy <k.samburskiy@omp.ru>
  Date:   2025-11-25 (Tue, 25 Nov 2025)

  Changed paths:
    M obexd/plugins/opp.c
    M obexd/src/manager.c
    M obexd/src/manager.h

  Log Message:
  -----------
  obexd: Always flush tranfser status changes. Set status to queued before starting

When transferring multiple files in the same session, obexd reuses the
same obex_transfer object to communicate transfer state to agents.
Because of that every transfer except the first one starts with its
status being "completed". If in addition to that, if the file size is
0 bytes, then the transfer status will change to "active" and then
immediately to "completed", but only change to "completed" will be
signaled through D-Bus. Such status change from "completed" to
"completed" is invalid and can cause issues with some agents. To
resolve the issue, always signal status changes, and set status to
"queued" before starting the transfer.

Fixes: https://github.com/bluez/bluez/issues/1683



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
