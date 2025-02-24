Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA1A19DF8C
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 20:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428142; cv=none; b=mLst7i3muqkiqFbl4NYJFENxB+hUJwuf3dC8cbNRNR9BnWWlWIz/08Cw6HZMVYthAcDjWq+1OztIer8OTMqwWGuPv7ErQdVfiQs2Xeb6tTjWJDzfCYu+Z43WVof4uJOR2ZYJ7N3pnAJvzp1I3gdD1MruaEZfRgJKq83AiHl4L68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428142; c=relaxed/simple;
	bh=oLsVV95QC4L8lc/kf1EX3inhd0tN2OHPfv/QWnvjE1s=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=DbL1Z60Dze7JzDE/7+phdbZ+h2Q0+PBG0CACZa+2dxTfEjqCiLlO36nLvAVqiKbxUUwcnXxECbWlNin8xCMtnp6JqWWYPldoQQUCzmYR+qrT5qrMsSRaI5dcvgR3gVo4jIX7h3K7cVCnGhenkCqGU3aY2J9KgDYgX/DnGd28xSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=L+NHSqvv; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="L+NHSqvv"
Received: from github.com (hubbernetes-node-afc927f.ash1-iad.github.net [10.56.163.32])
	by smtp.github.com (Postfix) with ESMTPA id DF509920AA8
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 12:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1740428139;
	bh=mjEC//0rggoOuA+3lG+DRCQ855bx3TU+f2uFLe8cUIk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=L+NHSqvvEFnIWAu4T2L3wfe82aynk3G1flJolFZPaYZWpIhs27QMOkLK6dYAmWwwK
	 YD8+l12yLl9A7faJxFO2BriK+ykHEXs/Sz8zDZaV1eseDE436rOrvHpqeyxcVK1jPE
	 mYGHF12XS8UtXTeXn++dUc8KyZa31KlWEXNJYicI=
Date: Mon, 24 Feb 2025 12:15:39 -0800
From: BajajSarv <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/fc7be1-4465c5@github.com>
Subject: [bluez/bluez] 4465c5: shared/gatt-db: Fix incorrect attribute type
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
  Commit: 4465c577778d812702d752dfd2812e25a2f69b31
      https://github.com/bluez/bluez/commit/4465c577778d812702d752dfd2812e25a2f69b31
  Author: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
  Date:   2025-02-21 (Fri, 21 Feb 2025)

  Changed paths:
    M src/shared/gatt-db.c

  Log Message:
  -----------
  shared/gatt-db: Fix incorrect attribute type

As part of BLE GATT Fuzzing testcase,if application sends an invalid
ATT_FIND_BY_TYPE_VALUE_REQ with attribute type as CCC (UUID 0x2902).
However,this request is not valid for descriptors like CCC, as it is
specifically intended for discovering primary services with a given UUID.
When processed in find_by_type(),attempts to access attribute->value
without checking if attribute or attribute->value is NULL,
leading to a segmentation fault.

Added NULL pointer checks before accessing attribute values in multiple
functions to prevent potential crashes due to invalid memory access

Bluetoothd crash dump:
0 0x73fec87ae81e  (/lib/x86_64-linux-gnu/libc.so.6+0x1ae81e)
1 0x73fec94942e9 in MemcmpInterceptorCommon(void*, int (*)
(void const*, void const*, unsigned long), void const*,
void const*, unsigned long)
../../../../src/libsanitizer/sanitizer_common/
sanitizer_common_interceptors.inc:881
2 0x73fec9494bc6 in __interceptor_memcmp ../../../../src/
libsanitizer/sanitizer_common
/sanitizer_common_interceptors.inc:892
3 0x73fec9494bc6 in __interceptor_memcmp ../../../../src/
libsanitizer/sanitizer_common
/sanitizer_common_interceptors.inc:887
4 0x5d5c290f2456 in find_by_type src/shared/gatt-db.c:1389
5 0x5d5c290ff855 in foreach_in_range src/shared/gatt-db.c:1549
6 0x5d5c29099752 in queue_foreach src/shared/queue.c:207
7 0x5d5c290fb085 in gatt_db_foreach_in_range src/shared/gatt-db.c:1593
8 0x5d5c290fb4ca in gatt_db_find_by_type_value src/shared/gatt-db.c:1434
9 0x5d5c290e1996 in find_by_type_val_cb src/shared/gatt-server.c:745
10 0x5d5c290c3083 in handle_notify src/shared/att.c:1015
11 0x5d5c290c3083 in can_read_data src/shared/att.c:1100
12 0x5d5c291867c1 in watch_callback src/shared/io-glib.c:157
13 0x73fec931bc43 in g_main_context_dispatch
(/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x55c43)
14 0x73fec93712b7  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xab2b7)
15 0x73fec931b2b2 in g_main_loop_run (/lib/x86_64-linux-gnu/
libglib-2.0.so.0+0x552b2)
16 0x5d5c29188518 in mainloop_run src/shared/mainloop-glib.c:66
17 0x5d5c29188e26 in mainloop_run_with_signal src/shared
/mainloop-notify.c:189
18 0x5d5c28d8c6ae in main src/main.c:1544
19 0x73fec8629d8f in __libc_start_call_main ../sysdeps/nptl/
libc_start_call_main.h:58
20 0x73fec8629e3f in __libc_start_main_impl ../csu/libc-start.c:392
21 0x5d5c28d8f4c4 in _start (/root/LE_Audio_Work/Bluez/bluez/
src/bluetoothd+0x6204c4)



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
