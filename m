Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2971288C0E
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 17:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773943021; cv=none; b=BT4ekdold3SdMhJncdIXhEfYZRwERBOl7Kb5mRsTwFqGcNMj6ru6a89Vv91eSusvo8wQYWsPto+3NG3V+5hH8bVsWiuIabKTY+GBqIYZIxupF1oNpGc/XACWBss48Aj1LJlKianPnOblaqfq13R4ikbP/RbtSaZcZUcKKPB8dsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773943021; c=relaxed/simple;
	bh=vrLuHXP6RGs4NMz5W7MkPEr54aGn7B6hmchBy2MBcXw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AaJlMOhOFogOjzFAsy94Dh1wfngnX/D8/y/0xcE10Pr+u3NANXvrrAXC6JL1BpvtRcdFa8Hbw9NWVuxBUh8AMyxRg2Ofi/n4d+fG+bywrq81PgsaRH8G2btfUjcT54xSeqEYMJFZlCSbOLmDu5Fl1xTU4MmKr+60WPzbOZv7scA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=K//B2Qa+; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="K//B2Qa+"
Received: from github.com (hubbernetes-node-5ad0545.ac4-iad.github.net [10.52.220.30])
	by smtp.github.com (Postfix) with ESMTPA id 0D3002089A
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 10:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773943020;
	bh=QREDn/L2NFyhBHIMoPTQ/O3cPBgHuDtSjd77KEYPy5s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=K//B2Qa+pQ38m+oJtsTm4jumx/ujCiI4IMF9JAnG3Q5jsfI2TTWL9kD2vY/sp4LOF
	 es24eU5CVN9GUVDA/hfKdP94GOwDHv7kFMpDtE40HFtj/1/kh/xDRkPq4+aCeJcnHI
	 GdblwlJcrfGFFioq3oLD4fjwxgP4L+aHFGFHsEfw=
Date: Thu, 19 Mar 2026 10:57:00 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1069215/46937f-000000@github.com>
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

  Branch: refs/heads/1069215
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
