Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85FA19F12A
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Nov 2025 16:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764175603; cv=none; b=CRQKeKC6e3mPs4kfxlf/Onu43UjYDJLlu7zS89z35O79mr4iTCEJLZKY19MNo0KQzPkPlY3ffJqcJ9LNkttaBobinAFf18wFV0JimLB8C31kLLMa9aoigULz8AO0XegnoyhcL9/OA7pOIeS/4d5YS5LZ299HMf6jYxuIU8yMwjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764175603; c=relaxed/simple;
	bh=VhwggqzHRHZb3589x6C+1N7cC8WAX8MGbx3d8dA/cOY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=t34lXgdZZGQBSJiHSGRbYCCyGrl5b8TmvGIiQmAQByr6Os+UdmBQRuRoi+tcAVFXCCUR9bnFxm76K/A4vU87Lqcsxfuk0CzRPsvxckC1PGxXYde9GJ6XgboTFSOOexzSIao9hI95UDZJNk3O6gcusGL9hA5FijpXX3GzT3ZxNlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=nGneHQ/p; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="nGneHQ/p"
Received: from github.com (hubbernetes-node-4d8f161.ash1-iad.github.net [10.56.206.16])
	by smtp.github.com (Postfix) with ESMTPA id D29DD920187
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Nov 2025 08:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764175600;
	bh=WrHCxhKiyZZUNQvnT2wIMb7zdH4XaQRJsHJ4mQlbw3I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=nGneHQ/pM+GBxasuN7ZQ+m++aEo8KHjWNefR37TyIwoLJ4bUm25zWUOWQHDC5Kqo9
	 SnhsZ1R8+B8lDQF73E0ca4SLkTqYhfqxfhIPI45od4bP5evIKwnbgXyxs3gc+ryAS8
	 DaM8AFCx/SH/8iO0Gc2xVujv4y7/u39AdsJH9gPo=
Date: Wed, 26 Nov 2025 08:46:40 -0800
From: Kirill Samburskiy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/0f56b2-d42182@github.com>
Subject: [bluez/bluez] d42182: obexd: Always flush transfer status changes
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
  Commit: d4218235678c29b52e5094e4dc5c7451bea9009c
      https://github.com/bluez/bluez/commit/d4218235678c29b52e5094e4dc5c7451bea9009c
  Author: Kirill Samburskiy <k.samburskiy@omp.ru>
  Date:   2025-11-26 (Wed, 26 Nov 2025)

  Changed paths:
    M obexd/plugins/opp.c
    M obexd/src/manager.c
    M obexd/src/manager.h

  Log Message:
  -----------
  obexd: Always flush transfer status changes

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
