Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23B8BE5E
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Jun 2025 21:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750629371; cv=none; b=KO+m4bd7f5cWSoT2JvzY2nLW704RZCB0+e67GZhRoQD4oAa3qCxxGXSm7Md60tEKVhi0B7Y5niRU6RCFJFuB+BOtenanQZZ5hMS55ZiAo9WKb6EvVTpeiQYvTZfvQEKZ3rsPkyYyTalV+oiMVrS5tgUjP61JswcwoAZJjpHsanw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750629371; c=relaxed/simple;
	bh=JZUY8eFtSQOrPQOVZXGRY06IWyvcpeyMJONEUYVve6M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=hP4iWIeksRaNkn0JQ8p5B+QrPN6J2j9VB8fNG+NO4zHUORWywnEFb/G4p+vSYqCBYbXfqA0XgcKFx3Jeo5tC2xIdBW+JDpnB7HE67MaPFTkFJjSklr0qpfapRASjb0/E+TOf1yRyQ6LLzS1AGytkAVA85v1sQE4RHbNIDiJHrTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VAs9aJDp; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VAs9aJDp"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad883afdf0cso723714466b.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Jun 2025 14:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750629368; x=1751234168; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yA+r4oMmmnoEoUyMTC62lg9WA360iTwbvDGiRH9IsQE=;
        b=VAs9aJDpfj9sFyq3sgCD4pTJAForP5ZUhVSaouq1joMvN+jlqEt3n6uvwtBAi+hRZE
         +PaHYZZjiVyLDx/sk5tdn3J7gpS8PNddMdSaFGNdoSpVh4A5eZM3RCRuJZl7Xf06eeTj
         3FpSAHw3hJtsotcZnZvZRJ8FDN3OXb/9i4CdzoUEm+o5yXfs2QLdpQ04AGh1hJWK2q47
         x3ephQEyNpGcNJEgrt7HHrjylyrIKhMXndpO4cKd5RIp9RnFBCPpPiIDuElGeR+mgLiV
         3SEg7Mt+B82b/kkS7cDsXqLJFz6LU091tt3osb2g5jqBvqxxZugCpcBs1kbl/cAm4hOA
         SFyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750629368; x=1751234168;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yA+r4oMmmnoEoUyMTC62lg9WA360iTwbvDGiRH9IsQE=;
        b=lQK8ggSghoIY7y6YqoyaRWyHAFsGT/yXBdWsqCOPz1vODAZY/DHC8c1XuyYMjnTzhr
         HjLtP6acOx4B+5vAjhsahaDca5yHAACWaLgQfbC2j2Hzl0OGgoVgUYcRMlkVpXkOLfKP
         e+nI0qe1LWU/mYMBHpoghedHwHDf1FjdONJ6XWOfZxzxCc/wpYLnO2LbvkGo3d9Qoy7A
         Z64ShT9Vj/Wx8aeFzr0MhHWGidMAqXblSViQyEjd4853oLwPKe6XBuicPcoWDA/kOFFd
         LIxqrJ+d/VgF5yv1auxolpR+RllKMMvqhTM1U5toTVZ6Ok7e/xW24gAobYgeyQhHjd0r
         dRug==
X-Gm-Message-State: AOJu0Yyq9dI92vnqs8hDVnBtZei+4PaeLAIiIdBX5fTUVWhbne9aCqgK
	u0yoUMjGsBEWQXYSWEYO4iBqB+EhWYi3r3LztOlGsB4HWsixoZBskYtKmijutm4jubtZGD3JPVU
	iUL9jOgmdEgKBxVqGGWKer4N8Z50yY0fK+4UF/zE=
X-Gm-Gg: ASbGncvaqbALr3dr05/fVhUCkbGEvsuBLDk8ZPcKYgbynXqgqN3KClhKRphtK7VRw8J
	OdbCWNWh5BX2hw6Gnslbu9mf9OllMJeLGxN4Kj3kUupBGdE+U6O5I/xNMIStwsPOzf9wivcZMUQ
	3ruOLNJcZQmwQtMACPy21+LMRAoDoSUao+0BfFioBQl4CYwz4KF+UWTw==
X-Google-Smtp-Source: AGHT+IHWXMrE0o/3Czf9tyVga1wCVZN8/TpBxGZyMI1puembu6a5+sHOfdBhloPaLD9M5GRYHGDpHmeUs5NlAISZMwc=
X-Received: by 2002:a17:907:e2d3:b0:ad8:8689:2cc9 with SMTP id
 a640c23a62f3a-ae057c2510cmr919658566b.56.1750629368154; Sun, 22 Jun 2025
 14:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ivan Kalvachev <ikalvachev@gmail.com>
Date: Mon, 23 Jun 2025 00:55:28 +0300
X-Gm-Features: AX0GCFtjQjfIja7zfJsT_GCQnC_le6lJavmB0bxWVdf4S63s3S5lYTwBbVvXQgQ
Message-ID: <CABA=pqdhsBeabrxHvfXx-uWzSq_-hs9OR16NSs1xuc6aB0s_kQ@mail.gmail.com>
Subject: Bluez-5.83 is crashing during suspend/resume.
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The problem started when my distro (Slackware64-current) upgraded to bluez-5.83.
The current git still has the problem (01f3ef3cd9d69b56554f5ef6d7ac2a5c40e41393)

Steps to reproduce the crash:

- Start bluetoothd;
- Start pipewire;
- Connect headphones;
- Play something (!mandatory!),
- Suspend (pm_test="freeze" is enough).
- When you resume bluetoothd has crashed.

