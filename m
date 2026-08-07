Received: from out-37.smtp.github.com (out-37.smtp.github.com [192.30.252.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA2A463B7A
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 07:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088480; cv=none; b=t0hnSYqButq3iAEXuPJE2QW8daM8a/yHiaRYAtOAdOjAEgMdKBX9lnumyK6dX+HnAb0mtUI4qYxRNtIuza93VtP0WdJYcD99vw5vVqvH6JFjDK//YCRmBRdBUTKmPHBuQTj+CUEvuwAlfQs5BQqTlH585WO9AgpG2zJhQnlyNjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088480; c=relaxed/simple;
	bh=89hCspf26qfmynqJhww1J8bRzCYadz7jsZU+WNqDfQU=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=heeKOp/GQziKv3oVt01XkajnizL18/BnSDJUiqnC1XHJVwMWAxitFZCzGyMJSx8YtQ/UtMHKk+0YV40XeebYPLIJttXuTUG5uHKMVUlUPZOevQbt0WvwdCX+144ouIntAbJ2l1HGiAZ6Kd19EuRDwB6VeV0RLtRviGmhjkmSI30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TpKDOfKa; arc=none smtp.client-ip=192.30.252.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TpKDOfKa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1786088475;
	bh=EJ5P7njxDh2Orw/duBuBH39YtmghrKpHEBMqmsrRjLw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TpKDOfKaUaGub7mSQRynJqiyOGBJihfV5QkhV7jscEoKtaawFYMg3qbO/xSfQ66Be
	 goOPY7xBFvYwmdvMNKNn3NGQmSd0Om2r/i+t8BtPueVRUN8Y1mcxcM/3CLxyP27ve+
	 mlPlGnXs9uzeAHmUD0mSFKjnjG84BfExYel8WA9U=
Received: from github.com (hubbernetes-node-853e8bb.ash1-iad.github.net [10.56.190.32])
	by smtp.github.com (Postfix) with ESMTPA id 932C292050B
	for <linux-bluetooth@vger.kernel.org>; Fri,  7 Aug 2026 00:41:15 -0700 (PDT)
Date: Fri, 07 Aug 2026 00:41:15 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1141938/000000-325365@github.com>
Subject: [bluez/bluez] 325365: client/btpclient: Fix missing errno.h include
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

  Branch: refs/heads/1141938
  Home:   https://github.com/bluez/bluez
  Commit: 325365f5fda29ff5ec15716b453c1c1a25cb00a0
      https://github.com/bluez/bluez/commit/325365f5fda29ff5ec15716b453c1c1a25cb00a0
  Author: Jinwang Li <jinwang.li@oss.qualcomm.com>
  Date:   2026-08-07 (Fri, 07 Aug 2026)

  Changed paths:
    M client/btpclient/gatt.c

  Log Message:
  -----------
  client/btpclient: Fix missing errno.h include

EINVAL is used in create_uuid() but errno.h was not included,
causing a build failure.

Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
