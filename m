Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C82478E55
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 17:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630641; cv=none; b=pUDAa7EWkd/+JUsOY8Hy3bAOTzCBFy0/t31e4I07oMI3uaXPV3AzULrfP5oQ/vuIg6dmnaM8Di1/J+HKMvR82h8NgExHAo/N7fJxK8pDt55eF0+dnh6SSjlxGr80qi/u8beineMxbCGS3DxyO6zdDUhPfgu1wsMTbq4dT89N7vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630641; c=relaxed/simple;
	bh=n7NOsgBH4xs5egon/swzVRBOD9K9Lgi4gWi2o6XcnNY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fMfRCqR7wZY3aERUjcNYNdSYirIAW6oqJGdjYiaYLx+vLyXH24muZ/k8hriKBt7QhSwcf9nsC4XAuKlcSpDTPIuF6DNk8mpv48wzciLJRSvR0yVsDb7v1zh5nPrAkwK2idwEFX1JjQqEbRPOcAU51WFeGLG7KwvLaCJ6MuSKD1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=EM+W1ZBr; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="EM+W1ZBr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781630639;
	bh=FWMamDdqvayHiyXYX63xuejMWlHeya0nxzOVdWygSRk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=EM+W1ZBrw7XAtUxydnhBmjUaug9P62ArObYvcXoE4ul3SHZAL4B/tC1kjQd2aHwbu
	 VoBYY0miIRAMEPN0F91k5h3SHiWpSlrw2XUwg+iyUu7u4ChHI0QUC86dO71FoTDT8W
	 ZYPz94Vy3e8dkKSqfEGeZNDl98rqP+7VNVHS2UT8=
Received: from github.com (hubbernetes-node-4aa3f6f.va3-iad.github.net [10.48.124.77])
	by smtp.github.com (Postfix) with ESMTPA id 662F0500C5C
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 10:23:59 -0700 (PDT)
Date: Tue, 16 Jun 2026 10:23:59 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1112321/000000-4f34c4@github.com>
Subject: [bluez/bluez] 4f34c4: shared/gatt: Fix gatt-db buffer overflow for
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

  Branch: refs/heads/1112321
  Home:   https://github.com/bluez/bluez
  Commit: 4f34c4155f8ff852ab543ba8e4ca85fcc600530b
      https://github.com/bluez/bluez/commit/4f34c4155f8ff852ab543ba8e4ca8=
5fcc600530b
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



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
