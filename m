Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAFFDDC5
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 22:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761863546; cv=none; b=rx9pViMUaehiHsOj2CeuWOepxBxLKoARCi6RnJtHgvyFt1gG2c0RmXXqaCr1EV3BRO1BYL+eHGUtRUaII0/Yy4PLBVgiiQxNlGEpODNFzA3HtQd4B6Xhq4z+uy+lvaFnNAuCi9TiVq3FqSl5np2pw4ZRQZ8z6wphoCdtSsr582o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761863546; c=relaxed/simple;
	bh=sSZSehxVn/9NKUmyFZE5EstY9kLkOJwa9R5JReCRYOc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kOHp1Dnikb4I3IA3VSzaq6cMvH56mWB2u//QcZpYiLYF4tsTwYLxuoxq9bTKvYXd7bJTvcUazNUvANHAKISLED/E0tA+xunOi4VLbBvXdhK/u5W6L/lCw+HNIW+DDr4gKkKK2Ds8285NYujEscn8zrrzft+1C0hSuV/P6WvhCGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=nG68ABkk; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="nG68ABkk"
Received: from github.com (hubbernetes-node-d1b9fb1.va3-iad.github.net [10.48.222.58])
	by smtp.github.com (Postfix) with ESMTPA id 24B944E0874
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Oct 2025 15:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1761863544;
	bh=S/6CPf4j66zXTuu+IatmS5+yKAKvCINU/RgAwSKzZ/s=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=nG68ABkkR7mNl5e572QAWrqPxFDLjkVNUnS24h7771FtYN8zGYjF051a2DiUGtp1R
	 j4hf8D6ECd0BB7i247MabH0MRr/+uE9B47a3NI7qE1fRY0vMWQYLaSwsZQm9NqH7e3
	 c/ty3ER+O8o+nXUjvKX9dg8inigW7TI6eOrw5YTw=
Date: Thu, 30 Oct 2025 15:32:24 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f80a2a-32d740@github.com>
Subject: [bluez/bluez] 229d41: bthost: Fix crash on bthost_past_set_info
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
  Commit: 229d411e5a71486e62a13365dfc0049a3d930f62
      https://github.com/bluez/bluez/commit/229d411e5a71486e62a13365dfc00=
49a3d930f62
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


  Commit: bb82243a6c27d0a0890005eddbea3a6c54b558b8
      https://github.com/bluez/bluez/commit/bb82243a6c27d0a0890005eddbea3=
a6c54b558b8
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


  Commit: 1479b279a016a515aee4fc7fc79fc7bcb229b4cb
      https://github.com/bluez/bluez/commit/1479b279a016a515aee4fc7fc79fc=
7bcb229b4cb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-30 (Thu, 30 Oct 2025)

  Changed paths:
    M monitor/bt.h
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Add decoding support for LL Extended Feature Set

This adds support for decoding LL Extended Feature Set introduced in 6.0
that adds the following:

Commands:

 - HCI_LE_Read_All_Local_Supported_=C2=ADFeatures(0x2087)(Feature:47,1)
 - HCI_LE_Read_All_Remote_Features(0x2088)(Feature:47,2)

Events:

 - HCI_LE_Read_All_Remote_Features_Complete(0x2b)(Mask bit:42)


  Commit: 32d740d87970fa476644aeea267663ea3c74644a
      https://github.com/bluez/bluez/commit/32d740d87970fa476644aeea26766=
3ea3c74644a
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-10-30 (Thu, 30 Oct 2025)

  Changed paths:
    M monitor/bt.h
    M monitor/ll.c
    M monitor/packet.c
    M monitor/packet.h

  Log Message:
  -----------
  monitor: Add decoding support for LL_FEATURE_EXT_{REQ,RSP}

This adds support for LL_FEATURE_EXT_{REQ,RSP} which is used to
exchange LL Features.


Compare: https://github.com/bluez/bluez/compare/f80a2a57c910...32d740d879=
70

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
