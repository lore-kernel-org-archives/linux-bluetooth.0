Received: from out-31.smtp.github.com (out-31.smtp.github.com [192.30.252.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F98B47ACF8
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 11:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310111; cv=none; b=hJ9CjEgCJhkb4oOm3sAdu2wTwfrx+RiQYXOb8KGAqO8FWdNnAZ808SLNIRBDUSkR2YTcu6tLefn2XLts/DcMwG1GoVAXs4ZCT0pUWle58hAALICDx2P0+iXVkedBJ0f3sDGhDiVla1/CnOb76O+AcXwYLMIz1hxb70uvlPAbNjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310111; c=relaxed/simple;
	bh=Ao4wmhcEveNLQtwjh7dEDIALcc5qJdPP50lytrbtPLc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=p4vxo77464ru46jCJosaUSi50dFHYyMlXh66TSys+HuHeaX0TuS87L8GHw+/cHJr2OBmC+w5rnRlKgaNo5Xm5Age1qFfoMAsqUQfyZzJkw5Q7s6SPp+CPlckRZ0AGQKl4iV5D20mVOOPDmreRTOrpEa+h7gOjjSWUB+dnFCIH6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JyaywrsS; arc=none smtp.client-ip=192.30.252.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JyaywrsS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787310109;
	bh=g+d1t90tTYG6YqTrAf1BQHGc9o0KEsD6lx9dT9HrcQ0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JyaywrsSW5dGfu7vfI4fB0uocOHWOwXH5qZZ4pcCz2RcCA0L/ukmt6T4+1SZM7r+d
	 UKUDDwQD9tkZYB2yQvn5Huc+UZtARrKdj0jjm81M29KcjqzMYwducDj6Og/dE0qKI+
	 GhU/iZDU03tYWt+4qgsNoh3CK/yg71enJdvVTSPk=
Received: from github.com (hubbernetes-node-696a913.ac4-iad.github.net [10.52.181.48])
	by smtp.github.com (Postfix) with ESMTPA id 666FF325AAB
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 04:01:49 -0700 (PDT)
Date: Fri, 21 Aug 2026 04:01:49 -0700
From: hudsonzuo <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1149710/000000-e76177@github.com>
Subject: [bluez/bluez] e76177: gatt-server: Fix integer overflow and 3 CI VLA
 wan...
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

  Branch: refs/heads/1149710
  Home:   https://github.com/bluez/bluez
  Commit: e7617711ab38c02df60a53a3d51f5ca3c84909d6
      https://github.com/bluez/bluez/commit/e7617711ab38c02df60a53a3d51f5ca3c84909d6
  Author: zuohsh <zuohongsheng@kylinos.cn>
  Date:   2026-08-21 (Fri, 21 Aug 2026)

  Changed paths:
    M src/shared/gatt-server.c

  Log Message:
  -----------
  gatt-server: Fix integer overflow and 3 CI VLA wanings

By using size_t for realloc len and rejecting allocations exceeding
UINT16_MAX , to prevent truncation into the uint16_t field.

Fix CI warnings: Variable length array is used, use malloc/free instead.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
