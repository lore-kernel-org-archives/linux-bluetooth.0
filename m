Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90D2318EC5
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781188492; cv=none; b=eY6a2jtx+CGf7/pJRhOCstYAV5GSOho1oGEXkmxaiK0Jcy/Y89/dKPUDx+8Td1hxQM4VAtxt2W9GRvWRD39m0RiXxJGRKNz2UXnyg+Z/qDv9gXAElx1PYvudAy1bpiIL2M3Cyr30j3+3HpshyTOUjA1iW853+ecUzl5b6jTykn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781188492; c=relaxed/simple;
	bh=/+ZJGO3w73FOWQGqUFZdLdnlXL8wr7QnccO9BmX5l7w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ebfDHhI8AgwHNW9opn9v+sxoE5ZoNgznsznVV0WzAVWMFQjGluph9C+kVyIX1XEWbRFfEuuyLUfYxUfMJJmseEdBIS/snUrBtUQ6tDMwHkBQXxNs+M4+2vNfGuabqQ6VKnkzaMnLPnPrKnVG8eaMEcsKj5oAftilxrpv3xWx7Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UY4r5bba; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UY4r5bba"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781188488;
	bh=yqEr1/3sjUs3CQVQdN4Od7xmR4aLEoVeDVNLmcRPBmg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UY4r5bbaz7PQQVMoWr1d2q3WkZfyHn3rJgzebQ0nPbmNFhmYI1cn6/6j5q2KIvTT+
	 ET7TBrfMcpx43wZZrqQY+0WhyIQS8TROobBODg5w2sQ7MNk7Fa6LhTxznyOgnE9DPf
	 NpMv0ilsthbGvDVmLoqTqcggal2/wu56hX7BtVIA=
Received: from github.com (hubbernetes-node-288eb78.va3-iad.github.net [10.48.219.35])
	by smtp.github.com (Postfix) with ESMTPA id E407828107A
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Jun 2026 07:34:48 -0700 (PDT)
Date: Thu, 11 Jun 2026 07:34:48 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108690/8c2ee0-000000@github.com>
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

  Branch: refs/heads/1108690
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
