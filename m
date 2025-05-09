Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70552918F1
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 May 2025 13:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746799080; cv=none; b=KwEzSIpN50qWzxDKzPBL+ZobqojDTKqQOYxR/WIFkzIDSb+QKZ0+XubRAorqjPRpm2Y25WCcPBJbza8axhUI4vY/jScIjgoQPj5g9nFZIi9G2vWoBugPzpZhVbVAfta0G4YD9aLg6JUWIRhyYFNgRlAh3fot24av2fjO664MkME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746799080; c=relaxed/simple;
	bh=nnv7q6Qmf2VNxh4NMvAYxtq4HKTejcY3b5x+whuafi4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YRS+PHITvMwcPrKJhVZXmEB+h/WLo1v86FVVOK//vbFMQo3qGiRAkNI7FqwJFqQiui1JhVSYe+NH9W63W1kENlL0y5irWRXNcnXhAgdHLXlFw0IqUaCYvziJExuJOicSM9qv4CS8c8PETJcAGtzBuYBitPn70ioWlAgvE2FKY8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=MRJ0MR5L; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="MRJ0MR5L"
Received: from github.com (hubbernetes-node-7b68375.ash1-iad.github.net [10.56.178.25])
	by smtp.github.com (Postfix) with ESMTPA id BDD38601196
	for <linux-bluetooth@vger.kernel.org>; Fri,  9 May 2025 06:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746799077;
	bh=lM6kZdZEj6s+9WlYaI4jzx/8kphxLXgcy8IswiK3XYI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=MRJ0MR5LZ1Bs0vdWbCjYcZjFgK+nFZsY8JwtMJL5onD0cuAr9sMqDBQAhtwkXzurW
	 XzYTh3qTbcb2AjOKHSla4MuSpmiLqtv+7g4XcCkaI2lZaODZ5Q7hWmCLOPOnsNpI8f
	 KklkjCGCdp9E+aj0WDZtQk3Al4yjPHUryLV5e2mg=
Date: Fri, 09 May 2025 06:57:57 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/72dddc-ab6ce0@github.com>
Subject: [bluez/bluez] ab6ce0: input/device: Fix not sending virtual cable
 unplug
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
  Commit: ab6ce0c8f3e066299bd22bea6d03625edb1fbbe8
      https://github.com/bluez/bluez/commit/ab6ce0c8f3e066299bd22bea6d03625edb1fbbe8
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-08 (Thu, 08 May 2025)

  Changed paths:
    M profiles/input/device.c

  Log Message:
  -----------
  input/device: Fix not sending virtual cable unplug

When using udev HIDP_CTRL_VIRTUAL_CABLE_UNPLUG must be sent directly
since it is not handled internally like when utilizing kernel hidp
module.

Fixes: https://github.com/bluez/bluez/issues/1173



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
