Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4748319F40A
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763125568; cv=none; b=uxnP62tEJp5Sgrk6nDk9dfg9SoV9OBT0XDp+0WTukJCOBjQZ5ldXgTM8XV3VLNEFVpuuARjlzzQcyVKNTxnq07oA1+ShAgr1xROpx9AklbDUV7mpkcXdunvg/kuB2xqqWaiV0L5/00mb2iQNYb2GjGutGPO02lXwHt/vSXl7PmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763125568; c=relaxed/simple;
	bh=ssSW+RlyDxzO/tb3DLV3TTcLP6lpt+W21I73tmzJbTQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oFuDcC+E7bd6DONsWnLIo0KjAfZ4NLfGiWxZxL5TKUKGrm8Ow4tiwD3VgdluP/aTYZuG4R0XTvdpq2OtKZAOy3rC+5llI8lmVJCfWzPnVgjviK8uUSpe/ULA37YOl0ZV5I1djSV5mNLTY4RIh7dyeD8c2/upLMTbq7ZZWKAozFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Grj73CC9; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Grj73CC9"
Received: from github.com (hubbernetes-node-10aa7ba.ash1-iad.github.net [10.56.209.121])
	by smtp.github.com (Postfix) with ESMTPA id 3CF279212BA
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Nov 2025 05:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763125566;
	bh=HBRRfJ5r9f3dX0UKUPOrIS2hBpKwsuSr7ziL6DSRYLU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Grj73CC9Cl9E2GB7tELv6XvKgre8OzSqUPoG2w3qNSEjzz0dJWENcSYknDgK9uwGL
	 JWVFQRGrTcnLrTj6Ad0/Ja8M5uPVJSMIzdW02nKLhRDIwROPLcrg+8ryjyFYQGuF1m
	 pWri80wZWJS+TyB3/WhwCxjMbwVoW4qWCkt9+pWM=
Date: Fri, 14 Nov 2025 05:06:06 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1019882/6b2859-000000@github.com>
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

  Branch: refs/heads/1019882
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
