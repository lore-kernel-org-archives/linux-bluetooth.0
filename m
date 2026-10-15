Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD99C381B0A
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Oct 2026 06:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792046372; cv=none; b=pvTcKypWlUsTP3xT4dkGoGUm0ftegWWUTmgPB+E+wVWLoz4SMZBufTWQdu9nTiujzxUClgPtf1aXcCp8O86labKSn7TO/7TMAghM8syzYs5R8AZCgyck1qmHnm5ZOZTbmwoMV2cRw80i1b0mPwiG+FjoeAT9yRaCimdW97rHw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792046372; c=relaxed/simple;
	bh=taTA5XKCFp8mxGzmoFJeQKQx7BKhJinB1AurTJcSIf0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=pp6WODdTGT1ptfTA+2OTETusGWB70f45SxA/X5bMXiMGJk+0rJir+lrPoCifo78zrFriOJYR/5U5wAVQL3dNycfQg6IhObH0BQFXsz5FNgN3sbpLI5jyy36A6tdY+qT93mqQKf5HYPTEqMpS046EKC+26nyGkRv1Zf+NEQjEy5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=OGyg7qIM; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="OGyg7qIM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1792046371;
	bh=RpOXXwHR6JCXcjFQ6WUpplCwVhbPlV5CmJDxKqh4A30=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OGyg7qIMAYhsoM194M5cdGsjW9PCPfm5Y/9xgicoIGzVXbCmjHVPmBxLV+/kwARql
	 T/jhOxOoTqaeeVkFt2pJFGYRy4Admjc5vVPXg87HPPJhgxPh68ROimOkFAI1WSWKIK
	 ViH7eSg8kiq2eXXHfCI6mKjkL6ZiQMcUjSIuQZJhwSuxaVmaVQsAkPm3kU/REAYUoA
	 ua5VcXoONtcjfcDAjjx4MB3/Jwengr633Oi9UWb4FhN7Br5b45uHa3qP1wCbFa9lTm
	 Y+CFWJ8AXLH23TYmvULuUUE0gK+1xcUUYIUgntR6gM2EZEP5Pqh9KrPH6vuezNIdDv
	 gmBH3r0xO4uIw==
Received: from github.com (hubbernetes-node-18f19b4.va3-iad.github.net [10.48.41.99])
	by smtp.github.com (Postfix) with ESMTPA id F2EE0501013
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 23:39:30 -0700 (PDT)
Date: Wed, 14 Oct 2026 23:39:30 -0700
From: cochcoder <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1186110/000000-a41d01@github.com>
Subject: [bluez/bluez] a41d01: l2cap-tester: Check compatible interval
 preferences
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

  Branch: refs/heads/1186110
  Home:   https://github.com/bluez/bluez
  Commit: a41d0197bc00c72333f67d2a1fe93d4fcc5e8c18
      https://github.com/bluez/bluez/commit/a41d0197bc00c72333f67d2a1fe93d4fcc5e8c18
  Author: Kyle Pepper <cochcoder@proton.me>
  Date:   2026-10-15 (Thu, 15 Oct 2026)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  l2cap-tester: Check compatible interval preferences

Load local connection preferences and check both the peer's L2CAP
response and the resulting HCI Connection Update range. Cover overlap,
fast HID and slow idle fallback, and an exact-range control.

Assisted-by: OpenCode:gpt-6.1-sol



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
