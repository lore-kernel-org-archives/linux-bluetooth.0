Received: from out-7.smtp.github.com (out-7.smtp.github.com [192.30.252.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7753C09F9
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 18:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065859; cv=none; b=rs/wMOrv1cG26GUCNrdutaRvZYGf2634VKiemJwDptwHRITvc6gnBQVbBUiXmlPS8ls4/LNQvh6JVfPk4VBI+0Ks+oApE5MJlYJEx9Ddftm8iR3shhieJJhvzZ8p4MUGZvUip4zilwXIhs1S2TrVl4ETMhQYyKT+47Ylicg8v+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065859; c=relaxed/simple;
	bh=AfRluoRo4tpCnpPLoAF57LLCB8WJniLCzbmJfsgyd0o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IongB7WB5+ASj7CJ/iWNgXep9fWF8yX+3EzUBT+E9HocQYvAL4lkgh1N5DWeKpXAcC/IjOTZDqHizFsknPGqFGdu2U6zSRFnHNxEkaoVJVWr48b6o3HrMsAa/XQzrI8cy4UuVPCWdycpxRfrnQdHJ+1zOnycyjAH+tczqM0iKV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MH0ZpscD; arc=none smtp.client-ip=192.30.252.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MH0ZpscD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1789065857;
	bh=uAHrfaqCazRK4zd8GTGZPgfpQImn3W1pNHhOKHw0gbI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MH0ZpscDl/xO5xY3fs8mZjdgVdCOc84ZuO14cHldS2RWxuqj0qfJtNTypErsSO2Te
	 CcKdyLyBf5m3mPYev03QZUS/j4cNkSAtP/u2SyKtKkkIJOzW/PCJ6k4qZKiB11yE6Q
	 1CCN0Tg63fxv43eobm2Db3TOQPPuvkjxKnzUjsZ0=
Received: from github.com (hubbernetes-node-858389f.va3-iad.github.net [10.48.64.102])
	by smtp.github.com (Postfix) with ESMTPA id 533E2781436
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Sep 2026 11:44:17 -0700 (PDT)
Date: Thu, 10 Sep 2026 11:44:17 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1146603/582ec3-000000@github.com>
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

  Branch: refs/heads/1146603
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
