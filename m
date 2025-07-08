Received: from out-21.smtp.github.com (out-21.smtp.github.com [192.30.252.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE2B17DFE7
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751989837; cv=none; b=McmT3SRTWgzu7/uzF+zXiZ0+O+PJ5QA5cOOVHaskMQij53vx5vg/xR4irixhpq290jJ0BYAF0Za0yqx7CFFtKt34VNr9qFoW1HnlmrfMY5V/HFtafuSZFpZrqB5BzaQP7g4SD9xLi8uW/RcrHNMjmuB+DqDIxYHpFGum4cb9HOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751989837; c=relaxed/simple;
	bh=JTTZWnSBOCOApcstlvbcv4Y5csx+eOB0eLLZV7M11iY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=PUj+RrhOsXDlWlS6Qkio5iyYHx7BDG0uJk+Zqr/NG66byyG08WsRBci44ly2QF6gXHabldPmN9Ig8+aBFg/Zt3SH4W+rwL1uoSSFXNiweXU/cpHoV+/Abj8hBTJQJTQ6PW/seLil+0kF33RXMxsKIpFk2bbafD2AZHHhmAOWl9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=jCNYpkGy; arc=none smtp.client-ip=192.30.252.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="jCNYpkGy"
Received: from github.com (hubbernetes-node-d71ae00.ac4-iad.github.net [10.52.158.56])
	by smtp.github.com (Postfix) with ESMTPA id 096BF7003F0
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 08:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751989835;
	bh=zPoYiTeNwsg2a5T9JqtOOjECio1t1rstnvYAlUF9bhA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=jCNYpkGy91OCn7V+gY9EakwqNIr92jHYsBnoEBKN6S8XpiQLnwmxRyJfc7/wW5G2t
	 Gb9wfPizSp4RH/hdVnmutdDI/n3YkkSQnTpHtxNAUHGq/wm+HwTM29FPo6gStcwplH
	 zSG30v6vGHTwtG870eznbe0SV2kjwEHHDxzAZsmI=
Date: Tue, 08 Jul 2025 08:50:35 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/980101/000000-30d642@github.com>
Subject: [bluez/bluez] fe0eb9: shared/util: Add strtoutf8 function
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

  Branch: refs/heads/980101
  Home:   https://github.com/bluez/bluez
  Commit: fe0eb95831ebc43210a92fd5d850f52d27287f33
      https://github.com/bluez/bluez/commit/fe0eb95831ebc43210a92fd5d850f=
52d27287f33
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M src/shared/util.c
    M src/shared/util.h

  Log Message:
  -----------
  shared/util: Add strtoutf8 function

This adds the strtoutf8 function that truncate a string before the
first non UTF-8 character.
This truncation is done in place.


  Commit: 83fbfb7ad0e5231067d52354eedfbf9ba15dd51e
      https://github.com/bluez/bluez/commit/83fbfb7ad0e5231067d52354eedfb=
f9ba15dd51e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  audio/avrcp: Fix crash with invalid UTF-8 item name

As stated in AVRCP 1.6.2 chapter 6.10.2.3 Media element item, for the
Displayable Name Length property, the target device may truncate the
item name:

  Length of Displayable Name in octets. The name shall be limited such
  that a response to a GetFolderItems containing one media player item
  fits within the maximum size of PDU which can be received by the CT.

This truncatation may occur in the middle of a multi-byte character,
at least with Samsung Music app, which triggers a DBus assertion and
crashes bluetoothd:

  profiles/audio/player.c:media_folder_create_item() Din Dhal Jaye
      Haye with lyrics | "=E0=A4=A6=E0=A4=BF=E0=A4=A8 =E0=A4=A2=E0=A4=B2 =
=E0=A4=9C=E0=A4=BE=E0=A4=8F
      =E0=A4=B9=E0=A4=BE=E0=A4=AF" =E0=A4=97=E0=A4=BE=E0=A4=A8=E0=A5=87 =E0=
=A4=95=E0=A5=87 =E0=A4=AC=E0=A5=8B=EF=BF=BD type audio uid 1
  profiles/audio/player.c:media_folder_create_item()
      /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item1
  profiles/audio/player.c:media_player_set_metadata() Title: Din Dhal
      Jaye Haye with lyrics | "=E0=A4=A6=E0=A4=BF=E0=A4=A8 =E0=A4=A2=E0=A4=
=B2 =E0=A4=9C=E0=A4=BE=E0=A4=8F =E0=A4=B9=E0=A4=BE=E0=A4=AF"
      =E0=A4=97=E0=A4=BE=E0=A4=A8=E0=A5=87 =E0=A4=95=E0=A5=87 =E0=A4=AC=E0=
=A5=8B=E0=A4=B2 | Guide | Dev Anand, Waheeda Rehman
  =E2=80=A6
  arguments to dbus_message_iter_append_basic() were incorrect,
      assertion "_dbus_check_is_valid_utf8 (*string_p)" failed in
      file dbus-message.c line 2775.
  This is normally a bug in some application using the D-Bus library.


  Commit: f091098e5c0e9d1117683379a14effaa07616d71
      https://github.com/bluez/bluez/commit/f091098e5c0e9d1117683379a14ef=
faa07616d71
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  audio/mcp: Use strtoutf8 for player name and track title

Truncate the string to first character before invalid UTF-8 one
instead of replacing non ascii characters by spaces.


  Commit: 4d04f4b3c7d56ea7fdfb3e17f47bf033a4f8b43b
      https://github.com/bluez/bluez/commit/4d04f4b3c7d56ea7fdfb3e17f47bf=
033a4f8b43b
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M profiles/gap/gas.c

  Log Message:
  -----------
  audio/gap: Use strtoutf8 for GAP device name

Truncate the string to first character before invalid UTF-8 one
instead of replacing non ascii characters by spaces.


  Commit: 53904d22aaec7723b800f93938ba2989585d9a19
      https://github.com/bluez/bluez/commit/53904d22aaec7723b800f93938ba2=
989585d9a19
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M src/eir.c

  Log Message:
  -----------
  eir: Use strtoutf8 for device names

Truncate the string to first character before invalid UTF-8 one
instead of replacing non ascii characters by spaces.


  Commit: 73b07a0b63ec3275abe93a722f4f0efcf165403f
      https://github.com/bluez/bluez/commit/73b07a0b63ec3275abe93a722f4f0=
efcf165403f
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M src/shared/ad.c

  Log Message:
  -----------
  shared/ad: Use strtoutf8 for name

Truncate the string to first character before invalid UTF-8 one
instead of replacing non ascii characters by spaces.


  Commit: 30d64214996e1ee0eaf8f0c9ad4a8df53be84aed
      https://github.com/bluez/bluez/commit/30d64214996e1ee0eaf8f0c9ad4a8=
df53be84aed
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M unit/test-eir.c

  Log Message:
  -----------
  unit/test-eir: Add name encoding tests

This ensures that device name encode with UTF-16, ISO-2022-JP or with
an incorrect character in UTF-8 string are truncated correctly.


Compare: https://github.com/bluez/bluez/compare/fe0eb95831eb%5E...30d6421=
4996e

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
