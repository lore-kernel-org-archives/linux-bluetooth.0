Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1617375F81
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 21:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776893521; cv=none; b=n52mVo6OqnDnNiJ2F72+e6c3n7RmGU31Dnz/A6+x0lqsppsc7ZuIXvh/hKY1QEHUvE5T+Ik6YCJnyXFz2vbQwrfyP8GK8oechLNJkC79Blt35RDOA/E3LeXrrOlnvwkfhU5B/9kLx191jvv7Tg+5EpFtS9M6D0H9xqtaEXIrmyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776893521; c=relaxed/simple;
	bh=Vv+QesDRrcH/nteRT4aJO7pAA3MCWWEZTGah/jYdo/0=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=B/Nblg8MfPnKXa4XpeKFOv5RleypGPUMBqurFcACkvLrRTII6lWIlj6oMDGFymDLWQSxixLKlYfVxb/MHV2Y4EeWMH4SKv8PJ3VYUFmozGfYv7gA1HBuiWo0UDydc6Xb0z2hmLJM7hJoBK1zSnLs/oZXG29xLFeH823x9Z4X1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=F9/roaAW; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="F9/roaAW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1776893519;
	bh=iMSsLz0qLOvZnJ2XRVlbKLC5jgVO/otSEMau9emxXRQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=F9/roaAW8pXNQBisO/jTXIlE6H6HlAvKDqu/J4goQv7Dz2D9wwSqMpDrT0zI84SzI
	 JKIWZVlPYUDfm/NFfBDWLcnsL4rSWqzWyqGZp/FslZWL+sxdfXbJYEw61Gn/GA5Rd2
	 x2GgmcWC5tbu4UDVv2b5AlYEWN1PJKLKwjCz5pGA=
Received: from github.com (hubbernetes-node-f217a38.ac4-iad.github.net [10.52.12.66])
	by smtp.github.com (Postfix) with ESMTPA id EDF60A10B8
	for <linux-bluetooth@vger.kernel.org>; Wed, 22 Apr 2026 14:31:59 -0700 (PDT)
Date: Wed, 22 Apr 2026 14:31:59 -0700
From: Marek Czerski <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1084434/000000-e0de29@github.com>
Subject: [bluez/bluez] e0de29: sixaxis: Fix pairing Esperanza EGG109k
 controller
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

  Branch: refs/heads/1084434
  Home:   https://github.com/bluez/bluez
  Commit: e0de2926e912fdcb559946777acc5289ad27380d
      https://github.com/bluez/bluez/commit/e0de2926e912fdcb559946777acc5289ad27380d
  Author: Marek Czerski <ma.czerski@gmail.com>
  Date:   2026-04-22 (Wed, 22 Apr 2026)

  Changed paths:
    M plugins/sixaxis.c

  Log Message:
  -----------
  sixaxis: Fix pairing Esperanza EGG109k controller

This change is required for Esperanza EGG109k ps controller clone.
EGG109k looks like PS3 controller but presents itself to the system
as PS4 controller. It does not respond to 0x81 command.
Command 0x12 contains both the device bluetooth address as well as
configured host bluetooth address, so it can be used to query
both. Kernel driver hid-playstation also uses 0x12 command for that.

Manufacturer link:
https://esperanza.pl/esperanza-gamepad-bezprzewodowy-ps3-marine-czarny,176,1701.html



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
