Received: from out-2.smtp.github.com (out-2.smtp.github.com [192.30.252.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69816411669
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 22:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042872; cv=none; b=aW2Y2BHaCJGFQC4vgcAJq7vozxUPfBV/lRNq7+rJ1faDeev9nWemO8jpXpaAjfhJscTJSBBGkTj4Qyb+tRSdRUQ1E3eAXhnMlh9NH/GR8R4LA9mGyL2u01EhwviqdEkUz7uD0t7xbRf/c5THpI/oRjOjyazqvpdEQsvrvP6+UsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042872; c=relaxed/simple;
	bh=HQdmkzM8n5DqypY/+lS7DOkxGdbJQ1y6MNz72EslzH4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BplbLdQKo2jPCuBBTE5hwU9M9UfEwq8tQzIqHdduXu2ctYkDHGJF8zF2m7tsu7H/XFd70Ks4g1yvdJ7Hb3AfHQBj6urmiD3qJyWna5IIiDoGQBuUEI1KPyspLmKBn0X1RjKOEd/uSv7LSgKnSPjZsO3Sys5XEe5h0V9YCrXwQiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=gPOKDr9U; arc=none smtp.client-ip=192.30.252.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="gPOKDr9U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781042870;
	bh=H0I78TDFfhqzOdjWGlfvbKcdjZx5JJeCqpZ1BsQFwjA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=gPOKDr9U9MK3JQLBrozeirmxfroGOkyyihq8lmQ11pLbHXoUc3MFoOJ4AN/5ZU2zw
	 WGyTWkKbFAfYzG1RXUUl7ZYwGLPyGmK/3QsYzvz/Rrl1dlgkjLPO/iH5i//eJvZyHg
	 +BWtJoGpT8hwWiP1k8rjFUjurdVngAfWrFiRknIk=
Received: from github.com (hubbernetes-node-2522e0c.va3-iad.github.net [10.48.134.32])
	by smtp.github.com (Postfix) with ESMTPA id 86F7F340457
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 15:07:50 -0700 (PDT)
Date: Tue, 09 Jun 2026 15:07:50 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108823/000000-cedc4d@github.com>
Subject: [bluez/bluez] cedc4d: shared/bap: Report invalid-length ASE CP write
 via...
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

  Branch: refs/heads/1108823
  Home:   https://github.com/bluez/bluez
  Commit: cedc4dee229747e0dbae75c6bc017e0e72aeaae3
      https://github.com/bluez/bluez/commit/cedc4dee229747e0dbae75c6bc017e0e72aeaae3
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-09 (Tue, 09 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Report invalid-length ASE CP write via notification

A zero-length write to the ASE Control Point returned an ATT error, but
ASCS requires the write to succeed at ATT level and the failure to be
carried by a CP notification. Build a response with the truncated error
code and return success instead.

Fixes PTS tests ASCS/SR/SPE/BI-01-C and BI-02-C



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
