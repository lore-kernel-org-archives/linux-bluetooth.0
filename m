Received: from out-33.smtp.github.com (out-33.smtp.github.com [192.30.252.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D638381B16
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 05:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779342607; cv=none; b=Odv5cbAh1SzCvQEnUYOOelBxl8IYFMqBbszCuk78Shm2Ev9yMZC2wiv/q3qQZCZK18sksztgdeexlDHdjkYUJyGvFz7RKEy5d2J3cBS4Ss9ctE4V5fka3ZrmBuykQukx+YcfUvl2FC22n1qZmz7YwbZUSRAjw3QeYb7mM3ytAJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779342607; c=relaxed/simple;
	bh=CELOr5C3jd94Qs54zJqJjtHIeAcMXOWn/1Iyx5b1lCA=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=YkfWiZf7x3WEmJTvupMsLHpITOF99Ivf81MH8FVaSWYwB6sXfzcuiFQoPNe4JfsgM5Azcj9zsmrt0LQtSqQK429wwcGFaMm+ezgDPoZTZiaZIpaWc9lZqNP9hN4B6A3nNwzwfPxL3WzXE1BpV7/K2K3kBowRrFu8410hdH90X2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=iliWE3Kp; arc=none smtp.client-ip=192.30.252.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="iliWE3Kp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1779342605;
	bh=SJVwFqpuI88NYxJSOGMtA4Dt6ebLZCdYYVk3lpqIZqo=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=iliWE3KpJic75nKhwBaChyZ0tXZHiefnPDRFy1KL7PygrBGyeGO97skaT6CEKyQb7
	 IMFsGKeaoMJsZCkZSzphxDb0FgLpZJl5qUko2cE2SssKtauLKefF9UD2QAXJ4wM2it
	 xeXYX3aOs8ud3zPt+uczhcfTg8nQUE/zPg8n9JUs=
Received: from github.com (hubbernetes-node-bdc6b66.ac4-iad.github.net [10.52.125.27])
	by smtp.github.com (Postfix) with ESMTPA id 63AF7740325
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 May 2026 22:50:05 -0700 (PDT)
Date: Wed, 20 May 2026 22:50:05 -0700
From: michael kong <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1098419/000000-e58872@github.com>
Subject: [bluez/bluez] 35baf7: shared/bap: Fix unused value in qos
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

  Branch: refs/heads/1098419
  Home:   https://github.com/bluez/bluez
  Commit: 35baf761c1f830861a6bcacf856c4c95029148f9
      https://github.com/bluez/bluez/commit/35baf761c1f830861a6bcacf856c4c95029148f9
  Author: michael_kong <kx960506@163.com>
  Date:   2026-05-21 (Thu, 21 May 2026)

  Changed paths:
    M src/shared/bap.c

  Log Message:
  -----------
  shared/bap: Fix unused value in qos

In bt_bap_parse_base, PresentationDelay is parsed but not written to QoS.


  Commit: e58872a259ad0973107ef479b33a4e2be273bbf6
      https://github.com/bluez/bluez/commit/e58872a259ad0973107ef479b33a4e2be273bbf6
  Author: michael_kong <kx960506@163.com>
  Date:   2026-05-21 (Thu, 21 May 2026)

  Changed paths:
    M profiles/audio/transport.c

  Log Message:
  -----------
  transport: Add support for obtaining PresentationDelay in broadcast QoS


Compare: https://github.com/bluez/bluez/compare/35baf761c1f8%5E...e58872a259ad

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
