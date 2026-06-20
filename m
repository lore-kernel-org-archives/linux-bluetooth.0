Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8922F0C79
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 20:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781986152; cv=none; b=jlz8trudUhuaL0Jjk95Rt5+5k7EauDke1f0K4HH8/rkFYxp5tabisZzFukRw5+sMDLJH6lY6E9+csLKv3Bb47/CRKJlD6ARTAwHwPHjxNM69p3/Ab7G53x/mKJka7UhhddxzG266BJw/dqiA2BAcVIkSVGsbhvxlcDlxB5AgDrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781986152; c=relaxed/simple;
	bh=Clc8OBOTg3H8/GvVzdXuPouCmBZqsC+neTHnKod8h0k=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YxcrIlZYbglMFfSoEb56MYwaw1Q3UvQDep5FhiO9goIC6kGXWvit9CCCBwX7jhLfrPaGIPGe13XvlLOh3NxsJCMwX8ATMI0w+ZTj5she7dCgKv6ReIeHh0DQXX8FP/Yk1PGKzwRMuBpOclQWkI9vsk1PaScVvMUpxlwLsHoEzrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=g6wieJtc; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="g6wieJtc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1781986150;
	bh=sCj3Oi8Uo8oqxRZCEcvrVpvoX+z9mGpkI0ErKSB3Khg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=g6wieJtcMV96zM2AN9PvaNWyNNARWEVaCJXyOazcpo+S47VEvc9goPQnxNd6EHvRT
	 KsA7b1hbMLP9SW1gnMfbHYxYcmjTxlPOWWEi+LBIUz6OYsh7B5ly2/AviNr0TQDJNx
	 rYudDjfDQPsoMhugEDhRrxF/UCbAlYja7SZ27O3Q=
Received: from github.com (hubbernetes-node-722180b.ac4-iad.github.net [10.52.152.37])
	by smtp.github.com (Postfix) with ESMTPA id EDCB1A0243
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jun 2026 13:09:10 -0700 (PDT)
Date: Sat, 20 Jun 2026 13:09:10 -0700
From: Geraldo Netto <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1114243/000000-ffaded@github.com>
Subject: [bluez/bluez] cfc7fc: shared: harden btsnoop trace parsing
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 7bit
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1114243
  Home:   https://github.com/bluez/bluez
  Commit: cfc7fc7c0b3c95c9445764d5a2d21323e803c32d
      https://github.com/bluez/bluez/commit/cfc7fc7c0b3c95c9445764d5a2d21323e803c32d
  Author: Geraldo Netto <geraldonetto@gmail.com>
  Date:   2026-06-20 (Sat, 20 Jun 2026)

  Changed paths:
    M Makefile.am
    M monitor/analyze.c
    M monitor/control.c
    M src/shared/btsnoop.c
    M src/shared/btsnoop.h
    A unit/test-btsnoop.c
    A unit/test-btsnoop.h

  Log Message:
  -----------
  shared: harden btsnoop trace parsing


  Commit: ffadedbfd700d2cc08c39a6a0ffddba0184a72b0
      https://github.com/bluez/bluez/commit/ffadedbfd700d2cc08c39a6a0ffddba0184a72b0
  Author: Geraldo Netto <geraldonetto@gmail.com>
  Date:   2026-06-20 (Sat, 20 Jun 2026)

  Changed paths:
    M Makefile.am
    A unit/test-btsnoop-pklg.c
    M unit/test-btsnoop.c

  Log Message:
  -----------
  unit: split btsnoop pklg tests


Compare: https://github.com/bluez/bluez/compare/cfc7fc7c0b3c%5E...ffadedbfd700

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
