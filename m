Received: from out-32.smtp.github.com (out-32.smtp.github.com [192.30.252.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E4D397B09
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 23:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791849113; cv=none; b=JyLY9R33D/YQUEEHJ9G6M/x+8Z8uDe5gzYwrIkeHpYFtc0UMdpo9MLI5sZO021gHERruSaZwjXzLoIkijRvr00UUwlsvSYO/fbnCojtg5wa5/cqiS+TOitUD85CXjCJQ6Ihlx0KRL+h38hT74LJVfHHGpJ/cC5rVb1OrIp1HSAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791849113; c=relaxed/simple;
	bh=oF6m+rB9cb9mduzMRyiYhCm3I5c8nCn4qiNdNFX1GVs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qh6v2RdCjXGfsSACol793pMcbdV18V05YHaRBQKos29gpCKlzVX3BpzZHC+8e2+BEGjHJ7WstMqb0hfachFRe4t7o5yLJVy15hhYObc5dM2BCIY60ClzNXXf4UqHWzir+kPlOY0KyG84P2qojkzq/8dipmOJjJNDtxFM8QDjI+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=KyI+JhcE; arc=none smtp.client-ip=192.30.252.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="KyI+JhcE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791849111;
	bh=WnQBiaTgGxKSxaioEpeeM68pky+YBASuczIv4W4mdqo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KyI+JhcEgqV77ukF0eKbknCdGUUpJtFaBQjySbIOetSEE5Z9cKvO8yx3E230pjBhT
	 JlQcSVcXCJI/x+Ua9zoANGX8zg1DqmVZnuDCmolkwqhEUazOkZ/SI4FUB6b61CiZxL
	 xe/Ayn6fkzM27Y1rm5UQ266WpwSLP9mKah7AHO2j0NuAMcA6+p0agifzzrH8sPztiR
	 OwGgaDkw1KaQXBjTlhZd5IHUWSdxnDI3VYkIVJYIvbuJq3wOQyZyMxyFXVOwkHY5Hk
	 EcxW/HZufVcufBXbmZSCinXxJmImoQ3wJxVbuT4c1AnofeyUKYyRHNq5lJ/74y6xFV
	 t33UguTQHrgDA==
Received: from github.com (hubbernetes-node-cc66f8f.ac4-iad.github.net [10.52.183.58])
	by smtp.github.com (Postfix) with ESMTPA id 2B5953203A7
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 16:51:51 -0700 (PDT)
Date: Mon, 12 Oct 2026 16:51:51 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1182943/dd49fc-000000@github.com>
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

  Branch: refs/heads/1182943
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
