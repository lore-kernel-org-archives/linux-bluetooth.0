Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C1A6F2F2
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765479746; cv=none; b=sKP9tpP7Y/9PUpuouX1A+kaNsAGFcPrOYZRZX0oaafm7BPg2V80M4M9wD3SCq3K8qczd4wQJm8NA5ewIxeQTjS47BOV6An6+QipRA03AdtDqS7O7D6BvgSWWJ272am3XnEW9HcNTxbcqTu86J4TfsyX1eMoof9YTArw236tu0hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765479746; c=relaxed/simple;
	bh=wB/FKQeCl6xr7vgICJumC2mNkNyhKujqwezz+shf7rU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AQjQXCajO3FA/KqNpcyhteD62FDF33e2H3mqYSYC7SyRvlrRWWozrWL3V1hZXm8c7olIyhrqNGNSP162E7L80a1qfboPzmFp0wva/k0X/xUQO0xxgk2br7ek1apaDJFu9R8Ph6XTU8A3idTzZf4g6uhEQhO44zu3IWcY8gMVwOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UiBf6AFN; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UiBf6AFN"
Received: from github.com (hubbernetes-node-9c73447.va3-iad.github.net [10.48.200.57])
	by smtp.github.com (Postfix) with ESMTPA id AA00FE103F
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Dec 2025 11:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1765479744;
	bh=zPWL7WQVhf6bQfnP0f9WrOsZQzJFTPJh6CY25RM1ZbU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UiBf6AFNZ1G59FN4IQi4deuL6OlnzbnHeRzE9ENkLHB0uX08KCteLXTEmk43SKEXx
	 e3UbKlWV7Y7dhBofwztfZBTeU4kx3jZwkZDaXiWqp2aq1AQRO7MvHZ3T/cTieYsgG6
	 Ol3sX2hzEMFqwNWFqzLgQIwY5Hg4fp7TMYEd0khg=
Date: Thu, 11 Dec 2025 11:02:24 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1025836/a3bf8e-000000@github.com>
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

  Branch: refs/heads/1025836
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
