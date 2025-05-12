Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EE8293745
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 16:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068944; cv=none; b=kuQZ08xyNmTVj9iIzkKOTzlsZH9jiG0j16kPCoFg3g5jljpjgeChG4fJYu3xXVFMrVf1f8MOKdqEYxxgfgVKUvO0mshQQpmoOGVVgHqTvM8XMyS78CRS0cLoe1Gu8NLcr34Ix7mgn9cYJWP5tFDCP/drpz0Ism6oj08dSmyOIO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068944; c=relaxed/simple;
	bh=Hfvw+zxleTmv0SiPje2ZeIpgsQpV/L8pUwFQA/V0Pq0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=irnFvXNBo84Wk9WRoNPaZsLvEemhikaS5xurVq3Ot8P61f5CtD9t4XzVLRbY7W8SDvpky1Xali+rMRBb3NenlO46SN50imqiwQwZwBOpPd37d0uhkSm7gcbznJKd/L1NOBKjd+Vgs4Y9sm8o+BS7FXq+WnN8esfMB1adzaycxtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=h5p80JxZ; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="h5p80JxZ"
Received: from github.com (hubbernetes-node-b68fd7e.va3-iad.github.net [10.48.184.54])
	by smtp.github.com (Postfix) with ESMTPA id 14AAC8C0C1F
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 May 2025 09:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747068942;
	bh=P9l0b+mPON3noKSd4nqe6A5wZIjLaqlCzXcHDHt4PgU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=h5p80JxZH4Q+47f++85bHW2dkSozoKgcFh/KEBD5TZQxAuhy451nl8xp9XxtwpqpS
	 yIlAmiQ4aU1rrZGu5T20t/c7n3EpVsReIzuicrFkOqKGJy3k80HSk0w2I45PK525M4
	 xueEPh0vbWtpwNgeQ8dLxOhTJax4UsV5ju52CP/s=
Date: Mon, 12 May 2025 09:55:42 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/961533/31e40b-000000@github.com>
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

  Branch: refs/heads/961533
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
