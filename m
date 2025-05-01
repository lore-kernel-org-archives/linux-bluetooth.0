Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE1F125D6
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117712; cv=none; b=JnhAFHrtehMVYeQh5PAGGMzsxvV7CHmCNN3CdzS/DWUMVVAkFgM+YoL43gt9JHSZHOqRvF4ugHIIzXKXTGvZDq2DN0ZkIhxrHucdgZIuXQAfkfpm/6oDEjPKeH4lldHHh94OuGiZSRzpwCjrkcDkvTOWezY7waMb/96VXQi2iGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117712; c=relaxed/simple;
	bh=SBqTlsySAekfb6JHKGUl2PoLXa3WTPF77KRAlPR9ZeQ=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=b6f4thxxQ58xhp89n61zdfosmksyddCsUX36YEByZFlIaq7Imp7KA6ZM+L2oWhD8OCcz2TZBtc8wiN6iABMn6P+Nm5I0sG/yaoKxzKnRgEkdS6ep3fj3r54fXWrzqDvcfWmJg/ieKQtTPjMm+8OWqWVtdtGeBUaVc32C2+b3Ze8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=KaGd94/5; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="KaGd94/5"
Received: from github.com (hubbernetes-node-d8d992d.ash1-iad.github.net [10.56.159.43])
	by smtp.github.com (Postfix) with ESMTPA id A3C26140B89
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 09:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746117710;
	bh=0VbSkwO8HrR8bKFAICsrTdeR/QJpiTCQifY3XHTKEwM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=KaGd94/53nbTqNBdVbv8T5hpTMBjl27KO8WT6LhQzTZ5PKZbPnyhAZtFgc8fc+NXI
	 5zOHZJ7rRK/Jgh4zBh4qXljdsDw30ZYb4KwHOMYP6EUAzE9pl2FZOjvZisdQrTtxRf
	 vCmgdzdDtexZwiJ9C8LRBevDOYfvEI0UlsPZbT9s=
Date: Thu, 01 May 2025 09:41:50 -0700
From: Perale Thomas <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/958828/000000-b62395@github.com>
Subject: [bluez/bluez] 418352: input: fix HID compilation w/o HoG
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

  Branch: refs/heads/958828
  Home:   https://github.com/bluez/bluez
  Commit: 418352cc036404fcb388431a6c834369ba31783f
      https://github.com/bluez/bluez/commit/418352cc036404fcb388431a6c834369ba31783f
  Author: Thomas Perale <thomas.perale@mind.be>
  Date:   2025-05-01 (Thu, 01 May 2025)

  Changed paths:
    M profiles/input/device.h
    M profiles/input/hog.c
    M profiles/input/manager.c

  Log Message:
  -----------
  input: fix HID compilation w/o HoG

Commit [1] introduced a dependency with the HID plugin in the HoG code
As a result, building with --enable-hid --disable-hog caused linker
errors due to undefined references to HoG-related functions:

```
> ./configure --enable-hid --disable-hog
...
> make
...
  CCLD     src/bluetoothd
/usr/bin/ld: profiles/input/bluetoothd-manager.o: in function `input_init':
/home/../bluez/profiles/input/manager.c:122:(.text.input_init+0x1c8): undefined reference to `input_set_auto_sec'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:6376: src/bluetoothd] Error 1
```

This patch moves the reading of the HOG specific configuration of the
'input.conf' file: LEAutoSecurity, to the HoG plugin file.

[1] f2778f587 input: Add LEAutoSecurity setting to input.conf


  Commit: b623954f429620fbb32e8f9daae2c6918d7b7ee5
      https://github.com/bluez/bluez/commit/b623954f429620fbb32e8f9daae2c6918d7b7ee5
  Author: Thomas Perale <thomas.perale@mind.be>
  Date:   2025-05-01 (Thu, 01 May 2025)

  Changed paths:
    M profiles/input/device.c
    M profiles/input/device.h
    M profiles/input/hog.c

  Log Message:
  -----------
  input: fix HoG compilation w/o HID

Commit [1] introduced a dependency with the HID plugin in the HoG code
As a result, building with --disable-hid --enable-hog caused linker
errors due to undefined references to HID-related functions:

```
> ./configure --disable-hid --enable-hog
> make
/usr/bin/ld: profiles/input/bluetoothd-hog.o: in function `hog_accept':
/home/../bluez/profiles/input/hog.c:184:(.text.hog_accept+0xbb): undefined reference to `input_get_auto_sec'
/usr/bin/ld: profiles/input/bluetoothd-hog.o: in function `hog_disconnect':
/home/../bluez/profiles/input/hog.c:205:(.text.hog_disconnect+0x12): undefined reference to `input_get_userspace_hid'
collect2: error: ld returned 1 exit status
make[1]: *** [Makefile:6344: src/bluetoothd] Error 1
make: *** [Makefile:4695: all] Error 2
```

This patch duplicate the read of the 'UserspaceHID=persist' config entry
in the HoG plugin file to remove the dependency on the HID plugin files.

[1] 1782bfd79 input: Add support for UserspaceHID=persist

Fixes: https://github.com/bluez/bluez/issues/1228


Compare: https://github.com/bluez/bluez/compare/418352cc0364%5E...b623954f4296

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
