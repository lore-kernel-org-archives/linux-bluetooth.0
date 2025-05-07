Received: from out-20.smtp.github.com (out-20.smtp.github.com [192.30.252.203])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1843828BAAE
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 May 2025 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.203
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635927; cv=none; b=K3VDiGWUzT8VBOf+bWY2wg8UUDxtFoMxVQ1A5kuA+v1G9BnKg6jag2d2Y3MPYpmePQ/I3gPJqQ4C+cbscvLxXGBQBee+8d8LgKlUGTjdZQlICdZi/SfeI2ARVnR9GNitAQX6oUGw9z/7aiUKpAkdU1Po4c+G6kGMufdb53ab0Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635927; c=relaxed/simple;
	bh=X6Qduv/pSXGUiTjx5BgNKNya27vZyRQ+IMGPNu4kSm4=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JePJupDOXnt6eNL23PA9AymdGSRwf7laxBYzJREVQ3YZoLiXXxfYitwgnrLkiF1xDRsa4KSuSvxzVR+DFnv6TouwiHozlAKCoxCDF4jDsjXyrnuG4seqZTUEbRzqx7WqokuPQXg1AxDbP0mIUrnbGCfsIlcss2iAOu8jBJky/ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=PsIhr2ZS; arc=none smtp.client-ip=192.30.252.203
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="PsIhr2ZS"
Received: from github.com (hubbernetes-node-f265528.va3-iad.github.net [10.48.155.34])
	by smtp.github.com (Postfix) with ESMTPA id 081D58C13DA
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 May 2025 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1746635925;
	bh=pu397/gCqcK2kbbIpcxoefMliA7k4PlHE4HRKzuK/LA=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=PsIhr2ZS63MlnTXDz/yaco7EuRyHSNcKMAbPlqlbrBagOSIC71olyf2BnxBNCVIAe
	 QsBaNdOWDIHiX3LP2zExw+NK7XtKPcpnxSzL6dTuqsaSBlG8oalr83gCarvwmA2kc3
	 4LG9kktVF0uABMJ7VdR38APHcAcgpQkNON5CDpK4=
Date: Wed, 07 May 2025 09:38:45 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/960563/000000-c3d84e@github.com>
Subject: [bluez/bluez] c3d84e: btio: Fix not being able to set security level
 4
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

  Branch: refs/heads/960563
  Home:   https://github.com/bluez/bluez
  Commit: c3d84efc546833154a699fb4e2c3838181df1000
      https://github.com/bluez/bluez/commit/c3d84efc546833154a699fb4e2c3838181df1000
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-05-07 (Wed, 07 May 2025)

  Changed paths:
    M btio/btio.c

  Log Message:
  -----------
  btio: Fix not being able to set security level 4

This adds support for BT_IO_SEC_FIPS which shall represent the security
level 4.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
