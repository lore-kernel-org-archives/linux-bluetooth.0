Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2365D36F428
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 12:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775479784; cv=none; b=tGchCyqO86PrelYryMWUG/q/DalEjU55suTFQLThPScXTCC49qwLM4XZdZdbZnaPUKADBvCzv8s1xKAlfljXJ3AaNJrrMptVluw5iMDuGDEFnmLK4+G6JKNM+uGcijINlYzcTP4igwN/JPLv6HVqiae3f22FZdyXB+BRoOA9iJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775479784; c=relaxed/simple;
	bh=wnu5Yd/gnW7Lx4u6cB8WQpbU/uvz4Vcr/T8GDRuNMvs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=g7u21C20fQ5X7oG6XT353WQTe09mizUlhjvFXPiAyGYeWaekzdTLsHh0iFFEWZl5JsV0r4K6KB1ArugwcNeTiOtme6T5DCHHBLYV00SzAK/Tz/s7zHUvZZ57B6rMPUw+hbL+4aAj7NzOls8ulFqrTl1oxt/8M54182HJ4L4Xyjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mcsOV6w+; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mcsOV6w+"
Received: from github.com (hubbernetes-node-6b3ce89.va3-iad.github.net [10.48.145.17])
	by smtp.github.com (Postfix) with ESMTPA id 6C8924E0E03
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 05:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775479782;
	bh=XM0f2PxX2w0BOkYcsFZ0gBvpARhhxYPVUSm94C8Pr48=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mcsOV6w+Mqt/RtwVgQOOA48DMcytMIqAZn4Buuf+P423TXUKPR5VmuKgwbRp7hHqV
	 0IBY9Wh0oWGL7LFkDxqA+kYb2JgbPPJRP9Lee3kBIpN7/QeGa5R6YB63q4a9duku7H
	 KyCJrOaSZgDZvYCHnzs5ZhgrjFflupbey0UE/KHg=
Date: Mon, 06 Apr 2026 05:49:42 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077651/000000-39d78e@github.com>
Subject: [bluez/bluez] cf18b0: shared/mcp: fix crash on destroy after ATT gone
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

  Branch: refs/heads/1077651
  Home:   https://github.com/bluez/bluez
  Commit: cf18b01149155f7cd2294ceeb79b338cff778fbd
      https://github.com/bluez/bluez/commit/cf18b01149155f7cd2294ceeb79b338cff778fbd
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M src/shared/mcp.c

  Log Message:
  -----------
  shared/mcp: fix crash on destroy after ATT gone

Tie lifetime of bt_mcs_session to that of ATT disconnect watch.  The
disconnect handler is not necessarily called before ATT is freed, but
destroy is.

Fixes UAF of session->att in bt_mcs_unregister() -> session_destroy() ->
bt_att_unregister_disconnect() if ATT was freed first.


  Commit: 39d78e7712d5e1ce5f1071776ae0a445802f3244
      https://github.com/bluez/bluez/commit/39d78e7712d5e1ce5f1071776ae0a445802f3244
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-04-06 (Mon, 06 Apr 2026)

  Changed paths:
    M src/shared/mcp.c
    M unit/test-mcp.c

  Log Message:
  -----------
  shared/mcp: fix parsing of control point arguments

Fix parsing of control point argument lost in rebases.

Add tests for Move Relative command that need it:

MCS/SR/MCP/BV-12-C [Move Relative from Playing]
MCS/SR/MCP/BV-13-C [Move Relative from Paused]
MCS/SR/MCP/BV-14-C [Move Relative from Seeking]
MCS/SR/MCP/BV-75-C [Move Relative from Inactive]


Compare: https://github.com/bluez/bluez/compare/cf18b0114915%5E...39d78e7712d5

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
