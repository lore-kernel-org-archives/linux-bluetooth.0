Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA432C9A
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 20:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747427485; cv=none; b=VF2fL+OwSb9O3etabf7vppBoy7JaOTQtUP7nLQ/HU/UDN3GGSSeskUWVWKs0Z8mYTW6iDYGEEQWXMhdSGtB7siAnr+ybV/X0g7jkmP1guF9u8ItjQbTAzofdWDsYiwwdqS/lMXDEOvBEnm1OUBJHabk6Kex0QrHSnvo6snNjqtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747427485; c=relaxed/simple;
	bh=LoQV2TQMUnydPz3U0MYNCFd/U9zZr1seWoMINrPvLX0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hy5tKGvC/gV7NgwFcCz+yGsJSoo3AChqTHGyJBAYX9ouXYC3SsUaP/hxPh4XwIRNlqGhwm1SwAQIcC9Vo6Rvy4XyI+rTqVex5iBTACKeNWNvvrK+06oqDfoAqczH+J7HjCZ25jo9yAl7y3hQJtgtJ1o2vl/g7u8e7ZOE1RqNcXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=ZIyy1lGR; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="ZIyy1lGR"
Received: from github.com (hubbernetes-node-dbac0ba.va3-iad.github.net [10.48.133.41])
	by smtp.github.com (Postfix) with ESMTPA id 994954E02B6
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 13:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747427483;
	bh=FpY/js9tVt1hCR8ktJs0glcmlI6WNyDYOPXXkr9IO0Q=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=ZIyy1lGRz/6tMTbrlXiHY0TU81cbqlWIWBnXYj1PXDaRs79+PKX6KlmnpS6u9gLSD
	 sKi00h476pNiAbW2tLl8pPBk36xbtmGtsFJZWO8/TyN4feZPYv2GmB/HkXONhRepIY
	 IO7WkNSws8p1zuERE0z1W67xQPvwoTWRzCUpp/W4=
Date: Fri, 16 May 2025 13:31:23 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/00969b-05f8bd@github.com>
Subject: [bluez/bluez] 665f35: avdtp: Fix setting in_use flag for local seps
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
  Commit: 665f35180ff20ceb994f857bd11f1b31742faf80
      https://github.com/bluez/bluez/commit/665f35180ff20ceb994f857bd11f1b31742faf80
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-15 (Thu, 15 May 2025)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/avdtp.c
    M profiles/audio/avdtp.h

  Log Message:
  -----------
  avdtp: Fix setting in_use flag for local seps

This removes the assumption that only 1 stream can be configured per
local sep which prevents multipoint setups where different devices can
be using the same local endpoint.


  Commit: 05f8bd489fd1fbf27dfdc4828bb15aeece3a50a3
      https://github.com/bluez/bluez/commit/05f8bd489fd1fbf27dfdc4828bb15aeece3a50a3
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-16 (Fri, 16 May 2025)

  Changed paths:
    M profiles/audio/a2dp.c
    M profiles/audio/a2dp.h
    M profiles/audio/media.c
    M profiles/audio/transport.c

  Log Message:
  -----------
  a2dp: Fix a2dp_sep mapping to a single stream

This removes the assumption that only 1 stream can be configured per
local sep which prevents multipoint setups where different devices can
be using the same local endpoint.

Fixes: https://github.com/bluez/bluez/issues/1037
Fixes: https://github.com/bluez/bluez/issues/1064
Fixes: https://github.com/bluez/bluez/issues/597


Compare: https://github.com/bluez/bluez/compare/00969bdb17ea...05f8bd489fd1

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
