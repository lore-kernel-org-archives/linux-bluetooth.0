Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB463DDCD
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 20:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468819; cv=none; b=ZnZ8MH4VHaJOjU46kHKn5vZsrhEGnGg7EL6uNHFgxAzVuiXvzdk9OldRz4GGkDUOm6xWEcHXBTTGJJrWNcCgzseGe58PZDfRCDt+Mxfkvuwetn9nOkohG3KzYb8lRPiw+RfpxoQJumRGFZfsn2T0JmbnZNSNo9U8CidbNyxBsog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468819; c=relaxed/simple;
	bh=zyWv9GnVWFnjrMw37V25yF+MRTov1B1WQTm4Vj0BseY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DPYNAgKNlowkxQhsJMgYMBgCtOe2f9XxS4FOzSyy8IdYtlicZlPdp1q9RbU2L8jwtbUgVx/tebKdJkZd1R24Tq7HW4tOx+qjuXJ2zktwBWtKDl9voWkkPHCdw2DmfOCacdtoKrq6efZkzEvfxILzCdY8AEW6G52fptq5aNl95Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QTAzgKlj; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QTAzgKlj"
Received: from github.com (hubbernetes-node-d798256.ash1-iad.github.net [10.56.185.14])
	by smtp.github.com (Postfix) with ESMTPA id 11974120CB5
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 13:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1774468818;
	bh=2P2C5Gb4hkFA55OdJMHZsGSPFQj7J1NBm3fLw6Ichqo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QTAzgKlj/McvJ3Wj4Mt0IYNuppFjfWtsSoSU4F+TuPcrGgSrO5O88euwIzI3AalF9
	 30VNIhJ9pViBTdoCQEpPuNhjrFYm1GEIyedC8vhwCnh3meNyKsvq8Q8eAFbz44nGlH
	 72uWLFdC7lazrE3FPGzjnSy19bQL4NMVn4YBtSF4=
Date: Wed, 25 Mar 2026 13:00:18 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1071883/13b9e4-000000@github.com>
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

  Branch: refs/heads/1071883
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
