Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7A035F17D
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 22:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779922111; cv=none; b=Y8kDzcyTId8EhA6AOH8rdKORwrt0i7ATMcQSFByVH6Aa4crxAwqBvtVTxgikm10CoRoPHrDAins2x1/FhO58HyZ93XtGOkAQNZpLHg/sysUZ1c9mb3F74guX/eVOpFTBDjiBOcAzk40shAZ1i/V3gHe4YVf2wDPcRzRwt7OJ+10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779922111; c=relaxed/simple;
	bh=zh9H59m1H3T1PnvKiEY5F2NG4vX3XZjHn8Gse3gG4WU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bIoW889E8Eh0u9M33VTu/WokkJVpZw1nPTXf8FYGbaZk/9iytn2F7KatDQG5GMwNdVnGDLSCgycxToCWKfW1I4u3iXBFpfzWlLDa25C4SejLQbzRVEnbmcA56BEle3imwViyjRo7Y7hFP43b/Ct+4IT2MCFDNmd6lhF9/j4HgcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HRXEMBC9; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HRXEMBC9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779922110;
	bh=RE+gMF8j4602UItUVeRfpMYwCISB+bD+SdEX2qHdNXQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HRXEMBC9XJGFIZazZ7I+u4KscmCsa9neaBOSHhJ6nCdEj6iFbgln15CngCclmm3WM
	 ZnMI6cu+5i793UTXIfoKVKQ3aQhmvArSfh0T19vpmKtst/d6YgflrtCm9M1KKal6yy
	 KTVac1+q1yfYrJjI9bIZEV3Ugdo14iDYm5FaIb8E=
Received: from github.com (hubbernetes-node-3d215b7.va3-iad.github.net [10.48.171.25])
	by smtp.github.com (Postfix) with ESMTPA id F24C71805F4
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 15:48:29 -0700 (PDT)
Date: Wed, 27 May 2026 15:48:29 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1101147/c81b48-000000@github.com>
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

  Branch: refs/heads/1101147
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
