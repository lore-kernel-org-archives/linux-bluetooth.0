Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D184D428850
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Feb 2026 19:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770405250; cv=none; b=bR3PmwTa20i79jYxWHV6+dr4HyWnHkdusH7Y0JSSbAWmcvVVEllCBw7yNreSkGSzO2kdJA3kpaRN6CsK1mlTsMsalHXUvItA88yW60xFnrOkCuPdBQTE2eC/SlEiddziY+oRB6sUpc7Oi9xkHCmVSIi7NxUkAc4dvvkNwvzH0mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770405250; c=relaxed/simple;
	bh=TAP+qY0Vzo/JgejZL/xz+Jr/hGA4/qY//dLRVrRo+Dk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZV0K47n9xvcYiy5YvcAs0beCn08F/xu3eZ0Sn9RmMKNjdMY20KwFDIGumhz7mCi+fqpBYelOjHQUOUUebt56JvzzwryCjEgB1Mescp+GqduJlW6rLnE5D1Ny2Pwn6nODlDeGa7TXlYDB8G9HYQeWS16zXzcWkUnJvyvIfiycLEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AHjau6Hk; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AHjau6Hk"
Received: from github.com (hubbernetes-node-ef65151.va3-iad.github.net [10.51.91.42])
	by smtp.github.com (Postfix) with ESMTPA id EB9A7E0BF2
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Feb 2026 11:14:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1770405248;
	bh=ySJEkzYASWHJ2jhd1N1ye05OD6OFNvSUwHrweKf0e9Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AHjau6Hk0qGD/ZnDaGKsxe39W1vEyUmabajJvy9uHc4hVB6yDnyaWRHgbjdZb8BYV
	 rJ8NfHeHZjQJ8yMj0iaFtXVRKujP2Ma0hit3quFl4hTeMDLPcc52ZEeh/LcikQwW3P
	 85NXIqPmB8Xw5jxDKyibSWUoZQohzzsYZkqu1kxE=
Date: Fri, 06 Feb 2026 11:14:08 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1051705/000000-0b8cb3@github.com>
Subject: [bluez/bluez] 0b8cb3: l2test: Fix not being able to use -X
 ext-flowctl
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

  Branch: refs/heads/1051705
  Home:   https://github.com/bluez/bluez
  Commit: 0b8cb36583cc48d0ee874fc9f62350bc1f55260d
      https://github.com/bluez/bluez/commit/0b8cb36583cc48d0ee874fc9f62350bc1f55260d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-02-06 (Fri, 06 Feb 2026)

  Changed paths:
    M tools/l2test.c

  Log Message:
  -----------
  l2test: Fix not being able to use -X ext-flowctl

-X ext-flowctl requires using setsockopt(BT_MODE, BT_MODE_EXT_FLOWCTL)
but instead the code was attempting to use L2CAP_OPTIONS to read the
current l2cap_options which is not support when the address type if
not BDADDR_BREDR.

Fixes: https://github.com/bluez/bluez/issues/1869



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
