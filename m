Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E141A682E
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 21:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778015329; cv=none; b=N/pmBo3R3+YXPVyA8EMNkKOeAxAlwW9C9cgzl4+hLQc9STkoivPdXqpSysbGQf1W2geHXOPFrCDeA8vbCj0xpvG3dlc5UviyAyoksXxz59kDBZGQ/sXMOzbcHy9/ZzS1RXiEq8sAeqj1Tm/d3bNDjkhze1Nzit5FE/PwGNtPAKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778015329; c=relaxed/simple;
	bh=duEKSW2ScnKuPP2h7W4z6Vaj+QfwgVlYXo/L8yX9RKI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=qjahrWCI51JQZaoFZNFUf7s8EwL0P5KKNr03iadJg+9a2kc+5R455HjjpB5w1ARGjHBD2mw1J/YP2VInmh5SBBWGq2LJwGJaV/PVpj/IiVoW3BAHHXaame1Hd3aHbi3RkCi0gSEddyLS7YqAJaGTue0KOWh94UiYFV4pnvu/MRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=m/aWHX0E; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="m/aWHX0E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778015327;
	bh=HJrtg29TvE/V9d6owKBckqAHKgqAwsxY1YRgQfpfqkE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=m/aWHX0E6UTNzPc0R4hkvs9osuBFAGm/F88mbCU7p1WHttkZYmcJ8xF/HQstYa/gg
	 T+rKU4+7ip0qf0qZ9UWJzacs54LIire4u7ttM6S0do7XCOIoYW8vEwoQjEQZTNTRZv
	 IflnAMIlE1dIAeBN2ATyUc811BAwgkanVEn1CBOs=
Received: from github.com (hubbernetes-node-89ef772.va3-iad.github.net [10.48.131.40])
	by smtp.github.com (Postfix) with ESMTPA id 17662280E19
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 May 2026 14:08:47 -0700 (PDT)
Date: Tue, 05 May 2026 14:08:47 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1090113/000000-fae0c7@github.com>
Subject: [bluez/bluez] fae0c7: hciemu: Fix crash if hciemu_client_new return
 NULL
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

  Branch: refs/heads/1090113
  Home:   https://github.com/bluez/bluez
  Commit: fae0c76f643a6d9c925998a29e3b25baa0b79ce8
      https://github.com/bluez/bluez/commit/fae0c76f643a6d9c925998a29e3b25baa0b79ce8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-05 (Tue, 05 May 2026)

  Changed paths:
    M emulator/hciemu.c

  Log Message:
  -----------
  hciemu: Fix crash if hciemu_client_new return NULL

The following crahs can be observed if hciemu_client_new fails:

 Invalid read of size 8
   at 0x12DA79: queue_get_entries (queue.c:356)
   by 0x118434: hciemu_get_client (hciemu.c:277)
   by 0x1184A3: hciemu_client_get_host (hciemu.c:301)
   by 0x11536B: setup_powered_common (l2cap-tester.c:1452)
   by 0x11568E: setup_powered_client (l2cap-tester.c:1491)
   by 0x1324C6: setup_callback (tester.c:500)
   by 0x48A304D: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
   by 0x48A33FF: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
   by 0x48A36F2: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.6400.6)
   by 0x133868: mainloop_run (mainloop-glib.c:65)
   by 0x133C9F: mainloop_run_with_signal (mainloop-notify.c:196)
   by 0x13325F: tester_run (tester.c:1085)
  Address 0x4c1e388 is 8 bytes inside a block of size 32 free'd
   at 0x483CA3F: free (in /usr/lib/x86_64-linux-gnu/valgrind/vgpreload_memcheck-amd64-linux.so)
   by 0x1187BF: hciemu_new_num (hciemu.c:437)



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
