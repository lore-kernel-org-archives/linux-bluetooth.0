Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36BF212F98
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 22:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750111919; cv=none; b=XjW1UUuW+/QYDUPjK6bXunGLzHggtm4Lhcl7nfOyyMUsjCOx6bCaq8Zka9WffIPRhClH/t5UKkY2RidV3ujB15QN9+DhDxy1tdeLDvc/Wxnw4d8gdOSUnFRzOpHV23yPu1tKp18r8Q9+9NRRLa39xE7uKmv03SSuQnHgNEJwFpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750111919; c=relaxed/simple;
	bh=W4v9rOZLwAKZSz8uT28QPTzSRPEOoX4Wbm1uhe+Np0Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UzugUBmYlD3qoUnC6EhHENg3sXBEHong9TKYT/H4Y8ddSL1QhLj0Y1R6JklIlQDrfts2dYH384eylL81nJbXVslpWN40HXlN+qUM9dCKqhxiT47VNwYqzlQoP360sXeVAph41egas7H8uwPd2qCWiZfybOdsEeO6sJnenVeYpi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LTCPV9j2; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LTCPV9j2"
Received: from github.com (hubbernetes-node-6ddfa8a.ash1-iad.github.net [10.56.159.34])
	by smtp.github.com (Postfix) with ESMTPA id C8DF39208AB
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 15:11:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750111914;
	bh=fgL1LymnB6bkqzUsidgnIpleyVU/jtDZ7aZitB02Xo4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LTCPV9j27ZevifKA1U/wILg+4rH8388I6atW9K50MtM+P3mkYZV44gOG2srpL7mYE
	 emqLVjH7IgjiSdHNHe+ZYxv69pQ1yZ3LK0KjkDoA587iztC8kXCRHbamUPLtgp35+C
	 uLFfYzVmUj7CmwimVtNtCiOCIrNg2tVZF6n5O/hc=
Date: Mon, 16 Jun 2025 15:11:54 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/972634/09dfef-000000@github.com>
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

  Branch: refs/heads/972634
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
