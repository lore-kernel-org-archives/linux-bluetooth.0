Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB802275870
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 15:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777648001; cv=none; b=O2x589f3ZqSYJhz9aRRM7NU4Rn1D6SryDeK8BfdLhv4ajg3HMamkM0mUIc4uGS7DY9G0+J0tBhYGtEhpW475C2csc3bLoK7SN2SoW8t9DfWo4NbTVb/xN4oSuqzsYW2KbNvnxIQCQkw+SsWisiwfBbE9Ql9JdGLuguA6t4YyiX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777648001; c=relaxed/simple;
	bh=R4UfnrRnyw0ljAieaPxrXpfRpDDp2fHZ/vsx7Gryz8Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FuIwc/I5gVjE/oVs8tekHXxxeRBxY6Quon2x53QZoERaafUgO4Gk6FvAIKuM0e/C4RiQWmSSieyCFV6x18Y1hI5RPKv3QbiPwHxK4HVrS35WeX+XvmEnpAFk93k0WdSKYQja0+v3HitgMaVTwvG2afZ3Mc/F4Rk0CkRpOL89wng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=O9MA6dYE; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="O9MA6dYE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777647998;
	bh=Kn56s1/xoPual1+N1a7Tj39AEUXokmTA2ZBrviNrsgQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=O9MA6dYEjFb4EJztgCyN59H8yqLC7V0qjuMR5fdmenP548AA5PGgRum6zp5NlwrDF
	 iNEwkyg9/A9aL32YsAabgvRRdDporY4GPbpa6SRByeHwK4r1vOb5JHLqbxWxtSOjsl
	 9u5kCVniD+AxNz56MZF5GVPsoKc4yRegde7mKU0E=
Received: from github.com (hubbernetes-node-6d89ac6.ash1-iad.github.net [10.56.208.79])
	by smtp.github.com (Postfix) with ESMTPA id EFD055207B4
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 May 2026 08:06:38 -0700 (PDT)
Date: Fri, 01 May 2026 08:06:38 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1088547/000000-dfbc31@github.com>
Subject: [bluez/bluez] 323d54: shared/hci: Add BPF filter for registered
 events
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

  Branch: refs/heads/1088547
  Home:   https://github.com/bluez/bluez
  Commit: 323d54f958ff446ecd6897c8ce1aade29639e454
      https://github.com/bluez/bluez/commit/323d54f958ff446ecd6897c8ce1aade29639e454
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-01 (Fri, 01 May 2026)

  Changed paths:
    M src/shared/hci.c

  Log Message:
  -----------
  shared/hci: Add BPF filter for registered events

Implement a BPF socket filter in bt_hci_register/bt_hci_unregister that
uses setsockopt(SO_ATTACH_FILTER) to only accept HCI events that have
been registered, plus BT_HCI_EVT_CMD_COMPLETE and BT_HCI_EVT_CMD_STATUS
which are always needed for command response processing.

The filter is rebuilt each time an event is registered or unregistered,
and only applies to non-stream (raw socket) connections.

Assisted-by: Claude:claude-opus-4.6


  Commit: 445437b236ab5b3c7b9c888ae1baa52176216928
      https://github.com/bluez/bluez/commit/445437b236ab5b3c7b9c888ae1baa52176216928
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-01 (Fri, 01 May 2026)

  Changed paths:
    M src/shared/hci.c
    M src/shared/hci.h

  Log Message:
  -----------
  shared/hci: Add bt_hci_register_subevent for LE Meta events

Add bt_hci_register_subevent/bt_hci_unregister_subevent API that allows
registering for specific LE Meta Event subevents. The BPF filter is
extended to accept BT_HCI_EVT_LE_META_EVENT packets and then check the
subevent byte (offset 4) against registered subevents.

Since bt_hci_register_subevent is only used with BT_HCI_EVT_LE_META_EVENT,
the event parameter is omitted. The subevent list reuses struct evt where
evt->event stores the subevent code.

Assisted-by: Claude:claude-opus-4.6


  Commit: 5b1e05389d250781fbfd1e72308395b297f9414a
      https://github.com/bluez/bluez/commit/5b1e05389d250781fbfd1e72308395b297f9414a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-01 (Fri, 01 May 2026)

  Changed paths:
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  ranging/rap_hci: Use bt_hci_register_subevent for LE CS events

Replace the single BT_HCI_EVT_LE_META_EVENT registration and subevent
dispatch table with individual bt_hci_register_subevent calls for each
CS subevent. This enables BPF filtering at the socket level for each
specific subevent and removes the manual subevent dispatch logic.

Event IDs are stored in a struct queue for flexible management.

Assisted-by: Claude:claude-opus-4.6


  Commit: dfbc31a733555c70ff0c6e74ba1834908485a950
      https://github.com/bluez/bluez/commit/dfbc31a733555c70ff0c6e74ba1834908485a950
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-01 (Fri, 01 May 2026)

  Changed paths:
    M tools/hci-tester.c

  Log Message:
  -----------
  hci-tester: Use bt_hci_register_subevent for LE Meta events

Convert all bt_hci_register(BT_HCI_EVT_LE_META_EVENT) calls to use
bt_hci_register_subevent with the specific subevent code. Update
callbacks to work with data that no longer contains the subevent byte
prefix, since bt_hci_register_subevent strips it before dispatch.

Assisted-by: Claude:claude-opus-4.6


Compare: https://github.com/bluez/bluez/compare/323d54f958ff%5E...dfbc31a73355

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
