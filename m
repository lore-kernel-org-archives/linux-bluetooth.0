Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C454C3D5241
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045141; cv=none; b=YNsWmaitwcobsDhoxeMNwmg5qTXL0WXeOYdM4vzooFTOGBRQOvEwEw72vCMLqn+GymnTiRymj0t2cCZjcxWsJPkcm0RHrDYJhsR9Q895+c85zMkVz03vFTuc5TmrXIeIrsLYqYD+ZF3lByRlnxJZ7wDAaFwLKegq8jxxdGWVhiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045141; c=relaxed/simple;
	bh=yaXO72G+Rx4PwvXeR1FWivDBCoW3d4V1uOSiVd+xIYI=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=o5wEWxmRCZLk3NTegcUBhkwBO6jNQz2mnznvcOY5WHc9sllWVuccPWqQtRgfui+z75d48aEm6sR4FBS7w4uB7wgU7Mr/8N5J0DaJixreWAypFPyhGE5lKUy028vrrEI33h2Xd4JaowXyDIvgxkB68B6C+ukhuU8nYNIRnGFkDJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=Oqn1pIT+; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="Oqn1pIT+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1777045140;
	bh=77TwpuxusSGC/rjRJ43oQ85Qm00d1O+OdU0Ih45dfK0=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=Oqn1pIT+mHizpgEbXoGZEQgqa2+APIVpVieFZHoD1r19VCxj5gCM9p0MIQjG+uY6b
	 PIz4rUjIPwVZIU626ZecrT/TFvPysQxvXa2nChLvkMCV6NvujsagE4GQyZDCiS0pu1
	 3AWJh4Nkh3v9sn5tsslw6nv6qkmTHCq8X+4i8oRc=
Received: from github.com (hubbernetes-node-57ab0af.ac4-iad.github.net [10.52.14.82])
	by smtp.github.com (Postfix) with ESMTPA id EE878941137
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Apr 2026 08:38:59 -0700 (PDT)
Date: Fri, 24 Apr 2026 08:38:59 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1084770/32ef84-000000@github.com>
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

  Branch: refs/heads/1084770
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
