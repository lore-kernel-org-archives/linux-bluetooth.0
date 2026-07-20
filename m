Received: from out-43.smtp.github.com (out-43.smtp.github.com [192.30.252.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F2D3612F4
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 19:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784577436; cv=none; b=au7FK4OPGTWJFCS9z7zYKmJrj9l8aGfv8DaWEuXhHGXpmdkftn1C1Derh2TRPVg4Lf/rsBqivO8zG6efCgjK3QPwdf04KWzCtDNJgQHB42Lrtub25JT+Vujicz6nnL10dS5Eb/QZ1Tet03V/RGAT3uS9JjTpvEGZlmhdc/TbFCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784577436; c=relaxed/simple;
	bh=vzrUf9zZJnWZzV0LOIbJG6Vv4nDQdQGhUjezQwCtNj4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=XPerWjUb+txPQ0mTV7CN6Y4GCPWPWcnD4wPHDZSmxNesVTNfBs4fpPq4GOrmnLLtHNINOUTLMrry2cU8wayh13QObxwWf1n4z1Mt8vHpuGqU0CoIgYTy/RlUKVtC8RKg5ZZS8JDmWVojScMyRnYBkyYlMRXM77gNaLAH2sj92VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Uxu3Q/yM; arc=none smtp.client-ip=192.30.252.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Uxu3Q/yM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784577435;
	bh=5AIFGcuSS3OlQ0htv2xzXyKtUWDPiQFT5tSzHtV0zT4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Uxu3Q/yMqLM8xgljtE33YIP0r0ytnm18rrEJla6OeD+O03hfy79Ol+IJ4lELN+JDu
	 qiosp5b7iYuW39FSGzSKGT3yswLiepWpb9TC8W/GfvRFohj9uJFSJmRoNU1rr2YW+f
	 I+lGcXGLby2E3DgtPMqE7aFo+q34Y4wO4oAsrpN8=
Received: from github.com (hubbernetes-node-4917d10.ash1-iad.github.net [10.56.172.18])
	by smtp.github.com (Postfix) with ESMTPA id EA3D78413E0
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 12:57:14 -0700 (PDT)
Date: Mon, 20 Jul 2026 12:57:14 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1128034/e5cd97-000000@github.com>
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

  Branch: refs/heads/1128034
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
