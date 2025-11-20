Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874C133F8A4
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647193; cv=none; b=VE4hcsJPpoYhpBmj2dCDr5u0aWPmg17BgLDTZFDTy3F49tY0UsJ0MRB78VTzvw2Bfr8kBG4SwHZiKBdk09Dzh3hXsNqyy0EBK15AjmxPCWYyL6R2BNX8HFr1f/aInuVT7tzwF34tnMNr5qm8Kpo+9O+E7OZc8EJcv6sFioAIIgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647193; c=relaxed/simple;
	bh=ZGs7kvwZF1JHAGkEdqn8Ma5BUM/UXF8q97PEFxnVz3I=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JgLRI+horQ3Zxs2rHiZUUu32YAEAEAEIoedwtIZ+mrCErnLuip240WrawmYBmSshxKtwPqJ2MsDu50eXrIJdqWTmFgeGRsB9Dj1xVNkrpGLiJfsfep9tEb7cHY1CwbypfHVjqv9Lhcon1WzCG3KL601fi9iYUJj8lYm+A7dqowM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OrXDaoKj; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OrXDaoKj"
Received: from github.com (hubbernetes-node-651ff6f.ac4-iad.github.net [10.52.182.36])
	by smtp.github.com (Postfix) with ESMTPA id A4671640BC9
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Nov 2025 05:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763647191;
	bh=GdxWatdh/c0uHWMHOPo21kO6sxUy7RrNMYMih2PzOcc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OrXDaoKjqSdyublX9XtU+TH310kHU8bsg+B5SotfYav63H9vluAHxVbeLNGKZp+r0
	 emxdeRHQe68jY55emgIvBp3V92uA7xJeB+QlPkCWRV+bDhPCo92YNMLCzOEr83D3n9
	 EgB6UihaGPquy+ZgTz5Tpix7E47agyEBiE/p5ILo=
Date: Thu, 20 Nov 2025 05:59:51 -0800
From: fdanis-oss <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1025836/000000-a3bf8e@github.com>
Subject: [bluez/bluez] 288c5f: doc: Add new telephony related profiles
 interfaces
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

  Branch: refs/heads/1025836
  Home:   https://github.com/bluez/bluez
  Commit: 288c5fed2183547596bc88c06d6b7190e1fd0397
      https://github.com/bluez/bluez/commit/288c5fed2183547596bc88c06d6b7=
190e1fd0397
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-20 (Thu, 20 Nov 2025)

  Changed paths:
    M Makefile.am
    A doc/org.bluez.Call.rst
    A doc/org.bluez.Telephony.rst

  Log Message:
  -----------
  doc: Add new telephony related profiles interfaces

These are interfaces are meant to be generic to the telephony related
"headset" profiles like HSP HS, HFP HF, and CCP.


  Commit: 9ad999ac10ae727b7c934706b9f2a2155951a530
      https://github.com/bluez/bluez/commit/9ad999ac10ae727b7c934706b9f2a=
2155951a530
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-20 (Thu, 20 Nov 2025)

  Changed paths:
    A profiles/audio/telephony.c
    A profiles/audio/telephony.h

  Log Message:
  -----------
  audio/telephony: Add shared interfaces implementation


  Commit: bd5fdbe7defed012f194fc0a220f099da80ad9fe
      https://github.com/bluez/bluez/commit/bd5fdbe7defed012f194fc0a220f0=
99da80ad9fe
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-20 (Thu, 20 Nov 2025)

  Changed paths:
    M Makefile.plugins
    M configure.ac
    A profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add skeleton for HFP profile


  Commit: 239d6593bb4155a7d7a774038699d71d664323d8
      https://github.com/bluez/bluez/commit/239d6593bb4155a7d7a774038699d=
71d664323d8
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-20 (Thu, 20 Nov 2025)

  Changed paths:
    M profiles/audio/hfp-hf.c

  Log Message:
  -----------
  audio/hfp-hf: Add HFP SLC connection and event support


  Commit: a3bf8ebd45e63db4b7116228d90ba79158ba9c3c
      https://github.com/bluez/bluez/commit/a3bf8ebd45e63db4b7116228d90ba=
79158ba9c3c
  Author: Fr=C3=A9d=C3=A9ric Danis <frederic.danis@collabora.com>
  Date:   2025-11-20 (Thu, 20 Nov 2025)

  Changed paths:
    M Makefile.tools
    A client/bluetoothctl-telephony.rst
    M client/main.c
    A client/telephony.c
    A client/telephony.h

  Log Message:
  -----------
  client/telephony: Add new submenu


Compare: https://github.com/bluez/bluez/compare/288c5fed2183%5E...a3bf8eb=
d45e6

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
