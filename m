Received: from out-18.smtp.github.com (out-18.smtp.github.com [192.30.252.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716E529B76F
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 13:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751896616; cv=none; b=b95Y3fmK9e4wHJhd+zOxCpn68BX6ayiaT73PU1Pmdc1Gl9ClxB2kETqlu4ZPHJPXfTdqf4rNM2OvCSTsRM4/qWseDYVTTT70KIr1rR+hQiogby+0BBIVB7/s3iJ+dgl7JlTvHD9OvXSa2jrwkbVZOs4D4k5L6VA6pHTmQTPD/nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751896616; c=relaxed/simple;
	bh=2P+3nWwnFw8brTsQcndBStdyvHa2VH/xepvoju8X+wo=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=gFvbEuncEmJtgzOt0qbEW3ZnRwHtQY4B3jQfPYGD48z/ZcgqUzBdQHp2HD3NfeRP1zgc6+85Jq2OihiYOmjfHA73xB5v+iKSYrrNnBMws+SMDOrcrOqIqB+UU7N6X2L4V4uW3ecnFoCa9vp7UtgxKGSszfBn0+1X/+02O5p2bGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ECkjcA6E; arc=none smtp.client-ip=192.30.252.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ECkjcA6E"
Received: from github.com (hubbernetes-node-b2574e3.va3-iad.github.net [10.48.220.15])
	by smtp.github.com (Postfix) with ESMTPA id 955CBE1081
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Jul 2025 06:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1751896614;
	bh=5zLh/e6A+PUSyfzvZSE4zPl1XmlKqnvbWVXpxlhUgU0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ECkjcA6EhAB60qrvYwA3KzmFODB2o+HCtmxF5SX3JklLz/J5YFoiSHOG8ZOs/YTnr
	 ICOXdHGniHmaX5MvxEybCk59nQJr4UerNfb7Lpfus9ZiNMnTQuKj1U9o4iDRlkaPfc
	 h8lPyZUldOQz102tjy0POwpEr4HwyxEzT/k0Cz74=
Date: Mon, 07 Jul 2025 06:56:54 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/979696/000000-3e4758@github.com>
Subject: [bluez/bluez] 3e4758: audio/avrcp: Fix crash with invalid UTF-8 item
 name
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

  Branch: refs/heads/979696
  Home:   https://github.com/bluez/bluez
  Commit: 3e47583cfde84035d0464acc965889cb085f06e5
      https://github.com/bluez/bluez/commit/3e47583cfde84035d0464acc96588=
9cb085f06e5
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-07-07 (Mon, 07 Jul 2025)

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



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
