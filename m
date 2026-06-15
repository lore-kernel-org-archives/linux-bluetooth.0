Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809A33911CA
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 21:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558212; cv=none; b=QIVcBERo9JcpIJccXN8kzSsJbXDQhazNLOqlG/I0sc+Ppq09T7DW3FEpWYEcd1ETPbm0Jt0hEu0NeKrHxPaF0wzmtKNSDCzT278iOgZAC0dN5gKpfbCNjTKcJXy/kMw721vv6tAShw5y6qnqKKWq+mAT/FEZgOQJfBNmjeeD1FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558212; c=relaxed/simple;
	bh=9UHiNw/eBoMLNW/cmTIWUDqYJUmFSORRZlXGQTlgQPI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=IvuPO8mzWEuAhX4QPWLh6Vx4CaFgZcvBpgYq4BpoxTkv9obnZVgsDR7qUy40ZOUaCa1Xbj1ezUYoffrqklmjYOzZ0qpbPSf7yKebFtcF1fCkL3/ltMlRy4fC2G5c3cA4GWrmFkKXAxiEZFFDQuIJ//FrBoeKoWrEs+0IJNCklc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MEjSzRrd; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MEjSzRrd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781558210;
	bh=UMmYbdJLnCLG/zq1mgfNU2vRSA1rl/le5XF5fiYKpw0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MEjSzRrdXDOfWOQMzG9pbMIOcn+wybE4tHmmBtamSrka0/9QSZUEYf9GAuIdYSTtB
	 CyTdM/SNdGjtBwoZ448gC/OMBb5EnD/LdOB6frcjiZQ1hHpNediZ8o2+ClqJuG1W6v
	 +A18XTYKd++f0z4kdVc4Eah+md1eoS/GATzbh4vA=
Received: from github.com (hubbernetes-node-2131695.va3-iad.github.net [10.48.170.41])
	by smtp.github.com (Postfix) with ESMTPA id BE4B31811F4
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Jun 2026 14:16:50 -0700 (PDT)
Date: Mon, 15 Jun 2026 14:16:50 -0700
From: =?UTF-8?B?xaBpbW9uIE1pa3VkYQ==?= <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9c36e4-5297cf@github.com>
Subject: [bluez/bluez] 80ec1f: test-bap: Fix using BT_ISO_QOS_CIG_UNSET for
 CIS_ID
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
  Commit: 80ec1f9d01c44768219c2842795652c6b6bb291c
      https://github.com/bluez/bluez/commit/80ec1f9d01c44768219c2842795652c6b6bb291c
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-15 (Mon, 15 Jun 2026)

  Changed paths:
    M unit/test-bap.c

  Log Message:
  -----------
  test-bap: Fix using BT_ISO_QOS_CIG_UNSET for CIS_ID

Although there are the same value the proper define is
BT_ISO_QOS_CIS_UNSET.


  Commit: 64ae65d8958e67fb65f7413ef4ceab2ad51a6b28
      https://github.com/bluez/bluez/commit/64ae65d8958e67fb65f7413ef4ceab2ad51a6b28
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-15 (Mon, 15 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Initialize ucast/bcast IDs as unset

Also change some lines where CIS should be used instead of CIG.


  Commit: 5297cf2b6af6970e12081e20f1a978c2bf52fd1f
      https://github.com/bluez/bluez/commit/5297cf2b6af6970e12081e20f1a978c2bf52fd1f
  Author: Simon Mikuda <simon.mikuda@streamunlimited.com>
  Date:   2026-06-15 (Mon, 15 Jun 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Don't link server ucast streams before CIS IDs are assigned

bap_ucast_io_link pairs streams whose CIG/CIS IDs match, but the IDs
are unset in Codec Configured state, so a Sink and Source bound for
different CISes get linked. The stray link later propagates a
disconnect to the wrong ASE and breaks Receiver Start Ready.

Skip linking until QoS Configured assigns the IDs.

Fixes PTS test BAP/USR/STR/BV-362-C


Compare: https://github.com/bluez/bluez/compare/9c36e4189e32...5297cf2b6af6

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
