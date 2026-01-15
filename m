Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A530CD89
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 14:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768488659; cv=none; b=mAyEOxsq/iMaJrwWg/AZHUpQUY00xjq7rA99EzBoiN+7PW2Nr/TTHiaHq3Qx5eufVBw+ZBnjhw5Jn70gXLDVf4ZZr7TUhncVrQrMOhXlPogz8aD8tVXHOoc9Iqyy/a5mWiPzltkVgQ4Sjnq2MCF7ySoL8XLpCc/gIhQ/Q0e8PaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768488659; c=relaxed/simple;
	bh=xv0GZ+ZNxsZqAzqEbqKRLr70X1DfQFTH8y2ynx1qoCg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Sah63BJIRJsuGSeYFkIHmM2otlUkxvPcAtpOoDyOSohmlgyFk254unToFhq+R7iVJ11xNjjIv4NiskiVoqkOjiNypL4ln0FpgqSyc6eOHYx1CPmrZJNsv4I6IRHfc//EjeFpE3K5moTfK1kaFyv/G090ThAnETRkuv4DHxe+cq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=JR99jpqg; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="JR99jpqg"
Received: from github.com (hubbernetes-node-3cf1f51.va3-iad.github.net [10.48.131.37])
	by smtp.github.com (Postfix) with ESMTPA id A3AE94E0887
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Jan 2026 06:50:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768488657;
	bh=kSp4d5me+EdnEGE61TVkgFZfs1qMdc+50CagsvI7yek=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=JR99jpqgpesYTJ51T2qataSqtUJmk7+DPOA8Es7BvsjtgSU1rlNl7pCkV4aTmc9u5
	 4TQGQMKJq3o24ZL0T0tlCdt2ZoHLrZSafEPsgm504P6F5urBBBWAEjAAWNiE4QnhAk
	 onn21tYcA+CGGcSNr60TplTCu98MXiB1Uz6d7Tmw=
Date: Thu, 15 Jan 2026 06:50:57 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1042851/000000-fe88b4@github.com>
Subject: [bluez/bluez] fe88b4: tools/btpclient: Fix discovery filter setup
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

  Branch: refs/heads/1042851
  Home:   https://github.com/bluez/bluez
  Commit: fe88b43c39d1a4c2abb2cd73c4d8f32e3311f0ec
      https://github.com/bluez/bluez/commit/fe88b43c39d1a4c2abb2cd73c4d8f=
32e3311f0ec
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



To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
