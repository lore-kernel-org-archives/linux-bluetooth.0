Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DDF826FA66
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 17:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739898785; cv=none; b=Nvg+trTZRnIGQ4ic1bQhy3ApDS3nk2hC9al7k9xzBa3XYRkI/7ceDLwf+w6KFroVERt073swdM+ZewKkkSyiS0ChJSjx/Z68NwDwb8M5udzQksUFki8evH/3S6cgy1h4l/Vu+hd0VdY6LLSIeujQ9eeE4lma98Ex3ERfNq3KO3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739898785; c=relaxed/simple;
	bh=9HQcyAVZXmYkeTINLXMfrqyMUfWNFqfoSuIp+32tfbM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=deTwB1y8M4ZKJfp9FhKBY5dGLyzK8UFGoWdBg8e9xmlNPds9dEJ88eOlO8g9AjTPehSCqLjQXjuPX2JykxxcApqTcSxyPjhcm67lB1bjMYVeO3pmWTbrdpiqkEgx8ztlkYU7bJJk65106juuO5S7mH0sZjrgFJu12vT+VG47Hl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mTdGKDwy; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mTdGKDwy"
Received: from github.com (hubbernetes-node-9bf2421.ac4-iad.github.net [10.52.130.31])
	by smtp.github.com (Postfix) with ESMTPA id 89CBC211E2
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Feb 2025 09:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1739898781;
	bh=cC5EhgO01SlkeinsX4QG9iEC1Ov5+W0rAAnyCaIf8ZU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mTdGKDwyUfDTplaN2JXOqM2matm0f2qaxva4E4N5v7RA1mBGeekWcNAVNs9sidcJp
	 DbqnB0y2daKJ31gvlcu0ssoMIvZh6eGcCnqlGaBkmp8LLy9LsgAL969csFCxC5Vl82
	 pavy/uNICi+WYZ3Jr4nb5K6YV0I3kjTDn8g5lEUA=
Date: Tue, 18 Feb 2025 09:13:01 -0800
From: Arkadiusz Bokowy <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/264bf9-3c62df@github.com>
Subject: [bluez/bluez] fdbfe0: monitor: Fix crash due to negative max_len
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
  Commit: fdbfe0018f6f216ff089c0e1db848ec8ae16585e
      https://github.com/bluez/bluez/commit/fdbfe0018f6f216ff089c0e1db848ec8ae16585e
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-02-18 (Tue, 18 Feb 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Fix crash due to negative max_len

While calculating the max_len for printing the packet details that can
come out negative, so this discards extra text if that happens otherwise
it can cause the following error:

 Process terminating with default action of signal 6 (SIGABRT)
    at 0x4A800F4: __pthread_kill_implementation (in /usr/lib64/libc.so.6)
    by 0x4A26FDD: raise (in /usr/lib64/libc.so.6)
    by 0x4A0E941: abort (in /usr/lib64/libc.so.6)
    by 0x4A0F7A6: __libc_message_impl.cold (in /usr/lib64/libc.so.6)
    by 0x4B0E3B8: __fortify_fail (in /usr/lib64/libc.so.6)
    by 0x4B0DD53: __chk_fail (in /usr/lib64/libc.so.6)
    by 0x4B0F544: __snprintf_chk (in /usr/lib64/libc.so.6)
    by 0x11F3E6: snprintf (stdio2.h:68)


  Commit: 3c62df13abbce6551166a25c481a1cd4d2d32ce7
      https://github.com/bluez/bluez/commit/3c62df13abbce6551166a25c481a1cd4d2d32ce7
  Author: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
  Date:   2025-02-18 (Tue, 18 Feb 2025)

  Changed paths:
    M emulator/btdev.c
    M emulator/bthost.c

  Log Message:
  -----------
  bthost: Set advertising intervals to valid value

The range for LE advertising intervals shall be in range between 20 ms
and 10,485,759.375 ms. Requesting other value should result in the
unsupported feature or parameter value error code (0x11).

After the modification in fa4d477, the btdev emulator no longer accepts
uninitialized LE advertising intervals. To fix that, set the default LE
advertising interval to the lowest possible value - 20 ms - in order to
minimize tests delay cause by device discovery.

Also, this commit fixes the detection of the high duty cycle directed
connectable advertising and sets the advertising interval to 3 ms for
such cases in order to be complaint with the spec.


Compare: https://github.com/bluez/bluez/compare/264bf951f2d6...3c62df13abbc

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
