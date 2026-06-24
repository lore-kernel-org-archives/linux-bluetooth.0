Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45433E2770
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 20:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334758; cv=none; b=SFzD0/510mie2awrUlKJEfaK/6UJvHneYoW4GHYiyQTGQNaC3EMXrN95odyevddYwndlEr0rr6YDqonLfppbUCE+Y+XxUagh/8GT7bXwfus3PJt5vJfzUhCAhmtUY6QjMly5yMm4ytGG1dr6wVibe4NK6nqT5ajDPRQc/1+N9Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334758; c=relaxed/simple;
	bh=TUdGbqjZmDpkeDc4LYHr/WR2wNSCUMB7YNhJYq77kUY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=jXv9eWQUwDVkUe/ebXW6u4/prvmv/e9aS2mDaRYq0U4Ja9LF+GeC1cIwEXPKifwHUmlO+qavoumEQtR696NzIVAgTX7tGcZLrd4JID1I2FFeGFNofFxy9bEl5pwaXVaIteJBjCNVJO1LxtsV4x+IkE7C1jLEGs5AkYGnZLmwyKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UN6f0NxR; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UN6f0NxR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1782334756;
	bh=RlU+8eWJKo0RjqGKAhe1fRvd+XgESHspF4/Zg8tlROM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UN6f0NxRKxwDXLfHuMfoIGrA/LxUNskBwIvSg+hgeVO3C5kWMKy4RhvmH8z55QWnF
	 wTesI1Y/ISqbD5GjUpXEpm8kXZPSMQJIVAMZKsp7d3LgKAU3WXkgHObYCJBS9baont
	 K+wjJ/b8GollUDkqUPqB0uPagiDvAk9CagToUyXA=
Received: from github.com (hubbernetes-node-eeec014.va3-iad.github.net [10.48.171.27])
	by smtp.github.com (Postfix) with ESMTPA id E23A5281288
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jun 2026 13:59:16 -0700 (PDT)
Date: Wed, 24 Jun 2026 13:59:16 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1114334/d6996f-000000@github.com>
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

  Branch: refs/heads/1114334
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
