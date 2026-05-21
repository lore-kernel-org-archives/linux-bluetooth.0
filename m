Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBC8367F26
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373837; cv=none; b=V6D/y3m4w9WBY2NLq3q6LiFw+g+WYjV8UYS0N51DHON9A9HDEOKdlpqSzCEEllUFvBgw42S4zXmt0FrNjiPfSScPyMfKkmyDk4mYnJc/VMDUpf/8kam6TxKb6WlTTwMZYJrB665r0Q7DCNIRyg9AQmYDqe6y+2a+wxRTkEHNVE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373837; c=relaxed/simple;
	bh=3AOZO8QPwcGIlMzYbcDC76gXWWsCfyKrOF6awgw40lw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Uo99jn5g+/xxxAfCiQ7hZBN69tYAHB0G86PmFNuApYf29Facp5PeRTARXoH9MSYLyGTk4eoih3KdG5pkzmtaGAwaVzJeSjlQsI8pLeUm0UU9T/p3NNTlfnQ9f2WYHIOdasmO6QLCI84eKJxuU31Aby8RqQBe10C+fxTKUYS/EvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZHEvL69l; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZHEvL69l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779373835;
	bh=WpyzOkfLOesCwDOn2i+MK5DfaMB0M6ZH5Rh1CO1aaPk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZHEvL69lKb+U39dORZfsOUUZIgH2YUsehWE81i/EqKm4WNRuj0Y1W5gFeoIIlp+WC
	 UdMzQaxXRUtPJAobh5yd0nntb16Ma85JMgSPRWOYIH9MYaLKArhnzG2jMN9CVqUS1t
	 IkCalG9Z0NEh/Zhg63CDKYv//SWHj84qbiFtEa/c=
Received: from github.com (hubbernetes-node-15f979d.ac4-iad.github.net [10.52.13.78])
	by smtp.github.com (Postfix) with ESMTPA id 82D1894032A
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 07:30:35 -0700 (PDT)
Date: Thu, 21 May 2026 07:30:35 -0700
From: michael kong <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/757cd9-d167d3@github.com>
Subject: [bluez/bluez] 247044: tester.config: add missing CRYPTO_AES
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 2470448ed9d7ddff2347215a91b28de3a4565b0c
      https://github.com/bluez/bluez/commit/2470448ed9d7ddff2347215a91b28=
de3a4565b0c
  Author: Pauli Virtanen <pav@iki.fi>
  Date:   2026-05-19 (Tue, 19 May 2026)

  Changed paths:
    M doc/ci.config
    M doc/test-runner.rst
    M doc/tester.config

  Log Message:
  -----------
  tester.config: add missing CRYPTO_AES

Kernel commit 4a1507625b0 ("Bluetooth: SMP: Use AES-CMAC library
API") removed CRYPTO_AES from the default Bluetooth kernel config.

This causes Bluetooth testbots to fail silently with "Not Run" status:

Basic Framework - Success - init
  Read Index List callback
    Status: 0x00
Bluetooth: hci0: Opcode 0x0c03 failed: -110
Bluetooth: hci0: Opcode 0x0c03 failed: -110
  hciemu: Failed to open vhci
  Failed to setup HCI emulation
Basic Framework - Success - pre setup failed
Basic Framework - Success - done
...
SCO CVSD Listen Send - Success                       Not Run
Total: 30, Passed: 0 (0.0%), Failed: 0, Not Run: 30

Fix by explicitly requiring CRYPTO_AES.


  Commit: 0e55974d713b699166fe56f11974e8520596076b
      https://github.com/bluez/bluez/commit/0e55974d713b699166fe56f11974e=
8520596076b
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-05-19 (Tue, 19 May 2026)

  Changed paths:
    M client/btpclient/bap.c
    M client/btpclient/btpclient.c
    M client/btpclient/btpclient.h
    M client/btpclient/core.c
    M client/btpclient/gap.c
    M client/btpclient/gatt.c

  Log Message:
  -----------
  client/btpclient: refactor read-commands bitmap building

Add add_supported_command() and use it across all btp_*_read_commands
handlers.

This replaces fixed-size bitmask assembly with a dynamically growing
command bitmap based on opcode index, avoiding shift-width issues with
higher opcodes.
This will allow to add opcodes like GAP_SET_EXTENDED_ADVERTISING
(0x21).

Refactor core, gap, gatt and bap read-commands paths to build response
bitmaps through the shared helper and preserve existing error handling
for allocation failures.

Assisted-by: GPT:GPT-5.3-Codex


  Commit: 9074d38c5fed33cd6b611b9663f600c4f68bb741
      https://github.com/bluez/bluez/commit/9074d38c5fed33cd6b611b9663f60=
0c4f68bb741
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-05-19 (Tue, 19 May 2026)

  Changed paths:
    M client/btpclient/gap.c

  Log Message:
  -----------
  client/btpclient: Replace advertising defines by shared ones

The advertisement types are already defined in src/shared/ad.h


  Commit: 588a0267d8fabf146a0f35c85f30e06394fb526f
      https://github.com/bluez/bluez/commit/588a0267d8fabf146a0f35c85f30e=
06394fb526f
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-05-19 (Tue, 19 May 2026)

  Changed paths:
    M client/btpclient/gap.c
    M src/shared/btp.h

  Log Message:
  -----------
  client/btpclient: Add BTP_OP_GAP_SET_EXTENDED_ADVERTISING support

This set LEAdvertisement1's SecondaryChannel property to "2M" to
force Extended advertisement type.


  Commit: 29fb17c909a0998b09aaee1dc0fb6163bd2619cb
      https://github.com/bluez/bluez/commit/29fb17c909a0998b09aaee1dc0fb6=
163bd2619cb
  Author: michael_kong <kx960506@163.com>
  Date:   2026-05-21 (Thu, 21 May 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix unused value in qos

In bt_bap_parse_base, PresentationDelay is parsed but not written to QoS.=



  Commit: fd25b4b1e5968a68ab9e9ef626c25d9cb4c24241
      https://github.com/bluez/bluez/commit/fd25b4b1e5968a68ab9e9ef626c25=
d9cb4c24241
  Author: michael_kong <kx960506@163.com>
  Date:   2026-05-21 (Thu, 21 May 2026)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Add support for obtaining PresentationDelay in broadcast QoS=



  Commit: d167d3409e94440da7fb021d7d6d4601b65a83b5
      https://github.com/bluez/bluez/commit/d167d3409e94440da7fb021d7d6d4=
601b65a83b5
  Author: michael_kong <kx960506@163.com>
  Date:   2026-05-21 (Thu, 21 May 2026)

  Changed paths:
    M doc/btmon-le-audio.rst

  Log Message:
  -----------
  doc: Fix Data Path direction in btmon-le-audio.rst

The Data Path direction 0x01 should be Output (Controller to Host).


Compare: https://github.com/bluez/bluez/compare/757cd98f4186...d167d3409e=
94

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
