Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A183B7753
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775570292; cv=none; b=WAv8KHlQxlglcFpqRRDTtvlO8im/zss1yShjyQRbYIiY99Y4EzjDRvEoLDQEOW/xJlD092wDtTlnqzo3eVGHbW3gNO7A5RkVsKGcEbiuSY6lB7fbKtpLxEpHKOHrL1OJSvpHz9goE/BTFd8Ok24xrSALA/aaj3EjptCGQyK4LK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775570292; c=relaxed/simple;
	bh=FaKU2CicW5NVYGZXt65nEAzr6dwN3V4xsL1RcrJ+3Xc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=S3X0lkftHsd3rTx0aLUUB5WtkA63ka8UxNdrFXIBGw+VNwGMthemgbPdwonfEcg3wqrIsudmV+B9CU+As3f3PSndlMWcFoW8TX8lRJ0QqDgEsrgZAuuzzvNy5lA0l0LTP2y8oyuHECbH1c30TnHy+kIK7n9vHm1XRipbfQkqKEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=LVH6aNrs; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="LVH6aNrs"
Received: from github.com (hubbernetes-node-f0aa762.ash1-iad.github.net [10.56.182.39])
	by smtp.github.com (Postfix) with ESMTPA id 2F4771408B2
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 06:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1775570291;
	bh=VfhBS0Hv7VRiCb/IcgaVnGMeTZILvBQLHGxKUEdKkHY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=LVH6aNrsPon4nKval1HW2aaEZpTG3i5Ic6cfyhWy2ojeFBgqmMa5i96xvcNF+Wanj
	 FlRZ7UtV31QjFkdhDwoSjKBQQZ+MS+2RBJiEDYBjLXUuaQjJg9wfBsLfsfUuic6znp
	 rAYomrLgqFsUwGMzBBxqcaEPUdrisF5OjS7lRTk4=
Date: Tue, 07 Apr 2026 06:58:11 -0700
From: BluezTestBot <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1063221/a3b3f1-000000@github.com>
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

  Branch: refs/heads/1063221
  Home:   https://github.com/bluez/bluez

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
