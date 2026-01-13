Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4DE280335
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 22:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768344152; cv=none; b=X3fDGNiZlCw7xqZHh+N0fQ2OLAo6GMl6tDzXD93kmTpxssUuj5X13Ml+L08O8yr4OhdXJdejcR83/ZFgIs9aIQn3GhHgiBjfAyr8Wbp1rIauaaPuA/VUWWrs08ffNRz7sZbjGeiE7iDEJUzRQu+sDL4Kr9oB0xoMH0KrZUa9Ujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768344152; c=relaxed/simple;
	bh=iVHYizv7dZmwMOqdEtV2sv9lAOtf5F7Vv5PvDy7nAoI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kxKjPVoj7l6DlhMQZde2A/Z0uYVLPRWyPb1OsJDkcm+BF2osNqFfyE/9OF2cGO6rbMPSWS5jDJkDZGspAaRInkqHuAV/AQvRwzJ8TbX+v2gSXg3DRr+lVCWDln/nhUEuPAHrmog5kOShX0Ob2mxUsFOJdWGFOxL6whvbk6jl68g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JaPh2thr; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JaPh2thr"
Received: from github.com (hubbernetes-node-4bb5584.va3-iad.github.net [10.48.167.52])
	by smtp.github.com (Postfix) with ESMTPA id 34ABAE0621
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 14:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768344150;
	bh=IBSs6qaaHas38LINtU4yTiYmP48Wj/+Za805F4qKJjo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JaPh2thr2qGXBYJm2iP8GFRXzIEH7sXAPoT+cXmJnhaq2TN8pUNmLj5h4hVvwWO0T
	 jH11kwCw1SAJGzV6Pbqy8Nectu3ibJL5HdROrDlnxmEJeI+n/F9cE6Y+ejU8/xVekn
	 rr1k3gL1HmpQePd0ufEapdBKsH2/IB2yNJoezoA4=
Date: Tue, 13 Jan 2026 14:42:30 -0800
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/a94f99-4ce4b5@github.com>
Subject: [bluez/bluez] e9f2c8: shared/mcp: emit MCS error if value changes
 during...
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
  Commit: e9f2c8fdc676e8d33ed1a3be144594ebdfb620de
      https://github.com/bluez/bluez/commit/e9f2c8fdc676e8d33ed1a3be144594ebdfb620de
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-01-13 (Tue, 13 Jan 2026)

  Changed paths:
    M src/shared/mcp.c

  Log Message:
  -----------
  shared/mcp: emit MCS error if value changes during long read

MCS spec requires emitting Value Changed During Read Long if value
changes between remote reading with zero offset and nonzero offset.

This is session-specific state, so add support for that.

As server, track value changes and emit that error properly.

As client, we don't need to reread if this error occurs, as there should
be a notification or track changed that queues a new read.


  Commit: 4ce4b5d679ab62bc6361207c67007e9e6df22779
      https://github.com/bluez/bluez/commit/4ce4b5d679ab62bc6361207c67007e9e6df22779
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-01-13 (Tue, 13 Jan 2026)

  Changed paths:
    M src/shared/mcp.c
    M src/shared/mcp.h
    M unit/test-mcp.c

  Log Message:
  -----------
  test-mcp: add tests for long value reading

Add server tests for handling the Value Changed During Read Long error.

Add similar client tests.


Compare: https://github.com/bluez/bluez/compare/a94f994201a6...4ce4b5d679ab

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
