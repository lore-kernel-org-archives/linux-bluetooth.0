Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8043346AE4
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766157332; cv=none; b=cHYejmw/Rv314GCUKHOwEuePIr1rIfGIfUz9eEE3Qi+H0nZon+CyyMHhib54rqMNW5nN//80Nsg9nxuUoqBKLn1rUa/cb1SgsnvQVNOh5PiBH0BRlwjRSORzsn8MHodCKnwXt00EaVsX6kCW895nhBhRQlPeSQot0f/VluCbVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766157332; c=relaxed/simple;
	bh=Ox/IQb+MCdN11WjWpPa2Ffk88ZKN+W5MJFvUJmw9fVI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Dn4zA78GCGNnf4mKOia4GALSbyLC5aPjoA3cj/z8YxYB21lANltcBFgi52rdbpyXj0Cz6tb9IK0LC/mtkmSFwD2vb6OwS765q11zGYuqaL/hoKfMPzEw810x483lgwc2E0Mg3Vpsu416kYnG8Rnm3Ro6zkvlk+iticMmb1l8Xdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dyBPJJjM; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dyBPJJjM"
Received: from github.com (hubbernetes-node-74a33c8.va3-iad.github.net [10.48.146.26])
	by smtp.github.com (Postfix) with ESMTPA id CD2863C11E4
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Dec 2025 07:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1766157329;
	bh=ZCJijtWQvgcGJ/srb4uaOdFLh6V6o4tAmCZ4K2+7rfE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dyBPJJjMD5pNYp2H5yDlSfMVk8zgeOo4kY9j6fNfZYdPpdwf2ta1XxkwyHKAMaPhN
	 EE1JgUEtTwZxuL5/H36IkVuJ6GPDS6DwjgJdL+B286HSxMJHMMxFbMCbAV43bSLtA5
	 Su//YCAGicL9b9bFNOpkwUjj/4rkTK7kiuK+IdXg=
Date: Fri, 19 Dec 2025 07:15:29 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1034282/d11bfe-000000@github.com>
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

  Branch: refs/heads/1034282
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
