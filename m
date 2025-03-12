Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEF71D63D8
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 16:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741797948; cv=none; b=OyiJRxXopE6jsfT5lSLBvAKeO0mvaUm6WN/CLLklzkXRMuGVof4KPzLpRhOI8SKN/WaNQ8U6hAgaqM/o8/up8JgnG9ckak3nyHRrxtbmAkmm7m2SqC9IKUGtvjQk0pS59nsWZ85ibITMe7cxf0C6K9O1Ojwa1uNk2mlpY4Z8U0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741797948; c=relaxed/simple;
	bh=kwYLOg5K9trJSbG0q2Lfg+9nS4FPUQOTg0PN9G+wsd8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RdMzHVAAA5TUxQ7ixD1T8NoWNIJ5jNQ+65WiSfMueVJ/iELkmCiG9Bk/q/1foL1a+DzPzG+mg9u6udUOB/jlPgDt8HJjUAFunx2sBpDdSLqd1e8b5Zrh1AB8/xvbwNlQDeCITmfgnqjP1tAIoz71wH+68C6oUYbXwGr1r+XtnRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MEHc++/j; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MEHc++/j"
Received: from github.com (hubbernetes-node-43b47b7.ash1-iad.github.net [10.56.150.43])
	by smtp.github.com (Postfix) with ESMTPA id B8CCB92095F
	for <linux-bluetooth@vger.kernel.org>; Wed, 12 Mar 2025 09:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1741797945;
	bh=WbeduhRr47++DS/kdQX0k7idSZDuVAQqiitjEiS/gmM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MEHc++/j7dGjPPEAe8XT0QMNni0MR8GoXuqyOFwqsIAa/BlGKsn73x8+qJbyFMp0K
	 p2q2cmuwS+uZasvIxo5JkZMpn3HhC00aTxKnO6FyXIk+Jb05741wIBLHy+OD32HoDG
	 7idg0rSfZpHWyzGtxU/VB/LBjv5jAmuG9k4Cogt8=
Date: Wed, 12 Mar 2025 09:45:45 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/adcd73-d4749c@github.com>
Subject: [bluez/bluez] e3b275: share/hci: Fix data type in bt_hci_send_data
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
  Commit: e3b2759634d4bd244c2090a96c76aef5a118c93d
      https://github.com/bluez/bluez/commit/e3b2759634d4bd244c2090a96c76aef5a118c93d
  Author: michael_kong <kx960506@163.com>
  Date:   2025-03-12 (Wed, 12 Mar 2025)

  Changed paths:
    M src/shared/hci.c

  Log Message:
  -----------
  share/hci: Fix data type in bt_hci_send_data

The data type in bt_hci_send_data shall be ACL, SCO or ISO.


  Commit: 8e835a685935b8e90fb45b96e6781d8332b00ef3
      https://github.com/bluez/bluez/commit/8e835a685935b8e90fb45b96e6781d8332b00ef3
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-03-12 (Wed, 12 Mar 2025)

  Changed paths:
    M tools/mpris-proxy.service.in

  Log Message:
  -----------
  mpris-proxy: Avoid spurious warnings when dbus.service stops

The systemd services generates a warning when it loses
ownership of its D-Bus name, which happens routinely
when dbus.service exits (e.g. when the user logs out).


  Commit: 8fba2cd3b71267a9aad125f03ff39c0cfc2733bb
      https://github.com/bluez/bluez/commit/8fba2cd3b71267a9aad125f03ff39c0cfc2733bb
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-03-12 (Wed, 12 Mar 2025)

  Changed paths:
    M obexd/plugins/phonebook-ebook.c

  Log Message:
  -----------
  phonebook-ebook: Fix typo: s/registery/registry/


  Commit: d4749cfd7fba432341f335147833c3204c533aa9
      https://github.com/bluez/bluez/commit/d4749cfd7fba432341f335147833c3204c533aa9
  Author: Andrew Sayers <kernel.org@pileofstuff.org>
  Date:   2025-03-12 (Wed, 12 Mar 2025)

  Changed paths:
    M HACKING

  Log Message:
  -----------
  HACKING: Fix URL for submitting patches

The previous URL is out of date, and now just says
"This file has moved to process/submitting-patches.rst"


Compare: https://github.com/bluez/bluez/compare/adcd73901831...d4749cfd7fba

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
