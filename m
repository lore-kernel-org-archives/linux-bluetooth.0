Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D603A544A
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 08:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451638; cv=none; b=un8Bk8lcforqLosyliZmWB8062hPBiiTL3jhaBfQk8FupFZOsBQl0bf6C1jkquXnQrkFMsfGTTGOLa4GfmLx0h8nxRKNi5p+pYNKZu/S0xXuG6JaXWahWbqiwkgU0Elet5+mTY6lsrz9KzlsxKx2exGcH9HQ4E2YMU+BNddLWNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451638; c=relaxed/simple;
	bh=afa3XV35Qcms/7LoXu2Zn57JsT0gG+BQggzF5IU4EEQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EF8LKlPvZCdO0mWoN9wC5mSNb57NS8OzSVVgY33DlCuUfvD2q8ZFJ0eYUG7S69FgFHqcb+BDBMBcamE3Kesa4yx/0VsBU/L5CtwxCsK3RrOs1WiyZakUcld338yTc7r7nA0l4Ot/JMBzb4C4uJqhQwYTX9m5QvPdhPYFAvw89k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AD8xXeJn; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AD8xXeJn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777451636;
	bh=iNDSbAAXQYfLz1L1LitY/i/Krsv770676EyE916pTiA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AD8xXeJnLHSJCDn7W5iydZinmYrX8nA6kW/2g03BmrknZKRKIqgN/c6oQk9mMT2re
	 ScTrjqw44IWxFYYzbUkfgNdJrMiT7D1iYZHah6qiz0Fb+ii00+dPqtENlkHWeiOMWX
	 4hTTboRw9G+iFKdi1sAeX+kMb6/0szlkVzJQ2EhY=
Received: from github.com (hubbernetes-node-2163ac2.ash1-iad.github.net [10.56.181.34])
	by smtp.github.com (Postfix) with ESMTPA id 9B581520C7F
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 01:33:56 -0700 (PDT)
Date: Wed, 29 Apr 2026 01:33:56 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1086916/1b866e-000000@github.com>
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

  Branch: refs/heads/1086916
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
