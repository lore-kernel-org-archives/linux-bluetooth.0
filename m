Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B22FF14C
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758185772; cv=none; b=iy2Tbpl1/eJVjJvZ5sFYxSvA2A5kHGCtyh108/mUssJA6+9iQQh1j+SHyqSPQe0X+W9EfeA5eTee94m9NwupJI2PPGf53P1qQMdhImwXR0RUeV5xfy0phrPWbpkHBHRd3db5wtwFjEsxS+mIawNdnQ9NjRlySFp4+pDEH7nTnvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758185772; c=relaxed/simple;
	bh=3ci8Nz8hyiLb5s6IiBJI9g0nv/b/vYO5NA8FD+iNqLc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tl8crBWDPLK9iOmInDR3DxQxrMXS6S3gDxId9rQC8z6qXOq+9naFzHqx8e+mdP9u+qiEtq2Ha5Jd3Xls7WsAUQH9sd94qi8iZZjDn2jsgMjwiWIRi9w68fsjGQVGBfl9LS7JAZVeEXfVXpvDVqeB5Nhjj4eot+hx5PCbMapzxHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=h573FwCb; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="h573FwCb"
Received: from github.com (hubbernetes-node-f5c3f28.ash1-iad.github.net [10.56.158.58])
	by smtp.github.com (Postfix) with ESMTPA id 9F5AF601014
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Sep 2025 01:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758185769;
	bh=bln/AKn5sAv37MFuCxLhpTGN3SWLoDYXZd4N2UdOAL0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=h573FwCbXpoCMMV3ocB0DeLuIZxZE9FcjgZLNzSpxpQCnFx/wejeA/DXVLxvJqMuo
	 aAQG+E0CybLm0bMnRGXH3zXBsQsn0i0A+rdUMF3uNGMzPFz+xBwVGrcXMpfVm582cU
	 Sk/qcX5tHyTzWhDA9n/KMqIGJIZNRGCd04V5g0Gk=
Date: Thu, 18 Sep 2025 01:56:09 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/992906/aeb8ae-000000@github.com>
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

  Branch: refs/heads/992906
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
