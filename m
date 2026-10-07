Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604C540A929
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791415596; cv=none; b=uqORfAI862Vn2iKnX+hlSfW5c6Ek94y9adcqyw8+pTJwr1cIDvW1jQ/mqpKg3ISiZAtbl6KqQBwl/mW+hv0dVMMgtByQWTobmc23ahBdGMXa98gdkANg0VK6EUlgJQpDnNYIa1NgS1tEcI5jKZauEmuctiMzgpGzt9gYavf1cLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791415596; c=relaxed/simple;
	bh=NELD4BQBv/SA/46N6AKHL5F7hz8KEAxGE4kpyhJOL0g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZBmORHsiHKR8BeDdBS3VhRYmOpQc45dhagoCh/i70cCBWuoo4tMTApG5YwfHPBZ8z1nUg85E7jjNSQyzSiKN8t6YhvXKIN4AHrWTcDKeVtkdRiGTDGH4lF89EP8dSUUXdUx89AcXvSfzXyI/Hs0PqfLaCDQeCrIjCkUFVOGoWHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=RXPcTtFJ; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="RXPcTtFJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791415594;
	bh=2cWgfNGlSaZBqKpDwXYXmi5U9uPJOgAp54r6mBxtBgU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RXPcTtFJz1T6U1KUQL9N/ztm+cvUKOB8BsTIYRf2aubzRHC42uHaRluS60Y9/dIsi
	 yu+03FBWJPujm1QL8P2vzlqUMD5LB+hb/Rj0W6+yVjfhTVWw+ds4IBR3se6iluFQRT
	 0SuC7cCsGo/Xij+uUIBsflds4usE1t3IrjSvo0OSPqRRpX/L/S46yzYLURRWSJYVhS
	 rmoDr4HHrNC7doLYS5+f3sgXzvHkPCm1tXBaER2KTwLZWc8gW3cGi5TTHzIL2cMO6A
	 1lWyHyQHkVZrE1a3r2c2xz0rScx89xkM6OCX3ICGVOhT1vyYG7OArfTDLfplZShPmR
	 R6NEXOn5fpZyg==
Received: from github.com (hubbernetes-node-890be91.va3-iad.github.net [10.48.144.43])
	by smtp.github.com (Postfix) with ESMTPA id 51676800741
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 16:26:34 -0700 (PDT)
Date: Wed, 07 Oct 2026 16:26:34 -0700
From: Hui Peng <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1181104/000000-b904ef@github.com>
Subject: [bluez/bluez] b904ef: sdp: Prevent integer underflow in string
 attribute...
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

  Branch: refs/heads/1181104
  Home:   https://github.com/bluez/bluez
  Commit: b904efdd05008b502133355b76cfc737edf80b9d
      https://github.com/bluez/bluez/commit/b904efdd05008b502133355b76cfc737edf80b9d
  Author: Hui Peng <benquike@gmail.com>
  Date:   2026-10-07 (Wed, 07 Oct 2026)

  Changed paths:
    M lib/bluetooth/sdp.c

  Log Message:
  -----------
  sdp: Prevent integer underflow in string attribute length calculation

In lib/bluetooth/sdp.c, attribute string length calculations subtract
sizeof(uint8_t) from d->unitSize (e.g. d->unitSize - sizeof(uint8_t)).
When d->unitSize is 0 or less than sizeof(uint8_t), this subtraction
underflows in 32-bit integer arithmetic to a negative/huge length value,
passing invalid sizes to memory allocation and length extraction
functions.

Add explicit lower-bound guards to ensure that when
d->unitSize <= sizeof(uint8_t), the calculated string length is safely
set to 0.

Assisted-by: Antigravity



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
