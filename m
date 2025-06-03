Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB86127FD46
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 09:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942086; cv=none; b=gWS5f1WEf12zKaZnK5KbEcXeQf384MOMWd7vtHKFyzHRxXh7HOjZkRCMYC4I/Lf3iDoHitBURIvr99k0oiTIPNDeh9G3HFDgxc5u7cxHFa6KtjaxABW7B5mMFgRZ2qumN3Wy8bVQ7xgvBrekwRCi/c7o6NXeGdHmZVMrexq7bQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942086; c=relaxed/simple;
	bh=o77PrscGkxAd6CVj2J64OhaoZDT7WHD7jQQHxp+L3II=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=Oz5aXhsLiQaQUfs1DkcDv+i88cK1u5zsCg3Vevme6DxCtMlFWeuC6QfvRteUvWPhaS+plgTG9rwP1UmZRaYHSzC3fSrC+dFE57jaUV6bjFrOboakXlr25YBU7rUP+77H5Xl7u+H555fU/7MepbU6UZGhCOx7GVYqKxIz/BXHugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=FETgs91m; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="FETgs91m"
Received: from github.com (hubbernetes-node-39f410b.ash1-iad.github.net [10.56.186.31])
	by smtp.github.com (Postfix) with ESMTPA id D06A19212F0
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Jun 2025 02:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1748942083;
	bh=a6HhUThEA76DQrqQ9NkDHWUZXgfsSOFG34zAN8gnFeI=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=FETgs91mz7UnXrwa+ohOyX5MvXW4IaWZSOVJmPXRn5zaLBFIEtx5+pr1iEQFeMiti
	 ArOW/xLJjkGvaGgYsIVXQJwtvQm6sIOAMUiYYnvJE6WRzhQXfD5uAHlDMqw5CYrOl8
	 Q5uQkx+whoo9tniN94y1fURUrWyOfsAegilHv+dY=
Date: Tue, 03 Jun 2025 02:14:43 -0700
From: mkasenberg <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/968220/000000-1c0528@github.com>
Subject: [bluez/bluez] 1c0528: monitor: Fix bit for
 HCI_LE_Read_ISO_Link_QUALITY
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

  Branch: refs/heads/968220
  Home:   https://github.com/bluez/bluez
  Commit: 1c0528d5a8f34dff9f386ee35a92f2c9e663faeb
      https://github.com/bluez/bluez/commit/1c0528d5a8f34dff9f386ee35a92f2c9e663faeb
  Author: Magdalena Kasenberg <magdalena.kasenberg@codecoup.pl>
  Date:   2025-06-03 (Tue, 03 Jun 2025)

  Changed paths:
    M monitor/bt.h

  Log Message:
  -----------
  monitor: Fix bit for HCI_LE_Read_ISO_Link_QUALITY

Fix the bit ID of the HCI_LE_Read_ISO_Link_QUALITY command to match
the assigned value defined in Supported_Commands table in the Bluetooth
Core Specification.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
