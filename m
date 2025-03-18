Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54137211A24
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742322005; cv=none; b=HEvkj3L9hAtxZ6reqJMTSYjCIwWNyfO6a6fMJuGQwnZ66cVzY0DPBixVlfFkxMHNG1ibhhyt2uKKg5b2Y7dXkPEkWFBtV2tn6ecD/AG8vOoS3pjsTp7hUprUhbSMyqAdkjI7YHlb6Y31a6yhIZzF85LvNnBdNhsYqI230Qd0c3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742322005; c=relaxed/simple;
	bh=EmUi7JrslqGWUVlpLTvctiSBhVgihjdxbdz1f8uMFYA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=sCkLf3sKsr8C1P6onr/7gdBIT71sQhXqWTtpKlW6XfaUqixCCYcDwC24u4Js7gJHMKq8T4L+tSyJbnFeo2xWBf1j1ArLDQ/9VwJsyBTVSLTIRx6fWm35TYOBes12+IadMn/+TFbkkZICIeQJyEs49Ji89U0GSTwC7E8n9mN7WIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=UVar3Rh/; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="UVar3Rh/"
Received: from github.com (hubbernetes-node-6277201.va3-iad.github.net [10.48.136.31])
	by smtp.github.com (Postfix) with ESMTPA id 3D9FCE113C
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Mar 2025 11:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1742322002;
	bh=P96j7bbjpFE8wBuONIpGL09+stu9GpoSa/N4quKnCLI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=UVar3Rh/Y9PZvSZyQglR4yt8LwpaVoJNFyZF0X/8y5PCYeqP5eCH32DeYYQ8vl1ol
	 d+80IiTCVubm7MF3hVd8/9aIGFp3ueoBGM7ncBmlYJ4XUtT1wGcmvxQTpoYkcdgNrK
	 oNLur4FzJOcyYER2uDCZQ3TvfGTtIzY2jZEW7Ge4=
Date: Tue, 18 Mar 2025 11:20:02 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/9590cf-3b9a6d@github.com>
Subject: [bluez/bluez] 48c33d: client/player: Fix changing preset SDU
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: 48c33d291d921be2fb2a7958528e0d16a176a913
      https://github.com/bluez/bluez/commit/48c33d291d921be2fb2a7958528e0=
d16a176a913
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-03-17 (Mon, 17 Mar 2025)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix changing preset SDU

This fixes changing preset SDU when configuring multiple channels, the
SDU of the configuration is the one the needs to be adjusted not the
preset itself.


  Commit: 0205edbd29fc972f9aad2b2d21789e97f45d3c24
      https://github.com/bluez/bluez/commit/0205edbd29fc972f9aad2b2d21789=
e97f45d3c24
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2025-03-18 (Tue, 18 Mar 2025)

  Changed paths:
    M src/shared/util.c
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: implement argsisutf8()

This implements argsisutf8() which checks that all strings in the
argv array are written in utf8.


  Commit: eb1dd2bc1c4b32b791203340b303306bd7f5fe0b
      https://github.com/bluez/bluez/commit/eb1dd2bc1c4b32b791203340b3033=
06bd7f5fe0b
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2025-03-18 (Tue, 18 Mar 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: replace validate_input() with argsisutf8()

argsisutf8() does the same thing as validate_input(), but can
be used elsewhere.


  Commit: 1edffc22a343511ad1357d002f1968e4746c68a6
      https://github.com/bluez/bluez/commit/1edffc22a343511ad1357d002f196=
8e4746c68a6
  Author: Roman Smirnov <r.smirnov@omp.ru>
  Date:   2025-03-18 (Tue, 18 Mar 2025)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: add check to shell_exec()

When passing a Unicode character to bluetoothctl, the application
crashes in dbus:

dbus[5324]: arguments to dbus_message_iter_append_basic() were
incorrect, assertion "_dbus_check_is_valid_utf8 (*string_p)"
failed in file .../dbus-message.c line 2765.

Check that all characters are written in utf8.

Fixes: https://github.com/bluez/bluez/issues/1137


  Commit: 2eba5b6e91555d9f4dfb1c4b2adcc5b18d1d8897
      https://github.com/bluez/bluez/commit/2eba5b6e91555d9f4dfb1c4b2adcc=
5b18d1d8897
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-03-18 (Tue, 18 Mar 2025)

  Changed paths:
    M obexd/plugins/bluetooth.c

  Log Message:
  -----------
  obex: Fix typo


  Commit: 3b9a6d3f6186c510bcd762498b141c6114e612b2
      https://github.com/bluez/bluez/commit/3b9a6d3f6186c510bcd762498b141=
c6114e612b2
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-03-18 (Tue, 18 Mar 2025)

  Changed paths:
    M obexd/client/pbap.c

  Log Message:
  -----------
  obex: Publish SDP record for Phonebook Access Client

This is required for passing below PTS test cases:

1. PBAP/PCE/SGSIT/ATTR/BV-01-C
   Attribute GSIT - Bluetooth Profile Descriptor List, PBAP 1.2
2. PBAP/PCE/SGSIT/OFFS/BV-02-C
   Attribute ID Offset String GSIT - Service Name
3. PBAP/PCE/SGSIT/SERR/BV-01-C
   Service record GSIT - PBAP PCE

Currently the Phonebook Access Client SDP record is not registered,
hence  above test cases are failing.
This commit adds code to register the profile (0x112e).


Compare: https://github.com/bluez/bluez/compare/9590cf12b232...3b9a6d3f61=
86

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
