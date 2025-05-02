Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2924E2609D1
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 17:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746208641; cv=none; b=I3JYYaNlzefkcYiqYmk96p7c51DMKYMa6KZnv9DuqqYL8Xpl6w56TN9Iptik15DI4CKxPN1YMJQM9KAgehus3t/G+s8hKewLXaYYaphc7wMQR08QGKZ5o+hAqfLeSgNLoqYnm2bUBw5vppFye1Jcr0wsrV21WgfMii9ch3roGZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746208641; c=relaxed/simple;
	bh=15wy2j54F9EYzUPrKyZrEgkmamKkJGldiKzcPk0qF0A=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=u/9inaNg0WdqUYjiTbzQ+lJEfD01QlBe7rrvB4hOdgiFkdZ6gvETV0rDvqYlooz0aQXoojYhYtoN+LNxhAawUsrUImeOfKeMcL3rZqSw+p8SijTiv9eKlIBefKR0tk0T3hIB/0Su7F86QhNixrpREzsf/QV5K22cE3L3VaiHQWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FKz9g9vh; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FKz9g9vh"
Received: from github.com (hubbernetes-node-cf50fbc.va3-iad.github.net [10.48.148.35])
	by smtp.github.com (Postfix) with ESMTPA id 2837D8C05A1
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 May 2025 10:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746208639;
	bh=YyxsxR+5KeIBxaLUzTyYA8hO4EHVw3RKH0rmsskolts=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FKz9g9vh122nHOPT+lN0Ccyil+980h/RUNW0vdM9Xujeu6O/uCBHcdirc+Tn3sL+S
	 2B+Fg8UWSiEUH/rWlAr2EaYm3Wzg6ywb9l8paiIPOLvWF68b+vFwEUsRXvC9wrVAnt
	 sFNY2YL/jiwa0Y4W4yh5apfbyjN24HsCkEp2KmvA=
Date: Fri, 02 May 2025 10:57:19 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9c5218-0831bd@github.com>
Subject: [bluez/bluez] db790b: doc/l2cap: Fix BT_POWER default
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
  Commit: db790b7d691654a2041ea56efc96281d428febf6
      https://github.com/bluez/bluez/commit/db790b7d691654a2041ea56efc96281d428febf6
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-02 (Fri, 02 May 2025)

  Changed paths:
    M doc/l2cap.rst

  Log Message:
  -----------
  doc/l2cap: Fix BT_POWER default

Default is actually BT_POWER_FORCE_ACTIVE_ON as the kernel code
net/bluetooth/l2cap_core.c:l2cap_chan_set_defaults do:

set_bit(FLAG_FORCE_ACTIVE, &chan->flags);


  Commit: 0831bd39a0bde1492f2174153b60b582c4f3100e
      https://github.com/bluez/bluez/commit/0831bd39a0bde1492f2174153b60b582c4f3100e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-02 (Fri, 02 May 2025)

  Changed paths:
    M doc/rfcomm.rst

  Log Message:
  -----------
  doc/rfcomm: Remove BT_POWER

BT_POWER socket option is only supported by L2CAP sockets.


Compare: https://github.com/bluez/bluez/compare/9c52188d7530...0831bd39a0bd

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
