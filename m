Received: from out-26.smtp.github.com (out-26.smtp.github.com [192.30.252.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86521DEFC1
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2024 16:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731516292; cv=none; b=L0YLwPFo4xqTTmtaGFmGwkDZSYrU+342JFIPcKi1wfVqHy4P/8xCPCDBgBj48xdbqGOdjolEh+AwF5gh5m8J67UGiHH0YgD/i5cIXOLDhmJu+mveU1u5hzpiHej192foPumIQuSMeDwecnKG17btLS2DjrNMt2JYOAU72H8h5M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731516292; c=relaxed/simple;
	bh=aFk+YhjzjpEJYP1Q9Pj7YLYa5siKscsCyfWa9OOkBow=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=bNY7sAxRaenKR3WArRd6W1gZbGBAChOKdx1c4wFCXEQDkhprw0tdj0qZTrzRkv6f6J/yJHObkgq8ssBFs4t0OmIbfwguJ6CFaxIsg7N+tjBCv9q/AJy0Na81/JVGxGZqg9wy2uZUDxweGYyhjBO+xGCn5KY+EXBO40RzITHu8/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=W0lF3IlA; arc=none smtp.client-ip=192.30.252.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="W0lF3IlA"
Received: from github.com (hubbernetes-node-11841be.ash1-iad.github.net [10.56.158.25])
	by smtp.github.com (Postfix) with ESMTPA id F11CF601327
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Nov 2024 08:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1731516289;
	bh=aLppQUqh0vxH5L/Jc+4OneZNFW7/CmFfQGX78rBy+TQ=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=W0lF3IlANtHA7ocxprN+C0Gnjy78IEdz3eLSIfz0gsgSCt2hYv1z0OgE3flPT4rUp
	 wAr5HZWhnoFKjUfQe6y7gElB0gOmDOsKWwJGMl2VZOGNFdTfDrMES55mQrkpqwtFv1
	 NlBypsBY0Wwf4rpOUteEwjqc30qrn7NzaeLkjjGY=
Date: Wed, 13 Nov 2024 08:44:49 -0800
From: Marcus Prebble <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/f0302d-63f1ab@github.com>
Subject: [bluez/bluez] 63f1ab: rfkill: Do not log errors for missing device
 path
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
  Commit: 63f1ab560c4253742aa12f139610d5c1c52debb5
      https://github.com/bluez/bluez/commit/63f1ab560c4253742aa12f139610d5c1c52debb5
  Author: Marcus Prebble <marcus.prebble@axis.com>
  Date:   2024-11-13 (Wed, 13 Nov 2024)

  Changed paths:
    M src/rfkill.c

  Log Message:
  -----------
  rfkill: Do not log errors for missing device path

In the case of our products, we lack a physical RFKILL switch and do
not have the rfkill module enabled in the kernel which resulted in an
error message each time bluetoothd was started.

This commit looks at the errno code after failing to open the RFKILL
device and only logs an error if it is something other than ENOENT
(No such file or directory).

Fixes: https://github.com/bluez/bluez/issues/792



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
