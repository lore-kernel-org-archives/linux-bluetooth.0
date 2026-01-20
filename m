Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDDA33F8DC
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768928019; cv=none; b=DeX4QGTjAEgR+ZsdwqAia3/kYHOTKls6ZPO0G7Pwfn8G5AH2VD4035ZAjZVkigQhxO2Q5IAwJS3sqVnKO2ROqWa+u47B4GSgPg79EnAUrixIAXpx+5adfxLlmwCO2N58xyR+Lem0JqNQUMyaH1S5cHBvjEYA69ov5BujIyTI9K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768928019; c=relaxed/simple;
	bh=DLLrzEpAEWERcnT0e3EbCoH5duthIi6LZdB518fTlWM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EQPJYYDg3YTJVZEYG9f8NsiPDYSw0PQQYTXEM7uKt2z09SumOmDOAqaPT3Ymz9mvMm6wnkypV6AGfL0BI4QZOMk5ftRJtpBwD6FMT3KzLiX5bIS3SgskBklK0KPG+ZAVqD09tqV4yockpDN84ZfOoTL20kCMz9NrYu0JyuNRo8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=fiHQ6/o7; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="fiHQ6/o7"
Received: from github.com (hubbernetes-node-7c1d509.ash1-iad.github.net [10.59.98.29])
	by smtp.github.com (Postfix) with ESMTPA id A310592128A
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jan 2026 08:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768928017;
	bh=WRyD/NoDCYk/jLS15b8dyOLC1V1Tn13TMQZ6qz1340w=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=fiHQ6/o7wcG8JuTwfwkKkMFHSqHmHJLpQ9nVw75GK8YbWfQLboTskLZsZpCxXkDr7
	 P5TOsxIfyAhn8kCp3FCGzPAElx5NDBMOo7fmCVlVmL93voHUWuXBc/tA0axRiwSpwi
	 sTItggsk7UN6UCmW9uxLBOssYicWWbi45Cr2LpSw=
Date: Tue, 20 Jan 2026 08:53:37 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1044781/000000-0d4960@github.com>
Subject: [bluez/bluez] 0d4960: adapter: Fix bt_uuid_hash() crash
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

  Branch: refs/heads/1044781
  Home:   https://github.com/bluez/bluez
  Commit: 0d4960cce9ac6580b481d73c49a3f1dcf02ec051
      https://github.com/bluez/bluez/commit/0d4960cce9ac6580b481d73c49a3f=
1dcf02ec051
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-20 (Tue, 20 Jan 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix bt_uuid_hash() crash

This is reproducible on Ubuntu 24.04, which enables libasan, by
calling org.bluez.AdminPolicySet1.SetServiceAllowList() method with
an array of UUIDs like ['110c','110e']:

bluetoothd[9975]: [:1.1435:method_call] > org.bluez.AdminPolicySet1.SetSe=
rviceAllowList [#468]
bluetoothd[9975]: plugins/admin.c:set_service_allowlist() sender :1.1435
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D9975=3D=3DERROR: AddressSanitizer: unknown-crash on address 0x763ae=
f383ee4 at pc 0x648113f85064 bp 0x7fffe4db4970 sp 0x7fffe4db4960
WRITE of size 16 at 0x763aef383ee4 thread T0
    #0 0x648113f85063 in bt_uuid16_to_uuid128 lib/bluetooth/uuid.c:35
    #1 0x648113f85063 in bt_uuid_to_uuid128 lib/bluetooth/uuid.c:73
    #2 0x648113e90459 in bt_uuid_hash src/adapter.c:3891
    #3 0x763af2700a5b in g_hash_table_add (/lib/x86_64-linux-gnu/libglib-=
2.0.so.0+0x49a5b) (BuildId: 94bfd21331c311d3199726de93a2656d07c22b33)
    #4 0x648113fa7232 in queue_foreach src/shared/queue.c:207
    #5 0x648113eb69df in btd_adapter_set_allowed_uuids src/adapter.c:3924=

    #6 0x648113cd6f11 in service_allowlist_set plugins/admin.c:165
    #7 0x648113cd8162 in set_service_allowlist plugins/admin.c:382
    #8 0x648113f97564 in process_message gdbus/object.c:293
    #9 0x763af2f6f553 in dbus_connection_dispatch (/lib/x86_64-linux-gnu/=
libdbus-1.so.3+0x18553) (BuildId: 47829078e4267099473c6cf5f5742f16ccb2644=
d)
    #10 0x648113f86d47 in message_dispatch gdbus/mainloop.c:59
    #11 0x763af271440d  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5d40d) =
(BuildId: 94bfd21331c311d3199726de93a2656d07c22b33)
    #12 0x763af2773766  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xbc766) =
(BuildId: 94bfd21331c311d3199726de93a2656d07c22b33)
    #13 0x763af2714ef6 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-=
2.0.so.0+0x5def6) (BuildId: 94bfd21331c311d3199726de93a2656d07c22b33)
    #14 0x6481140bf9d8 in mainloop_run src/shared/mainloop-glib.c:65
    #15 0x6481140c0306 in mainloop_run_with_signal src/shared/mainloop-no=
tify.c:196
    #16 0x648113c93d58 in main src/main.c:1550
    #17 0x763af1a2a1c9 in __libc_start_call_main ../sysdeps/nptl/libc_sta=
rt_call_main.h:58
    #18 0x763af1a2a28a in __libc_start_main_impl ../csu/libc-start.c:360
    #19 0x648113c96854 in _start (/home/fdanis/src/bluez/src/bluetoothd+0=
x65d854) (BuildId: 4e2b98c227059c308efb311ffe5b023d60e142ac)

Address 0x763aef383ee4 is located in stack of thread T0 at offset 36 in f=
rame
    #0 0x648113e903df in bt_uuid_hash src/adapter.c:3884

  This frame has 1 object(s):
    [32, 48) 'uuid_128' (line 3886) <=3D=3D Memory access at offset 36 pa=
rtially overflows this variable
HINT: this may be a false positive if your program uses some custom stack=
 unwind mechanism, swapcontext or vfork
      (longjmp and C++ exceptions *are* supported)
SUMMARY: AddressSanitizer: unknown-crash lib/bluetooth/uuid.c:35 in bt_uu=
id16_to_uuid128
Shadow bytes around the buggy address:
  0x763aef383c00: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
  0x763aef383c80: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
  0x763aef383d00: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
  0x763aef383d80: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
  0x763aef383e00: f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5 f5
=3D>0x763aef383e80: f5 f5 f5 f5 f5 f5 f5 f5 f1 f1 f1 f1[00]00 f3 f3
  0x763aef383f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x763aef383f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x763aef384000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x763aef384080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  0x763aef384100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
