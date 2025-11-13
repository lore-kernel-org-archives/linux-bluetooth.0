Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF82359F92
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763056741; cv=none; b=oIhVCWtK3AazCwLirexEIUkD4DLI3EWC/MbTCc6OTwWiRy4XjvHAxU3Tq7ckoC8GXcLFimceTOFB/v3GQ7Y9MlWtSgCFbfeN9wc6Jjav2atugt5ZoWDDST1VJ7dNPnKO7z12r3ykGfkWwgeh2ZQ7n+/G6S0RvSpGTPe4Knoe+WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763056741; c=relaxed/simple;
	bh=NeR/5M09Hv0mwYFx9klfxEkVR0jdx+4Nam6+KbQiF+o=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=If73DImy789Dpb8lrfm0odoXq01d0Fim5edbSc8nAQyi/RRKOFrNQB0pFDqkV/3Fj8K+wgksloL1A4vOMlHzYjvXCZE7QWIwr7dfy0jZ+8d+Gbglne51kzQUrcoSC1ILo6MkqLhrTf6al6p6jrkesaKkVmIIIXv0HFh1QeQh2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Lnkl8qBO; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Lnkl8qBO"
Received: from github.com (hubbernetes-node-f5b04dd.va3-iad.github.net [10.48.181.34])
	by smtp.github.com (Postfix) with ESMTPA id B004F4E0412
	for <linux-bluetooth@vger.kernel.org>; Thu, 13 Nov 2025 09:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763056736;
	bh=sAYTyjcfibYvkAdF7M6qEyLE3bUZ9zzjDIbDdwjvOmE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Lnkl8qBOB+CUAVm38rZKH9jUcc6uIHjNsNgOmEDdDltwSq7Up0xJefEYQAEWJed3M
	 so+oQ+UznBAEf7i+C692vhX8aaDi4NekPumETXFShXLgvb2wq7EoVe2qLvCcUyGRMX
	 n6+C2Uqe7YWXOhmGCnMyEIzaCfAQrXhaTZ0o7CW4=
Date: Thu, 13 Nov 2025 09:58:56 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1022641/a4d2b1-000000@github.com>
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

  Branch: refs/heads/1022641
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
