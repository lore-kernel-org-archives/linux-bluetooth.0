Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E3E27FD45
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 20:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768595601; cv=none; b=moJbFojZJBqiJdiETlDQyffFnvwjomoinYTb1Y+VoJa7qchmxK3QFPiYLLXAxfTPAfjZ8Beoxn1yR9QozwjtwLEKdGFbolT4+tiPF4Knew9s3lASOiuHnDQBKdNNgM1VrAdhFGjwsDkCeqvu84/DYi+0lij0IXpnXxRThZiic5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768595601; c=relaxed/simple;
	bh=HXR5cTfiSTi+YVDg+tGyopewcrI2e3QguRmkEx96exk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Gwm4EQCnXZmT6mTUE+rPyNM+LRyyP5Mk7SPACxeXvxyB+r2FnqHOgBP1Z3Gd7K6sCDIkO3yTrR32ZHp+seRlsuTtYFFCJDPhT4d7ko0lp36YMK+hWVBA1bcg+uYbOmrSObTBa6bhE93AbO3Zv5VzSst8i2ybvneVEpQbQDqQwvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=NfGLyjmS; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="NfGLyjmS"
Received: from github.com (hubbernetes-node-60b8b26.ac4-iad.github.net [10.52.138.28])
	by smtp.github.com (Postfix) with ESMTPA id 30B10400442
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 12:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768595599;
	bh=nJVQgRdC4Ff0tFwjDocHEX2n+MVwGz9QsTXRX7pBY6A=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=NfGLyjmSeNPWf8oiHSxGHE0Bxukvac5KHZ9ySJKaeOu1sP8YIpPyzEoaV0VZ1SIFR
	 r69X10QV2ToOn1NAWnEjAe7Xi42yf04SdFM8g2fcyo6TB/3nWKnMpmdt6SklMtcUYE
	 DDbIxwIlGnl6HdAEqxme0SxrLchXJ3RQtjbV8RxI=
Date: Fri, 16 Jan 2026 12:33:19 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1043515/000000-5577b3@github.com>
Subject: [bluez/bluez] 5577b3: monitor: Make eir and ad print hexdump
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

  Branch: refs/heads/1043515
  Home:   https://github.com/bluez/bluez
  Commit: 5577b35f0c82fb327e805bb4e0faac50eda09669
      https://github.com/bluez/bluez/commit/5577b35f0c82fb327e805bb4e0faac50eda09669
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-01-16 (Fri, 16 Jan 2026)

  Changed paths:
    M monitor/display.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Make eir and ad print hexdump

This makes eir and ad print an hexdump so user are able to identify
if there is text encoded into them.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
