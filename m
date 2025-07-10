Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79872F56
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 15:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160740; cv=none; b=sE5N6Ro7dyOJYrsxTpXnE6/WeVz2zgtzWaeEZjWTWI9gexRoE7zuqBy7P5qjszi9nkmGQ7HleWOKRG9s/evJ6wSi5STHrWs2rTceqFOaLKBDL2lCNHTrFdtgQydzJ5JuZz6f1tX2bCtyE4pSO+3JlU7BRoaXf/lpT0WVL42fvns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160740; c=relaxed/simple;
	bh=o7/lV2XWxDVkyXjxNhi85LwuxsMeRIs3d+HvYDpyt6s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YZgHT5OE5iw6sNZlCsZvgqUpYzu2BimgaL41RxbTL3Ep+dWFQvJp9LDCAoOjj5dziLPgNjddHXSc+x0LNEGHy+/ucgTlIl2Gpk12FETAseZpXfc2M79dt9/++yACUXLiP9aNonheR5sQMUHne3xq4+y3xw4c4d/vvb2A7/4vSKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=X4e0+F9A; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="X4e0+F9A"
Received: from github.com (hubbernetes-node-256c3b2.ac4-iad.github.net [10.52.147.31])
	by smtp.github.com (Postfix) with ESMTPA id D66DF640458
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Jul 2025 08:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752160736;
	bh=RePZt3MeKEM/UxxXVFR7qkIKxPdZkBRpG5ae2JvdX1E=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=X4e0+F9A9sKJuOkJeyeg61XsWw8gt7i0TqlvlLzgZSZLr277xcSM309DxRZvZLTjp
	 bh6GtCdqTCgeHJlXdGaCilWaILFuPpRYSzc/2YB6/vq0erC5puahLpz4wfZ/EEUDhg
	 VmeM3caFy05IGJq2r5kWPqFFzOkypJzz+HwyKijg=
Date: Thu, 10 Jul 2025 08:18:56 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980952/63201d-000000@github.com>
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

  Branch: refs/heads/980952
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
