Received: from out-7.smtp.github.com (out-7.smtp.github.com [192.30.252.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926D3242910
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788114281; cv=none; b=AmF9rETSymJKICVCPNetQGzKtkxzkQaLjna2zJR/BBWS50iY3JPjhkasKquKo9+KiMyWMXePZIh5nol4VClneV7QbIVVFZg4eI2wTLTefRpSQCE1yVEmZVxp4wYFUROrGI342QXjlyuqlYGYhVLxqDx7WYZCohzEJR30o7Mzoq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788114281; c=relaxed/simple;
	bh=NMAORHlS3fIkeR9pycz4KTggrqyGZSNAbDvTeD4R2ok=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bBFbarGZJG/3BXYqfm3nkjLh161AvbjpaWXgYyhpoD1cDGGuuAfQksfO6hxwgCxspvaFmDp4yOs8EzEuOmr6VTqtNzwfDmuaT+ZOljbH7I+SapUKAm3rBOJLfPFmbKPZqQR1j1sQkrtW78gdSAEtq71y5T+VMNPP4eqRpB3lJLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=kwBFjHI2; arc=none smtp.client-ip=192.30.252.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="kwBFjHI2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1788114279;
	bh=C2fSXmw3fmOgML0RBWfN450Vwxik/Uu3XPQ/rXvMjeU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=kwBFjHI2auZVPjuQ7iOPfktHU8+mb46l8UwRgkK8RsvRKJe6HMEwGCcGoUBttYgSA
	 XXoMjbceRkMU7BB55YE7Gz+EmUhnGOQeIW+Ich0z7si4NRWW7LaiWDVs7tBsxVtIqF
	 MpK8DvTtPU5GIKqqQUtNCw62napSd7p7ezgWDKRw=
Received: from github.com (hubbernetes-node-47f2c78.va3-iad.github.net [10.48.178.45])
	by smtp.github.com (Postfix) with ESMTPA id A81487800E5
	for <linux-bluetooth@vger.kernel.org>; Sun, 30 Aug 2026 11:24:39 -0700 (PDT)
Date: Sun, 30 Aug 2026 11:24:39 -0700
From: Pauli Virtanen <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1153956/000000-6f01a4@github.com>
Subject: [bluez/bluez] ace43b: emulator: bthost: add function for sending raw
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

  Branch: refs/heads/1153956
  Home:   https://github.com/bluez/bluez
  Commit: ace43bd022cd4fc18d065e06421f196f89afeaf3
      https://github.com/bluez/bluez/commit/ace43bd022cd4fc18d065e06421f196f89afeaf3
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


  Commit: 6f01a45f06cbce1e14bee0ab241358a10954da4e
      https://github.com/bluez/bluez/commit/6f01a45f06cbce1e14bee0ab241358a10954da4e
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


Compare: https://github.com/bluez/bluez/compare/ace43bd022cd%5E...6f01a45f06cb

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
