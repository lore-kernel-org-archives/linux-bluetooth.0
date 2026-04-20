Received: from out-40.smtp.github.com (out-40.smtp.github.com [192.30.252.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D7B3750BE
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776703625; cv=none; b=OQYCDOJXaSwFBUrZeYbyG5bD+eYm5xtZdqAbg2c4YSIl6wp1P/s4UJ270DSYwiWlv9h4sLY5olQBmyIhTixATZJ1MEMRY1mlU3ZrAV+FKvc4QTubXJA8MVXAm55BuhAtHVamsEoCrpgTFYekwm8MnKogu0hU+ZJ9OGE17gzD0bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776703625; c=relaxed/simple;
	bh=JBWWsH+klT5vd4pS2RQYarxGoBPEF9oX1D/IaEPq17M=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Uu1C1qhDLzEWdDNXK3SmZNNeMuHs1wi6YYN3oQiej3Uum8m71A+7kupTjtBj2OnomjAE/uVnCAx/x0t0FTaXJ35Jjjby9bxpPS4Tcbz0jj+SELvJNPSEqgvz8AyI6jfaU0I8LO+pDd+tGhIo996pWDM9RkQ+mIMxvh1h8R/Q8y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=BW3hsWZf; arc=none smtp.client-ip=192.30.252.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="BW3hsWZf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776703623;
	bh=mZHzg4j7PJS3AGM4myCe4pRvG++TNcYSnPCPvcjs9HQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=BW3hsWZfvlvqecyLa4Uhxh3mmfc5ICo6pmW0TLHXKdLszvCoWK5XdysJwy4DfE3nQ
	 VCTcKytWjmlb6eCnmkDtQ3/GYalbwPYa48PcNe8Z6qEFOrt1bBziVB5aU4Xh3KyxJH
	 WbvhNIxvl8fdy2pRAA+goE6H7S62DVVDJqgIZq1w=
Received: from github.com (hubbernetes-node-be8e60f.ash1-iad.github.net [10.56.226.33])
	by smtp.github.com (Postfix) with ESMTPA id 255059210D0
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Apr 2026 09:47:03 -0700 (PDT)
Date: Mon, 20 Apr 2026 09:47:03 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1083418/000000-2a5c70@github.com>
Subject: [bluez/bluez] bcfaf5: audio: Add ability to force CIS transport Links
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

  Branch: refs/heads/1083418
  Home:   https://github.com/bluez/bluez
  Commit: bcfaf58269f745f22fd00dff381e5b243e816e2d
      https://github.com/bluez/bluez/commit/bcfaf58269f745f22fd00dff381e5=
b243e816e2d
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-20 (Mon, 20 Apr 2026)

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


  Commit: b4d9604598d75c3636f378b814cea745d47be818
      https://github.com/bluez/bluez/commit/b4d9604598d75c3636f378b814cea=
745d47be818
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-20 (Mon, 20 Apr 2026)

  Changed paths:
    M doc/org.bluez.MediaTransport.rst

  Log Message:
  -----------
  doc: Add documentation for readwrite CIS transport Links property

This is only supported when bluetoothd is started in testing mode.


  Commit: 2a5c70a0a783d8b745187ce3bd9a0e7006cffd06
      https://github.com/bluez/bluez/commit/2a5c70a0a783d8b745187ce3bd9a0=
e7006cffd06
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-04-20 (Mon, 20 Apr 2026)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Add support to unlink transports

This is used to pass PTS tests BAP/UCL/STR/BV-543-C and BV-546-C.


Compare: https://github.com/bluez/bluez/compare/bcfaf58269f7%5E...2a5c70a=
0a783

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
