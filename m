Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63088153581
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 16:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713802129; cv=none; b=bF/f3ftNsES8TuNejswRLNrvZlLCGuzrnA1wQo0MXlQxC1gnagWoKcU3p389LNdz93U3lDBxNVaodLkA4/WZph3pyhWeyfLjB5BomBpAF/l6djiVFpTPVqaAcQsZeIK7LLbuuF4i85KJHK/awY4nvbG6S54O798gcv9GwMUJpMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713802129; c=relaxed/simple;
	bh=RbUmtsYcKmkvPUSSoeliihF+jnTJ1vzYiDd5LPDwaCw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=EzuoriLcpEZzglGW2h04I7f9GNvgESSg+4ikkqeItMtnR9wm76gy18D5qOTghlXGFR20Xzx3ZBgzAo97aQhOdPMRgGo0kpl8+B6xtfE/XxqL1atXflKzNN0YWxhIevZG7TgCY9woTz1EenL/nGMNGNUI/fvl3jEL33DCq/rvRqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=OcNen4Lo; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="OcNen4Lo"
Received: from github.com (hubbernetes-node-076a6b1.va3-iad.github.net [10.48.13.36])
	by smtp.github.com (Postfix) with ESMTPA id 6BC928C06B7
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 09:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1713802127;
	bh=PGbdZN/hbVXo6NuU3BKhQ5ahz/NQLwzXyixMP14/ku0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=OcNen4LoPl/VEKOk7nVGoT/yyEM+QObhL7U+1GhORPFMkk7WABH2ixI8F/pIBHsOm
	 0wRz3roOPYF81BIxoZE9zwfLji1Ukuby5XuKoLMuZUW5ak1CmSaHZlRV4f4q4LaFCc
	 UBtN62uShgSn3tW/zLz6uWuf2uN4sX9J7EUbNIWM=
Date: Mon, 22 Apr 2024 09:08:47 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/4dea3f-041535@github.com>
Subject: [bluez/bluez] a08ec1: gatt-database: Fix sending notification to all
 dev...
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

  Branch: refs/heads/master
  Home:   https://github.com/bluez/bluez
  Commit: a08ec1a4e93b7805cdda33600d83d946969acb47
      https://github.com/bluez/bluez/commit/a08ec1a4e93b7805cdda33600d83d946969acb47
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-19 (Fri, 19 Apr 2024)

  Changed paths:
    M src/gatt-database.c

  Log Message:
  -----------
  gatt-database: Fix sending notification to all devices

If notifications where setup with GATT application that implements
AcquireNotify the code will attempt to setup a dedicate fd/io for each
device so when receiving a notification over the fd/io it is only meant
to be send to the device only.

Fixes: https://github.com/bluez/bluez/issues/820


  Commit: 92c1c1c366119c344e60f5025503c8ee97927c65
      https://github.com/bluez/bluez/commit/92c1c1c366119c344e60f5025503c8ee97927c65
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-19 (Fri, 19 Apr 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix calculation of number of packet

The calculation shall attempt to round to number of packets to the
closest integer otherwise it can result in 0 packets to be sent at each
latency.


  Commit: 04153538aaf4904403ac1d0cade674d9ca0a7f4d
      https://github.com/bluez/bluez/commit/04153538aaf4904403ac1d0cade674d9ca0a7f4d
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2024-04-19 (Fri, 19 Apr 2024)

  Changed paths:
    M client/player.c

  Log Message:
  -----------
  client/player: Fix using unicast QoS for broadcast

The code needs to identify first if the parameters refers to a broadcast
stream or unicast.


Compare: https://github.com/bluez/bluez/compare/4dea3fb932f8...04153538aaf4

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
