Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C95239022D
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 17:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773336573; cv=none; b=pU6yESOn7x20L17QRmMw6W9dpw0DgJoNh/AzOd9TXQHUJ74PUq9Hnk0TxshkjnIaLO9JdP+vbQN5BA+hrFlqHBAe+bGSFnShlJqJIDEPydwTSYupDomdYO+OVxCi87WLfADMNaEPTBbmiKKpcZ9OuWXJQH6EyHztYX2l4fb6x/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773336573; c=relaxed/simple;
	bh=KN3092uO7M/LZHMfUEcBko5yq38y/DDri+mfmO1rEDQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Yc1+MneqaYzsM19VBp7V9Wt5ylNgvnzafz6yeWvp+g/OfTHrmmPygMg0GAuwcM1cdR58TLDzTxYLts3wH7sy841cVlJW6Zj0zohZ3HAfaY3pbPjtetQdMQuFiVB/LEhsgjdk9Df8N/pyxPbP9ozThtfq7RRKlJVQq1nteR08Kk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WqJ/H7GE; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WqJ/H7GE"
Received: from github.com (hubbernetes-node-42c3309.ash1-iad.github.net [10.56.128.74])
	by smtp.github.com (Postfix) with ESMTPA id C3ABA140BC9
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Mar 2026 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773336571;
	bh=R/hEyy1L2n/8c+0vpgras6KHgLT7VAYIIHvjuVGgmdM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WqJ/H7GESyL+ubSzIba1JYNiAX7ondz/PR2R6nyW40ifPO/FqUJuD4K6hh53BGwT9
	 Zyw79W7rseTIAwuCMSuSIAZsPhs7CXsGzx5DfVUuIUwBu7EWal0mzRG8DQmADlSn0t
	 4GmTnlHR0FBCm6hA131e+yNCCfo5lHSOnO2r7EXI=
Date: Thu, 12 Mar 2026 10:29:31 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1065807/000000-15e0d8@github.com>
Subject: [bluez/bluez] 2d5745: doc/btmon: Split Advertising and Scanning into
 btm...
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

  Branch: refs/heads/1065807
  Home:   https://github.com/bluez/bluez
  Commit: 2d5745dafdbd10ed703654b2081585c9ca81e6f2
      https://github.com/bluez/bluez/commit/2d5745dafdbd10ed703654b2081585c9ca81e6f2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-12 (Thu, 12 Mar 2026)

  Changed paths:
    A doc/btmon-advertising.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Split Advertising and Scanning into btmon-advertising.rst

Move the ADVERTISING AND SCANNING section into a standalone file and
replace it with an RST include directive. This allows the
btsnoop-analyzer to load only the relevant documentation for
advertising/scanning focus-area analysis instead of the full btmon.rst.


  Commit: e2d0b187f95a1cac8dde6b33dfadce786cb5c299
      https://github.com/bluez/bluez/commit/e2d0b187f95a1cac8dde6b33dfadce786cb5c299
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-12 (Thu, 12 Mar 2026)

  Changed paths:
    A doc/btmon-le-audio.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Split LE Audio Protocol Flow into btmon-le-audio.rst

Move the LE AUDIO PROTOCOL FLOW section (including CIS unicast,
BIS broadcast, and BIG sync flows) into a standalone file and
replace it with an RST include directive. This is the largest
split section (660 lines) and was being truncated away in
context-limited analysis.


  Commit: 4e6201f92c9e327337cb940cbcc76f10707e1512
      https://github.com/bluez/bluez/commit/4e6201f92c9e327337cb940cbcc76f10707e1512
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-12 (Thu, 12 Mar 2026)

  Changed paths:
    A doc/btmon-l2cap.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Split L2CAP Channel Tracking into btmon-l2cap.rst

Move the L2CAP CHANNEL TRACKING section into a standalone file and
replace it with an RST include directive.


  Commit: 891e162ae7036a0125e96a740cb331a4d25866c2
      https://github.com/bluez/bluez/commit/891e162ae7036a0125e96a740cb331a4d25866c2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-12 (Thu, 12 Mar 2026)

  Changed paths:
    A doc/btmon-smp.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Split SMP Pairing Flow into btmon-smp.rst

Move the SMP PAIRING FLOW section into a standalone file and replace
it with an RST include directive.


  Commit: 67f1ef63c968e5c9f2260a19da86802a0e6bc6be
      https://github.com/bluez/bluez/commit/67f1ef63c968e5c9f2260a19da86802a0e6bc6be
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-12 (Thu, 12 Mar 2026)

  Changed paths:
    A doc/btmon-gatt.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Split GATT Database Reconstruction into btmon-gatt.rst

Move the RECONSTRUCTING A GATT DATABASE FROM SNOOP TRACES section
into a standalone file and replace it with an RST include directive.


  Commit: 15e0d85021e6dab3546f960a4a900231b8380be2
      https://github.com/bluez/bluez/commit/15e0d85021e6dab3546f960a4a900231b8380be2
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-12 (Thu, 12 Mar 2026)

  Changed paths:
    A doc/btmon-connections.rst
    M doc/btmon.rst

  Log Message:
  -----------
  doc/btmon: Split Connection Tracking into btmon-connections.rst

Move the CONNECTION TRACKING and HCI ERROR AND DISCONNECT REASON CODES
sections into a standalone file and replace them with an RST include
directive.


Compare: https://github.com/bluez/bluez/compare/2d5745dafdbd%5E...15e0d85021e6

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
