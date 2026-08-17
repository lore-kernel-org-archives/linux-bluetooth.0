Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FD83DB31D
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 21:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787003988; cv=none; b=MeSrQZ6MiWXrQG7UtbvK+XzA2ULB3ynkdyA8F5qKn+qE3NC/iQFwAoIz7DsKHFqcHr9OO60Hp6bDMAk1DNlDNsd+f+4EEZvieFBxLNU4W7C/Qhb5hT/a8NAOkTyXvlGSQvvDh/iUW3AnSDt86PtnQES4CDV6nx71GIzGxctQZR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787003988; c=relaxed/simple;
	bh=kJjK8K7klo/lcjZPMte9WG9FLqjq6HqkrflqZYdGc9w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=p2gEMODNXXBD2gqcGJr2R+gkGTIz9QY4DEl6rpmR57k5VxRM0h3pLT9gkvJvRtthwcm2VrfQg9oVsaY/2siYXj1doQaQsfj6i3CKrKdiSY0mZniNNhZKJ7RydOEi9lTG190x2lA5SrZ8HdgMgv6pS4dSzn9e5HmV3j3CcSpLJUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UmfMFnT/; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UmfMFnT/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1787003985;
	bh=9tjT2k9o7WY3vclqUztSihmfeH0qXGg4k2RfmTl0tnI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UmfMFnT/NnbL+utdWlE2sz/0vGvHtvF3QrNhLnjWvgUP4cIyQP2ZGkMWjlkK7LXV4
	 bwzKBr8zndmdfhbTCEjpZyH/e7cm9CHRHSZIx+EjMi7FsMTR32OnPWJ0QFXmXZll9/
	 Cxe3A/zg4Xa0A/ispsDjESutweBjuoWsSdbjF+TM=
Received: from github.com (hubbernetes-node-db3789a.ac4-iad.github.net [10.52.83.36])
	by smtp.github.com (Postfix) with ESMTPA id D4FA3A11D3
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Aug 2026 14:59:45 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:59:45 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1146222/421aab-000000@github.com>
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

  Branch: refs/heads/1146222
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
