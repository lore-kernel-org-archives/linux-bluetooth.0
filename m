Received: from out-37.smtp.github.com (out-37.smtp.github.com [192.30.252.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550FF2EC09F
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 15:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564796; cv=none; b=WSQXwMar2hr16hk9SQriRwO/aVmeyjrGRYEZyiCYfDelN7KBCvlESgZECJF+XFdWbCrui8R476UXHJTsWCNUq77iFNc+Qsdxp4t1bQ10LyAc1kH0BAIwrDunm4z7ajQ+ghjRKBkTcRD2GsPZi6WLn/SfTEDQmuCCY5RFZud+r4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564796; c=relaxed/simple;
	bh=Wjydt8/t+D4l31awDWkjeZhlW2tRwdsCCudZFvwQWnY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Vht66/yy1TOS6s4fAGpMpE1PjYEVZd+PnqNxeWgQKsicOP5M4uSZTthF7IGz9aYYL+g3Owo7qehL/FEQwc0B/wlU94+YnVN+4mk65Tpr2cnXNQV84y0GqgMpaLNy2OjjtEFLWmfVuCV1SsQlaBco6m4TqroLSKQJz+mWS6tgXP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=WrQFlDxm; arc=none smtp.client-ip=192.30.252.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="WrQFlDxm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777564794;
	bh=LX4hCH/v69AYEHaHg1Krbd8kMQf12mOtU89iFBO+5Js=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=WrQFlDxmvAyWDripP9mO1e9UwdxhlItJUAOrmndF/0Hc9sMqeIlnuCE3EVORGgGGx
	 RfbCy0jf9htZJy5An8iTIHlmWjKIvb7tLu5oyZ7/xL4+uLPIw/Lk96UeENW3F6ydd/
	 SE+77yeaDLzOwyHZsPONvH7dNRtDCknUBza5F41s=
Received: from github.com (hubbernetes-node-115ed07.ash1-iad.github.net [10.56.130.90])
	by smtp.github.com (Postfix) with ESMTPA id 853BA920E32
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 08:59:54 -0700 (PDT)
Date: Thu, 30 Apr 2026 08:59:54 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1088223/000000-e6772a@github.com>
Subject: [bluez/bluez] 88fd81: shared/hci: Add BPF filter for registered
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

  Branch: refs/heads/1088223
  Home:   https://github.com/bluez/bluez
  Commit: 88fd81c365dee91d3eaf97945282539636baf809
      https://github.com/bluez/bluez/commit/88fd81c365dee91d3eaf97945282539636baf809
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-30 (Thu, 30 Apr 2026)

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


  Commit: 576c56e190179d7cbecfa5b879705a79e847debf
      https://github.com/bluez/bluez/commit/576c56e190179d7cbecfa5b879705a79e847debf
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-30 (Thu, 30 Apr 2026)

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


  Commit: e6772a47c743ba2a3a84480dbd06b94346cfa74a
      https://github.com/bluez/bluez/commit/e6772a47c743ba2a3a84480dbd06b94346cfa74a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-04-30 (Thu, 30 Apr 2026)

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


Compare: https://github.com/bluez/bluez/compare/88fd81c365de%5E...e6772a47c743

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
