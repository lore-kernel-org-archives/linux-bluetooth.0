Received: from out-1.smtp.github.com (out-1.smtp.github.com [192.30.252.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744EC220F2A
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 16:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783094904; cv=none; b=PSdFSSjb+UmnZfMmkdA2OWCiicl26IHH6VGi4Nwcaqes/KZQQj6nrllXfKHvTxBkWSblYd4EiQ2KDlLwNGOIccwz7UpuT0ffH/X/NAX0Fj3keKSH7+Un/4rEXeSdi9d856oOtcvCGMKtYmjavZUkTVjpZWlP+TfeS9fXzqo9mGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783094904; c=relaxed/simple;
	bh=wxVkf4zFDAlhz+MMbYKq6rABvPtxVKjW2M7/xtEl0fo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OETW5EfZIlpeUg09279fg/jtJuuamVUfHLmVQP5Rcwv6P/iVNmI7Wq5MT+LimrkWvc8HPdj1sTf/Ty8Jro0Vq1qiaVE9CQ7BJobbjm7uO8Cxil7SAtDcFIFRvYR9DiIoCoIugvzcpfeYh5EwOXuCVNe9NoZkUyYaTadHlc4Hupw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=HzAIbbuT; arc=none smtp.client-ip=192.30.252.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="HzAIbbuT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1783094902;
	bh=veEVbAvj/sweld3Jv9y8FjhroAmSh2ZHrvNAd+SZwZ8=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=HzAIbbuT7wNxoElOEOPPsVknnQwRKLNF/NDHA/zE7CFUqEiHZA9zO/1aL+pLDYVMx
	 Kheox/VYrAHgqKkUa3pnyYgeNr5dJyxkuFz0UVqjZ9BLFc83Zr/X5+XzasLsKG/dyB
	 EpXTLnbx5gqLMFCSL9VwA/4h8nGffHa2cWDDqX+0=
Received: from github.com (hubbernetes-node-08a8064.va3-iad.github.net [10.48.70.46])
	by smtp.github.com (Postfix) with ESMTPA id 9C61734DDED
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 09:08:22 -0700 (PDT)
Date: Fri, 03 Jul 2026 09:08:22 -0700
From: Marcel Holtmann <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/220f10-65d11e@github.com>
Subject: [bluez/bluez] 65d11e: Release 5.87
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
  Commit: 65d11edee469c24dcc8d075b8be9c040cebaaf98
      https://github.com/bluez/bluez/commit/65d11edee469c24dcc8d075b8be9c040cebaaf98
  Author: Marcel Holtmann <marcel@holtmann.org>
  Date:   2026-07-03 (Fri, 03 Jul 2026)

  Changed paths:
    M ChangeLog
    M configure.ac

  Log Message:
  -----------
  Release 5.87



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
