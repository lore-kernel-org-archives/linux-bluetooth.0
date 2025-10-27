Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7935D2DE1E6
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761573216; cv=none; b=hOJuqm+EQKGbu7XcnIPhcuxxgRgqXzYZtNNLZMdH5YDrKZivbDhtqJJUaUraRMJRjdg/OJBFnLzgejzd14fljUMk7Rp7ybjrmoGjfAobTwzuBeKXs4xwY/ajDoGLVgnHGQxQKNlxfFN2MLmga1kCtYepqI6k6JK4sqLPTxCIwaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761573216; c=relaxed/simple;
	bh=lmQAS2ngHAzBW0K5Ds15H7H4XGoJc9DIXwm3QMLq0SE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cWIn24ni7JSh0rg2VetNSPYm1QpREIDWoIdS0FYnpYfnvoz5Xe3+UtU6478NoYzD1X1ii/8LSEP0IEkooX/elXMYRcvh1BeiN0bD/qOSYwaMRibnG546cSeLiEtHCx8J2FZVObcxFHkV56U2ayZoBqvdVV4iC6aExV6jhRklacU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PxBImUrP; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PxBImUrP"
Received: from github.com (hubbernetes-node-025607c.ash1-iad.github.net [10.56.15.64])
	by smtp.github.com (Postfix) with ESMTPA id 744E460046F
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Oct 2025 06:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761573214;
	bh=C4yundLozfOINYu2NTRHdI39dKCdJ3mTDjwFswtiKBA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PxBImUrPbGLBK2srr4+1LNTwIoesKHhDk++DXYbcHwF4IqqbhJTX9lK9o34dvIeb5
	 XkJHUDos022PnjMqI4Q4ssCMLv1ezmPDsXieOTV5pMl3bFG/CH7IwxNLZ/a1klOBcA
	 2cDA6QanYCFoFtFtEUqBmuv4oMP7Y+G1GIkXq/yY=
Date: Mon, 27 Oct 2025 06:53:34 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1015647/89461e-000000@github.com>
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

  Branch: refs/heads/1015647
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