Running `git bisect` landed me on this commit:
---
commit cdcdfb4843b485e08f6a1460b5a03a3420453a51
Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date:   Fri May 16 17:49:20 2025 -0400

    a2dp: Fix not destroying streams when unregistering

    When a2dp_unregister_sep it must destroy the stream queue before freeing
    the a2dp_sep otherwise it will cause memory leaks.

---
Reverting this commit seems to fix the issue, even for the current git.

I tried to get backtrace from a core-dump, but it was useless, so I
tried valgrind instead.
The following is result from `valgrind --tool=memcheck
--redzone-size=256 --freelist-vol=1000000000 --free-fill=0xcc
--undef-value-errors=no --leak-check=no
--log-file=bluetooth.%p.valgrind.log  ./src/bluetoothd`

---
==13728== Invalid read of size 8
==13728==    at 0x4253DA: release_stream (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x493D36E: g_slist_foreach (in
/usr/lib64/libglib-2.0.so.0.8400.3)
==13728==    by 0x4233A2: connection_lost (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4260FC: session_cb (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4918FA2: ??? (in /usr/lib64/libglib-2.0.so.0.8400.3)
==13728==    by 0x491B076: ??? (in /usr/lib64/libglib-2.0.so.0.8400.3)
==13728==    by 0x491BA6E: g_main_loop_run (in
/usr/lib64/libglib-2.0.so.0.8400.3)
==13728==    by 0x4DFFF4: mainloop_run (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4E03EE: mainloop_run_with_signal (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x40A6C1: main (in /mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==  Address 0x53ca558 is 24 bytes inside a block of size 40 free'd
==13728==    at 0x484C78B: free (vg_replace_malloc.c:989)
==13728==    by 0x424B77: avdtp_unregister_sep (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x41C393: a2dp_unregister_sep (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4AD7F8: proxy_free (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x49163EE: g_list_foreach (in
/usr/lib64/libglib-2.0.so.0.8400.3)
==13728==    by 0x491641F: g_list_free_full (in
/usr/lib64/libglib-2.0.so.0.8400.3)
==13728==    by 0x4ACFE6: service_disconnect (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4A8FDB: service_filter (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4A9272: message_filter (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4A350E8: dbus_connection_dispatch (in
/usr/lib64/libdbus-1.so.3.38.3)
==13728==    by 0x4A83A7: message_dispatch (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4918FA2: ??? (in /usr/lib64/libglib-2.0.so.0.8400.3)
==13728==  Block was alloc'd at
==13728==    at 0x4850A5F: calloc (vg_replace_malloc.c:1675)
==13728==    by 0x4921F65: g_malloc0 (in /usr/lib64/libglib-2.0.so.0.8400.3)
==13728==    by 0x424A26: avdtp_register_sep (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x420A3F: a2dp_add_sep (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x40E22F: endpoint_init_a2dp_source (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4112F4: media_endpoint_create (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4128C9: proxy_added_cb (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4ADB1F: parse_interfaces.part.0 (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4AEE4A: get_managed_objects_reply (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4A35225: dbus_connection_dispatch (in
/usr/lib64/libdbus-1.so.3.38.3)
==13728==    by 0x4A83A7: message_dispatch (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4918FA2: ??? (in /usr/lib64/libglib-2.0.so.0.8400.3)
==13728==
==13728== Invalid read of size 8
==13728==    at 0x4253E3: release_stream (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x493D36E: g_slist_foreach (in
/usr/lib64/libglib-2.0.so.0.8400.3)
==13728==    by 0x4233A2: connection_lost (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4260FC: session_cb (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4918FA2: ??? (in /usr/lib64/libglib-2.0.so.0.8400.3)
==13728==    by 0x491B076: ??? (in /usr/lib64/libglib-2.0.so.0.8400.3)
==13728==    by 0x491BA6E: g_main_loop_run (in
/usr/lib64/libglib-2.0.so.0.8400.3)
==13728==    by 0x4DFFF4: mainloop_run (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4E03EE: mainloop_run_with_signal (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x40A6C1: main (in /mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==  Address 0xccccccccccccccfc is not stack'd, malloc'd or
(recently) free'd
==13728==
==13728==
==13728== Process terminating with default action of signal 11
(SIGSEGV): dumping core
==13728==  General Protection Fault
==13728==    at 0x4253E3: release_stream (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x493D36E: g_slist_foreach (in
/usr/lib64/libglib-2.0.so.0.8400.3)
==13728==    by 0x4233A2: connection_lost (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4260FC: session_cb (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4918FA2: ??? (in /usr/lib64/libglib-2.0.so.0.8400.3)
==13728==    by 0x491B076: ??? (in /usr/lib64/libglib-2.0.so.0.8400.3)
==13728==    by 0x491BA6E: g_main_loop_run (in
/usr/lib64/libglib-2.0.so.0.8400.3)
==13728==    by 0x4DFFF4: mainloop_run (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x4E03EE: mainloop_run_with_signal (in
/mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==    by 0x40A6C1: main (in /mnt/btr3/tmp/build/bluez/src/bluetoothd)
==13728==
==13728== HEAP SUMMARY:
==13728==     in use at exit: 130,034 bytes in 2,358 blocks
==13728==   total heap usage: 17,390 allocs, 15,032 frees, 1,298,930
bytes allocated
==13728==
---

I used the same options as my distro to build bluez:
CFLAGS="-Og -ggdb -march=x86-64 -mtune=generic -fPIC"
./configure \
  --prefix=/usr \
  --libdir=/usr/lib64 \
  --sysconfdir=/etc \
  --mandir=/usr/man \
  --localstatedir=/var \
  --docdir=/usr/doc/bluez-5.83 \
  --enable-library \
  --disable-systemd \
  --enable-deprecated \
  --build=x86_64-slackware-linux

I hope this helps you diagnose and properly fix the issue.

Best Regards
   Ivan Kalvachev
