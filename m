Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C451713B586
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717447086; cv=none; b=sPKmzqdVkyvemfdVo7h2oOQlZGfTnPHkPRel2sx0KAy5AfPQXe7XEAmrYEJN19iSe0EropD3clfyQbePHwhUQkKFNPvDyO1E/1FO/nFXiDK9nrKF6gKoWXBMF2N6+jurfhpUVPz6SHyjDgDRFf4tgyydf21mMYqnmG8CjH+D5a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717447086; c=relaxed/simple;
	bh=wiDCqwhep8YxwakH1axatdi9QZ9bQLhTfMm2hP0vHug=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=mMtJKJKUOKciROMhkTC3ZYaOqFNWGUUd6umVLkRxI8Q0yk61ak6Tj86Fb+J8nCuVkPMq+dByiNWfZOoVQcYHnMUvt9IBqbR9F4bRbcauU3vWFRfRY43wKkKK1uRYVm6r76GJVnPlOV4cRfMkA1+S13t5ALay96DGHZgruIFLrsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=h4tkIlZX; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="h4tkIlZX"
Received: from github.com (hubbernetes-node-dbb145d.ash1-iad.github.net [10.56.159.35])
	by smtp.github.com (Postfix) with ESMTPA id ECED4641029
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jun 2024 13:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1717447084;
	bh=XYLoZGN5UtGdjulC0Skki4Zay6BJCio35BU3AkvU8qk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=h4tkIlZX7VKByniTVTT2XWaLBpQ8XoWxtoXp1P7UT7KVzydSjGASx34GaddetapYf
	 gDqBX89Nq/xM20D5AtVEYqcLNwBuyjlm4gcDLWiTWsZ1VKWfsPs49/dQfyuxSakjYg
	 2SDQboNL+RUsotFlWYhDri4su1LZERwZbouPH580=
Date: Mon, 03 Jun 2024 13:38:03 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/60b482-cbe414@github.com>
Subject: [bluez/bluez] 09e39a: shared/csip: Fix memory leak
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
  Commit: 09e39a7d6dca8041f3723ee9020c54b94c0c8d47
      https://github.com/bluez/bluez/commit/09e39a7d6dca8041f3723ee9020c54b94c0c8d47
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M src/shared/csip.c

  Log Message:
  -----------
  shared/csip: Fix memory leak

This fixes the following leak:

102 bytes in 6 blocks are definitely lost in loss record 660 of 909
   at 0x484282F: malloc (vg_replace_malloc.c:446)
   by 0x5A078B: util_malloc (util.c:46)
   by 0x649162: read_sirk (csip.c:485)
   by 0x5C74FA: read_cb (gatt-client.c:2713)
   by 0x5C4137: handle_rsp (att.c:880)
   by 0x5C4137: can_read_data (att.c:1072)
   by 0x65DDA4: watch_callback (io-glib.c:157)
   by 0x49656AB: ??? (in /usr/lib64/libglib-2.0.so.0.8000.2)
   by 0x49C6707: ??? (in /usr/lib64/libglib-2.0.so.0.8000.2)
   by 0x496B666: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.8000.2)
   by 0x65FE3D: mainloop_run (mainloop-glib.c:66)
   by 0x6605A3: mainloop_run_with_signal (mainloop-notify.c:188)
   by 0x31DEFA: main (main.c:1468)


  Commit: 7e9816dd8c219f26f52fcb46fa13ecddfcf2d526
      https://github.com/bluez/bluez/commit/7e9816dd8c219f26f52fcb46fa13ecddfcf2d526
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M src/shared/gatt-db.c
    M src/shared/gatt-db.h

  Log Message:
  -----------
  shared/gatt-db: Introduce gatt_db_clone

This introduces gatt_db_clone which can be used to clonse/deep copy and
existing database.


  Commit: cbe4144dea6fde87e13016c2861c9ba5f75f716f
      https://github.com/bluez/bluez/commit/cbe4144dea6fde87e13016c2861c9ba5f75f716f
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-06-03 (Mon, 03 Jun 2024)

  Changed paths:
    M src/device.c
    M src/device.h
    M src/set.c
    M src/shared/gatt-db.c

  Log Message:
  -----------
  set: Attempt to use existing set gatt-db

Most sets should be clone of each other, or at least very similar, so
this attempts to clone the existing gatt-db of the first member found
when connecting new sets, this substantially speed up the process of
bonding sets if their database matches which is something that is
currently ranging from 20-30 seconds depending on the manufacturer and
with this changes it cuts 5-10 seconds by bypassing discovery all
procedure of other members.

If the dbs don't really match bt_gatt_client instance will attempt to
rediscover the ranges that don't match.


Compare: https://github.com/bluez/bluez/compare/60b482c3c9ba...cbe4144dea6f

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
