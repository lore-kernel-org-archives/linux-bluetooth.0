Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4FB2D7DF8
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 19:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591461; cv=none; b=O395qmksU8WL8bDdU6Oo/tGKkPf56JmogCZgrskZ030/WXzsniJpZXXN71QT20jwtouiGaBKQy7fwW34l7bWTa7v8dlA+pYbi9bMePwfuAjgU9ixE36PS7HntqvkCO1EvFCeg25VBRIAHvl4BYT8kQkLpc1xoBHdTKv9kCPkNq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591461; c=relaxed/simple;
	bh=s0Cc+60CUacJvC+cHqGlRZvMrwySbVaTgvatJ4cAlig=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WOgn/x7NZb4YpH8RTtulNd6uexCD42TM0usH5AeM4KXyIfihNApG0V+oZYhAmfuv0W15AmKbrR0r7ZtSDmi0593/p0MyUwUs9+2EJkERx3qxBhMTQWSQ2slXZ/5/uwVvaWExVexxezqJeT4o0cLQUMOXBB42FzrR5B5xf896fTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=K9R7ZWA+; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="K9R7ZWA+"
Received: from github.com (hubbernetes-node-039dbaa.ac4-iad.github.net [10.52.220.62])
	by smtp.github.com (Postfix) with ESMTPA id D210E21051
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 11:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768591459;
	bh=5ICBIAQoyeXaSggIOEtn/OKexnf1r5uhY+MwzTECV5E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=K9R7ZWA+6vLSzMwEv8NBEVFbsw0Z2kkTjpnLbgyJF2wjyN7ii37jJI3dRE6ZSkqH6
	 Hc0BuGTPvcs0Sy81tX6buwgVVuwTFOAn2imMIKjnxBh0yuBSObhEBPycHHhJOPBIKC
	 qY8qNP0lbvkW05VdxGPVH/s4MS83aELS+s28DdpI=
Date: Fri, 16 Jan 2026 11:24:19 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1043486/000000-fb4afd@github.com>
Subject: [bluez/bluez] fb4afd: shared/util: Add missing entries to
 bt_appear_to_str
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

  Branch: refs/heads/1043486
  Home:   https://github.com/bluez/bluez
  Commit: fb4afd03e486052c5f160a19e94e07efbd99cd64
      https://github.com/bluez/bluez/commit/fb4afd03e486052c5f160a19e94e07efbd99cd64
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-16 (Fri, 16 Jan 2026)

  Changed paths:
    M src/shared/util.c

  Log Message:
  -----------
  shared/util: Add missing entries to bt_appear_to_str

This adds the missing entries to appearance_table to it can properly
decode appearance values as found in:

https://bitbucket.org/bluetooth-SIG/public/src/main/assigned_numbers/core/appearance_values.yaml



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
