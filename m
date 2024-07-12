Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C371F93E
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jul 2024 19:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720811469; cv=none; b=j2+STRs/xViCweaLQh/XzeGP5WW8vgEEJ9/k9eElVHr0Smf3Bygot22pANo4NMShM1aEB5TrQ2Xj0zUHg+Tafc3BOlgtDiOALdwdWsPfsLDPlClHVH4MItfZLLeI7UtYUcoQSpHEK+BFniIaKwVARitVC6FCSq/f8d7MiN4Gcj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720811469; c=relaxed/simple;
	bh=W4O8EAdVZwTru4grFtAqzpx1SgzT2ce/N8tkyWjS/jU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KZ9DLKwVhN0pcRECBN/j8coABfpaKqj82KwuaTP8PMVcWTmV5kVgvncCBhE5WE9nX5mbeYZzzXmiIhPFLakbWBY+8a8gNKzCYQhZVpyR7Jlb0G+a2ORXhhK1XLn7VQASDidFI3Mp7C/+K6aOlejh7Go3hGQxdUUA7V+Y2YbUHXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=isAcvPL4; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="isAcvPL4"
Received: from github.com (hubbernetes-node-88bf5fe.ash1-iad.github.net [10.56.154.28])
	by smtp.github.com (Postfix) with ESMTPA id EECD91412FD
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jul 2024 12:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1720811466;
	bh=9gAXKBeG06MPxP3t4m0URplebhVF9czSh//tEpPlWPA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=isAcvPL4Rc1XrRCE6RBIgPmTLni8q0DmZMBfXjgd3DbeXuezJ4x79J7B1U1iwItE0
	 XNYBUCTSPZteBNhRI7dObNDVnm3ZjClG/NbXInaffPK2E9Qz/pe0l6yyUcsx2l6TNm
	 +B3tTObEpdk6Q2yQ6e6Nh04CGYvBhdtEaV/3HVHQ=
Date: Fri, 12 Jul 2024 12:11:06 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/7a4503-9cc587@github.com>
Subject: [bluez/bluez] 9cc587: device: Fix overwritting current_flags
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
  Commit: 9cc587947b6ac56a4c94dcc880b273bc72af22a8
      https://github.com/bluez/bluez/commit/9cc587947b6ac56a4c94dcc880b273bc72af22a8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-07-11 (Thu, 11 Jul 2024)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  device: Fix overwritting current_flags

MGMT Set Device Flags overwrites the current_flags so only the last
flags set this way would remain active which can be seem in the
following sequence when LL Privacy is enabled:

@ MGMT Command: Set Device Flags (0x0050) plen 11
        LE Address: CF:AC:A6:79:3D:B9 (Static)
        Current Flags: 0x00000001
          Remote Wakeup
@ MGMT Event: Command Complete (0x0001) plen 10
      Set Device Flags (0x0050) plen 7
        Status: Success (0x00)
        LE Address: CF:AC:A6:79:3D:B9 (Static)
@ MGMT Command: Set Device Flags (0x0050) plen 11
        LE Address: CF:AC:A6:79:3D:B9 (Static)
        Current Flags: 0x00000002
          Device Privacy Mode
@ MGMT Event: Command Complete (0x0001) plen 10
      Set Device Flags (0x0050) plen 7
        Status: Success (0x00)
        LE Address: CF:AC:A6:79:3D:B9 (Static)

In order to do this properly the code needs to track the pending_flags
being set and also call btd_device_flags_changed whenever a change is
complete since that event is not generated when MGMT_OP_SET_DEVICE_FLAGS
is sent by bluetoothd itself.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
