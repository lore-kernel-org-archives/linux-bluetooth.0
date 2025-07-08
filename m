Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B6C2E36FE
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 17:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995923; cv=none; b=GZ3y07nr0DeMuMrO/TGjzutKAIrK07GH0M3yhVoVha2aYCYYBtJZxX5ZQPsqZSuZkGrcfdzC9QxwYHiEh/+DPGheD68fcoJKgpl0xj38B84vHVaFO5DI1oJEFxLnbelR48wLocodxEmh/qX3hsKPLyA9que1Rybahnl/B5OrCNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995923; c=relaxed/simple;
	bh=baUnoG8jIj84F7mTF4qfFvMlTCiOIcdk8yYkbJtJGwE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=llMpo0CiKpzfuKtfG4pAPqLC6HLllri7jYZQx6ttLKGuU5G1astR7hg0rPq/HHzsr/97MlGeqtDN6bVgwV5m6jjyHv/dqT4WDzTN4Oepr/iIl1dHu2rOncCwQ/tCewTIX9wNUNExu0i+dMh+KbLNsAGZ7iSJn+Yg3OZtFxGs+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SKEXGNCi; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SKEXGNCi"
Received: from github.com (hubbernetes-node-f2222e3.va3-iad.github.net [10.48.178.33])
	by smtp.github.com (Postfix) with ESMTPA id 700164E1004
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751995921;
	bh=CvbMM5iKy+FxscluLYOdaGF/8lVGCy/z64uw0rLXpq8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SKEXGNCiqE9FlSjvCZsz9F7wFgMD9Ur6KGlmrSEdwsoeFerArqFhmk4JfgFZPYzE1
	 7bhlvgyAHmWNAeXAHcwTOa23fzW7O8cwv+u+MZv0pGPBS1egA/xyCYFg1/M6NPnLzv
	 hB1fqQylhsOSe698c2T+SpH4tkJyKOQjru8mgK2I=
Date: Tue, 08 Jul 2025 10:32:01 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980136/000000-c60f55@github.com>
Subject: [bluez/bluez] c60f55: build: Fix typo in configure option help string
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

  Branch: refs/heads/980136
  Home:   https://github.com/bluez/bluez
  Commit: c60f5544226f83f70a34794b26b1e31d39109019
      https://github.com/bluez/bluez/commit/c60f5544226f83f70a34794b26b1e31d39109019
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M configure.ac

  Log Message:
  -----------
  build: Fix typo in configure option help string



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
