Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1663B2E62D0
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 21:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764710060; cv=none; b=gMrDmKwQ9bLY34v1e5BFgn819HprVMRnp4jLrMzQCyOhvfx8RdYWabKR1Wlr8BCm99vBsbJktT0btheB5OfAhq1nrjcINaIChcMRea4iHOP/Fif22WSB+67TIYL+tMZ3y/MZin8o2SPSl9r+Yi0K2Q89DgHtE6wOjQ8E1idgPqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764710060; c=relaxed/simple;
	bh=9y73LUmLnKpbME+AzIb2/wEbNKEdXGr1U7RMdIQCP1c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=TyjyZuMl1OeKzjMTSMzerOt2Z0aurVdtjsm0b46ie6JpLAFyL2+m92iOfVUDydKy11i1lGBIsx423hK3a3P0Sm15RIzh0Kcp1Zx0Ft1JFyW7HzUFb88iSR3K8F1G98pSm0TPCX2PFvhlX3OLBMXRG4acNfSIc83WGUOEiBMB4nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=A1Y6yltL; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="A1Y6yltL"
Received: from github.com (hubbernetes-node-f431fe4.ac4-iad.github.net [10.52.201.66])
	by smtp.github.com (Postfix) with ESMTPA id 2C5E820869
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 13:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764710058;
	bh=b+CtIMN1lGdRLc1CZ1VF7VnjyS0rT3+wVmZ6eoiKNtA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=A1Y6yltL2QXkNTV4StOwdpEdPPxZs9/SxunwJaIAgQYn2lZJ0zv3ZEi5Y46SzJsLY
	 nHs7MHZEzjQx71Oif2U1YSFzYLxGX2gyvsDSVdZUhk595HYwJA1kOrh6CYRwEnSIr7
	 ODl6ai01+sS0W9vS07fXCfC/edV1Bep4HAz4eG8U=
Date: Tue, 02 Dec 2025 13:14:18 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1028785/f84f03-000000@github.com>
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

  Branch: refs/heads/1028785
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
