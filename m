Received: from out-24.smtp.github.com (out-24.smtp.github.com [192.30.252.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C35334D3A5
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Nov 2025 21:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204327; cv=none; b=biLnJltICXWv79KtRNnTGyLQ0lUL/crRpBN2AN8nolS93XVIPOR7MXXEOYCZDUDUJyuVYQnre4nPx7zst8s62oIwDuwXiU+gOwAdyIvng8yBILp66XO0V5bpdvW/FonkyNkClc43mnJRHrYa7CiLUHH1xjuAGTDm5nUoXS5E7lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204327; c=relaxed/simple;
	bh=fAbJvQwYZNgRJkwDwHNWD9KXFQaTQom0W44+a9g8GCg=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=FIP75sSj+ozCxgjstcIcfsr3v41r53nvtfHGohfiVwz8dVx2qHLHLB9j7XYMAGoh+SgCKrEKBcnkA6LZdCb16zThRL1NEqU7GoCdLtpJjeVh7Xz73PRuv+0SynYyRfyZcOvD86gM62E52Y3V3TlzVCPyfBIUy4Mj0LU+Lo2iMyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=VNGc/2Y1; arc=none smtp.client-ip=192.30.252.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="VNGc/2Y1"
Received: from github.com (hubbernetes-node-f0ce00d.ac4-iad.github.net [10.52.205.79])
	by smtp.github.com (Postfix) with ESMTPA id 5B36C640796
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Nov 2025 13:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1762204325;
	bh=9DKEDll8bfp6qd5XNbtqmEGPa9/POUbn+ZWkJ8DApLw=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=VNGc/2Y1z5my79d0nmPrCvHKmrqxhizh1WfoODOq8EOHdYj5zHbYQLRTxbkF3OvnL
	 r83riKjaxrqOCc6UPyXTUyrBSwL81RgYTEDNRxq5yYV4pGE7hQAFj2bKXhhxYPWuYy
	 Lg69kgJz6V9tU1reaUPcylfuZX6e4WqXEp+HtqSM=
Date: Mon, 03 Nov 2025 13:12:05 -0800
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/1019114/000000-afd44f@github.com>
Subject: [bluez/bluez] 0bf5ec: monitor: Decode Bluetooth 6.0 version
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GitHub-Recipient-Address: linux-bluetooth@vger.kernel.org
X-Auto-Response-Suppress: All

  Branch: refs/heads/1019114
  Home:   https://github.com/bluez/bluez
  Commit: 0bf5ecdcd6d1cf691a9a427b15d0ed92e8cc9320
      https://github.com/bluez/bluez/commit/0bf5ecdcd6d1cf691a9a427b15d0e=
d92e8cc9320
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-03 (Mon, 03 Nov 2025)

  Changed paths:
    M monitor/packet.c

  Log Message:
  -----------
  monitor: Decode Bluetooth 6.0 version

This decodes 0x0e as Bluetooth 6.0.


  Commit: 4624e7c593f93ae4b6080fd04db67c9e626f0d41
      https://github.com/bluez/bluez/commit/4624e7c593f93ae4b6080fd04db67=
c9e626f0d41
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-03 (Mon, 03 Nov 2025)

  Changed paths:
    M emulator/btdev.c

  Log Message:
  -----------
  emulator: Add support for LL Extended Feature Set

This adds support for emulating LL Extended Feature Set introduced in 6.0=

that adds the following:

Commands:

 - HCI_LE_Read_All_Local_Supported_=C2=ADFeatures(0x2087)(Feature:47,1)
 - HCI_LE_Read_All_Remote_Features(0x2088)(Feature:47,2)

Events:

 - HCI_LE_Read_All_Remote_Features_Complete(0x2b)(Mask bit:42)


  Commit: afd44f3d12215fadc159b687d96d0d46f72e41f9
      https://github.com/bluez/bluez/commit/afd44f3d12215fadc159b687d96d0=
d46f72e41f9
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-11-03 (Mon, 03 Nov 2025)

  Changed paths:
    M tools/mgmt-tester.c

  Log Message:
  -----------
  mgmt-tester: Add tests for 5.2 and 6.0 Bluetooth version

This adds the following tests that attempt to initialize controllers
with version 5.2 and 6.0:

 - Set Low Energy on 5.2 - Success 4
 - Set Low Energy on 6.0 - Success 5


Compare: https://github.com/bluez/bluez/compare/0bf5ecdcd6d1%5E...afd44f3=
d1221

To unsubscribe from these emails, change your notification settings at ht=
tps://github.com/bluez/bluez/settings/notifications
