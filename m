Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB517DE36
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513139; cv=none; b=eL6z5/aCzVPwRjHMKSbKuxDE8UEURS1C6D0oarAWaJYpzzFkI5KUXgE+X7n5XKnIF057KZ8poD1DWjJ6Nrq08gDVGow7fucZLiZOGeuz4RElubDiwvya8bLs/w/HyFR48nXv1nBG+Hcs4oIfBqFr7KASkgr1t5aiPHoZj1/UCjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513139; c=relaxed/simple;
	bh=+GXZs6YOkbeWKrTJguIad/VsgqH7k/TWW0iNo3SeP9Y=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fIcJCfiO2rB97FCYB51TbalwIE0fw8NAA605DXTcKPqIGs4zhVdWcJiGgtbo0ljIxQI9Qr2VlqmcQqhPa2DzsK52vZFVXR0dbm7WOds3Ba0RosNhUGjUgnYKN4vrHRCwfq4KF10o7QpkD0whA/xwubMzjZ/a6di30LF/NTIJ1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=hFLy0bs+; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="hFLy0bs+"
Received: from github.com (hubbernetes-node-602e586.va3-iad.github.net [10.48.169.41])
	by smtp.github.com (Postfix) with ESMTPA id 6B1D14E081D
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 13:38:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768513137;
	bh=2E/wOauaC3dqufR6VvYViNMybilAvtGweRUGoiermz4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=hFLy0bs+c1OupxMAvkveTFQ+cnr+4/u+e4+EcpkRe7IIak6dTSyaFOAHlndGEiCTa
	 ca7Liw8m+p0CLz6jYUmIbdCiQ8GuqWZpMAS0sdu3zJ3HnyAB0NKwvO3e+mOH9rUoaz
	 yx0JWNdin+vd6ygVLfEwPvK9T/Cu/gRtQ1oFN28M=
Date: Thu, 15 Jan 2026 13:38:57 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4ce4b5-fe7094@github.com>
Subject: [bluez/bluez] 22eca4: shared/hfp: Add function to get multiparty call
 st...
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
  Commit: 22eca40e5ceba70105d2b551c4ec79503b727cad
      https://github.com/bluez/bluez/commit/22eca40e5ceba70105d2b551c4ec7=
9503b727cad
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-15 (Thu, 15 Jan 2026)

  Changed paths:
    M src/shared/hfp.c
    M src/shared/hfp.h

  Log Message:
  -----------
  shared/hfp: Add function to get multiparty call status


  Commit: 5e50b9353ff78418fe7ff8893d519b865fabdf50
      https://github.com/bluez/bluez/commit/5e50b9353ff78418fe7ff8893d519=
b865fabdf50
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-15 (Thu, 15 Jan 2026)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Update multiparty status on call creation


  Commit: 8d2f98ff2d5ca5c7df57ff2c4f5abe98f0a1ca38
      https://github.com/bluez/bluez/commit/8d2f98ff2d5ca5c7df57ff2c4f5ab=
e98f0a1ca38
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-15 (Thu, 15 Jan 2026)

  Changed paths:
    M tools/btpclient.c

  Log Message:
  -----------
  tools/btpclient: Fix discovery filter setup

Fix transport mode test to use 'auto' only when both BREDR and LE are
set.

Add an empty filter to discover all devices.

This allows to pass GAP/BROB/OBSV/BV-01-C and GAP/BROB/OBSV/BV-02-C
tests with auto-pts.


  Commit: 64208980a3744337206736a60add40b3dda072df
      https://github.com/bluez/bluez/commit/64208980a3744337206736a60add4=
0b3dda072df
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-15 (Thu, 15 Jan 2026)

  Changed paths:
    M src/shared/btp.h
    M tools/btpclient.c
    M tools/btpclientctl.c

  Log Message:
  -----------
  shared/btp: Fix typo


  Commit: fe7094da808198b560c6c7b8ca5bd9b01deb373a
      https://github.com/bluez/bluez/commit/fe7094da808198b560c6c7b8ca5bd=
9b01deb373a
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-15 (Thu, 15 Jan 2026)

  Changed paths:
    M tools/btpclient.c

  Log Message:
  -----------
  tools/btpclient: Fix name advertising

This allows to pass GAP/BROB/BCST/BV-03-C and GAP/BROB/OBSV/BV-06-C
tests with auto-pts.

Those tests request privacy to be on to share IRK.


Compare: https://github.com/bluez/bluez/compare/4ce4b5d679ab...fe7094da80=
81

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
