Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE243269CED
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 21:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749590013; cv=none; b=l5BAaO4smWCrCm+ndyEH7K3MvVyjQCsou2w/sp7Nr12EACT6nnvF73uE3KWfEbAE14F/p8sKy7xPoYP3PnHBxuJsh4qHJlWgyRNJNbGzPCVeY8wp/ALxonW4LxBPh/nDK9QOPTuf7DzrcGVgmpYe217sM5MQhl4A0UzENbylVco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749590013; c=relaxed/simple;
	bh=ogxZvhxoTOIoeLNC1cls6TMQaR4wstHPYtbup4rKICU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hNA3U/kl8A7NRsz+ZvpKFH31n4eP03V0/otFkHhEsgeqBMnOsZ5YAlexjh9wT5rWgVjoO04bxYfui8SYAB9Zpx00uy4yKj4LXaX3aHZHUTGWjoyRviCLaL6HCg9/1GXyFOIWgdBpvrwNrqWnEs0LsQ8uiXDlabJso1KPlOsp9/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FGQWxPd5; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FGQWxPd5"
Received: from github.com (hubbernetes-node-fd612dd.ash1-iad.github.net [10.56.155.23])
	by smtp.github.com (Postfix) with ESMTPA id E712C1412E2
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jun 2025 14:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1749590010;
	bh=bjiikr0ahnR9x6OaGC3TZRdagHckYI/Cs/XjiPrYCKQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FGQWxPd5vvLaWS1HG1A9fNJjZTbuhp/YHgNqYr0fZlzy+RmEhgitvuteW7/eo1tLY
	 xqdR8NOvfkXb9F1JqXfT2c0Vz7Rr7DQUSNmsZgLf5zsEMvuYliMUd6CXZLpdnJHtUw
	 ua7WcJu0vIim5fPe1bye/1YI5mDHvzjMdrF1SpcM=
Date: Tue, 10 Jun 2025 14:13:30 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/dd83c2-95b72b@github.com>
Subject: [bluez/bluez] 4bae39: btdev: Fix not setting sid on
 BT_HCI_EVT_LE_PA_SYN...
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
  Commit: 4bae390858d0bfa434e4c2d43950480b248a8718
      https://github.com/bluez/bluez/commit/4bae390858d0bfa434e4c2d43950480b248a8718
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-10 (Tue, 10 Jun 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix not setting sid on BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED

The event BT_HCI_EVT_LE_PA_SYNC_ESTABLISHED shall set the SID accourding
to the value set in the periodic advertisement it is synchronized since
the kernel will use that to complete the connection and notify the
socket.


  Commit: 1e9dae5750472fec748d75608a032be31c329f1d
      https://github.com/bluez/bluez/commit/1e9dae5750472fec748d75608a032be31c329f1d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-10 (Tue, 10 Jun 2025)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h
    M tools/iso-tester.c
    M tools/mesh-tester.c
    M tools/mgmt-tester.c

  Log Message:
  -----------
  iso-tester: Add more tests for getpeername

This tests setting SID for broadcast source in adition to existing test
that was testing broadcast sink only, so this adds/updates the following
test:

ISO Broadcaster SID auto - Success
ISO Broadcaster SID 0x01 - Success
ISO Broadcaster Receiver SID auto - Success
ISO Broadcaster Receiver SID 0x01 - Success


  Commit: 95b72bbf1fe42216d02a5ebb99bd18e9b69b6064
      https://github.com/bluez/bluez/commit/95b72bbf1fe42216d02a5ebb99bd18e9b69b6064
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-10 (Tue, 10 Jun 2025)

  Changed paths:
    M profiles/audio/bap.c

  Log Message:
  -----------
  bap: Fix not responding to SetConfiguration

For broadcast the SetConfiguration would call setup_config which were
not calling the callback so no reply was generated which brakes the
likes of client/script/broadcast-source.bt as endpoint.config would not
complete without a reply.


Compare: https://github.com/bluez/bluez/compare/dd83c2d670dd...95b72bbf1fe4

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
