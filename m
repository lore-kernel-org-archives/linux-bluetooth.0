Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3741C8FBA
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 09:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572605; cv=none; b=jwvIW3FgQGtV6rjV3uReJv671lV/91BASI2bcVMFMh+/PcSrZEmZt/VAyFYFjaSIPfLdng/12Yib73WOwuPv7liHmTiytjLJ+ikccs3Dt/AI5BNxJQ2ooUi2il8oPPOMv48yIKQZqnP7WjkCVbmuPryR77eqJaB9lD0QC1eeq0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572605; c=relaxed/simple;
	bh=xl4dF+gND6M71SxcqJyYnFz7FoSzXKoafeUy7CPrMyU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bU8KdiI7niChc1UuCKCI5WCcUfh3eTYU6PZlJIWeVreK6URi/xDvtktVQniqAfjwELXHI0udTaG16i9GVfRecBl29JX/NiguKJP2SvYn/mQpX6UZ9NjA9MmOiDnWHWNEn/ynTA39Cty9dKJw5QboZr2O7sLB9J5U6433nejn2Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=QtWlMpo6; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="QtWlMpo6"
Received: from github.com (hubbernetes-node-5036363.ash1-iad.github.net [10.56.177.14])
	by smtp.github.com (Postfix) with ESMTPA id 01EBE1412F5
	for <linux-bluetooth@vger.kernel.org>; Tue, 15 Jul 2025 02:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1752572603;
	bh=sTVC4U6oC8LwfTq/52d/uVrcmxql5UuiGDZjpouGDYg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=QtWlMpo68/JSQvdef/+KUED46XRYmbKH2fWIS+neFqqlO1zFCWmnZvXBvdPK1zGu2
	 i/bPbi74lo4RolE6LrKk88k90xL3LiCde6fYPoPi+bplWlSnH+eDqz8ybUlGRxSR3K
	 2KZ3oYbB2JZ3wR866fiDIakPI8csz95NKdJHXPyQ=
Date: Tue, 15 Jul 2025 02:43:22 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/982440/000000-d4f17d@github.com>
Subject: [bluez/bluez] d4f17d: adapter: Fix RemoveDevice timeout when device
 alre...
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

  Branch: refs/heads/982440
  Home:   https://github.com/bluez/bluez
  Commit: d4f17dec8a4f39431bad0892dcd4f13170d33bad
      https://github.com/bluez/bluez/commit/d4f17dec8a4f39431bad0892dcd4f13170d33bad
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-07-15 (Tue, 15 Jul 2025)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix RemoveDevice timeout when device already disconnected

When attempting to use RemoveDevice to delete a BIS source device that
was synchronized by the BIS sink scan delegator, the kernel marks the
device as disconnected due to PA(period adv) sync termination. However, BlueZ is not
notified of this disconnection and still proceeds to send MGMT Disconnect
command. The kernel responds with MGMT_STATUS_DISCONNECTED, which BlueZ
does not currently handle as a successful case. As a result, the RemoveDevice
call never completes and no D-Bus reply is returned.

Fixes: https://github.com/bluez/bluez/issues/1421

Signed-off-by: Ye He <ye.he@amlogic.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
