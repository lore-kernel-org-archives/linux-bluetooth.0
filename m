Received: from out-41.smtp.github.com (out-41.smtp.github.com [192.30.252.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD18C41A93A
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699195; cv=none; b=tCxp0GXJgXzRMUl0KcSdHxI1RHZBJZnKuuhQjGYOVyqgLq2/wdryT9AfYcjA9h/z2YJfSTEs9RRDsAiIlItnqCfZ5gXiVby7TM8QtJGy12Tp9IkRskhUNDo6nT4pBmsJCYBkaSK3x0A9bHR686gx92iMszaY48T83lIOt32j+So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699195; c=relaxed/simple;
	bh=qxpEu1+9KeFIqmrnuHwurZgNyIyZiOEkXbYKGPJjDMk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=og/LyBcL5DTm4eWBvjLVng1WVJvPT0k9RxfTmwZr6HowjoeOFzujLWqJ/He2JTibxMTrL3hypUuG6O6q7PPZIb02Z/Amhgs2r+XQEqFHS8Hq66KGZ23vGepRkS4Lnc3PgFGh/FTBaf/aMR7/oya9PUhP4mtKiy+Wu6WH24ALDbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YYVqniIn; arc=none smtp.client-ip=192.30.252.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YYVqniIn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786699192;
	bh=6G1tsJaBhByEfspmRu/sATb72HssIQY7ZnNsMV2nIUw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YYVqniInmt+ah0TXVvrvi8YgJ4FlBEbya/dKpKShFtaQdrgS6r1e3LYnlKt6FeM+M
	 taF/hep03bAUluNFTqk1tlzDrtQKIl9qu0vp5H0hhSRskgEnpju7GDqUxlCQicqSzb
	 0BMNnRPdkS/E89KixGCh/+jcmnUtm/+MY4puWU18=
Received: from github.com (hubbernetes-node-66b6fdf.ash1-iad.github.net [10.56.184.43])
	by smtp.github.com (Postfix) with ESMTPA id B546F840E2A
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 02:19:52 -0700 (PDT)
Date: Fri, 14 Aug 2026 02:19:52 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1128002/888d3d-000000@github.com>
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

  Branch: refs/heads/1128002
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
