Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F9126BF7
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 05:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773898222; cv=none; b=d+9kIdXMsRtn+BsssX+qPXc0+RTHFKhfKoI6DxBUQM0Kqt5xJsduTXzMza54V0TBEp4ovwqnsnjOLxwIgdH1efXjr9U4JBP11q5Nhgfow04Zd2ftsd5gQ6gPkqqY54dbcaTLUrb2x7T0G/1NboMW5Q3vvNVb6Gq+GxP67PekbAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773898222; c=relaxed/simple;
	bh=kAjfDZHDEcfK3kqwDPDEL8TiQGlTzbe5ezjnHQaOYcw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=Y5COIiy+MTxgPxVVdOk4c99ZCJb61tZFQA5pzL9bpLGpY+xXoQwscmXdvhUPoetsioqJcOVF5GoK3lxp+89+b+V0DCSyMcSujiV1LSc+0KRMwzTvio12w5qDYp0uSFnH3vQgpEGEZJogZb0Hs79h0gMPTZfTlBu2EEIl1sFa2Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lNyqhT9c; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lNyqhT9c"
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20260319053016epoutp04e4bcab32e09568ca67cf5128f3f3df28~eJweJNvTU1487914879epoutp04e
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 05:30:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20260319053016epoutp04e4bcab32e09568ca67cf5128f3f3df28~eJweJNvTU1487914879epoutp04e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1773898216;
	bh=2I2fTT7lYlPjV5TpJGdfr8FUI7c66Y1IEyhaxJkfVb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNyqhT9cJNRxWpHy9hiiPAswKA9vOthI4yeUVoPhtk3TkBZCOlyY/bxMy+LWGcGEB
	 7TYBXirBPfzIhT0bM0DvAKPLrwPViH2WRCxoqZXH/vQn7El2eBkvsvfzvCVjnp145K
	 Br0gKVSMhueSEZueNssIvL4KHcWcWcnmIx4kpcVA=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260319053016epcas5p18ccd40d6a9bdcc058577eecc31f2a28a~eJwd2Ntcm0455404554epcas5p1w;
	Thu, 19 Mar 2026 05:30:16 +0000 (GMT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42]) by
	epsnrtp04.localdomain (Postfix) with ESMTP id 4fbvRD1PJSz6B9mL; Thu, 19 Mar
	2026 05:30:16 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20260319053015epcas5p4e2daf3db9284efedfe0e5d9fa1a43ab8~eJwdVBe2x0590105901epcas5p48;
	Thu, 19 Mar 2026 05:30:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [109.144.5.214]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260319053015epsmtip2d163896a0e31a158815e279ed63001f6~eJwdAbKu20806208062epsmtip2g;
	Thu, 19 Mar 2026 05:30:15 +0000 (GMT)
From: Tailu Shi <tailu.shi@samsung.com>
To: Pauli Virtanen <pauli.virtanen@iki.fi>
Cc: Tailu Shi <tailu.shi@samsung.com>, Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: ISO: add timestamp for outgoing HCI ISO
Date: Thu, 19 Mar 2026 13:30:09 +0800
Message-Id: <20260319053009.1377202-1-tailu.shi@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <b6508eb975a31a10542682e71ed99bc175fedc27.camel@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260319053015epcas5p4e2daf3db9284efedfe0e5d9fa1a43ab8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20260319053015epcas5p4e2daf3db9284efedfe0e5d9fa1a43ab8
References: <CGME20260319053015epcas5p4e2daf3db9284efedfe0e5d9fa1a43ab8@epcas5p4.samsung.com>

On Wed, 18 Mar 2026 23:35:37 +0200 Pauli Virtanen wrote: 
> Thank you, this is very useful, and probably sufficient information for
> implementation. I'll still need to check MT7925 behavior on this, but
> it is probably enough to start with.

Dear Pauli,

Thank you for the update. I'm glad that the information helps advance
the patch integration.

Thanks again,

Best regards,

Tailu
