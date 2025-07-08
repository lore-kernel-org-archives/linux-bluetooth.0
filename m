Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CE3E55B
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 07:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959246; cv=none; b=FTYGKYJIk6t39K6IhIq4aXAijUcpxmp7i/Pg8ctSVVWBeWC5fqE02aBUsfRTkgjDA6wppFIGE5jPcBjqRiqiO2YtJIoRw7Qof236uZ50HltseL+Gt7UFpo8h06ARq+JOo1ZdtuxbLFUHLj8Vl5wrcAgizmvRPz48b5q5DZATCMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959246; c=relaxed/simple;
	bh=/fvEFy9ewa1NU2sevT1dqljB96K9oLhfqCBtu1o4qrA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Kkk0t38KRi5JZOClIiO0sEgyBfbZc0A0dDL70/9p0bVYiE1cga1vILrtmGLZxmijZ2koRjCcVw+CqI6SUOR07cMrNqJ/yMlIzHvbNMrxsOdtN9lVX5Wu3iwvWmCJmCzKHs8OFJGauwDWHz/ujUbN7w0jga9v9ZALszsLD9aQVsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ld6udfmS; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ld6udfmS"
Received: from github.com (hubbernetes-node-bebdce1.ash1-iad.github.net [10.56.159.38])
	by smtp.github.com (Postfix) with ESMTPA id C6BB9140165
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Jul 2025 00:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751959242;
	bh=BdPFlTrmrUXeuF955RaxiqWVtQjLRBVUZ+8OFMxLQDI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ld6udfmSYN1WvdhSx5PgfmLqpvjPHyRhD3LIiLpxO3khIWYS8mj+jGxEDvR6KxW7V
	 YtKzEjEf1BadPqukzj63LSYcaV3Yrc01sXZTeqrOEo1AW4jAtFgxedQnEBLQD/sgO6
	 yoYrsm3kSuMbBiXVMTjegKtjY0/kDJWhyS1TDYHw=
Date: Tue, 08 Jul 2025 00:20:42 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979916/000000-1c2af2@github.com>
Subject: [bluez/bluez] 0590d6: shared/util: Add strtoutf8 function
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

  Branch: refs/heads/979916
  Home:   https://github.com/bluez/bluez
  Commit: 0590d61013a5481bcf93876359e8e7df522ea0e9
      https://github.com/bluez/bluez/commit/0590d61013a5481bcf93876359e8e=
7df522ea0e9
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


  Commit: 8074c549df269742300841982c005c070ccc42ba
      https://github.com/bluez/bluez/commit/8074c549df269742300841982c005=
c070ccc42ba
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


  Commit: 262d974e1774ca31870186e48800c3b76134828f
      https://github.com/bluez/bluez/commit/262d974e1774ca31870186e48800c=
3b76134828f
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M profiles/audio/mcp.c

  Log Message:
  -----------
  audio/mcp: Use strtoutf8 for player name and track title

Truncate the string to first character before invalid UTF-8 one
instead of replacing non ascii characters by spaces.


  Commit: 0233c9bb284bdc2e8dd93e21df0b612a1baa894a
      https://github.com/bluez/bluez/commit/0233c9bb284bdc2e8dd93e21df0b6=
12a1baa894a
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M profiles/gap/gas.c

  Log Message:
  -----------
  audio/gap: Use strtoutf8 for GAP device name

Truncate the string to first character before invalid UTF-8 one
instead of replacing non ascii characters by spaces.


  Commit: 1c2af2b9c6da05f52d36663ec0aa314a96bb24e1
      https://github.com/bluez/bluez/commit/1c2af2b9c6da05f52d36663ec0aa3=
14a96bb24e1
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-08 (Tue, 08 Jul 2025)

  Changed paths:
    M src/eir.c

  Log Message:
  -----------
  eir: Use strtoutf8 for device names

Truncate the string to first character before invalid UTF-8 one
instead of replacing non ascii characters by spaces.


Compare: https://github.com/bluez/bluez/compare/0590d61013a5%5E...1c2af2b=
9c6da

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
