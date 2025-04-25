Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BC118BB8E
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 19:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745610735; cv=none; b=mEY1R1BjagJNJfGQWRlPeS1VewWf739yYxGXChs4DessquvB8x0dM2QuRlljM6ZxGHTnOzallcsZjgaCtA+UCj3HGjwC4YAyNBnTu7as5a040T9iAQL2LpgYLhVdAvjotlETzXdkW3Ezjl5pgqNazi9N5gmYIbfAnkZz/xgtYT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745610735; c=relaxed/simple;
	bh=VJsJjEfU9uFcTxdUXa17sqfuNO85rb8c49Ri0Aagpv4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=BLo6qtuQwAB19lmUpZ967Zh13sBsq9vS2YeDy90uubpnx61HWy+7cB/8nIlcG8qIlShLinnodNLUgF9N9mg4QU7mtjbsB9r2YaRR1xgaUzrpbXRdUnrRyE+PyvWKgZHlO6AL/guOfAPIBp/67JmmofAx9Akc+HId4uYr/jlOufU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JqhfdXjA; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JqhfdXjA"
Received: from github.com (hubbernetes-node-2b29bc0.va3-iad.github.net [10.48.139.15])
	by smtp.github.com (Postfix) with ESMTPA id 845E48C0216
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Apr 2025 12:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1745610732;
	bh=UHFiyH6SVDi7lGPy1r67JssyvLWp40xGG5Vl/lA9EpM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JqhfdXjAEdCeg01qPpHckdHTilo7VQ0C/3CjdT4M/BADju6RXivzuFAngbn6U1Ow1
	 +1kvZ3M1nl0Cr4YSm2OoPw974mJC5DtO5pfqiIuyO2lSJau7RDZMifHp57YejZ6C3s
	 Y32a46NiaPVKd+by0nGyoIjvYW0mHXVyghoG814U=
Date: Fri, 25 Apr 2025 12:52:12 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/957173/000000-defba7@github.com>
Subject: [bluez/bluez] defba7: shared/ad: Fix crash on match_manufacturer
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

  Branch: refs/heads/957173
  Home:   https://github.com/bluez/bluez
  Commit: defba73406566752b3e336f504ebe01d28e6a110
      https://github.com/bluez/bluez/commit/defba73406566752b3e336f504ebe01d28e6a110
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-04-25 (Fri, 25 Apr 2025)

  Changed paths:
    M src/shared/ad.c

  Log Message:
  -----------
  shared/ad: Fix crash on match_manufacturer

When matching manufacturer BT_EA_MAX_DATA_LEN in case of EA since that
can be bigger than regular advertisements otherwise it can cause the
following crash:

data #0 __libc_do_syscall () at ../sysdeps/unix/sysv/linux/arm/libc-do-syscall.S:47
1 0xb6e05c58 in __pthread_kill_implementation (threadid=, signo=signo@entry=6,
no_tid=no_tid@entry=0) at pthread_kill.c:43
2 0xb6e05c8c in __pthread_kill_internal (signo=6, threadid=) at pthread_kill.c:78
3 0xb6dd63ce in __GI_raise (sig=sig@entry=6)
at /usr/src/debug/glibc/2.39+git/sysdeps/posix/raise.c:26
4 0xb6dc7f5c in __GI_abort () at abort.c:79
5 0xb6dfd608 in __libc_message_impl (fmt=0xb6ea1a50 "*** %s **: terminated\n")
at /usr/src/debug/glibc/2.39+git/sysdeps/posix/libc_fatal.c:134
6 0xb6e5a430 in __GI___fortify_fail (msg=) at fortify_fail.c:24
7 0xb6e59ffe in __GI___chk_fail () at chk_fail.c:28
8 0xb6e5a8a2 in __GI___memcpy_chk (dstpp=dstpp@entry=0xbefff7e6, srcpp=,
len=, dstlen=dstlen@entry=29) at memcpy_chk.c:27
9 0x004944f4 in memcpy (__len=, __src=, __dest=0xbefff7e6)
at /usr/include/bits/string_fortified.h:29
10 match_manufacturer (data=, user_data=)

Fixes: https://github.com/bluez/bluez/issues/1169



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
