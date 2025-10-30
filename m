Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA204324B0A
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 17:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761844212; cv=none; b=sLXAroCQl0Rai/MVw/hSdpIgHldICr/iCM2kEoScG0XAdYDDQzHkE3G50OIpMfCWrVVUwIJq24taRamjKRl4JS/k4AuqhO3v2Wscp1uQiRMFjjvPFTcI9g2A8d/5IPoi3Xs0BkxdUMwkzULut0tWdjEWBT0MPhKu5Cui8BrwFsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761844212; c=relaxed/simple;
	bh=y/ZPMl3hnYAD85RFxwz2hx0JMGTc9TLH8J+iD3MsBVQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=VcIjEGMyUN+cvlixq+TGpmkOADnswxFFu3Q5bGyMABNtKfS4KPBB2LCWhLvXcOgFeH1lSs7Z2gzmSFv4B2lmxq/PxXQytItIXexuat6XsZsc8i2V9ctCsXdTREtSDrKT4QpJPvI6Ih/TWGXCygttVC0GdMZukYb8WEQrZpbXPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Yjss/P3Q; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Yjss/P3Q"
Received: from github.com (hubbernetes-node-60b6a68.va3-iad.github.net [10.48.178.47])
	by smtp.github.com (Postfix) with ESMTPA id 82FF7E1118
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 10:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761844209;
	bh=aI1bCISo1HHCEzQXZck9cp4K6UQHeD9JEu/jz4sdpYc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Yjss/P3QGz6uSpt84nF+vHR9l9X/mlxxNh1B37nBZOXahsnvUlBh0baiSrI6jNOKq
	 uSd1xBct6h4rJqtjy8g1dTRZy+sSIZ0HcS1ckvQkojW193ELYg7RnUkCnEzcc74e2d
	 XSm1PFkv5b3ace1lS0/oHc9zspsz3NljWCLVkT+w=
Date: Thu, 30 Oct 2025 10:10:09 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1017827/000000-32a5af@github.com>
Subject: [bluez/bluez] 8cdebd: bthost: Fix crash on bthost_past_set_info
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

  Branch: refs/heads/1017827
  Home:   https://github.com/bluez/bluez
  Commit: 8cdebdd4bab1736d47f08adff6b786125e6bd185
      https://github.com/bluez/bluez/commit/8cdebdd4bab1736d47f08adff6b786125e6bd185
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-30 (Thu, 30 Oct 2025)

  Changed paths:
    M emulator/bthost.c

  Log Message:
  -----------
  bthost: Fix crash on bthost_past_set_info

This fixes the following crash:

Invalid read of size 1
   at 0x401DEFE: send_command (bthost.c:1101)
   by 0x4021F01: bthost_past_set_info (bthost.c:3758)
   by 0x4006038: test_listen_past (iso-tester.c:3246)
   by 0x494984A: ??? (in /usr/lib64/libglib-2.0.so.0.8400.4)
   by 0x4943862: ??? (in /usr/lib64/libglib-2.0.so.0.8400.4)
   by 0x494C7A7: ??? (in /usr/lib64/libglib-2.0.so.0.8400.4)
   by 0x494CA4E: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.8400.4)
   by 0x402CC4D: mainloop_run (mainloop-glib.c:65)
   by 0x402D224: mainloop_run_with_signal (mainloop-notify.c:196)
   by 0x402C445: tester_run (tester.c:1084)
   by 0x4005609: main (iso-tester.c:4335)
 Address 0x40 is not stack'd, malloc'd or (recently) free'd


  Commit: 32a5af65eb204267918788fb56bb9a6e8e70e641
      https://github.com/bluez/bluez/commit/32a5af65eb204267918788fb56bb9a6e8e70e641
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-30 (Thu, 30 Oct 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  btdev: Fix crash on BIG cleanup

This fixes the following crash:

Invalid read of size 8
   at 0x400F26F: le_big_free (btdev.c:606)
   by 0x4024636: queue_remove_all (queue.c:341)
   by 0x40246C2: queue_destroy (queue.c:60)
   by 0x401B7C9: btdev_destroy (btdev.c:7820)
   by 0x400CFBF: hciemu_client_destroy (hciemu.c:301)
   by 0x4024636: queue_remove_all (queue.c:341)
   by 0x40246C2: queue_destroy (queue.c:60)
   by 0x400DA91: hciemu_unref (hciemu.c:441)
   by 0x40072F2: test_post_teardown (iso-tester.c:701)
   by 0x402BB0A: tester_teardown_complete (tester.c:713)
   by 0x402BB41: default_teardown (tester.c:266)
   by 0x402B43B: teardown_callback (tester.c:434)


Compare: https://github.com/bluez/bluez/compare/8cdebdd4bab1%5E...32a5af65eb20

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
