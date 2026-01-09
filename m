Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCBB2ED873
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 20:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767991192; cv=none; b=TrHo+yhvtt3Wr8LYYXaeJST23i/F1M39V9VRF/vITKriCaA+DXX83ZBKVadti/KnXyx33LvYpZ2fUZ8ZixOBGyS6hpoUiXwS8OONvP9w6UldOMgLHCqNFo7LpT6wpl7/2OE3kyENe27LOxWFxHa2nqPtf+7bRFfV9SqGDzTd8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767991192; c=relaxed/simple;
	bh=+hkktBAMzW1VhSyOIYgwDDug7f4hcHFoiPdaFxftmo4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EhXk5x6txJWiIpziQnBFAaPyE3dCcSqsduysW+ZWhb9nj1iwwSF7/Eqsf2L3SpeMzsa3RSQOpotjsx+vnEYJg8jWw1cSHKn8MAqCKSnyef0ujkZVcxh7dQvhq+LQVNmBzq1RemXtfs7WVXzYhylllOd0motejp8zpdeqpSse61E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PQX4kzlt; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PQX4kzlt"
Received: from github.com (hubbernetes-node-de061c5.va3-iad.github.net [10.48.177.34])
	by smtp.github.com (Postfix) with ESMTPA id BB6363C1101
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jan 2026 12:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1767991190;
	bh=27Up76yTzQ7v9sIsAfeKB5CR6hxT+BBoqx58wC61/Ok=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PQX4kzlt7r2IwOT/s4TaINFPJqO9SDqRa3r5GI31SXQ4sp6Ip5yKQutMOoAyHQgzv
	 xmiJu1hZTB5KhhZ5oJGEsFVQB/Rx++TPQhvnanEzRbCPGFB1KyIvhFKeFqnRU+2H5E
	 u3N0S8jRkG43SGvdlzQ737zRk6RPm7UyTjSl+vas=
Date: Fri, 09 Jan 2026 12:39:50 -0800
From: dalegaard <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1040618/000000-c355eb@github.com>
Subject: [bluez/bluez] c355eb: gatt-client: prevent use-after-free when
 clients d...
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

  Branch: refs/heads/1040618
  Home:   https://github.com/bluez/bluez
  Commit: c355ebd3953d5c830e80907839c256dfe20e180f
      https://github.com/bluez/bluez/commit/c355ebd3953d5c830e80907839c256dfe20e180f
  Author: Lasse Dalegaard <dalegaard@gmail.com>
  Date:   2026-01-09 (Fri, 09 Jan 2026)

  Changed paths:
    M src/gatt-client.c

  Log Message:
  -----------
  gatt-client: prevent use-after-free when clients disconnect

Clients with an acquired characteristic subscription would free the
client during disconnect. When notify_io_destroy then tries to remove
the client, it'll use-after-free.

Add another reference when allocating the notify_io and unref it again
in notify_io_destroy.

This was found with AddressSanitizer:

==766875==ERROR: AddressSanitizer: heap-use-after-free on address 0x7b7782a31df0 at pc 0x55d19ae87cf0 bp 0x7ffcc28ea0d0 sp 0x7ffcc28ea0c0
READ of size 8 at 0x7b7782a31df0 thread T0
    #0 0x55d19ae87cef in notify_io_destroy src/gatt-client.c:1567
    #1 0x55d19ae83462 in sock_io_destroy src/gatt-client.c:1171
    #2 0x55d19ae83a4b in destroy_sock src/gatt-client.c:1192
    #3 0x55d19ae83c52 in sock_hup src/gatt-client.c:1207
    ...

0x7b7782a31df0 is located 0 bytes inside of 32-byte region [0x7b7782a31df0,0x7b7782a31e10)
freed by thread T0 here:
    #0 0x7f4784d1f79d in free /usr/src/debug/gcc/gcc/libsanitizer/asan/asan_malloc_linux.cpp:51
    #1 0x55d19ae85c57 in notify_client_free src/gatt-client.c:1360
    #2 0x55d19ae85dd5 in notify_client_unref src/gatt-client.c:1372
    #3 0x55d19ae86517 in notify_client_disconnect src/gatt-client.c:1418
    ...

previously allocated by thread T0 here:
    #0 0x7f4784d20cb5 in malloc /usr/src/debug/gcc/gcc/libsanitizer/asan/asan_malloc_linux.cpp:67
    #1 0x55d19af6154d in util_malloc src/shared/util.c:46
    #2 0x55d19ae86550 in notify_client_create src/gatt-client.c:1426
    #3 0x55d19ae880cd in characteristic_acquire_notify src/gatt-client.c:1593
    ...

Other avenues could also result in this use-after-free. The root issue
is that the client struct is put in to both the notify list, and the
notify_io struct, but without an extra reference increment.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
