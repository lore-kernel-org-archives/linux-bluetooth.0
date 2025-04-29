Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14CF215060
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945445; cv=none; b=DUt9zWvNnquNwZfqCRcyXj2SOl4JJq6kOv8rHVofpqTvvNHbe/pnW2VEPou4FeoUByNqWDFbl4YPoqtRfZwpHG5yH2+s11Bveb7UcYsbo3R7ZLyiEOu1VbpM9brQjN/H5m3jEYxzA+Jzt1GVX1xnwCPjbizR1a/vvoyof9gsmuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945445; c=relaxed/simple;
	bh=tYd25HdFOX5I8ntpFz8R5vkb/02d8bVL12/m00Rt+8M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tE4uk/Uc77Fp+l6D2Mx2fihLmkwryYJdugOxicQ8o+hby1N98dq+LNFLxvXZiJp30U326arMOTDSzNxITj6RBBpRFDDcF/3G2OT26y4OivA+nkGsWip92r3l0WsHoR2wBIHiZrIrsGZZpr0klS1rtRhG3z3pCJPRLXuRNiXcp3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fxS1hOmZ; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fxS1hOmZ"
Received: from github.com (hubbernetes-node-0138e36.ac4-iad.github.net [10.52.143.32])
	by smtp.github.com (Postfix) with ESMTPA id DA71164135F
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Apr 2025 09:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745945442;
	bh=HEy1wbV1h7JFh3cUGm05u9O3uDzNccquk27ZR8sfjCs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fxS1hOmZyoRmxr4lWc7/BpLOYE/Gxt5vvwqlw+ha8ac/RrW+drEnEUfdAQ1/mTn0v
	 QKGpPfBb2fNVrvLBxzV8gc9jzZkTkn7XI4WYCUe/yFr/nblrfUrLonZpT5aJNyEJ7H
	 SNrL/BI3XEIvTAMoBDIB5zgIekdb4kRG73pdAJuM=
Date: Tue, 29 Apr 2025 09:50:42 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/958207/000000-46c2aa@github.com>
Subject: [bluez/bluez] 46c2aa: device: Fix not setting
 DEVICE_FLAG_REMOTE_WAKEUP ...
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

  Branch: refs/heads/958207
  Home:   https://github.com/bluez/bluez
  Commit: 46c2aa5c97070a51fd5d68f863c42e5316d69d17
      https://github.com/bluez/bluez/commit/46c2aa5c97070a51fd5d68f863c42e5316d69d17
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-29 (Tue, 29 Apr 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Fix not setting DEVICE_FLAG_REMOTE_WAKEUP when required

Due to the introduction of DEVICE_FLAG_ADDRESS_RESOLUTION it is no
longer possible to check if the kernel has support for it ahead of time
since that would depend on device->supported_flags which is only updated
with MGMT_OP_ADD_DEVICE _after_ services are probed.

Fixes: https://github.com/bluez/bluez/issues/1207



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
