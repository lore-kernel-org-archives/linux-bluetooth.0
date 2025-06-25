Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995FC1E87B
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 14:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750860975; cv=none; b=Xtkbj5r6Ngu0JYQOm/Xs3ViFDRdTnn9TNIQBMFF9kmLGkymEXQDShSYG+Sxv6f66KLsPoqqrkBPd9ZfcTJBKv+MHtQIG44J5emtQIBnKM63ER0GltsX+THvMe1BlhTVvq64+7HhPUN8DE1XVOWsOkrTXhYYYeCxyiaZ3ktDWWXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750860975; c=relaxed/simple;
	bh=uFwg1FxYbLXJklEL0ol1xxV7y/UXL/FD3SDQHissFQ8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=tBTBqBg0Fl6wnAR88OL+ZLGEJM4kaw9vGFp+m2A4pAHqJ0rr1xeEzalfoW7WxK3EYrI8QeuI7m16dxkmy+rMgcKo6/r9WUTq+eyM3BfsnnosnEFmCTddQqPjDkAbWNYpHZhqTXlrjLa6uirukSwUOEIoLt8iKJn8ZkiWAiucJEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OlB1EVx0; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OlB1EVx0"
Received: from github.com (hubbernetes-node-44c2c22.va3-iad.github.net [10.48.141.16])
	by smtp.github.com (Postfix) with ESMTPA id 9F6EDE0B1D
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 07:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750860972;
	bh=xHU0q1JJ9NiqQGxPATonP1kj+rgKKPvwS4tYOD369Dg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OlB1EVx01EOSgs3MF84ueuVHECV/T1XAiu8XbWC4LWxatYj08I8GI1WQFmLeXgW4l
	 i4M5V+1ZXdjDXCvJk0fziuqUKoc3w358uZocosLLPCrxFvQa1RSJ54Qkyj2NY/YXA3
	 KGTD9SrIMO67CAdDJFdz+ApZNzE7IqqOS8Wxj5ic=
Date: Wed, 25 Jun 2025 07:16:12 -0700
From: Andreas Kemnade <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/975818/000000-c9acde@github.com>
Subject: [bluez/bluez] c9acde: gatt-client: avoid UAF after acquire notify
 failure
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

  Branch: refs/heads/975818
  Home:   https://github.com/bluez/bluez
  Commit: c9acde78c668eaf28a41d58926031c3c02c8602f
      https://github.com/bluez/bluez/commit/c9acde78c668eaf28a41d58926031c3c02c8602f
  Author: Andreas Kemnade <andreas@kemnade.info>
  Date:   2025-06-25 (Wed, 25 Jun 2025)

  Changed paths:
    M src/gatt-client.c

  Log Message:
  -----------
  gatt-client: avoid UAF after acquire notify failure

If a disconnect happens during AcquireNotify dbus calls, a lot of
debris is left over. Subsequent calls to AcquireNotify will return
NotPermitted and StopNotify leads to an UAF, crashing bluetoothd.

Fix that by also clean up the socket stuff on failure.

This was provoked by putting the device into some RF shielding bag
and open and close it quickly.

Valgrind output:

bluetoothd[26032]: [:1.126:method_call] > org.bluez.GattCharacteristic1.AcquireNotify [#145]
bluetoothd[26032]: [:1.126:error] < org.bluez.Error.NotPermitted [#145]
bluetoothd[26032]: [:1.74:method_call] > org.freedesktop.DBus.Properties.GetAll [#895]
bluetoothd[26032]: [:1.74:method_return] < [#895]
bluetoothd[26032]: [:1.74:method_call] > org.bluez.GattCharacteristic1.StopNotify [#896]
==26032== Invalid read of size 8
==26032==    at 0x1A5721: notify_io_destroy (gatt-client.c:1562)
==26032==    by 0x1A7290: sock_io_destroy (gatt-client.c:1171)
==26032==    by 0x1A7290: destroy_sock (gatt-client.c:1192)
==26032==    by 0x1A73D6: characteristic_stop_notify (gatt-client.c:1698)
==26032==    by 0x1CF478: process_message (object.c:293)
==26032==    by 0x49CB71B: ??? (in /usr/lib/x86_64-linux-gnu/libdbus-1.so.3.32.4)
==26032==    by 0x49BB62A: dbus_connection_dispatch (in /usr/lib/x86_64-linux-gnu/libdbus-1.so.3.32.4)
==26032==    by 0x1CBCEF: message_dispatch (mainloop.c:59)
==26032==    by 0x48BF61E: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x48BF9D7: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x48BFC8E: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x202114: mainloop_run (mainloop-glib.c:65)
==26032==    by 0x202501: mainloop_run_with_signal (mainloop-notify.c:196)
==26032==  Address 0x5a7a430 is 0 bytes inside a block of size 32 free'd
==26032==    at 0x484417B: free (vg_replace_malloc.c:872)
==26032==    by 0x1DEC0F: complete_notify_request (gatt-client.c:1663)
==26032==    by 0x1DEC0F: enable_ccc_callback (gatt-client.c:1735)
==26032==    by 0x1DB8FF: disc_att_send_op (att.c:464)
==26032==    by 0x1DB8FF: disconnect_cb (att.c:676)
==26032==    by 0x2017A4: watch_callback (io-glib.c:173)
==26032==    by 0x48BF61E: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x48BF9D7: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x48BFC8E: g_main_loop_run (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x202114: mainloop_run (mainloop-glib.c:65)
==26032==    by 0x202501: mainloop_run_with_signal (mainloop-notify.c:196)
==26032==    by 0x12E60C: main (main.c:1535)
==26032==  Block was alloc'd at
==26032==    at 0x48417B4: malloc (vg_replace_malloc.c:381)
==26032==    by 0x1D2F4D: util_malloc (util.c:46)
==26032==    by 0x1A5DD3: notify_client_create (gatt-client.c:1426)
==26032==    by 0x1A5EFC: characteristic_acquire_notify (gatt-client.c:1588)
==26032==    by 0x1CF478: process_message (object.c:293)
==26032==    by 0x49CB71B: ??? (in /usr/lib/x86_64-linux-gnu/libdbus-1.so.3.32.4)
==26032==    by 0x49BB62A: dbus_connection_dispatch (in /usr/lib/x86_64-linux-gnu/libdbus-1.so.3.32.4)
==26032==    by 0x1CBCEF: message_dispatch (mainloop.c:59)
==26032==    by 0x48BF61E: g_main_context_dispatch (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)
==26032==    by 0x48BF9D7: ??? (in /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.7400.6)



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
