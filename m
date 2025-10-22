Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74651F584C
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761164141; cv=none; b=jSqgFIMmexW4JkPO+xpenLNXo3eDU7lEfTyAh3Vh6B3lMSE6kYXkFJEauqM4aEjjRVkgzHmSOZH7OWimT1arVXPkgdiAb5zD6ihhTGONngeqk/7vO9HvBSC3kfNWuV07uzeDWoUYehlc97zeeWcRBHaDEihyGPXrhFy2ZA4npDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761164141; c=relaxed/simple;
	bh=nJa8lixAfkJqE1yH4ah2JLYgOwgIo+lylR/oZEJT4Pw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=RPUePeR3xCI89u7IPrGEQltpBrNQxKdbJV5tus/Rx18etJLGviaV3KtSsedwcnufvTg2IV+ZKgFnxGjH5deQmzGjGoViePEapaC2P1rh6C3KvaCp9BWCTJL/otqKTkiq2ePW2Qmfe/GfeLTt3hia6U3zbzmnTFOJTdIGB+/N7A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZPt84FOy; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZPt84FOy"
Received: from github.com (hubbernetes-node-a55f3c5.ac4-iad.github.net [10.52.202.57])
	by smtp.github.com (Postfix) with ESMTPA id 101EB400DEC
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Oct 2025 13:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761164139;
	bh=cWJdgcq1BRxny5h9Ibu86ycTai4CE9guAsig6Mv0yCA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZPt84FOyXq9C5C3OGTYHLGujW9ZgMoLtkhsxJPJ7WkFxaYC1TbSS0aSp8OiXh6pAc
	 NC2oY41aoj27++4Ols2rRLct47SjqX1t3P1nWL6RtsJIJFyYmACkRaYgylAqber61V
	 f0NGyc3kNnV9tVIPJ4zVxLG6zLuSfNPqiaoC2KNE=
Date: Wed, 22 Oct 2025 13:15:38 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/39b541-9faf12@github.com>
Subject: [bluez/bluez] 0ff04a: ioctl-tester: Fix handle value
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
  Commit: 0ff04a94a69ccd1783f446f59de6050d79ca3604
      https://github.com/bluez/bluez/commit/0ff04a94a69ccd1783f446f59de6050d79ca3604
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-22 (Wed, 22 Oct 2025)

  Changed paths:
    M tools/ioctl-tester.c

  Log Message:
  -----------
  ioctl-tester: Fix handle value

Recent changes to emulator has changed the ACL handles to start at
handle 0x0001 in order to use dedicated ranges for different link
types.


  Commit: 9faf1244a93217775e31ed5ef3b656d4430b63e1
      https://github.com/bluez/bluez/commit/9faf1244a93217775e31ed5ef3b656d4430b63e1
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-22 (Wed, 22 Oct 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Print data if LTV and data length don't match

If data length and LTV don't match this should be made visible so
issues like the data coming as all zeros as bellow can be detected:

> HCI Event: LE Meta Event (0x3e) plen 50
      LE Periodic Advertising Report (0x0f)
        Sync handle: 64
        TX power: 127 dbm (0x7f)
        RSSI: -55 dBm (0xc9)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x2a

Versus:

> HCI Event: LE Meta Event (0x3e) plen 50
      LE Periodic Advertising Report (0x0f)
        Sync handle: 64
        TX power: 127 dbm (0x7f)
        RSSI: -55 dBm (0xc9)
        CTE Type: No Constant Tone Extension (0xff)
        Data status: Complete
        Data length: 0x2a
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
        00 00 00 00 00 00 00 00 00 00                    ..........


Compare: https://github.com/bluez/bluez/compare/39b541edb273...9faf1244a932

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
