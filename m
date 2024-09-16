Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB35A95E
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 18:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726510262; cv=none; b=qAeuZAeD0CjSFyLBsLgUDgcDiCigR/4G0qPwztrk8BAJ+fEhOUYawaYaH9iJtCFBdS15ne5P/7yk7ef6OO5zRHLlUMt6nG3QK3IeyJRq1BT6e7E/2/5FTCvCZN51uE/VGyMltmpuzvSt8dBRpHm0wsEiHAGIVVSa6g4Oet7NH+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726510262; c=relaxed/simple;
	bh=lumAFsnaUCeXppKXqBW/yg+6NgrKXdgel51r28SFLC8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cHhbLexzS33W0bgjFbVLtq0Sv16Ez3VVcG61azKxKRSqlH0lDGv/CDycIi6cWFSWrJxeXJRuHqRTzpQ9vY8FIcjTBiG92Em4+xQoJrWhGLrInKCz+JhGXJwyXzF8IuINf7ghGZwNcdoWgIbXAQKXqYXswLuLgWgdErUlJE+bcZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QDOhBtQi; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QDOhBtQi"
Received: from github.com (hubbernetes-node-250b9ac.ac4-iad.github.net [10.52.148.33])
	by smtp.github.com (Postfix) with ESMTPA id B50E1640DD6
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 11:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1726510259;
	bh=UMUg70O88WaWznCi2Le+R4oup9VdH7hrk833VjHJcWk=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QDOhBtQiPlXlU+/FrdKmV1JCLG/qsoDACgr15hQQ+mp8SPJr7t8FtPSc4GyQuUpXL
	 2RMMQwHhykXWSWP6KlV+Lksk5kKB1nH6fbifeutf29NNyqKc/QWp8GE4mfk+1qUNju
	 2dhOtK3Rgyrk163g7E7rY25oiQMQGvnY/zX08sc4=
Date: Mon, 16 Sep 2024 11:10:59 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/41f943-8562d0@github.com>
Subject: [bluez/bluez] 5d7d3a: obexd: Add PSM support to session create
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
  Commit: 5d7d3ac25bd56684f4f8c7378b3ec2db0b0ce1ae
      https://github.com/bluez/bluez/commit/5d7d3ac25bd56684f4f8c7378b3ec=
2db0b0ce1ae
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-09-16 (Mon, 16 Sep 2024)

  Changed paths:
    M doc/org.bluez.obex.Client.rst
    M doc/org.bluez.obex.Session.rst
    M obexd/client/manager.c
    M obexd/client/session.c
    M obexd/client/session.h

  Log Message:
  -----------
  obexd: Add PSM support to session create

An OBEX session can be connected to a RFCOMM channel or a L2CAP PSM.


  Commit: 4c05a0ff41c88f293ab0bd8b19c371865a2ea959
      https://github.com/bluez/bluez/commit/4c05a0ff41c88f293ab0bd8b19c37=
1865a2ea959
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-09-16 (Mon, 16 Sep 2024)

  Changed paths:
    M doc/org.bluez.MediaPlayer.rst
    M profiles/audio/avrcp.c
    M profiles/audio/player.c
    M profiles/audio/player.h

  Log Message:
  -----------
  player: Add OBEX PSM port for cover art support

This parse the AVRCP Target SDP record for the L2CAP PSM to use with
the OBEX session to get the cover art.


  Commit: 5cd301e888a1093322de9b6a207f3450e99df852
      https://github.com/bluez/bluez/commit/5cd301e888a1093322de9b6a207f3=
450e99df852
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-09-16 (Mon, 16 Sep 2024)

  Changed paths:
    M doc/org.bluez.MediaPlayer.rst
    M monitor/avctp.c
    M profiles/audio/avrcp.c
    M profiles/audio/avrcp.h
    M tools/parser/avrcp.c

  Log Message:
  -----------
  player: Add image handle support property

This is part of the metadata when the AVRCP target supports covert
art download and a OBEX BIP session is connected.
The image handle references the cover art associated to the track,
and is valid only during OBEX BIP session.


  Commit: 8562d0e3874ef8801d1f69d3c024611da33f9220
      https://github.com/bluez/bluez/commit/8562d0e3874ef8801d1f69d3c0246=
11da33f9220
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2024-09-16 (Mon, 16 Sep 2024)

  Changed paths:
    M obexd/client/transfer.c
    M obexd/client/transfer.h

  Log Message:
  -----------
  obexd: Add support for specific headers in obex transfer

The BIP is using the Image Handle Tag header to set the file handle
to transfer.


Compare: https://github.com/bluez/bluez/compare/41f943630d9a...8562d0e387=
4e

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
