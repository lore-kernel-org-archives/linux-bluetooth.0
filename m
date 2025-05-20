Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CC527BF8E
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747759496; cv=none; b=ZAMp+OMUptfTQ5UXJIRqSrXcrZFLOYofzVkOtWonDzrenCqDPJrRuY3CGAhzoHf0QsqUYvn2iXPQLMpmGyb0GfVDwHNuSgnRgYhoKNyaWJ8fC9yKSjPERmMlyC1nmBcKTJmHunN20QCB+iVbMqibPitG6+Yb1SJf/fQYbegnkwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747759496; c=relaxed/simple;
	bh=L1xglnuPe6B4HOcbErHXsq6PPRW+5snXrXh0JtFvAmU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=fFRsVZTIv84qtUKnNtpKJN5fbq4RgLiJzaVCH8d+0KzrSoRFns9DQOPuFUUJpSTrC+K0JYOnMWqGW0JwhI4WyuXanenyox5rvB0ksCB67I21s29Hv6nxWD8sqSysRTcWnlcyhwti3N+qHMebPwFeGqegEhMkqpAZZoafRJAVTbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Pn6rCHZG; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Pn6rCHZG"
Received: from github.com (hubbernetes-node-7b179c5.va3-iad.github.net [10.48.175.30])
	by smtp.github.com (Postfix) with ESMTPA id 70C084E0AAB
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 May 2025 09:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747759494;
	bh=ESXBLiEF85Je1vYdT8rMzNlDpvtV0nbJPaldnxckCCU=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Pn6rCHZG7ZIXyqTMIaR2MFlyhFgc/z6dJfZDARY9RBiFzdRpIx85MtJactyGPxjF8
	 xANWVWJ4gSHdb6DmMzavfJUnvzPgqQ15ogTX4fmZFOhYHgKrF2/Xq9Wr6TtIg6rSo/
	 NWge94kG1YBWIKQdUYo5QOCI2uwY1bN4t0ubd/f8=
Date: Tue, 20 May 2025 09:44:54 -0700
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/964653/000000-74a9bb@github.com>
Subject: [bluez/bluez] 2f2c60: src/device: Add Disconnected signal to
 propagate d...
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

  Branch: refs/heads/964653
  Home:   https://github.com/bluez/bluez
  Commit: 2f2c60fff1ccca54fbedc540df55330e112b2078
      https://github.com/bluez/bluez/commit/2f2c60fff1ccca54fbedc540df553=
30e112b2078
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-20 (Tue, 20 May 2025)

  Changed paths:
    M src/adapter.c
    M src/device.c
    M src/device.h

  Log Message:
  -----------
  src/device: Add Disconnected signal to propagate disconnection reason

Currently a client application is informed of the disconnection by the
update of the Connected property to false.
This sends a Disconnected signal with the disconnection reason before
the property is updated.

This helps client application to know the reason for the disconnection
and to take appropriate action.


  Commit: 52e9369f2a491d7d9c49074757ba3b8df4034f99
      https://github.com/bluez/bluez/commit/52e9369f2a491d7d9c49074757ba3=
b8df4034f99
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-20 (Tue, 20 May 2025)

  Changed paths:
    M doc/org.bluez.Device.rst

  Log Message:
  -----------
  doc/device: Add Disconnected signal


  Commit: 74a9bb116b7df0446e0a48b2c5e3e4cb88024756
      https://github.com/bluez/bluez/commit/74a9bb116b7df0446e0a48b2c5e3e=
4cb88024756
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-05-20 (Tue, 20 May 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Display disconnection reason

The new org.bluez.Device1.Disconnected signal propagates the
disconnection reason.


Compare: https://github.com/bluez/bluez/compare/2f2c60fff1cc%5E...74a9bb1=
16b7d

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
