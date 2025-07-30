Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06332D663B
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jul 2025 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753884705; cv=none; b=V2tJy9Ylji2a2NJRKl4chmk6wdyRN7TXGIAwDRXfsLOlB5rtrWBveUKVf6ezR0G8Pw2UOrQx+cEIeqGP0AvUMmMpwe243a78aMWaG/IMGwDlfKjQjMkhnL4Yca6PuQKFhiGSKrNLu1Dpt3cA53cXRlUSTqg7ZfotSEnMwH++kqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753884705; c=relaxed/simple;
	bh=roLAdmTpsC8KEmUlhPJxodlu9FJAa8+niKdza6EW5P8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Asz2NhuvVvnruep63+xbWEscUaUAA6RU9hXPdpfBnlHDLcCRsjVSKwvavPyMbO2RjQYCqhaXvUrtIbjZhzUlBfB/JtPATSJd6Yy4fCTyY+6aQEDOOMTFEhCC8npHTlEM27bYm/9/OwOf0Ylhn5gGI1QMFAQx4dgUyfBbbZn5xyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SaGTubx5; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SaGTubx5"
Received: from github.com (hubbernetes-node-a659b3e.va3-iad.github.net [10.48.171.27])
	by smtp.github.com (Postfix) with ESMTPA id A37244E5425
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Jul 2025 07:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1753884702;
	bh=agxtSSxu7ok6ODaFTvf6vsBI3NMt7i+dL08IiPSgV+c=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SaGTubx5uoFm1NOLBn5g5ORgNXTWX5X9DgwSTPrNULBE+DtEz+RRlsj1fdxwDfpQQ
	 f8a6brIR3R+nghh+CJVw2kPC1gsw7u6QDbK2Wp7pP4yTE5H0UyOi0Hz5QrlbisE5Dc
	 pgAX1qxm3MSZrt23OQ6eaxc6KjTJ0PJOp8bB07ic=
Date: Wed, 30 Jul 2025 07:11:42 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/977338/6f312d-000000@github.com>
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

  Branch: refs/heads/977338
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
