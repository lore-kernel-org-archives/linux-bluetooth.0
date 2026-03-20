Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE2936E480
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 22:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774044874; cv=none; b=qLHo4+lrkIl/dXb4XUJJeZ37LDQoEalqHo6q1scMCOZr+cOizmpJ5x9Nv7inMv0WuSR+nz30a28dUJyDfxeOpD1nFZfIntT3uDV2EmjzZXe4D2hvjyT1TDgZk3mKVNSAvE0VUevOn/D/Pf9W9SVttVZKh7RMZqxS6vKBba0y04I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774044874; c=relaxed/simple;
	bh=qc7TIPqRfIKgWmCG1WqbaNiB5Wdt3d1Rwp+y3l6gU+o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oBRoYNzWwSU0BXZWRK4LV72wYr3muk8ndmx4ha+gvVK3wTfJTaxGHwInKGec0oFlH8KTS0WB1wStx/Zx0d7JgzJs8Vi5+0NMr5AltXTkKo4Ke4pnSaVHYqTk6015+2Fs7VlWmc5EdECXx1zVr2k2MpdzuHLvWCmNvMOBBaoHtqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EGNjheQ6; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EGNjheQ6"
Received: from github.com (hubbernetes-node-d498343.ac4-iad.github.net [10.52.146.37])
	by smtp.github.com (Postfix) with ESMTPA id DD36E20442
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Mar 2026 15:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774044872;
	bh=3JJkiK5lbLd0QH8wyxYLvKaNHmd7RGU57DJIV3/d3To=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EGNjheQ6YbXxRTeTrxw+jZxnfl0fDOleke9+ajO5mBvYI3rRNSOBbQE0SGZE+xN4q
	 eyFNwi4FOYAxFKl1L28LZ/HiVTG0vO4LOcEZQaiK4+5Ca6kFZ6pq+eTBByHK/RuzOs
	 y8TyKHqtq4w4p2PhA/WrASNCZJjaFjPJuxwzL0W0=
Date: Fri, 20 Mar 2026 15:14:32 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1059428/feb53f-000000@github.com>
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

  Branch: refs/heads/1059428
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
