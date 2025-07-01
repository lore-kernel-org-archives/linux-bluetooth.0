Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118EA26D4CA
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751365317; cv=none; b=HF6N7b/babDxv9iGAe9Z6vQK+qDwiO0+9CqYRx5fMvCT6kv7ToeFKAUi55xfg/GLZwV7f6AyK1IdjXx2jtYuz8BqAgHn65Snw4OIOVIp0mI5V+iQnV/gUf5PTyDJwJX/4TOoIlaOrtxrtCkLsAR9NjL+kI2G5BgQNcyOImj9jRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751365317; c=relaxed/simple;
	bh=ZFeiQgXsMFg2hxSVQvFGm1t/SSNy1Xt2YSoW+cGH9dc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hemfrE1LFzA5py9eqV7lA7utuJZDS03NEU7Wh3OCzI/p0bdSQDuhe6TMY5p/TpLYluT5Fe3ALrYsxf/3yxFTggg2LUOKOX4vNeDyrDxnrTb5gn769lU82gRnKiW3CklmI3YmQHTD/bkrnaZ1JenAFIhOng4NrpkvhcfgEJHwtNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=RwoQKQYl; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="RwoQKQYl"
Received: from github.com (hubbernetes-node-e1f146c.ac4-iad.github.net [10.52.14.41])
	by smtp.github.com (Postfix) with ESMTPA id 1296A21249
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 03:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751365315;
	bh=RfdDA7P2A3MtBMwVfgYaKy/Sj2i7B60GgaGXdDRoKG0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=RwoQKQYlU6nBi0mNxYVYWzaTgSe9jcuOHb8L/YJhaMuSuDQjs2j7cQrmokJUdkbJv
	 90XVyRR9LWCDvEyajaKRZZd6b/xBmyJefH6rM99mS12pTToiEcpQ2cIUUe1vy1vaJa
	 AKcgJ1v67pY4NePvmpYzh+gT+9jwpL4QoUj6fLrQ=
Date: Tue, 01 Jul 2025 03:21:55 -0700
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/977659/000000-c2b027@github.com>
Subject: [bluez/bluez] d4d636: error: Rename device error helper to match
 retval
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

  Branch: refs/heads/977659
  Home:   https://github.com/bluez/bluez
  Commit: d4d636b22d08d70937febad2fcb0038ca32a8e68
      https://github.com/bluez/bluez/commit/d4d636b22d08d70937febad2fcb0038ca32a8e68
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M src/device.c
    M src/error.c
    M src/error.h

  Log Message:
  -----------
  error: Rename device error helper to match retval

Rename the helper to show that it outputs a string, and not an error
DbusMessage as the other functions do.


  Commit: 660d04f0a95be83c1f8dc79e1ebe9ffcb62a7a14
      https://github.com/bluez/bluez/commit/660d04f0a95be83c1f8dc79e1ebe9ffcb62a7a14
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M src/error.c
    M src/error.h

  Log Message:
  -----------
  error: Add helper to return DbusMessage errors from errno

This will allow us to start adding more precise errors instead of
"Failed" with a string if we're parsing an errno.


  Commit: 2f6b814a499f347c15e36cd0d1fa327ea11d4d5d
      https://github.com/bluez/bluez/commit/2f6b814a499f347c15e36cd0d1fa327ea11d4d5d
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Use new DbusMessage error helper


  Commit: 9b00d10c55113f75ab5684f0fdd00996a9ce4a80
      https://github.com/bluez/bluez/commit/9b00d10c55113f75ab5684f0fdd00996a9ce4a80
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M src/error.c
    M src/error.h

  Log Message:
  -----------
  error: Make errno to string helpers private

We're not using them outside the error code itself.


  Commit: 898da922298745920209885fa84afaf174a99e4d
      https://github.com/bluez/bluez/commit/898da922298745920209885fa84afaf174a99e4d
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M doc/org.bluez.Device.rst
    M src/device.c
    M src/error.c
    M src/error.h

  Log Message:
  -----------
  device: Better error when no BR/EDR profiles can be connected to

Add a more precise error when there are no BR/EDR profiles to connect
to. This is useful when trying to connect to a particular device, and
there are no relevant profiles to connect to on the bearer.


  Commit: d030c498000202554f2dab4413a809f7140f158a
      https://github.com/bluez/bluez/commit/d030c498000202554f2dab4413a809f7140f158a
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M src/device.c

  Log Message:
  -----------
  device: Better "Connect" debug

Output clearer debug information so that it's possible to follow the
decisions made by the bluetoothd daemon when a client such as
bluetoothctl or the GNOME Bluetooth settings ask it to connect to a
device.


  Commit: c76080b99af6fe1d41c1bc34b6ed18eede4275e5
      https://github.com/bluez/bluez/commit/c76080b99af6fe1d41c1bc34b6ed18eede4275e5
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M doc/org.bluez.Device.rst
    M src/device.c
    M src/error.c
    M src/error.h

  Log Message:
  -----------
  device: Better error when the link key is missing

Add a more precise error when the link key is missing for a
profile or device we're trying to connect to.


  Commit: c2b027956baea12d9c6d9f1dd025a326617fcd56
      https://github.com/bluez/bluez/commit/c2b027956baea12d9c6d9f1dd025a326617fcd56
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2025-07-01 (Tue, 01 Jul 2025)

  Changed paths:
    M doc/org.bluez.Device.rst
    M src/device.c
    M src/error.c
    M src/error.h

  Log Message:
  -----------
  device: Better error when the adapter is not powered


Compare: https://github.com/bluez/bluez/compare/d4d636b22d08%5E...c2b027956bae

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
