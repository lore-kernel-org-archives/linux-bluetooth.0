Received: from out-19.smtp.github.com (out-19.smtp.github.com [192.30.252.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BDC3346A9
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 14:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736239; cv=none; b=Cnw3IKDaNeW2CCKcyF5f0br11Seu9ttG67IKFwWcY7mFIQJX9pzHosoA8OuKMC+yl21M3Y5IDadBt0HZpLSqGBCacUXVmMsJ07YXj6e9qf8uQZVL7SJpOA2Q2FzNgVYdNaeDF5mO5Afc5m8T0XqAiUY/L6zdJleS6Z0iNLVnDoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736239; c=relaxed/simple;
	bh=vm729RKaRLjLXG2NQrqwQNX22gthM3+IVU0sOoOpG8c=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=KPkPJh8ETXl1ae4yy5Kaam8oEpFvY8lwkdJK0a7VL7RigNXQCszrCuAxITtYXM7WGdOdkqoJ2UV0OmkVZ9KHxVdsoekXGuThI2tyChq2PDKDdV8xgF9EWC+oI9e1LTKOm+RXTVJvgQAWYXlNhsmyCI/582+/Ha7+TWeXYOw6M70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lbH95zH8; arc=none smtp.client-ip=192.30.252.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lbH95zH8"
Received: from github.com (hubbernetes-node-6f921cd.va3-iad.github.net [10.48.221.57])
	by smtp.github.com (Postfix) with ESMTPA id 11C5FE0C5C
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Nov 2025 06:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1763736236;
	bh=z21sWYq43r0/eMRanqPtBzpDdrc1rsb2vcOKfe3NpzE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lbH95zH8puN7YGR9nQfpUoMoHSn3hxEknhXEFNIvdCR2RlbUFagMGw1X9MpXsFkYD
	 ZhVpTEUMxkQZ1lWg1lKuPyIgbZuslZkfLACigaBBlmhciod70mthXpF2Sc1sGLMzjC
	 D90zT7Us9DDdlPRaYH3xCrNL06w7wz9iRPIMUOog=
Date: Fri, 21 Nov 2025 06:43:56 -0800
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8a41ac-ae5473@github.com>
Subject: [bluez/bluez] ae5473: client: Fix issue of bearer info not printing
 corr...
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
  Commit: ae54731047cd8b124e1b35e7fb8e8ed73b340532
      https://github.com/bluez/bluez/commit/ae54731047cd8b124e1b35e7fb8e8ed73b340532
  Author: Ye He <ye.he@amlogic.com>
  Date:   2025-11-21 (Fri, 21 Nov 2025)

  Changed paths:
    M client/main.c

  Log Message:
  -----------
  client: Fix issue of bearer info not printing correctly

The device proxy was incorrectly used when printing
bearer properties.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
