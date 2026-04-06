Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF8928AB0B
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 14:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775484121; cv=none; b=fO2afDFKpuKaebScbeK7d4gL1+NUKsZz7XUQC3EctZv7DW7le9DdJXYMGCWECTqI7dM8MPZIKKxC/8ZENRZDvvCy7OEa2VxeXreR11R+qAZcmg1u19mpqL7SICpxFyf2Gn/iuehJLQqINBmWwoJt3mGisC02p0T3DsOgnaGJq0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775484121; c=relaxed/simple;
	bh=g5dhnvpK/fdLsyUpyUmsYxb4/QHe1En8rK0LF3Pwblg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mwSibdOTQh71jmYj3HfeIl7LdVAf7O+QB11UKgENfKPx1zrdu1UXICqJ2smXZUfOLXrtCUh2bIlHLXjYmfipNb2mhurfFZJMoZwDNbKxyuHvkBMgCG29CgCWuzN/a1H/5x4j9EJF0ulwxOIgz9XJD8MmxZVWHH0QavXSD8ilJmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FoavmY3V; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FoavmY3V"
Received: from github.com (hubbernetes-node-ed4c203.ash1-iad.github.net [10.56.226.78])
	by smtp.github.com (Postfix) with ESMTPA id 3CECEC1AAA
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 Apr 2026 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775484119;
	bh=h/0pgRCx2qN07O6XvW6dK1FeHO3kvFJWxVHB4kyg+zs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FoavmY3VTlkqudAF5HVBCMMEeqP7PksoAtIbeJo0GuHbQL9sBCkZ+aNFt1RdC1VsL
	 5bI52NO+1u5cu02df52zRB3HDL8SR25wW7h6LVKatms6kmJ4xWRT1wD/dJ/R6g5Hrf
	 XWOJTruNdsxD78R1bZcrUIuyiBB6UWPRx3ndilH4=
Date: Mon, 06 Apr 2026 07:01:59 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1077654/000000-6a643e@github.com>
Subject: [bluez/bluez] 5a7a91: shared/mcp: fix crash on destroy after ATT gone
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

  Branch: refs/heads/1077654
  Home:   https://github.com/bluez/bluez
  Commit: 5a7a91116c9d6b1d9cab858b9d198ac3ff2fe329
      https://github.com/bluez/bluez/commit/5a7a91116c9d6b1d9cab858b9d198ac3ff2fe329
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


  Commit: 6a643eb08d1ccb622f847683e739aa242f2ef359
      https://github.com/bluez/bluez/commit/6a643eb08d1ccb622f847683e739aa242f2ef359
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


Compare: https://github.com/bluez/bluez/compare/5a7a91116c9d%5E...6a643eb08d1c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
