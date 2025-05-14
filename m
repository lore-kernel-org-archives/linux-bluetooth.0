Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A6E286D5C
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747248052; cv=none; b=pHt3tgv/GlCs4qXPDl4AKp2dAkwTj67OxltDAmBehVKIB7XY9aY+Ki9zmWMR95k7VZ0LOpDIxEODz2Uzg9acgvjrXxtrU2wb4qJShGtEvVGMbpSH11jBOSejKBoS2zxuFxVh6wXvTb9SKE/+IE5A3zQkYH22kF5lMekdoLCchw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747248052; c=relaxed/simple;
	bh=PqkskZ2Pbd/Ns1ed1IujM7VjlXfhAesIK8fTpQ/TWGc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FVHdSwaTgoC4xPpv6MFij5OBbmP43hk1pAF6xr08sg4sInSlTeleK8PtEEZoV6LDmL06XVVSBvWxynGILcSG6R2IXPF03GhfxoILPMmu55lsGHJCGJD4QMVxMa+7c0zi0CWymmZbMo/fx2YVAz5QLBYPkVd+bLA2acmouy9wjA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Ct5v6gHN; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Ct5v6gHN"
Received: from github.com (hubbernetes-node-9c08eb9.ac4-iad.github.net [10.52.163.13])
	by smtp.github.com (Postfix) with ESMTPA id A02A1640D57
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 May 2025 11:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1747248049;
	bh=K6wc1wYJTr14WIcdcYghaPcVoY4NpwmG4Nv3hzz5H4k=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Ct5v6gHNK6pT3iV0nIc3JArlk5rtSG5AM3865kNI1caCfU/WgbU7DxmiQ+h1rZ26q
	 wddYckR9hbKLxmNYp56G69m4gjWWOaG0OwoEYGtQRqOgpkBmgde91Udx0Sreuwuk7X
	 DnfotMms9IIESPnjOyZGOpW4wazBFcCvKCv7edgY=
Date: Wed, 14 May 2025 11:40:49 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/962526/b4bd32-000000@github.com>
Subject: [bluez/bluez]
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

  Branch: refs/heads/962526
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
