Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4742D63E5
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 Aug 2025 11:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756034652; cv=none; b=ZmUY2KbeG2brOK4YWNPxo4iXFv2hLKf7J80oK+Zn9u0UhMRgFAr4pze44QUq/VVHjrODiRXlatXCmGHLHC6zrrsD1fjv0HmExPiLQGM2DnPNJ/fc23R8SiEq4yrZKyyGZ2mq3pKc5rfe8VVIX2/xeG4rHlqkquOY0YSULwXx15A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756034652; c=relaxed/simple;
	bh=LB/QPKLwesxENk4E4pcLvU4A47BO4Rkvo/n+Mns8OQA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JreLT8HbOraHrROWJcIYrKW9VpfL+uRAO0nWGkyBvISYztzqz7f09ESyjsBb3/B3t8nw6U3YLAnKAGz1Uiollvp1Lbp7gSm2yKHYmE/KYfrx+funzoFvR5fvJAPqhcRYGuVnM43ZPrgMubZUfO19qTXiFkpI/7F/nrZu2FiaiT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WDaWoP/H; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WDaWoP/H"
Received: from github.com (hubbernetes-node-2628f34.ash1-iad.github.net [10.56.158.33])
	by smtp.github.com (Postfix) with ESMTPA id 67E9A920968
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 Aug 2025 04:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756034650;
	bh=7bpU5AZtcmfwIihhVE9msJ0OwND+WUzApkIXNARSTK4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WDaWoP/HPqMtL0rbWt6q4nKG55ivl8pBxxwQq3VtkExXLHh5TRJjMjYWmfBc55wHH
	 837cmpqPFrVPiKSosGvObwDVtMdWJ9eC8n+80kL2VjN9JPUf7o5KtRlhSteFjiiLlC
	 o7zvOca4XPhYp1QbiCwzANPN18t0931Un9kE1O+M=
Date: Sun, 24 Aug 2025 04:24:10 -0700
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/994927/000000-0e1ea3@github.com>
Subject: [bluez/bluez] 0e1ea3: lib: Add Bluetooth 6.0 and 6.1 into the version
 table
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

  Branch: refs/heads/994927
  Home:   https://github.com/bluez/bluez
  Commit: 0e1ea3941837979239ba4197dff9881b88704b50
      https://github.com/bluez/bluez/commit/0e1ea3941837979239ba4197dff9881b88704b50
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-08-24 (Sun, 24 Aug 2025)

  Changed paths:
    M lib/bluetooth/hci.c

  Log Message:
  -----------
  lib: Add Bluetooth 6.0 and 6.1 into the version table



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
