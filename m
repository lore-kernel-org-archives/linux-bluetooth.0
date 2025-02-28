Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757E71F4C83
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 17:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740764258; cv=none; b=ektO8e0JgwJ37VV8PlDwplgTtzQGoSgCZ79er2q6p6Z9xpn5Aat5E6ErmqIkkQQsN9lQHI6Ru18lu6UznILwbjxX4lfMbnvs3rq8ePbxPaNm0J/yPxeO1IvZLOAimiGVJaua53QbadMPhXLkt5Gs54zDsHMI9bzor+b1u/hKPdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740764258; c=relaxed/simple;
	bh=26Z1/l73qt5oXWAn6FCdwXiFhPeb6hwMgSdTrLTz8Sc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=R45O1mk1nSimReiZM9rX1xUq7rT4Jtl3XAQJUZV9fNQV9EhbZGw4Ifzrw6Ap9sXQtIpZZYk7LU+6M8vn7QR0hbTCK3DN706BiSvTThEP5NW/8AOIgw0il6KIb8GSHT9Ude6RYcK1lov2rEcf+U+j5pqmE7YMMlET6SFB6R0erMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=aNz8e+Nd; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="aNz8e+Nd"
Received: from github.com (hubbernetes-node-cb4732c.ac4-iad.github.net [10.52.210.50])
	by smtp.github.com (Postfix) with ESMTPA id 70B8D640884
	for <linux-bluetooth@vger.kernel.org>; Fri, 28 Feb 2025 09:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1740764256;
	bh=cvUdUreiqvwtbW8dpdo1KDxugZlHuOGcxreCguaKcAs=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=aNz8e+NdA3vYfMq6nRTI1DZYc4+9qKDLKF/aNaSFBc2Fwew5ewzVZO7i/pr8RZIK5
	 hbWIknNBZwPyWdw14DkTm8QQBIBbG7PedZaK4h1kPqdLmNWT9SvaigHHPycIZTzpf4
	 +QFOAbNNS3Oa9ddu1bfHTHFy4fRtILANfDKi5Pyk=
Date: Fri, 28 Feb 2025 09:37:36 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/8d1c51-7f1fa3@github.com>
Subject: [bluez/bluez] 7f1fa3: shared/bap: Use a stack variable to notify
 releasi...
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
  Commit: 7f1fa3d7ce39e2e3325c948ef2580b1d60c48c78
      https://github.com/bluez/bluez/commit/7f1fa3d7ce39e2e3325c948ef2580b1d60c48c78
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-02-28 (Fri, 28 Feb 2025)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Use a stack variable to notify releasing state

This remove memory allocation in stream_notify_release.



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
