Received: from out-8.smtp.github.com (out-8.smtp.github.com [192.30.252.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421313AE19D
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451634; cv=none; b=DkM/2FgbwftlYe1OVUk1dAjt4IjS7CJfFt+fDgpuXLBYp5QgzayuUL2OM9DfBG9ugEOE3HyP9rXJd5TXIeqetrmdJVh1hYeNcYFxPPyaM+/2pocP+37Qvf2PS0CRW++47J3gPxzsF04PXHbl3fmhug/HiD8V6jX4rkxTeaP2arY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451634; c=relaxed/simple;
	bh=k1GIMssz/oQflHD33aaZDvw9nB61C4GY93szDazj1tA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hkZs5aJh7RpBzYfrp1eEJh0KuqRZE0NSHgif1JhTwALDqgNTqePaCS7chmMqCTM2vqqkBltRfHeEgARHmHDFulwp/r6AlJ4FSO6cx9XG2oSjX0p6t5RCdpKecoeesO0Biq6vu1Rs9JP5NZfeSrEvj/zHF/QOCqF90h+grMWff7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JbJAmN28; arc=none smtp.client-ip=192.30.252.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JbJAmN28"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777451631;
	bh=CC06TwWzMJswGQwTFoMvKZh5CfM0w2c9audF+ScZPtk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JbJAmN28/NkVHR6Kv1L8Bn/pyz+xdlhaTD+ZKxLwpDUZyBIxNXZoe9FMHrcq/2bsT
	 AepxARAuXHtmn9AQJBtlUD5tJZDwcwoaFVOBiiBLZmXMhNj8Fc7ppoYwmXzCqg1/bS
	 8hGAY5Slp5wfdhe323U+lz9qARuO6uqKujV1vefs=
Received: from github.com (hubbernetes-node-be40cb5.va3-iad.github.net [10.48.200.69])
	by smtp.github.com (Postfix) with ESMTPA id 00B607810E5
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Apr 2026 01:33:51 -0700 (PDT)
Date: Wed, 29 Apr 2026 01:33:50 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1087242/a3c0f2-000000@github.com>
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

  Branch: refs/heads/1087242
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
