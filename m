Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F287D43AB8
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 11:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218593; cv=none; b=Hiy4E0+7Qd6QJryvsEs8FSf2uUqUsSc8ggwDHH90spxyZH7zMSD8QxGs1hiBWFeZ28BajOmiSKz6A8vnCaOuQtMJ4fAc26ygu9a76Z4x1Wfg5sFVU8NkDqWnjpl5On63Di9zOz/ZySqq3FeKJPwWcupTdSq4LgU/CZyfJidHA+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218593; c=relaxed/simple;
	bh=mkzuY9bRKNTMqmmTgQ4z+EnRoUhF4H/VsBLIipsIeZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DYe0LjFBuznozpVlgi6GpNApPn8ITzzVRY1AcjNGyw1qLqnz6aIEpUH5rFWl17ja/QRafdm60PrTEY3QgLkunD+LHleJFung4XCZNDZqTabVjMD6VSb/jJkLrGsBxez6AEsMwE4GTQLyT6BKunlS2Gl72b93vDuG+RX6CxgQj8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TTgpf3Jfcz9t3V;
	Tue,  6 Feb 2024 12:23:06 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
Subject: [PATCH BlueZ v2 0/4] Adjust tests for sequential conn establishing
Date: Tue,  6 Feb 2024 12:22:49 +0100
Message-ID: <20240206112253.76446-1-verdre@v0yd.nl>
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

Kernel series:
https://lore.kernel.org/linux-bluetooth/20240206110816.74995-1-verdre@v0yd.nl/

---

v1: https://lore.kernel.org/linux-bluetooth/20240129114900.92919-1-verdre@v0yd.nl/
v2:
  - Switched to terminating lists for expect_hci_list using {} instead
    of opcode = 0 as suggested by review
  - Changed the timeout for sending page timeout error to 5.12 seconds
    as suggested by review

Jonas Dreßler (4):
  mgmt-tester: Add a 0-entry to expect_hci_list lists
  mgmt-tester: Adjust a test for recent kernel changes
  emulator/btdev: Send page timeout after 5.12 secs delay
  mgmt-tester: Add a test for connecting sequentially

 emulator/btdev.c    |  32 +++++++++++-
 tools/mgmt-tester.c | 115 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 145 insertions(+), 2 deletions(-)

-- 
2.43.0

