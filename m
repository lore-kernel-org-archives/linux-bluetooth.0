Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57F2DE6E6
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791575604; cv=none; b=uDl6xueF0lNhHcNfO/X5JyEkBGGTfF+6nLX0w9oLqd0xup7zIiAAHcfEFZ/O0Es3LOVKRvKWs/uvgkhCzTerTELRCEB9/B2w45xrDUxHhz5xud9FVwnpwkW5IDCqjnbnrFJHZ1LedmJDj3rQAf+VeDnMWwfi4B6dAbil0N1YFzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791575604; c=relaxed/simple;
	bh=5fAw3sc0kOP0TrH9iapAjLiyXc82fSj1g5dAD/sXNvc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EbDvmmQGv3yA2CVm1j3I9OXQMfeevq5aDC3/Ua03Y+7ltV3Qe32WudzqZ1J90xAIpg+FeYYKSwIden8SuBX0SSdK4UPmpu2eVMk3007tFpoiSsxZhh4MiydfRz0RcqBe6VKecOI1WKwQVairypOJcS38taCBSmRHGum/Fr7XCfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=QjsMy+xx; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="QjsMy+xx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1791575598;
	bh=ahhT1d+5ZJ0RegFm71Xnzhz6gTN7jZ7+KOwo8VojhMY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QjsMy+xxcGvg3MYRoO8Fbue1nLO/DSV0/vNvBC1Manr77wGXXqcaXfs/GCDTRxCsT
	 wAEY4XDlRXbOFd68NkMlQuzWVjb41ZcleubcigdURgTxKEgHBUbDU0uAVMh1tnhMOy
	 HVh+ba6JlBLKgKNdAH60IPkfXkdIMRx6SORzm6jpddLZqgldb+ow/1IDsgh2pl/XSC
	 0MQ970RnxrpyhmcsJd2JZnlLhR7U/KykjxhaEgwi8CnHqXyqJMbswOCbx5gCoqY/rl
	 lOJlmgStcO0tsczyBmvrx2leCuSNc8iiU35gBNf5oHSZZ+FZ3g4PUvQtFuan9d1n59
	 CVEj9EA3kJQlA==
Received: from github.com (hubbernetes-node-33e419d.ac4-iad.github.net [10.52.138.41])
	by smtp.github.com (Postfix) with ESMTPA id CCCB3740B28
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Oct 2026 12:53:18 -0700 (PDT)
Date: Fri, 09 Oct 2026 12:53:18 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1182613/000000-2957df@github.com>
Subject: [bluez/bluez] 9372cc: org.bluez.Bearer: Add Role property
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

  Branch: refs/heads/1182613
  Home:   https://github.com/bluez/bluez
  Commit: 9372cc1782e0e10cd7d064c10bed1815af47338f
      https://github.com/bluez/bluez/commit/9372cc1782e0e10cd7d064c10bed1815af47338f
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M doc/org.bluez.Bearer.LE.rst

  Log Message:
  -----------
  org.bluez.Bearer: Add Role property

This adds Role property to org.bluez.Bearer.LE1 which indicates whether
the remote device is the central or the peripheral of the current LE
connection, so applications can tell a central that connected to the
adapter from a peripheral the adapter connected to.

Assisted-by: Claude:claude-opus-5.5


  Commit: 25996bf0fdf1fc3bec723ef9a4a09f155407da61
      https://github.com/bluez/bluez/commit/25996bf0fdf1fc3bec723ef9a4a09f155407da61
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M src/bearer.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  bearer: Add Role property

This implements Role property for the LE bearer using the initiator
flag of the Device Connected event, which the kernel sets when the
adapter created the connection as central, and emits PropertiesChanged
along with Connected.

Assisted-by: Claude:claude-opus-5.5


  Commit: e628b057bb09c36b515aefd46bcf33b6f2631e78
      https://github.com/bluez/bluez/commit/e628b057bb09c36b515aefd46bcf33b6f2631e78
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Print LE.Role in info

This prints the Role property of the LE bearer with the likes of info
command:

bluetoothctl> info <addr>
...
        LE.Connected: yes
        LE.Connectable: yes
        LE.Role: central

Assisted-by: Claude:claude-opus-5.5


  Commit: 4e2ea23b375b1db21ff57dda4d95808309dfc00a
      https://github.com/bluez/bluez/commit/4e2ea23b375b1db21ff57dda4d95808309dfc00a
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    M Makefile.am
    A doc/functional-bearer.rst
    M doc/functional-testing.rst

  Log Message:
  -----------
  doc: Add functional-bearer documentation

Document the bearer functional tests, where two hosts connect or pair
over LE or BR/EDR and each checks the org.bluez.Bearer.LE1 and
org.bluez.Bearer.BREDR1 properties of the device object it has for the
other:

- Connected and Role on both sides of an LE connection, and the
  Disconnected signal with its reason on both sides
- Connectable for a connectable advertiser and for a broadcaster
- Paired, Bonded and Connected after LE and BR/EDR pairing, Role being
  only reported for LE

Assisted-by: Claude:claude-opus-5.5


  Commit: 2957df116f671d1ca6efc22846045011bcc5eeeb
      https://github.com/bluez/bluez/commit/2957df116f671d1ca6efc22846045011bcc5eeeb
  Author: Kevin Dewald <kevin@simpleble.org>
  Date:   2026-10-09 (Fri, 09 Oct 2026)

  Changed paths:
    A test/functional/test_bearer.py

  Log Message:
  -----------
  test: functional: add bearer tests

Add tests where host0 connects to or pairs with host1 over LE or
BR/EDR, and both hosts check the properties and the Disconnected
signal of the bearer interfaces of the device object they have for the
other, including the LE Role of each side of the connection.

See doc/functional-bearer.rst for details.

Assisted-by: Claude:claude-opus-5.5


Compare: https://github.com/bluez/bluez/compare/9372cc1782e0%5E...2957df116f67

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
