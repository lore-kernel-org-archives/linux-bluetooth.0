Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEFD302767
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 21:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788124559; cv=none; b=T8DSd6telwzKQp89xKf5o0j77z2AurjoaRMZQaXX+exVLOMTBQqsjtjbBUfGbUZV2EWJ1BF87nKOlPA3o2fCB66kmuRgWkrJz2GlpCyOXmMnNroVl9bBSM0xoWa8rp77p3D7SgatQVE/q29pDn5zMQOi1+0Ke9p0hUfkKszHsKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788124559; c=relaxed/simple;
	bh=wfF4AU/e3M9hVE1nshfuzknbDgl7f9fIAPorpB2n/U4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=e1HBDB5IBy7Tn8OMsAnS4oA87Wpwlxrg9oKXTblLhStL2DZqUHYFtDPNqIQiprwTyhPTL/o7VMm5BTFvIEXsDQ3tI5e0PRgyEIqmuY4R8bRYr/iUXcuWlFW9OspcHhHRxWYr3dEq1d3ySZJ5uRlGuh1s/+ImJsD+d+lOpNT29Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Qc4M+g98; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Qc4M+g98"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788124557;
	bh=r2fvKFA6QIU95Vghu0sWgVie2Zf3fsohzZRM+8sS+2I=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Qc4M+g98Wi/WwkQToYvJC8rEg0D3ZcuNTuoj6ocDmYrxsY2+m9lbgcLYkJ2L1jefy
	 p9zgf+OUw64Vr/L/QKM++2tBVKgPJPv72WX8gFEbPIAN1DiwuTHcfdXHmor0WyL9Sa
	 wtwPIBxX2hjgLqOaxfde7ftUoIO0BzGYLylIAiRY=
Received: from github.com (hubbernetes-node-8e6d0a7.va3-iad.github.net [10.48.137.40])
	by smtp.github.com (Postfix) with ESMTPA id 8170D280AFA
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 14:15:57 -0700 (PDT)
Date: Sun, 30 Aug 2026 14:15:57 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1153985/000000-19a870@github.com>
Subject: [bluez/bluez] 046d64: emulator: bthost: add function for sending raw
 L2C...
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

  Branch: refs/heads/1153985
  Home:   https://github.com/bluez/bluez
  Commit: 046d644e7b04f17017a89b5ef644aa81188cedfa
      https://github.com/bluez/bluez/commit/046d644e7b04f17017a89b5ef644aa81188cedfa
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-08-30 (Sun, 30 Aug 2026)

  Changed paths:
    M emulator/bthost.c
    M emulator/bthost.h

  Log Message:
  -----------
  emulator: bthost: add function for sending raw L2CAP sig commands

Add bthost_l2cap_sig_raw() that tests can use to send raw L2CAP
signaling commands.


  Commit: f27102bdb141b1f9f70ec85f5bac9165f0875423
      https://github.com/bluez/bluez/commit/f27102bdb141b1f9f70ec85f5bac9165f0875423
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-08-30 (Sun, 30 Aug 2026)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  tools/l2cap-server: add test for invalid Conn Req on Ext-Flowctl server

Add test that checks Ext-Flowctl server handles invalid connection
requests with ident collisions. This triggers null-deref crash / hang on
some kernel versions.

L2CAP Ext-Flowctl Server - Nval Conn Req


  Commit: 19a87065dd6cbe1d2155bbf50fa5c7435d26e6f3
      https://github.com/bluez/bluez/commit/19a87065dd6cbe1d2155bbf50fa5c7435d26e6f3
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-08-30 (Sun, 30 Aug 2026)

  Changed paths:
    M tools/l2cap-tester.c

  Log Message:
  -----------
  tools/l2cap-tester: test closing sockets with ECRED defer

Add test that does defer accept with ECRED with 1 SCIDs, and
accepts + closes the first before accepting the second. This triggers
deadlock on some kernel versions.

L2CAP Ext-Flowctl Server - Accept 2 Close 1


Compare: https://github.com/bluez/bluez/compare/046d644e7b04%5E...19a87065dd6c

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
