Received: from out-42.smtp.github.com (out-42.smtp.github.com [192.30.252.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041BE3876D0
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 10:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776941973; cv=none; b=KbIn4ZlEnaaPP2IyUMjBcLqy7/zoPS7CLW2dOag53HqpA+SoWIXoolCto2KxKVeBHFC0xBNe5iUciClovRhYZV692Qbyp1Tt5RtJAFOqjg8bNVdbl8WZpu9SdudfPwA8y9klwCbUQAFX9oHaizX9UtLJNQ4aOaLgUM08LSm1ZXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776941973; c=relaxed/simple;
	bh=qqjpg/cEVBcGwIqDLsPy9dHwcDjIVh6vwHIwyvTbjoA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cBL1QLY9CIBCpVLy7mqQ4qUc5vvPrmahDLYi0I9K881s1iaknnHlijLa/pOsUzKRCrapjsThgrPswhB88tyx9Fr6ENpwjqWkAHwO8Lf9ZaytPGRorulbxn9rVLQZedQ2kMz6pNqAsuv3V8CiPkO2C/M0ygyZviBaycOnSUHwRhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MQxucFJt; arc=none smtp.client-ip=192.30.252.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MQxucFJt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776941971;
	bh=oxFzb58zGOf7JSf68ZhzkcJrg6vkt2saAhcu54k7JzA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MQxucFJt5BNcfGCriTGrXd8tLAswlrmJ8JOwAxIeIrtFGtx5gZ6DZVq/yngpWjBLJ
	 swhUCp2iq1LM4G5Gt7NLOy2rlkL714wSI4A50Jhc2YtnpnlwhH0vJgfFAsyiI86OZd
	 zrNwaVvzbsy3K+DtIs0sVKspdLyoOzS18sh8sQDY=
Received: from github.com (hubbernetes-node-137be09.ash1-iad.github.net [10.56.208.33])
	by smtp.github.com (Postfix) with ESMTPA id 4FDD4841141
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 03:59:31 -0700 (PDT)
Date: Thu, 23 Apr 2026 03:59:31 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1084652/000000-ed9b9a@github.com>
Subject: [bluez/bluez] 5d9d39: audio: Add ability to force CIS transport Links
 pr...
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

  Branch: refs/heads/1084652
  Home:   https://github.com/bluez/bluez
  Commit: 5d9d394b23b77074a7426dc86dc2738f0ac4a970
      https://github.com/bluez/bluez/commit/5d9d394b23b77074a7426dc86dc27=
38f0ac4a970
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-23 (Thu, 23 Apr 2026)

  Changed paths:
    M profiles/audio/bap.c
    M profiles/audio/transport.c

  Log Message:
  -----------
  audio: Add ability to force CIS transport Links property

If bluetoothd is started in testing mode the Links property for CIS
is readwrite and can be used to force transport objects Links.
This can used to unlink transport objects by sending an empty array.

For unlinked transport objects, each transports needs to be acquired
separately.

This allows to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.


  Commit: 5bb06b0f3ae0ede93d527685cfe02f35027a5b10
      https://github.com/bluez/bluez/commit/5bb06b0f3ae0ede93d527685cfe02=
f35027a5b10
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-23 (Thu, 23 Apr 2026)

  Changed paths:
    M doc/org.bluez.MediaTransport.rst

  Log Message:
  -----------
  doc: Add documentation for readwrite CIS transport Links property

This is only supported when bluetoothd is started in testing mode.


  Commit: ed9b9a29eb03f91729ea5af221598fe257017d64
      https://github.com/bluez/bluez/commit/ed9b9a29eb03f91729ea5af221598=
fe257017d64
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-23 (Thu, 23 Apr 2026)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add support to unlink transports

This is used to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.


Compare: https://github.com/bluez/bluez/compare/5d9d394b23b7%5E...ed9b9a2=
9eb03

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
