Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AEC233140
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Sep 2025 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758116591; cv=none; b=YBidM8VslFK6pK8lvrmXUptsqYFUoC0caoI0QbAmFxwnufR3GDfVKMeDQZyVTzCPRMWJ517NJMdjkT8WD1hnkqgKi2kgJdtNa3ej6ILs67xbN1sTdzx7IsW18LjyREUOI7HSjqD84RiLB9OmNXiDkFsqFfkTzpBvOKeEjcOlbcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758116591; c=relaxed/simple;
	bh=LrrtTsdN9sc+yc7vpPiYGdce7X049iBhac9O6rq57B8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WooGGLag0/7mBZEr4U3v29YGnYXpITHp7eoZRQMGEtnV7r3FJmGrtOTdKzrvv9lz7UiICtQLmnCrltMFswPnCVfBZtvAneU0fi2nd5/WCypvSr7+xVbvrQ5h6DtYANwAwTtUYaL8qGNyRO/AP8dKnDtoHcqFBduYiQ1mZTELdrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AIu99398; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AIu99398"
Received: from github.com (hubbernetes-node-f795491.ac4-iad.github.net [10.52.157.18])
	by smtp.github.com (Postfix) with ESMTPA id 00A9364129D
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Sep 2025 06:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1758116589;
	bh=gjZ0kl4Fj/xcDvp5p50w1R6nIdfH6lwJ0AJQEkSvozI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AIu993987M1jIZY7YAJEAjt1Cmh3rADbBvhlTLfpy3DsTXQPTLry3VnfuPgtahq4W
	 tA+HpzYcetNcLiJVm8FwmtxMHEGWGZ8sbkRhbexZl2/aG7uZm2+geiAfPn5S7nYVq5
	 BjA0sk7NT9Oqr4bRWmKmwjzuoVfFId0sE/9qSVfc=
Date: Wed, 17 Sep 2025 06:43:08 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1002593/763b8b-000000@github.com>
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

  Branch: refs/heads/1002593
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
