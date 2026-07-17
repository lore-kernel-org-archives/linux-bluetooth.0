Received: from out-30.smtp.github.com (out-30.smtp.github.com [192.30.252.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A6BA3D
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 12:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784292425; cv=none; b=YXEj2WUpBddIKSmPMKdWvwc6jkD9piebfqDPAG/v/0VRv+0N8MmLJEHPUAOAUL1cli2UcHp7/ibQcnxyRjViM0cBge9yxptkN1xfnHxGa4gSYv+h51+tUXtHWVVvxaqGAabwBpgRyo5oXbzcQsqB2gyrI4OggtsnpmDy4sj6jXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784292425; c=relaxed/simple;
	bh=oXKK+ceI9HXM5qMP9RLyfmRYg4hLxmGoTugaKozAWlg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=CV8i8s+ZaDVVG7HYRZsDSXvT29UQwouM2x7UhZafZa9I+eSd66aOlhZeXrUrIvb14s5ariKyN5TvWmWgemuM2dgrMZJTiFtVDPnEYDOc3Ce9F9/S9/t6u4jpDGd0aD1mqin9DVafA0TP6qphn5oouCMHiOLqgODTNHmjGMfJGck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=cvPRiSpq; arc=none smtp.client-ip=192.30.252.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="cvPRiSpq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1784292422;
	bh=Xuj9xhHBB2lWauYVvjGHZioYQTPfIfgLwhTIFVuXqjc=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=cvPRiSpqC3uD4WtR7YnQjnd/Fv+D0fultQs6EBbN9xF2BxhRCjUDXfBeQXtZXmIrN
	 /qfyuj4WI6Puw8+cgtV5ta/822OCiagruj0cenVqFgcDRX6bOlfKiT2WbF0/t0XyOB
	 Mrvwqe4TY/bhHlvIRTvfofDvMRjg1zVOm0NoXyiQ=
Received: from github.com (hubbernetes-node-5ccc08e.ac4-iad.github.net [10.55.88.33])
	by smtp.github.com (Postfix) with ESMTPA id E6B20321047
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jul 2026 05:47:02 -0700 (PDT)
Date: Fri, 17 Jul 2026 05:47:02 -0700
From: Bhavani <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1129585/000000-b519f6@github.com>
Subject: [bluez/bluez] 05f685: rap: Add RAS attribute access notification API
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

  Branch: refs/heads/1129585
  Home:   https://github.com/bluez/bluez
  Commit: 05f6854f1088379cad49e051c9f085dbec18d0a4
      https://github.com/bluez/bluez/commit/05f6854f1088379cad49e051c9f085dbec18d0a4
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-17 (Fri, 17 Jul 2026)

  Changed paths:
    M src/shared/rap.c
    M src/shared/rap.h

  Log Message:
  -----------
  rap: Add RAS attribute access notification API

Add a callback registration mechanism to notify bt_rap consumers
when a remote peer accesses or discovers a RAS GATT attribute.
Introduce register/unregister APIs and invoke callbacks asynchronously
from all relevant RAS characteristic read/write handlers,
following the existing bt_rap_register() pattern to avoid
reentrancy into device/profile/D-Bus logic.


  Commit: b519f6ee42bb1bea70662d091c20c44c186318aa
      https://github.com/bluez/bluez/commit/b519f6ee42bb1bea70662d091c20c44c186318aa
  Author: Naga Bhavani Akella <naga.akella@oss.qualcomm.com>
  Date:   2026-07-17 (Fri, 17 Jul 2026)

  Changed paths:
    M profiles/ranging/rap.c

  Log Message:
  -----------
  profiles: Register RAS UUID reactively instead of probing

Replace the unconditional reflector-role GATT_UUID probe in
gatt_client_init() with a reactive registration driven by actual
remote RAS access, using the notification API added in shared/rap.


Compare: https://github.com/bluez/bluez/compare/05f6854f1088%5E...b519f6ee42bb

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
