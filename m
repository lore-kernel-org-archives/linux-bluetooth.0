Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B4647278B
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 15:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709312; cv=none; b=I7Hh6MYnsdelm5GX/3adtVgclk1FIiZw1gMANtWJYE8mODBDOxvIuelhUhS3C0HEf7M07SS9Kdyf0T3I+CPMw+wR0h7lAOvosQd9N+DQ6gRFgoWl3gk84iMuzppYz9pcr54SoQ1NAM1kATK6+kI+SkiJcfiYM+ELmoQZI7wNO8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709312; c=relaxed/simple;
	bh=3dF41fjCOk/key4re4DMZqrzBOBLUllUz8BgUhRKoJ0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=WbhpZ2b70Re/WgYtzS7cDYqm1SyBKn1b2bw2FJllmQgPEpROrRYNyzUEZP35Q20G9DEuj7Q8hKIQaAtAjlG6L6Bk5mTXzZBbmOMagHVoKDNQaPexzi7QIrAxytH8lQNJwyzpJkf2AoGPGAq1tH1OJQcX/tbCU8CpzC6XFuUf7qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=M4zEJWoI; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="M4zEJWoI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781709309;
	bh=VbLab7RwAqhBYmwkbQ9IGRVVAoUnOoDoo2KXHRI22R0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=M4zEJWoIC9IbFPEcAAdgXOU6xJJn933zJeJWmiizKE/z66Ee13uJuQMIWJEyijqON
	 sutzpMX93nc+D0rKsvuEO2fs2CxIxh+XrbPwcApVU1QELgN0DHOxmH5FM3ui6TOn8K
	 l5TRZJ8Sf1kv+6GY0vjS0MmScGSqo70h0gH08EMg=
Received: from github.com (hubbernetes-node-c4ca0d9.ash1-iad.github.net [10.56.161.41])
	by smtp.github.com (Postfix) with ESMTPA id 0FACD5212E6
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 08:15:09 -0700 (PDT)
Date: Wed, 17 Jun 2026 08:15:09 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/5297cf-629b78@github.com>
Subject: [bluez/bluez] aa8d0a: shared/gatt: Fix gatt-db buffer overflow for
 clone...
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
  Commit: aa8d0a2b684176e2295588f58ea9c8c3fc86597c
      https://github.com/bluez/bluez/commit/aa8d0a2b684176e2295588f58ea9c=
8c3fc86597c
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-06-16 (Tue, 16 Jun 2026)

  Changed paths:
    M src/shared/gatt-db.c

  Log Message:
  -----------
  shared/gatt: Fix gatt-db buffer overflow for cloned db

On notify_service_changed() timeout, db_hash_update() is called but
for cloned db the last-handle has not been copied and only one slot is
allocated, ending in buffer overflow:

=3D=3D288975=3D=3DERROR: AddressSanitizer: heap-buffer-overflow on addres=
s 0x5020000ac220 at pc 0x55f8b7e551bf bp 0x7ffcd6e9ddf0 sp 0x7ffcd6e9dde0=

WRITE of size 8 at 0x5020000ac220 thread T0
    #0 0x55f8b7e551be in gen_hash_m src/shared/gatt-db.c:415
    #1 0x55f8b7e5d817 in gatt_db_service_foreach src/shared/gatt-db.c:174=
4
    #2 0x55f8b7e5d817 in gatt_db_service_foreach src/shared/gatt-db.c:172=
2
    #3 0x55f8b7e60c6c in foreach_service_in_range src/shared/gatt-db.c:16=
33
    #4 0x55f8b7e60c6c in foreach_in_range src/shared/gatt-db.c:1656
    #5 0x55f8b7dde002 in queue_foreach src/shared/queue.c:207
    #6 0x55f8b7e5c435 in gatt_db_foreach_service_in_range src/shared/gatt=
-db.c:1698
    #7 0x55f8b7e5c87c in db_hash_update src/shared/gatt-db.c:442
    #8 0x55f8b7f15283 in timeout_callback src/shared/timeout-glib.c:25
    #9 0x7fc1845154f1  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e4f1) (=
BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #10 0x7fc18451445d  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d45d) =
(BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #11 0x7fc184573976  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbc976) =
(BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #12 0x7fc184514f46 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-=
2.0.so.0+0x5df46) (BuildId: 116e142b9b52c8a4dfd403e759e71ab8f95d8bb3)
    #13 0x55f8b7f157e8 in mainloop_run src/shared/mainloop-glib.c:65
    #14 0x55f8b7f16116 in mainloop_run_with_signal src/shared/mainloop-no=
tify.c:196
    #15 0x55f8b7af46df in main src/main.c:1709
    #16 0x7fc18382a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_sta=
rt_call_main.h:58
    #17 0x7fc18382a28a in __libc_start_main_impl ../csu/libc-start.c:360
    #18 0x55f8b7af68b4 in _start (/home/fdanis/src/bluez/src/bluetoothd+0=
x6588b4) (BuildId: 89dc89ac5800f58cc305bae57a965b1185601a3e)

0x5020000ac220 is located 0 bytes after 16-byte region [0x5020000ac210,0x=
5020000ac220)
allocated by thread T0 here:
    #0 0x7fc1846fd9c7 in malloc ../../../../src/libsanitizer/asan/asan_ma=
lloc_linux.cpp:69
    #1 0x55f8b7ddf2b6 in util_malloc src/shared/util.c:46


  Commit: efa2a66a7964234039ab694e1a572a5c0937be0d
      https://github.com/bluez/bluez/commit/efa2a66a7964234039ab694e1a572=
a5c0937be0d
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-16 (Tue, 16 Jun 2026)

  Changed paths:
    M src/shared/rap.h

  Log Message:
  -----------
  shared: rap: Check role before sending CS Sec Enable cmd

Add the is_central parameter to verify whether
the local role is central before sending
the HCI CS Security Enable command.


  Commit: 20cc88874d5759f19f16ff649d46e5e2a660df8d
      https://github.com/bluez/bluez/commit/20cc88874d5759f19f16ff649d46e=
5e2a660df8d
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-16 (Tue, 16 Jun 2026)

  Changed paths:
    M profiles/ranging/rap.c
    M profiles/ranging/rap_hci.c

  Log Message:
  -----------
  profiles: ranging: Add CS Initiator cmd and evt handling

Introduce support for LE Channel Sounding (CS)
ranging procedures in the Initiator role by enabling
required HCI command sequencing and event handling.

Add handling of core HCI LE CS commands and events
This enables cs capability discovery, cs configuration
management and execution of CS ranging procedures
in the Initiator role.


  Commit: 629b788e11b5ba7a8b1554c5ed1b8a02f2f9f310
      https://github.com/bluez/bluez/commit/629b788e11b5ba7a8b1554c5ed1b8=
a02f2f9f310
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-06-16 (Tue, 16 Jun 2026)

  Changed paths:
    M src/shared/rap.h

  Log Message:
  -----------
  shared: rap: remove the old wrapper API

Replace API bt_rap_set_conn_handle with
bt_rap_set_conn_hndl which has extra parameter
to avoid compilation error for individual patches


Compare: https://github.com/bluez/bluez/compare/5297cf2b6af6...629b788e11=
b5

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
