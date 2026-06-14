Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA68F35836E
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781438926; cv=none; b=NiQZsCA+TuNNIGOj5ht6WspF+lKOF690XxUIf2sRl6vXG8nGty92Pe0ZDqvPR5u3UUGmgNd1rT3DsB8hOH1sOYuTPiR9ujnwdpShfFFZPuvihwjDiEaa16yFWITlxK27KVIu8DpRu1fgksv4Nx1+bCfD5yZhz0k+JszmpWaRgWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781438926; c=relaxed/simple;
	bh=08MHT3i1YXdCHKeUzsv0IkBShNyyJBYVXy1JxoXtje8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RKutskfDYZ+cqxhn9gj24itRBql5MnV9CGo3/adrXxv6/F4ATSll15Kg4HFYJjfSTQfJx6KBpKDObelSWzWE+VPM5UJ+lXfh9gj7eZ5uY9o8njG6dMUDLVDIqwfF8sozBAy6+dfaBuuOsEPsrWWgibKiqHwlJ7r7yQfuWnvIJk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BS3SX13R; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BS3SX13R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781438924;
	bh=Ava8+lGLr6dYQc1DBZqGAf0hcx32bIsHPWN9kTLvl7U=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BS3SX13R8nlyu6OeoD7G3UbnacljMo9OQrKksl4d3yi/46GwZJx+H3zLcwhDyFuEZ
	 Lsxp93Z3GNTEZ95tBP0AMSiSm0QmWnvROm5D9TJ1iY7r9/mecRFNrlJY1kUUf3O4Lz
	 vILSQOkmgXYHBIqMKRCEuV3Qt6N+b+rV0mN+OOzE=
Received: from github.com (hubbernetes-node-3e494ce.ac4-iad.github.net [10.52.210.53])
	by smtp.github.com (Postfix) with ESMTPA id E6260780B6A
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jun 2026 05:08:44 -0700 (PDT)
Date: Sun, 14 Jun 2026 05:08:44 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1096011/59e580-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/1096011
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
