Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887043D5222
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 04:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791864050; cv=none; b=ellyB9l+q7OnV2dwVerSWjIUzCKfsvNxUvJrUk2sduxCEedRLtmtZqsjGr16lXj8yVARzb6edZXYYIi6BFJTmEU53MuBXLnpYuuDjvYQR+Pwvkl2//tF+dSTgBc1UAVtO3HJ05gROBMzpdwvUgFiNPejAcqg6fxkATDdOo50n5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791864050; c=relaxed/simple;
	bh=L24Mxp+j+0jJM+QjTM5tDM1NDd4O2GO4ehN/zZNsCHg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=UJIJqB1lmZ6KRfbKKTHBVZCg1x0ig2bcT9KfaeM55RwZMRsDWJ3n1HICIfJf7RtPCYo761fkC/CI3o2Ew3OeiuDi1mtc7fcSVBuOFrr21uivdP765RvIuaiFjdzkpzbbe/Lbgo4DFQsKPPIuNBlSn7xsmw6ZlmLSoMNoSgv6Qyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=g9qLyLQi; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="g9qLyLQi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791864048;
	bh=i/2lKjYQAX6tFx+W7ZwdtrRMaaiLp5nTKd7pKZlOnZU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=g9qLyLQiwo4rEYryrXwO00SiuHKryMTPLqlSnrlAW+YxB61ZGGN0j4K1E833/ngvn
	 +viWq8++cUXzI5RMhjyJg2ily6nlvIc5s+ZrRlBwgbQJYvGYkttXfePxkkk0J+Mqz2
	 iw4fjMhKnvVfaOw4SqyWmWhrZ1QCRd9qHbRCrqGsYDqgYKxCBOh5QGRnLAcpLPdkRQ
	 CdTGjmuyBalwIwyHS5NpeqLMFUTywT1VDq3ffNmpBVWK63+m0eVk/5qZCZWJv5uedi
	 L/2gLPXtbm4vcFCtWHJviDC7r5wkq+q7HB/PC1UY9KC0835Km/KE4vhtMvHvktsTFa
	 DLXQQrYlWs13Q==
Received: from github.com (hubbernetes-node-ed2dfae.ash1-iad.github.net [10.56.81.32])
	by smtp.github.com (Postfix) with ESMTPA id 8792D601024
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 21:00:48 -0700 (PDT)
Date: Mon, 12 Oct 2026 21:00:48 -0700
From: cochcoder <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1184362/000000-9ab75f@github.com>
Subject: [bluez/bluez] 9ab75f: asha: Defer BR/EDR inquiry while streaming
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

  Branch: refs/heads/1184362
  Home:   https://github.com/bluez/bluez
  Commit: 9ab75fde99a63832f488f7ef8d43a535871edff8
      https://github.com/bluez/bluez/commit/9ab75fde99a63832f488f7ef8d43a535871edff8
  Author: Kyle Pepper <cochcoder@proton.me>
  Date:   2026-10-13 (Tue, 13 Oct 2026)

  Changed paths:
    M profiles/audio/asha.c
    M src/adapter.c
    M src/adapter.h

  Log Message:
  -----------
  asha: Defer BR/EDR inquiry while streaming

Defer BR/EDR discovery while ASHA streams are active on the adapter.
Keep client filters intact and leave LE discovery available.

Reject a new BR/EDR-only discovery request with Busy rather than
leaving its reply pending. Re-evaluate the scan type after START
completes, and leave suspended discovery suspended.

Assisted-by: OpenCode:gpt-6.1-sol



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
