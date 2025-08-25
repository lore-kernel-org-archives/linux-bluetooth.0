Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A4276026
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756137130; cv=none; b=AM8l2yCJojXxinTMVcywoZUZIJ/zKSc4vl1UZRVzDxwNkuBAeYyZEwG3SapFiA+KOilwBV5FjdAS6lthzw5Qt0UCIjJh5aKOFxNQjBmkwGWRWhkfLU3tbbqWAx/eZuuHytdeluZTK7FKBvJLdffrFG3k4OD8Q7+3wHuRk4Vu0A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756137130; c=relaxed/simple;
	bh=JUGVApeOk9sjJsNXExbeC+J5aMm7dzZHx4Gx3+AEf5E=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=G0bogTzJwfcj4hTEKLrJPOFgcLS31Nwx/7yskHztJrML2+u6ZWhSv3L6II/izvQP0mCLrIN/6h66pydvoxkSUlw5IIT3A4vjuf2kbub/k97CEz5U1s3dGFMWFEsAxdBDQ5pz6acBSLm8wGxiFcvOqMPOokfP6uop2O14gqHXjSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=e0AuPQNF; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="e0AuPQNF"
Received: from github.com (hubbernetes-node-7d8da62.ac4-iad.github.net [10.52.145.57])
	by smtp.github.com (Postfix) with ESMTPA id CF101700C87
	for <linux-bluetooth@vger.kernel.org>; Mon, 25 Aug 2025 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756137127;
	bh=3D2smp88Bxag2hEmobAVBGstgzXOBc8hO2jplkfAqyM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=e0AuPQNFNP4gYOnIOkcpCi6tsiilWWd4eik5//lxrLkJyll5CS4NeWLtkvyHJ17+V
	 CSni1NdQ+v4jlGvMwNS18jXmtZ2dqm4b9YIjWOmO/Cef30kjwdf+G+7tnlOHV/FE/G
	 OLC27eYt4XjwXDN5Wy9ttnsf3ppnDgwBH3Kt7KYQ=
Date: Mon, 25 Aug 2025 08:52:07 -0700
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/995294/000000-eb3c17@github.com>
Subject: [bluez/bluez] eb3c17: lib: Fix includes in installed header files
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

  Branch: refs/heads/995294
  Home:   https://github.com/bluez/bluez
  Commit: eb3c17668cfa15f3c0799f57918c32058e343314
      https://github.com/bluez/bluez/commit/eb3c17668cfa15f3c0799f57918c32058e343314
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-08-25 (Mon, 25 Aug 2025)

  Changed paths:
    M lib/bluetooth/hci.h
    M lib/bluetooth/hci_lib.h

  Log Message:
  -----------
  lib: Fix includes in installed header files

Every public header file should be self-contained in terms of used
symbols. To satisfy that, hci.h and hci_lib.h need to pull their
direct dependencies, so users will not have to include bluetooth.h
before using for example hci_lib.h.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
