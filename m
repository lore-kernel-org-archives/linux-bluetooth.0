Received: from out-25.smtp.github.com (out-25.smtp.github.com [192.30.252.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686531DDC24
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Dec 2024 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733177526; cv=none; b=pB3Qs/zaMNyCWbv8GhztCjozIIkFHhdU2X0TZpdp5ipi7jt9/FW9oV8rAzjE6e+42uRjlJbxAud9cIRT74iaB1JFGsUve8yJYoiYyy1y2t3vX325eXoecYEPrMiiedoLAdfjYaSBrwNjHhQ1nqPhgttwLBbJOfeSieExz1cyIvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733177526; c=relaxed/simple;
	bh=jIUyRiFALu7dk//uW0OQmi0OuipGlQ/GBxY4G203NUs=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=hSyknG4ivunPHixPnNlvqtTSwQQ2unjlX9UlqjcWk4VWwQQvCb5xSwZn3q9lYBkr87D4iPhbfd0KRZRU1eqFpc8MU8UXsEDi8dJQVAmt62Dx0mzS2juKlinj1sc6HqC+NRHqRBY2MKIkTsdgxlDohzrx+eIpKswbkHgXJyXeOJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cWs5fQun; arc=none smtp.client-ip=192.30.252.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cWs5fQun"
Received: from github.com (hubbernetes-node-779bb33.ash1-iad.github.net [10.56.152.35])
	by smtp.github.com (Postfix) with ESMTPA id 629781407DE
	for <linux-bluetooth@vger.kernel.org>; Mon,  2 Dec 2024 14:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1733177524;
	bh=Kxlb5Mx9pW4xZeXxgQW8xG5DCRYVC86mCqM2WrFWwXE=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cWs5fQun1pOoAOvDoII8dTch09a3V+8rps3GHTgkIoaEuO/pW6Y+XvIwuG0By88WP
	 mpjX7sdQy3/aqFAA9RYNFzZvW57fZO5VcPWjpUjBnsviyv3kW5wvcDPyesvURGPe71
	 V9pwD/8aG69yizjPzcO8sTBPkvyEh7eVD5Vy5gL0=
Date: Mon, 02 Dec 2024 14:12:04 -0800
From: hadess <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/d280c9-252883@github.com>
Subject: [bluez/bluez] fdcde2: profiles/audio: Quiet plug-in warnings
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
  Commit: fdcde2ce2112df852ab3df6e49b158621177f946
      https://github.com/bluez/bluez/commit/fdcde2ce2112df852ab3df6e49b158621177f946
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-12-02 (Mon, 02 Dec 2024)

  Changed paths:
    M profiles/audio/media.c
    M profiles/audio/micp.c

  Log Message:
  -----------
  profiles/audio: Quiet plug-in warnings

A normal daemon start should not throw warnings on a system in the
default configuration. Quiet the plug-in warnings that require
experimental features to be enabled. They will still appear in the debug
output.

bluetoothd[896]: profiles/audio/micp.c:micp_init() D-Bus experimental not enabled


  Commit: 252883241228f3149566f119336ce2c49a8d861e
      https://github.com/bluez/bluez/commit/252883241228f3149566f119336ce2c49a8d861e
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2024-12-02 (Mon, 02 Dec 2024)

  Changed paths:
    M src/plugin.c

  Log Message:
  -----------
  plugin: Quiet start-up warnings

It's not an error for a plug-in not to start if the hardware doesn't
support it. Quiet the warnings that require specific hardware.
The messages will still appear in the debug output.

bluetoothd[896]: src/plugin.c:plugin_init() System does not support csip plugin
bluetoothd[896]: src/plugin.c:plugin_init() System does not support micp plugin
bluetoothd[896]: src/plugin.c:plugin_init() System does not support vcp plugin
bluetoothd[896]: src/plugin.c:plugin_init() System does not support mcp plugin
bluetoothd[896]: src/plugin.c:plugin_init() System does not support bass plugin
bluetoothd[896]: src/plugin.c:plugin_init() System does not support bap plugin


Compare: https://github.com/bluez/bluez/compare/d280c9346cf0...252883241228

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
