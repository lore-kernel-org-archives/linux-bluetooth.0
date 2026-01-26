Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C86219A8A
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 22:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769465942; cv=none; b=mg+xs0XIH4ycoboreiTvWsduF6NkdzX2RNuzQ7Ab/vPlOZ7/DxZcm3nz/eGfoF5KJCHIgLYFB1oFzElkAcyU4xD8XEB4FDmogtgppZ3QPsxSug4VrL1Ogs5zITyxwqrjS7NLSJ3xj9PFRAbEdbff5taq9otC5EuVUo63ACZP5FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769465942; c=relaxed/simple;
	bh=yJ+n/CZlpIVZvAQxJTMP433NaEnNVPKCEz3uOedn8Ik=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fW6mULL2psXj6rkHKlXTy9EwT0cp5734c1au8WYa0M6bscAVD6HKOn7K0iRCm7l3ytdePgnGQqtM9hkRFZyNj2PACWNV0WveeyE7to7Eygf5hmasGkHJH4PwqCk+aKaJ39xOHSQrlyMcBCU0qab2KOu5rkFjIla+UzCupsly5Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=IMHLuKB/; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="IMHLuKB/"
Received: from github.com (hubbernetes-node-eb39a88.ash1-iad.github.net [10.56.209.91])
	by smtp.github.com (Postfix) with ESMTPA id 15D7A1410EC
	for <linux-bluetooth@vger.kernel.org>; Mon, 26 Jan 2026 14:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1769465940;
	bh=Ta/AKBycKzkZzqY0ol2weuDnDc1M9yuZHWBdAfQg8B0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=IMHLuKB/ec46BKxSG7eSZ+q2I3Rr/BrMnRwmbkjgx/I84GeCgguMkyq3uF9gEW/aE
	 xA35q2FDE9YzyZdi0loREK0Ktal6tDrQpkATSkN3iZMzrsryf8++9u8R5/gfjINWtE
	 /OnrsTHOSwY5qdTAIL43Q5H1dBiNYD5yPjtYCMac=
Date: Mon, 26 Jan 2026 14:19:00 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/521088-687c62@github.com>
Subject: [bluez/bluez] 3f21f7: doc: Update .gitignore for new daemon man page
 loc...
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
  Commit: 3f21f7817a405c765737cc177148c31618bd0b69
      https://github.com/bluez/bluez/commit/3f21f7817a405c765737cc177148c=
31618bd0b69
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-26 (Mon, 26 Jan 2026)

  Changed paths:
    M .gitignore

  Log Message:
  -----------
  doc: Update .gitignore for new daemon man page locations

bluetoothd.rst.in and bluetooth-meshd.rst.in moved, so the generated
".rst" files moved too. Update .gitignore to match the new location.


  Commit: 76cfed12730d74ca634eb8001ef3d047af76ecb3
      https://github.com/bluez/bluez/commit/76cfed12730d74ca634eb8001ef3d=
047af76ecb3
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-26 (Mon, 26 Jan 2026)

  Changed paths:
    A doc/qualification/gap-pics.rst
    A doc/qualification/gap-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the GAP qualification


  Commit: 2c72364163e0db6b3f61ccb78a2b1b10f908c1cf
      https://github.com/bluez/bluez/commit/2c72364163e0db6b3f61ccb78a2b1=
b10f908c1cf
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-26 (Mon, 26 Jan 2026)

  Changed paths:
    A doc/qualification/gatt-pics.rst
    A doc/qualification/gatt-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the GATT qualification


  Commit: 687c62a08ee824edad4aab34c966b42ce7eb2a12
      https://github.com/bluez/bluez/commit/687c62a08ee824edad4aab34c966b=
42ce7eb2a12
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2026-01-26 (Mon, 26 Jan 2026)

  Changed paths:
    A doc/qualification/sm-pics.rst
    A doc/qualification/sm-pts.rst

  Log Message:
  -----------
  doc/qualification: Add PICS and howto for the SM qualification


Compare: https://github.com/bluez/bluez/compare/521088388bab...687c62a08e=
e8

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
