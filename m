Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5165778F39
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746024388; cv=none; b=CG4p7QvgSxr7PI5is1+7TFIg/bPbQotOk9t49KFn10OmYb4D1jWZQ0nDjx2j613MkSWDApaU6D0oWTkk0EZXPE0IuuFRKHLAAING4DjjkSe7qDfaNV5RLRrhNQIFOWwbb+TnebAebQV+6GXTFnIDEX4MhOS3BDh1SiMhipDYEOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746024388; c=relaxed/simple;
	bh=keUQP7pKm5fftmZgkIQQy8QAdtcPHO6c9Bz8hqBp694=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=eFvgwd2C/afVliCifRP0x3sRjsj5X4gmkrHmTYmk/SkPxK595Z3ybMl50qTsyqmbywJu3pA9ZtxUXjh3i410wuQlGZ4TUmCJQ51veekljeELQpbtLaSa0vm9UdYaruxwE0ZLICeyV0HqWFw/884jyCtb4E02jAaGfcXhPs/Pk+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Z1NBpkPH; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Z1NBpkPH"
Received: from github.com (hubbernetes-node-5e9bda3.va3-iad.github.net [10.48.144.29])
	by smtp.github.com (Postfix) with ESMTPA id 6F2EAE0B60
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Apr 2025 07:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746024386;
	bh=s3akzzFce7pYM7OEyyX7geCj80Gvrvy8Tj1E9xCCn9o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Z1NBpkPHEQJKwbEXZWawPDLd2sWwwi3woeOcIb+k5kBW6VZYCitxqr1LWGrAzpTe6
	 2cHBO0afn2a1jEkJgp5OENXfqZIdUKvITfTZKmtYoTJ11Z4A3RksXxawwWXGNc7dKl
	 H8sYMj6uv/ayfxszDLypOHqaRibW7yQ4O+SBb3eU=
Date: Wed, 30 Apr 2025 07:46:26 -0700
From: Perale Thomas <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/958549/000000-37aeb6@github.com>
Subject: [bluez/bluez] 5960da: input: fix HID compilation w/o HoG
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

  Branch: refs/heads/958549
  Home:   https://github.com/bluez/bluez
  Commit: 5960da49b27a976ce8792bad46cceb74b740078b
      https://github.com/bluez/bluez/commit/5960da49b27a976ce8792bad46cceb74b740078b
  Author: Thomas Perale <thomas.perale@mind.be>
  Date:   2025-04-30 (Wed, 30 Apr 2025)

  Changed paths:
    M profiles/input/device.c
    M profiles/input/device.h
    M profiles/input/hog.c

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

This patch moves the `input_set_auto_sec` function to
`profiles/input/device.c` file so it remains defined even when HoG is
disabled.

[1] f2778f587 input: Add LEAutoSecurity setting to input.conf


  Commit: 37aeb6597318bb1befe5bd0b8f561359f27fa0c3
      https://github.com/bluez/bluez/commit/37aeb6597318bb1befe5bd0b8f561359f27fa0c3
  Author: Thomas Perale <thomas.perale@mind.be>
  Date:   2025-04-30 (Wed, 30 Apr 2025)

  Changed paths:
    M configure.ac
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

This patch introduces the HAVE_HID symbol to conditionally call the
HID-related code in the HoG plugin only when HID is enabled.

Additionally, hog_disconnect() reverts to its pre-[1] behavior when
the HID plugin is unavailable.

[1] 1782bfd79 input: Add support for UserspaceHID=persist

Fixes: https://github.com/bluez/bluez/issues/1228


Compare: https://github.com/bluez/bluez/compare/5960da49b27a%5E...37aeb6597318

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
