Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A77286D57
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756208993; cv=none; b=WX5w8qpAOXS9Rj27FJ/wiXnDIT1pryML4VG8Nmyzz/XRHD41BdqqOzlWzAnjxbYuRuFlSFKi9fVF2ZYipN8iZ+PhQx51/VQ7FYgjALJXLf6fxJVoWn21IoorzyWZGEumix4oCYJgaI8A8pCCgulY89v1deE+KrSL9Yj64Z0B33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756208993; c=relaxed/simple;
	bh=lOQ5+3TMTGLGXkbPa8ysT4f6u1VM8gh12YanNbwfhsQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IsbhI5kki60ipcrpoNGg0GMsS88B3X1XzJQ5AoPw5memmTYvAlsXzCNJCnTXNZXWnFlGxlP7Yq1sASnPyNZIIXtuT/qBAg66mP+ThadGj0tukuyzmQXvqosgd7NZ0974FMNSRXysSD8Nr1dUa7f4xz+odGIRjvfdYBLwGj73bAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=U+Ly2uuS; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="U+Ly2uuS"
Received: from github.com (hubbernetes-node-a670f64.ash1-iad.github.net [10.56.163.31])
	by smtp.github.com (Postfix) with ESMTPA id 3CCEF1412AE
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 04:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756208991;
	bh=rb91lnnTTnyY2iRj6klQjxct8D6w6/4nyZz/5vkyt8Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=U+Ly2uuSHzzPYZM9+snsy1KPaI6pc0UvqASZZ0L9zjSwo+peNI70rmZWXL+OuwpcD
	 wkYemS0bktQN5e/F9/eKega3taXyer7fQPDzZAIxQKPVqnlETsmdhiV0Jh7zOm/C+2
	 5bmBmsW/7LfICSJmAoiLLkBv+TGoFGU3LX7M5iQ4=
Date: Tue, 26 Aug 2025 04:49:51 -0700
From: Andreas Kemnade <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/995640/000000-9e52d3@github.com>
Subject: [bluez/bluez] 9e52d3: device: fix auto connect with private addresses
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

  Branch: refs/heads/995640
  Home:   https://github.com/bluez/bluez
  Commit: 9e52d33d91b1665c2cefd9115297139281513eaf
      https://github.com/bluez/bluez/commit/9e52d33d91b1665c2cefd9115297139281513eaf
  Author: Andreas Kemnade <andreas@kemnade.info>
  Date:   2025-08-26 (Tue, 26 Aug 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: fix auto connect with private addresses

When an app is registered and a device gets paired,
device_set_auto_connect() can be called before the address is resolved.
Do not ignore the request but rather record the auto connect request so
that it can be enabled in device_update_addr.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
