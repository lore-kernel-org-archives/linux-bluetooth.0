Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481A21DF74F
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992792; cv=none; b=YX7r9mfjvrp3KaCNysj4j6/Dic9z1eM5p+FI2E/BRGIbCbnZm2VBf/uU25vDJP1CDwATFPl2Rqz+iRgMY3c+dYVFkk7mByQHOT+HjPEOrS4eNUDVScPg9QGLiUGdULDsY9lJYurm+fGdXaIWhYGpNz7ZJd5qcL62LOPm3il1Q7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992792; c=relaxed/simple;
	bh=N31ykquXTIpVS0vwJwemQSNCmNdYSLLH5aoaFv37ldw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=OrKK+rSjX2skyTNl5JKA/ekzcZxduoNUIoZwvN6X3qw1PoZWZFVFofB0GQ8c0cg+1URAtGpCT/gg9T3gWf9xbThExLpgkehRrWFqc1y8WV5Qu4ZUnuKr56yUQArGG7/dsNUFrL6Xm8RtvTbYSL0539xjdL0S7RS4/47ffHG4zxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IZM0F99a; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IZM0F99a"
Received: from github.com (hubbernetes-node-732c825.ash1-iad.github.net [10.56.182.37])
	by smtp.github.com (Postfix) with ESMTPA id 646269212B8
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 09:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751992790;
	bh=rwKGivB67L5HYWiDsgnOYiqCrMqZvOXfI2bJGRZ6kpY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IZM0F99aUwrq58V5UTTCSKB7XfPhz+3sE/DwC/EgSqZ8ay5MnwVEaRb5SnA8yXYQP
	 2BasQzN7j/8Rfsqk6tBuRL+awRwcb95liOIrnABsXtrD8+F4JLmlQSGHKyEXrV99Np
	 D3LnYJA1yG/gZ4dfAE0EQph5qf6tUF1i1wXWG9A8=
Date: Tue, 08 Jul 2025 09:39:50 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/a7e074-004518@github.com>
Subject: [bluez/bluez] 0440ca: shared/util: Add strtoutf8 function
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
  Commit: 0440ca68a8c4ca3a4c26500b521b362693a2e1ae
      https://github.com/bluez/bluez/commit/0440ca68a8c4ca3a4c26500b521b3=
62693a2e1ae
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


  Commit: 89079f2ca635601c1408f8318978c1bc75ca5efd
      https://github.com/bluez/bluez/commit/89079f2ca635601c1408f8318978c=
1bc75ca5efd
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


  Commit: a8f59849253d6ef0900441dd2b0930945672725b
      https://github.com/bluez/bluez/commit/a8f59849253d6ef0900441dd2b093=
0945672725b
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  audio/mcp: Use strtoutf8 for player name and track title

Truncate the string to first character before invalid UTF-8 one
instead of replacing non ascii characters by spaces.


  Commit: a0387d66372beee3940c778031e94940acf10c63
      https://github.com/bluez/bluez/commit/a0387d66372beee3940c778031e94=
940acf10c63
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M profiles/gap/gas.c

  Log Message:
  -----------
  audio/gap: Use strtoutf8 for GAP device name

Truncate the string to first character before invalid UTF-8 one
instead of replacing non ascii characters by spaces.


  Commit: 218db700f49370bc07ce1e6d609d28d846470d99
      https://github.com/bluez/bluez/commit/218db700f49370bc07ce1e6d609d2=
8d846470d99
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M src/eir.c

  Log Message:
  -----------
  eir: Use strtoutf8 for device names

Truncate the string to first character before invalid UTF-8 one
instead of replacing non ascii characters by spaces.


  Commit: 4cedd8d19ad5e416ca9f537d5129e548709287bc
      https://github.com/bluez/bluez/commit/4cedd8d19ad5e416ca9f537d5129e=
548709287bc
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M src/shared/ad.c

  Log Message:
  -----------
  shared/ad: Use strtoutf8 for name

Truncate the string to first character before invalid UTF-8 one
instead of replacing non ascii characters by spaces.


  Commit: 004518d061d4ecc1efc94a561e4050ac1928957e
      https://github.com/bluez/bluez/commit/004518d061d4ecc1efc94a561e405=
0ac1928957e
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M unit/test-eir.c

  Log Message:
  -----------
  unit/test-eir: Add name encoding tests

This ensures that device name encode with UTF-16, ISO-2022-JP or with
an incorrect character in UTF-8 string are truncated correctly.


Compare: https://github.com/bluez/bluez/compare/a7e0747e21de...004518d061=
d4

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
