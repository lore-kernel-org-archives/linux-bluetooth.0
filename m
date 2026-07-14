Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27023353A93
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 09:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020789; cv=none; b=UppPCxAVt/aIU/QeztkMpunlUiZemx91ZwkRKQRF47UriA/7FdRLmqfudcss0wrIGNY2B5kMIHWxwDRdp+AwBVP8AwAZ5neX7XRWXAFOSYT6IJKF1nQCv6nP1YO/4iQyj2LPACKVRlL/9PlBNFdKBlkLfocyVZnZPu8JBgtIs1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020789; c=relaxed/simple;
	bh=68LJ281l0Be4TOJbqOqciRPZba/VJO3DLXV5JXCHK0g=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=kMdSR26VtQUj36kK+eUxzHfscXv9v/fFYEOHiNu3q+MJItp4ENS+FKqHfMOh/Iv7zDu5eL+RKZhGLxwz9fTTIqdTDiyslNDmugXDfgGCvtVpdFz60VbvRJi2P15NmOcHrZ+h9yhwXVRWcOuwgqrGypV9Y2ePcwWOSR4sIaNmRA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=miGoSw3A; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="miGoSw3A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784020787;
	bh=X3NqNT+r4euQYbFOkotFkhkhdpUOa4KqbcUvM2pByCQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=miGoSw3AePkPu3gtXz359hpx3VV13uM9uqJy/by6fCjgEx44SJFF30FgjsySn+a0Q
	 RPYjOhg7aNoTGdiYf3n4M3ioX2b7zYNYQVsjdKyWe/KRlEoGDk+To974aQqHJddWiD
	 H/PrJrG20WBh8EGuQTWHOvayaWDbJPykJKgXwyKg=
Received: from github.com (hubbernetes-node-65f4d36.ac4-iad.github.net [10.52.125.53])
	by smtp.github.com (Postfix) with ESMTPA id 5C56F741302
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jul 2026 02:19:47 -0700 (PDT)
Date: Tue, 14 Jul 2026 02:19:47 -0700
From: uos-eng <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1127225/000000-454ff2@github.com>
Subject: [bluez/bluez] 454ff2: adapter: Trigger profile connection on inbound
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

  Branch: refs/heads/1127225
  Home:   https://github.com/bluez/bluez
  Commit: 454ff2ff75699a2fb88b5ad2ff0b6f99ed923aa3
      https://github.com/bluez/bluez/commit/454ff2ff75699a2fb88b5ad2ff0b6f99ed923aa3
  Author: Chengyi Zhao <chengyi.zhao@qq.com>
  Date:   2026-07-14 (Tue, 14 Jul 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Trigger profile connection on inbound device connection

When a bonded device initiates an inbound ACL connection before the
host sends an outbound one (e.g., after resume the remote wins the
race), BlueZ accepts the ACL link via connected_callback() but does
not establish AVDTP/AVCTP profiles. The remote's subsequent L2CAP
connect for PSM 25 fails with "security block" because the link is
not yet encrypted, and the kernel does not retry. The ACL link stays
up with no audio.

Fix: in connected_callback(), call btd_device_connect_services() for
bonded inbound devices. This initiates outbound profile connections
from the host side. Unlike inbound L2CAP, outbound L2CAP is queued
by the kernel until encryption completes, so it survives the race.
Safe when the host already won: the function returns -EBUSY if
dev->connect or dev->pending is set.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
