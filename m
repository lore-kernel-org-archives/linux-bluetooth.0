Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC25A253958
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772553875; cv=none; b=S0Z2+YQoRcsPTp4tUujJAkqdj+75yRROWkpTykSMo/padDj43q7Tw15RH6T/BHLe1qcCzsBfX1wjNTL+QOvSo28CFuCM4xljxKJjMwihJRYNvpYOlgWkJleVNHxpvXxcgnxROEhOADtR6a+Bz+DWn6gN7pLJH2kIEJiylOLCbw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772553875; c=relaxed/simple;
	bh=Hc5717K8Mikd1/w0MV6yEodNWMypB4ZbiVLaJAKpeNk=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZwLEUcn2rSek+hC6sWwBs7PO6Y3k9hGu4qKsWr2pz7Ilqb8zoulmibqFkbmM0xo10oSUuMeULH3s0L0pU46EFsJ02Z8t/uyiM3CWpk0wr66avvzTiGtqExnMPfm0/4qSo39SGd/KuhEH4IftAALhok6V53x5NsNmQwCCFS2SQDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=AMsH81Jq; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="AMsH81Jq"
Received: from github.com (hubbernetes-node-7746806.ac4-iad.github.net [10.52.148.38])
	by smtp.github.com (Postfix) with ESMTPA id 335B9643FAD
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Mar 2026 08:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1772553632;
	bh=DGHQA76VrbdihYtDfQtyfzHUgHtgUxopWGznV+oOdwQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=AMsH81Jq9sNA9oe0zZ1pWUly4SENXG9+aFnspCJiF7NrVVtYYYCJgOE3WzjGvpbrM
	 QWChYvqCnIWvpOjFMb4zLBKvrwN16l/G3KFfWoJAeGHEESMZ/evuqP1Rue8/M0EDYA
	 HH3bdFaF6R8q8Y/yJnwP9xpEAwkA/x7rlfL+ptKs=
Date: Tue, 03 Mar 2026 08:00:32 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/081dfd-b138a0@github.com>
Subject: [bluez/bluez] 744fad: hciemu: Fix silently dropping packet if writev
 ret...
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
  Commit: 744fad3c342e79bf41713e440378a726a680e633
      https://github.com/bluez/bluez/commit/744fad3c342e79bf41713e440378a726a680e633
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-03 (Tue, 03 Mar 2026)

  Changed paths:
    M emulator/hciemu.c

  Log Message:
  -----------
  hciemu: Fix silently dropping packet if writev return -EAGAIN

The code has been silently dropping packets due to lack of buffer
since hciemu design is single threaded it cannot do partial writes
or flushes to force the buffer to be consumed and give space to the
next chunk, so in order to fix this the code will now attempt to
detect if a socket runs out of space and automatically bump the
buffer with use of SO_SNDBUF.


  Commit: b138a0849ba26310c3f40e78037565ce274d8737
      https://github.com/bluez/bluez/commit/b138a0849ba26310c3f40e78037565ce274d8737
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-03-03 (Tue, 03 Mar 2026)

  Changed paths:
    M emulator/bthost.c

  Log Message:
  -----------
  bthost: Add segmentation support for L2CAP LE-(E)CRED mode

This fixes the following tests since the kernel now attempts to
check if a segment length is bigger than the MPS:

L2CAP LE Client - Read 32k Success - run
  Connect in progress
  Client connect CID 0x0040 handle 0x0001
  Successfully connected to CID 0x0040
Bluetooth: Too big LE L2CAP MPS: len 672 > 188

L2CAP LE Client - RX Timestamping 32k - run
  Connect in progress
  Client connect CID 0x0040 handle 0x0001
  Successfully connected to CID 0x0040
Bluetooth: Too big LE L2CAP MPS: len 672 > 188


Compare: https://github.com/bluez/bluez/compare/081dfd785fe5...b138a0849ba2

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
