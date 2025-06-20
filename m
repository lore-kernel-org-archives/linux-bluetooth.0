Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA501CAA6D
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 15:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432705; cv=none; b=jgyf8ZA+AIOakhVbDs8B59iw6NuhUliD+Sr1U40Bp2PixSXu58rZBS8+wt7GNqjVOeOWANLdnzEOkfm8gfkp1iCH7Pxj78pOPSjiJZiq+EN0YwsjRi3Ja0EQ5/yFQPO6WTiiOtboa2MYxvqv4KsvmWNBgTa/ahkJH0pJVvX5sqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432705; c=relaxed/simple;
	bh=DyWp34KZVzhODk/pdZR5TRpn6YWQNfvZZsJdDAW0rfQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qSWrFP+BcXjbR1DhsdWQsRO76BO1T3cvgTCdFXloXC9FUHibXoBeRaba+6TFTziBHuKZfl4I/8dgkmDrTWVu701BFX6aj3W5NM7lCzreJr9f+ia6WrIBuys+aqRv73pfz6SWejobiHPHXXAt83ebuKVk2137JV58pyD4CevpH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EcXygXjd; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EcXygXjd"
Received: from github.com (hubbernetes-node-44aa45b.ac4-iad.github.net [10.52.175.51])
	by smtp.github.com (Postfix) with ESMTPA id 31EDA7002ED
	for <linux-bluetooth@vger.kernel.org>; Fri, 20 Jun 2025 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750432701;
	bh=q32qFjgyP9TU4QbBu2SZUyfuP+90kFnV7HIMIVK3ojE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EcXygXjdwU6KOlHcFL6AHCy4d+GUNtvUcmoOf9h2MzAMpN2ejfv4mn6sSXOPWQ9q5
	 UCS8hzJ2Kn2Yr3DVCnzPALa1rbNpL7c9EElsrlTL9x0jLWp6XnkSudFYg0NDc2iV0a
	 1Qn7+AKmnts8y/DP9cVpDRgR65scEUjaLCURT1bw=
Date: Fri, 20 Jun 2025 08:18:21 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/ab13c2-a209d6@github.com>
Subject: [bluez/bluez] 71b5ea: shared/bap: ignore NULL attach/detach callbacks
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
  Commit: 71b5ea9bf3738755bf644d0a21958e54816c54c4
      https://github.com/bluez/bluez/commit/71b5ea9bf3738755bf644d0a21958e54816c54c4
  Author: Kirill Samburskiy <k.samburskiy@omp.ru>
  Date:   2025-06-20 (Fri, 20 Jun 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: ignore NULL attach/detach callbacks

Allow registering NULL attach/detach callbacks with bt_bap_register
for cases when one of callbacks is not needed, e.g. in tests.


  Commit: f5a4e95d73fec983d4b9a6058a0a177856c1b0f1
      https://github.com/bluez/bluez/commit/f5a4e95d73fec983d4b9a6058a0a177856c1b0f1
  Author: Kirill Samburskiy <k.samburskiy@omp.ru>
  Date:   2025-06-20 (Fri, 20 Jun 2025)

  Changed paths:
    M unit/test-vcp.c

  Log Message:
  -----------
  test-vcp: remove unnecessary bt_vcp allocation

Do not create bt_vcp in test_server since it is not necessary for this
test. Also register bt_vcp detached callback to unref and free
objects created by vcp_get_session.


  Commit: 659fc8fa7037c18b34f2dd66b9188b98ba55f6e1
      https://github.com/bluez/bluez/commit/659fc8fa7037c18b34f2dd66b9188b98ba55f6e1
  Author: Kirill Samburskiy <k.samburskiy@omp.ru>
  Date:   2025-06-20 (Fri, 20 Jun 2025)

  Changed paths:
    M unit/test-micp.c

  Log Message:
  -----------
  test-micp: remove unnecessary bt_micp allocation

Do not create bt_micp in test_server since it is not necessary for this
test. Also register bt_micp detached callback to unref and free
objects created by micp_get_session.


  Commit: a209d69767db0f62d6fdc86a7f73ee4ec749c37f
      https://github.com/bluez/bluez/commit/a209d69767db0f62d6fdc86a7f73ee4ec749c37f
  Author: Kirill Samburskiy <k.samburskiy@omp.ru>
  Date:   2025-06-20 (Fri, 20 Jun 2025)

  Changed paths:
    M src/shared/tester.c
    M src/shared/tester.h

  Log Message:
  -----------
  shared/tester: shutdown tester IO before test teardown

Some tests may require shutdown of tester IO for proper teardown.
Add function tester_shutdown_io to accomplish that and call it
automatically when test finishes.


Compare: https://github.com/bluez/bluez/compare/ab13c24eab87...a209d69767db

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
