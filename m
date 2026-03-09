Received: from out-17.smtp.github.com (out-17.smtp.github.com [192.30.252.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CE63A0E85
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 11:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773056679; cv=none; b=CDObfW4CqLfR/7IYwQnpguAT4FErExml9GUZcLLp9zU4c8dH/tm/k8SRYImM7zSqwgssBd9u3pi5OtPVYygBOrh77uhSIl/LrsJX46R6H4muZPWhdmg3l7Djn7soe2XQAaDPKTgCwwmpuKu2Y7bbvnRkMczI9vTGWKotrGzb65M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773056679; c=relaxed/simple;
	bh=2vIzIOggmvxqrauvWWfWTtcmJXfpKegnLFkBhstaFhw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ngTRM0EdRUCN2cbV/R8tQGjkppd2WpTGTZ45U6g23HyoeAYVtrv/65uvPNfLyKrweQKlUxSl6u9ysracIGwKf3d5EZF30YAtcTdYvzMqe79KPwwmXdOzpTLxhNcm6ipUOUEgckX+SVypcQaidZL1LzWmFmq4NkBJ9+4fy/3YFKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=dwj178Uj; arc=none smtp.client-ip=192.30.252.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="dwj178Uj"
Received: from github.com (hubbernetes-node-122ed91.va3-iad.github.net [10.51.96.26])
	by smtp.github.com (Postfix) with ESMTPA id 0CE1F4E08A9
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Mar 2026 04:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773056678;
	bh=EEO/EUjLuv8wCyRDWvjeCJEAVeIXTTVbSc7rEp/JsHM=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=dwj178UjU+aeFKKtRBjH7DD6OQy8TYSxdN1H2iRI3s4C/XAPS0SG0bWz5ugenV/UB
	 NeRAnh7pNCMBwRqCnZ1YF/GHTN47n6xPUXVIeNehyEFMB48Gcuu5/x3Lh0I93A3O4b
	 Tf3qwqFnRPmb/OBjMB24A/r1kAu6w+7IKFlgnOEY=
Date: Mon, 09 Mar 2026 04:44:38 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1063601/000000-b83b48@github.com>
Subject: [bluez/bluez] b83b48: transport: Fix set volume failure with invalid
 dev...
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

  Branch: refs/heads/1063601
  Home:   https://github.com/bluez/bluez
  Commit: b83b48ab7e8faaefde2686b988996142a8ef52a4
      https://github.com/bluez/bluez/commit/b83b48ab7e8faaefde2686b988996142a8ef52a4
  Author: Jinwang Li <jinwang.li@oss.qualcomm.com>
  Date:   2026-03-09 (Mon, 09 Mar 2026)

  Changed paths:
    M profiles/audio/avrcp.c

  Log Message:
  -----------
  transport: Fix set volume failure with invalid device volume

When AVRCP is connected before AVDTP, an invalid device volume causes
the target to reject registration for the EVENT_VOLUME_CHANGED
notification, which breaks subsequent volume updates.

Fix this by initializing the volume to the maximum value in the AVRCP
target init path when it is invalid, allowing the controller to
subscribe to AVRCP_EVENT_VOLUME_CHANGED.

Fixes: fa7828bddd21 ("transport: Fix not being able to initialize volume properly")
Suggested-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
