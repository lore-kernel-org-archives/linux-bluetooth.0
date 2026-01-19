Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59C637F0E8
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832909; cv=none; b=qrVvAayr4W1gjTCpRajTCVs8ZMkEPVHODvgYfz35naqb2N+b2Cm6YcYMRdGYlIljVRM450PiS+Y6BU/MBTgrpSCMzNx0RqdPniVAKOUPby1GbIiB5sNXsnerXtEdTX/HlXsZKeHsrTLsOSwIOo2laKsyPf4u/RxvZWKBAzBD9Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832909; c=relaxed/simple;
	bh=bMvVQNuvYBW3z81Z685E5e2sOpEQbJ6ngBaeWGUpd6w=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=l48b2ZZqKGOv98zA/idv6Ww6WrPQ9ig+JH73DB3x6SwO5aXwhqEcvjXxylMcTnLQ5X9qLQtvcPmiJnuUq4/x8OqvnROR6PPQg0tT/24Ivop3rxvrWkK+J4OkR76JUqofdO2By5Q1e5SPQMnW9UIda+ehH2YU+1XzT/yTSNaPvNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=YvvYkcWo; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="YvvYkcWo"
Received: from github.com (hubbernetes-node-e38ed37.ash1-iad.github.net [10.56.188.35])
	by smtp.github.com (Postfix) with ESMTPA id 262A81402FF
	for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jan 2026 06:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1768832907;
	bh=uDIdNd42lMVc9l+51Bl/ha0eXi4x6YgWKJKNLN7Upl4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=YvvYkcWovMVpnV41vac0ClK50JPt7tiV/hTqtUpBTt7mAHdSvGTsX858uWS1lgaCW
	 jWlON4Sk1O753q5h+5/konhipkWBQVRMyD8nCc9318wOBqrxqZAA+Y6CEX5lS7DVrV
	 XyxB2TYnQCcPHNhI57c9K7E8mf3MjLv9Vp7/kqNU=
Date: Mon, 19 Jan 2026 06:28:27 -0800
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1044175/000000-8d6e78@github.com>
Subject: [bluez/bluez] 61e360: src: Turn available priority macros into an
 enum
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

  Branch: refs/heads/1044175
  Home:   https://github.com/bluez/bluez
  Commit: 61e3601d244cb6dcf3d25656175073d293416bd4
      https://github.com/bluez/bluez/commit/61e3601d244cb6dcf3d25656175073d293416bd4
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-19 (Mon, 19 Jan 2026)

  Changed paths:
    M src/plugin.h

  Log Message:
  -----------
  src: Turn available priority macros into an enum

This will allow generated bindings to know to use the same type
independent of individual values.


  Commit: a417c7177892ae6d9882355e729fe2206a5feaf7
      https://github.com/bluez/bluez/commit/a417c7177892ae6d9882355e729fe2206a5feaf7
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-19 (Mon, 19 Jan 2026)

  Changed paths:
    M plugins/hostname.c
    M src/adapter.c
    M src/adapter.h

  Log Message:
  -----------
  src: Prefix plugin-accessible adapter_set_name() function

Plugin-accessible functions are usually prefixed with btd_ to avoid
confusing them with internal private functions. Rename
adapter_set_name() to match the existing btd_adapter_set_class().


  Commit: 352b69ef9b7d2a681510935ae849c76eaec7b733
      https://github.com/bluez/bluez/commit/352b69ef9b7d2a681510935ae849c76eaec7b733
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-19 (Mon, 19 Jan 2026)

  Changed paths:
    M src/adapter.c
    M src/adapter.h

  Log Message:
  -----------
  adapter: Fix const'ness of struct btd_adapter_driver

When registering or deregistering an adapter driver, the struct that
holds the function pointers to the various callbacks doesn't need to be
modified, so make it const.


  Commit: 8d6e78f31b13d513aacb33f129c6382802d8682f
      https://github.com/bluez/bluez/commit/8d6e78f31b13d513aacb33f129c6382802d8682f
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-01-19 (Mon, 19 Jan 2026)

  Changed paths:
    M plugins/hostname.c
    M src/adapter.c
    M src/adapter.h
    M src/agent.c
    M src/gatt-database.c
    M src/profile.c

  Log Message:
  -----------
  src: Prefix plugin-accessible adapter_foreach() function


Compare: https://github.com/bluez/bluez/compare/61e3601d244c%5E...8d6e78f31b13

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
