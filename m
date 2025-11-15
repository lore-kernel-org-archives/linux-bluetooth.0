Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB84F2F5B
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763211410; cv=none; b=ZSb/mH/QCNLetZ41L9CROWkO3rHG3RQhEWxHCg0KDZoIjNR20RAVZ0Wg5MRHUoSAbQmtcu4N66sVnhaklRqbG3onX5IMcKjhuiuG5ddj6Kyp/DXeAB59rgzI/WPL0bcM4B5MLgbdyJ0vfD4vnnPPvnMmFfalII/FxjDmeJ8BENY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763211410; c=relaxed/simple;
	bh=je37mZtPL4VU0gpe3D5OW1kIG4e6Ig0LoauGEPf8zuY=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YVQZz1iPKibpoRRcfBRyadzNYMLb+yoJO4ub1wRi8ySyq1Zu02Nv5gv5Bp7vn/QPPMAkklId8VPwrSkwBEhrMPsBEl13tmhEQ9M50NXhMNvPx/cyXdGWvgOW2eco3U5gDis9kPZFItWnulA07FUK9N81H9+zMFATr9yXb5/i9ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=mm5ELSmV; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="mm5ELSmV"
Received: from github.com (hubbernetes-node-56e9ad6.ac4-iad.github.net [10.52.145.31])
	by smtp.github.com (Postfix) with ESMTPA id C5588640164
	for <linux-bluetooth@vger.kernel.org>; Sat, 15 Nov 2025 04:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763211407;
	bh=SpAUo39N3o/EkSK/dHSpYsUDRgnrcinu6YQPP1cU2rg=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=mm5ELSmVtJkvaHgZofxB9aW3qrB+XbBZb/T+u/cLrdioGVwP1IosjW6PmdC+1nVYD
	 6Gb7V/j9X0e5I7q4nfnrbF33KdO2xLmHbTy+YJm2E21dR+uO3EHAeWGih9b4kRBQal
	 uwda4IPdqGG4tnG7GwyeSEmkYDmt8dO0fys4S5XU=
Date: Sat, 15 Nov 2025 04:56:47 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1023092/6a39a6-000000@github.com>
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

  Branch: refs/heads/1023092
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
