Received: from out-41.smtp.github.com (out-41.smtp.github.com [192.30.252.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C61434E745
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780954176; cv=none; b=kYrS595vFcUAi2VW1++Y8bCM+KEQ/tXOa/ilv67znBDznZcVqvxRwJvyLtSn9vFjDYq5foKKXFcCF5qSVdmtp/30t9pzMEjVGdmjON5PUHMOdYotYHNQKeeZEbKBVfbk9tJzFyjDZaGudeLtGmxIuxAqvFdIhh4G8+foMcrZ5yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780954176; c=relaxed/simple;
	bh=tONSmeHnLDyoD5rgpQWjJ8ConOO0sapWVGWoXf/DcWs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=iVAs8Ax6Ef/IKwq/0aCHlaAhuR97fxeEOJoOTxf/kmqQ5K/FLHLf7gttYNIZ8YXE82iEP4UL1XR/ZK72i2K9xF9XtjH8pmSz/KYDFA8Te8xp+EcsmhtSSKNW9pJul+Q1OB+OjV2xxmGaPVeTdR0d00Zd/1yHrr8ZQgd2K0NItjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lhBcCPE7; arc=none smtp.client-ip=192.30.252.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lhBcCPE7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1780954174;
	bh=bLDnvWDrC+RK8tOQUNDHOiACb054ERiJI6z4Iy/7vow=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lhBcCPE7qCnBDFFayfCPePz6hdBF15vYD2m9sZJkyuCs6ePWnu1NOvr24dVpQJfPC
	 MqpWVtqgf1khqJMFcgD7gFg4kvokNHavTPK2F/o1kHENJScz4e0k1Q/Q9PMIyECq9D
	 Js9LBEZvZCP7u+w7g7Yyhn16KpCaCDKJ1fxsTCGs=
Received: from github.com (hubbernetes-node-95f9088.ash1-iad.github.net [10.56.131.62])
	by smtp.github.com (Postfix) with ESMTPA id 678CB841100
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Jun 2026 14:29:34 -0700 (PDT)
Date: Mon, 08 Jun 2026 14:29:34 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1108111/000000-ad880b@github.com>
Subject: [bluez/bluez] 61b6c0: shared/hci: Avoid redundant BPF filter updates
 on ...
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

  Branch: refs/heads/1108111
  Home:   https://github.com/bluez/bluez
  Commit: 61b6c0cbc6a9c6c018ac942d301f4f900c272961
      https://github.com/bluez/bluez/commit/61b6c0cbc6a9c6c018ac942d301f4f900c272961
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/shared/hci.c

  Log Message:
  -----------
  shared/hci: Avoid redundant BPF filter updates on duplicate events

Skip updating the BPF socket filter in bt_hci_register and
bt_hci_register_subevent when the event/subevent is already
registered, since it is already part of the filter.

Similarly, skip updating the filter in bt_hci_unregister and
bt_hci_unregister_subevent when other handlers for the same
event/subevent still remain in the queue.

This avoids unnecessary setsockopt(SO_ATTACH_FILTER) calls when
multiple handlers are registered for the same event code.


  Commit: ad880be30195eff5b2ad4d2df52f6c426d79fe73
      https://github.com/bluez/bluez/commit/ad880be30195eff5b2ad4d2df52f6c426d79fe73
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-06-08 (Mon, 08 Jun 2026)

  Changed paths:
    M src/shared/hci.c

  Log Message:
  -----------
  shared/hci: Debounce SO_ATTACH_FILTER with timeout_add(0)

Coalesce multiple BPF filter updates into a single SO_ATTACH_FILTER
setsockopt call by deferring the update to the next event loop
iteration using timeout_add(0, ...).

When bt_hci_register_event or bt_hci_register_subevent is called
multiple times in succession (e.g. from bt_rap_attach_hci), each call
previously triggered a full filter rebuild and setsockopt. Now,
schedule_evt_filter() simply marks a pending update which fires once
in filter_timeout() after all synchronous registrations complete.


Compare: https://github.com/bluez/bluez/compare/61b6c0cbc6a9%5E...ad880be30195

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
