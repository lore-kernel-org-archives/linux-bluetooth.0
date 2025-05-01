Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956E62236FA
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 19:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746126510; cv=none; b=fGxyQHCSpC/YM/Q4zk297wA2hVo8MrWmCSKzteP/7HrDWDyCF9vqzVxDnxVDPtjdlaSZrEZGJGCOizaG5gjTZOPpG3OZIiESp23gV9RH42vOz+84KXo7nwatDB3AlzY9AljfWSISBTsLQRidZR3T2AyI6f81OcpRirtHrPFIc0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746126510; c=relaxed/simple;
	bh=k/y+DF2bK7x5Nc0qZ8Fan34XMXRpt7CpMtRnhkdOPRM=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KUXkzvLSMUHBeKYbSba3wylJxJbe/jxGifvH8UDR5QLmk2zDkGVGaEqVaOQxGg77KfS25o27VnPAvy+pjy8XZejCOLjb3fHAhfNjExg1oO3E848s9Nn788iiutPdYIaDcDAVoz3HK0LXX8F6dVbfI3tdd70VuwrFIWYdJiEveXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Cu+PQyXu; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Cu+PQyXu"
Received: from github.com (hubbernetes-node-1eeca9b.ac4-iad.github.net [10.52.139.40])
	by smtp.github.com (Postfix) with ESMTPA id 6E71A6407D7
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 May 2025 12:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746126507;
	bh=W4fE26knlYMrj136LFLuS3b8ew36mqYHXst4g9815nE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Cu+PQyXubXX43I0AUYSOaLaD+bTtBuzVZ9AHfC6YNi7/SAOFtAiZsKmxhGvHpCcvI
	 BvukKyqLHMGgIGxYtoiKm3nN3x6EjLWlGVDvNwoOJoSGfWTn2af0r/9nkUcEi62kET
	 IhMdHw1SuulehIzTdpz3NCyiAUnYQnZ6ftB9/LX4=
Date: Thu, 01 May 2025 12:08:27 -0700
From: Perale Thomas <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/bbfeef-9c5218@github.com>
Subject: [bluez/bluez] b111b5: input: fix HID compilation w/o HoG
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
  Commit: b111b5e15eb74e08b74cb3c7e91bcb21f54be4c7
      https://github.com/bluez/bluez/commit/b111b5e15eb74e08b74cb3c7e91bcb21f54be4c7
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


  Commit: 9c52188d753002a6afd6ae145f921a2ff52c1c81
      https://github.com/bluez/bluez/commit/9c52188d753002a6afd6ae145f921a2ff52c1c81
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


Compare: https://github.com/bluez/bluez/compare/bbfeef3a04b0...9c52188d7530

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
