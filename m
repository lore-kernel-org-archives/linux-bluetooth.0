Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCDA23D7C6
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 19:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760038956; cv=none; b=HsNugZ7Y2zqoP8JStbrhuhrKPcg7xDzgFmvKgx7a/jV2C0tZqtTQQvTu4TfAv6QzUe7ZzNwqGDA2Ez4WRbP5YCAlDcXcaQnAk02FmbdcnML6LPRHNs2irOSpzlHJY+qmxba2XjjppMeCM57oWDSrmQ4mLeIlpBEerzLA1dkv6lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760038956; c=relaxed/simple;
	bh=SL+WKobEbHKGJ2sXXBO84lIqRhZAKOKv0+l2Znqj1l0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=T3c4pvTytTIgBD5wk302/LSv43eu8kjAlMOOylQRxlACc03s0qb/3oMHvkEQwocE2pKHi6Zz4G3SCUWhkvs9NL14In68zFcnUpKZ4i/GV60YC3p/eYVJ8zbzbxmsXGR8N11cEWd+TOC91gzJeJ0BISQdQvH0CuOi0VaHbwC619I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jkbF/gwO; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jkbF/gwO"
Received: from github.com (hubbernetes-node-0f984b9.ac4-iad.github.net [10.52.13.74])
	by smtp.github.com (Postfix) with ESMTPA id 19980401105
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Oct 2025 12:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1760038954;
	bh=ItsyHtkAhEhNfl4u9Shp6SMcqRmgK/XTZp6/i+j4FiE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jkbF/gwOzS/9T1QYeB+WZh6eU9Yh7ElfWC5ZhX7p8rw79BY+QM+ds0yXpdhyRKNAt
	 M4/BWDV1WfcqUbo/71+2pxlIW60nd5b99CIPxvqr+k0llX9s64meI7A+8gVc4KEM//
	 jScIzLCcnbmP8hJ2w+aBVa4OXOReCNbCKUCvlR3w=
Date: Thu, 09 Oct 2025 12:42:34 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1009611/b659e4-000000@github.com>
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

  Branch: refs/heads/1009611
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
