Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12A66086F
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528958; cv=none; b=FRsR24SxRT0ie7K9FdqUZs2rx9Twvqa2qi8ZRxZmg1eJruHpLkfGHp+4vt18UmV+6icZwLU6jkfxkPn9vDm2tohkOwD2FErFFFGetYGX9FtRPsd3wkyIRCy36esF5CoUXoLadHEM8z4ILmyuQwgMLkifcHzrPHLRfGSGGhabR2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528958; c=relaxed/simple;
	bh=aam5IX03tA860kQ+IjqcW/dHe22WyanYUquT/2J2M48=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dpKg6U0bSENSqhpA2yql3SG9Frpc74TvmH6zecclXvx7qjyYYsQk8Qt1a9hX6qI/YNvtMZS1beyDmff+EW9n9xfV8j0WVJ9e3sCy+VEGOLK8sacqf8W6QpR9UbbIuoXML55EI978IPNIPLD/drAZKbAfxSe3j7omIBZxe4+hJFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TNmmK5Xjzz9snk;
	Mon, 29 Jan 2024 12:49:05 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
Subject: [PATCH BlueZ 0/4] Adjust tests for sequential conn establishing
Date: Mon, 29 Jan 2024 12:48:56 +0100
Message-ID: <20240129114900.92919-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We're going to change the logic to establish connections to ACL
devices in the kernel so that they only happen sequentially,
similar to what we're already doing for "LE Create Connection".

This needs a change in mgmt-tester, and while at it, let's also
introduce a test verifying the new behavior.

Also included in this series is a small drive-by fix for running
mgmt-tester with address sanititzer.

Kernel series: https://lore.kernel.org/linux-bluetooth/20240108224614.56900-1-verdre@v0yd.nl/

Jonas Dreßler (4):
  mgmt-tester: Add a 0-opcode to expect_hci_list lists
  mgmt-tester: Adjust a test for recent kernel changes
  emulator/btdev: Send page timeout after 2 secs delay
  mgmt-tester: Add a test for connecting sequentially

 emulator/btdev.c    |  30 ++++++++++-
 tools/mgmt-tester.c | 129 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 157 insertions(+), 2 deletions(-)

-- 
2.43.0

