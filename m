Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 122B738DD3
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 23:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764977982; cv=none; b=VUSykD6Kvt2uAB2HuFRtS0wpbRRnRNOMO+eZEKu6QCuIAskjn1DUlNof86xWHZZhHHt8Qk6HoEqQxzWoBFz234biRyOkFOxYwa9pBGpeV+zCaC9ByiZjQeODjOjhpnL5XEoCiW5AXKsUNMQ7dplVVWWWqVvt16vQvtkHDY+luOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764977982; c=relaxed/simple;
	bh=guw1AcncKoYFWFks+pDVr7Bi4ygqCnlmkI7hKeYuvZc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hvV+4zP5sJoJ5sbmDJBanAJQRu8gWA/UjJHRbf2fDYlbDTGLn2rAFL3QMBa5oYjurIrmmu7UYfm/+G1HgASWxIVKKCGLijj7+E86rgBvrmHBbd2fT6kcPTWoo5KX2VvhQLCq867xzRFG2/QYtgQ6RahndoxxKloMhDmj4+vpVrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=X99DeEih; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="X99DeEih"
Received: from github.com (hubbernetes-node-6305e42.ac4-iad.github.net [10.52.172.40])
	by smtp.github.com (Postfix) with ESMTPA id 269F96406DA
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Dec 2025 15:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1764977980;
	bh=N6Ngfct+/Vjzgm2iYGg+5vGHtE9maNAuuHK9luKqnrs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=X99DeEihzR5B0mG2WEvBmOjjSjJsep75h1ASFBmhOmiDWjio8O39/XBTwBkv4dHk0
	 K+u4pg5/tHGveRhWbQfuMLjLpA5wtYSMdpkZ+lp/oWoOyfALrxlU0/MdLkpCEQXXhI
	 fUsOxrroEuFiCkByi3kTtBJHva187dGvi+032mQM=
Date: Fri, 05 Dec 2025 15:39:40 -0800
From: Andrey Smirnov <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1031008/000000-22059e@github.com>
Subject: [bluez/bluez] 22059e: monitor: Add unknown options decoding for
 Configur...
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

  Branch: refs/heads/1031008
  Home:   https://github.com/bluez/bluez
  Commit: 22059e38e49e126e4af68722378fc3184ab56deb
      https://github.com/bluez/bluez/commit/22059e38e49e126e4af68722378fc3184ab56deb
  Author: Andrey Smirnov <andrew.smirnov@gmail.com>
  Date:   2025-12-05 (Fri, 05 Dec 2025)

  Changed paths:
    M monitor/l2cap.c

  Log Message:
  -----------
  monitor: Add unknown options decoding for Configure Response

Unknown options respose for Configure Respose packet has a different
layout that that of unaccepted options, so it needs special code to
handle it.

Before:

> ACL Data RX: Handle 12 flags 0x02 dlen 15
      L2CAP: Configure Response (0x05) ident 2 len 7
        Source CID: 64
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        04

After:

> ACL Data RX: Handle 12 flags 0x02 dlen 15
      L2CAP: Configure Response (0x05) ident 3 len 7
        Source CID: 65
        Flags: 0x0000
        Result: Failure - unknown options (0x0003)
        Option: Retransmission and Flow Control (0x04)



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
