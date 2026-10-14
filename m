Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B23F54BF
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 20:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792011468; cv=none; b=cEzBTYLN9NTKCE4UQlmIdNMaV/kKTNozBjTCUK/03ccVKQC+RBzeliE86kfb+DOnu4Avruw40ZqCS0SSPS426gqmnH2ZeWEOvaxlvXxnJbY68pRvvY9g2ccWAHGb5i2IsbCIZKpsUswu/Je4bSnCnKlfUxCIytTwNp1EF4jD+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792011468; c=relaxed/simple;
	bh=JrXGhcp4CGNVpYGLfP+tGEE9vYXPLaB/HWK1OcY7PLE=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=cnWjyIWAYWg7jkSrY6niws6ogFYXBmymVNtiidnOe3Dw1I7W24vdGUrRqFRaJF2i/s5lQm/Xhj3dPp0GDCGprnB5lH5Glovx3hIFn0+wz3PPYMe+ChTLkBUF35Wxf8SKhPohKtRSasvEyGTGGPRINzOl6zzpcqM8X8qVwtO3EYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b=m0UTm6ni; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=github.com header.i=@github.com header.b="m0UTm6ni"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2026; t=1792011466;
	bh=QSsc9///YXGn/u+XaevAsZmJk1FtHBTx1SO9xvYMw8o=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=m0UTm6nifgvo/igqXkOicqMODGqeU5FtCzcY+GgnZhfPjtiJGY3TS9qX6f+5t76+0
	 fYOmod4b5xs2Z90EXJTlwqaoh3Ri6drOtFs7sp2/t3vbm5JsKP8kIeWbsVyayoj4Wt
	 DPsF5V8rnnL3qB2iNXCozDgJoFSBGnZk41YQ5MVHRUobWg75lU70zLp1gtz4mue8Y2
	 IB4L2zESap5m+TxLEWagnvK2rcHcKFFIP4uCiSMj/NPWI+Yp3fZ47dhkSxGXA59znk
	 DLhVJTuZ8qxHcuvO9x71erCwaxaS6beLLXRFbmlI3svudULSkUa8TzcjY474YXwXuQ
	 R2htZ1mPMQoSQ==
Received: from github.com (hubbernetes-node-78ed4e6.ac4-iad.github.net [10.52.158.57])
	by smtp.github.com (Postfix) with ESMTPA id A250634119F
	for <linux-bluetooth@vger.kernel.org>; Wed, 14 Oct 2026 13:57:46 -0700 (PDT)
Date: Wed, 14 Oct 2026 13:57:46 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1185788/000000-9fc799@github.com>
Subject: [bluez/bluez] 9fc799: mgmt-tester: Add LL Privacy host-resolved RPA
 scan...
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

  Branch: refs/heads/1185788
  Home:   https://github.com/bluez/bluez
  Commit: 9fc79909f951aac19e104818be944b4eec3bef67
      https://github.com/bluez/bluez/commit/9fc79909f951aac19e104818be944b4eec3bef67
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-10-14 (Wed, 14 Oct 2026)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add LL Privacy host-resolved RPA scan checks

Controllers with LL Privacy resolve RPAs themselves, so peers with an
IRK can be kept in the accept list and passive scanning shall use the
accept list filter policy.

Assisted-by: OpenCode:claude-opus-5.5



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
