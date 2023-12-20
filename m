Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B87F3A29A
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 19:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="GqTqOQEe"
Received: from github.com (hubbernetes-node-1160996.ac4-iad.github.net [10.52.150.34])
	by smtp.github.com (Postfix) with ESMTPA id 4044D70081F
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Dec 2023 11:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1703100978;
	bh=z4Aqx/H2XkFYL+YorCRpNSBvjtmrMFMPe/sfkt2d0Os=;
	h=Date:From:To:Subject:From;
	b=GqTqOQEefpYthbbc/2nNPAAzGWOxGLdFtjYOApjqQMBynuHe9kl8Nv7xjLh5Cgzs5
	 NPmg8W9Oze4qcdQ34Bcn6FhhpzjA8mFtV7j17BxaD3pFRG5ALakHhm908bHLN9y6SL
	 O/1riL/Z1zTV/nO7iCPgJn4ULHiAXuKTg8Kp7KVI=
Date: Wed, 20 Dec 2023 11:36:18 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/c623de-7ad566@github.com>
Subject: [bluez/bluez] 7ad566: adapter: Fix link key address type for old
 kernels
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 7ad5669402c9acff8e4cc808edc12a41df36654e
      https://github.com/bluez/bluez/commit/7ad5669402c9acff8e4cc808edc12a41df36654e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2023-12-20 (Wed, 20 Dec 2023)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix link key address type for old kernels

On old kernels only BDADDR_BREDR is supported so this attempts to detect
that and retry.

Fixes: https://github.com/bluez/bluez/issues/686


