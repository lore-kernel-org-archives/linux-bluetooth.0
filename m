Received: from out-28.smtp.github.com (out-28.smtp.github.com [192.30.252.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7C91C5D72
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461433; cv=none; b=RcKlO+T1JHIYF4T5maLcrbJCrxUG4X7rkhsoAhKTfN5iEqh2oDQshBghVbG90Ft6js8ilRRHKiNhTp+2b81Rw5I0VvyaN4pAnQYTGEi1cram30Mo/HxjVXwBd/7L9VXjb5R7kPu7mi0WWOaYNqeE5BOouUCtFZb9+qFsGkHOoOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461433; c=relaxed/simple;
	bh=PmhOFc0tJVrq1p71FZ8e1OCQRbhyO5/omrbISBx1HD8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=oqCAQwCCE8hybeXUJDbBUCKzCzt33G0OsgeP0vz3/+07E+qx3B8Q4m5/IB8yhwf1afNbkBChPjhdVCWvv4csxPj1P7RH2UhbR6nbJ2vIf7uXYMyU+otK3+hfy8LWfH1AeL6asQzp0glQXGIyWIQrTv//U0sDUqshHf/xofEBCMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=J77bj0oQ; arc=none smtp.client-ip=192.30.252.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="J77bj0oQ"
Received: from github.com (hubbernetes-node-2101ae3.ash1-iad.github.net [10.56.203.97])
	by smtp.github.com (Postfix) with ESMTPA id DFE70920DE7
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 02:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1756461430;
	bh=AnDeOu8u62LdgZqnqxohIUxrelpTl56PtzRxmxNZgy4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=J77bj0oQw4LKqJpiqJP/SK1YLx7CL5j6/Y5U8ixs++FOWaSvLdC/2gHHo2Hg5dYvZ
	 GH6c1vmuMJBMWYTjYWVJd6VOTsmPKnPnyUJOGN4dqdzzapgaV9Yznfaw8Uwv0xdkL7
	 xQJlQ5Bft/io8I9VAA0gwKNblMP4oYh5P0xhqSMc=
Date: Fri, 29 Aug 2025 02:57:10 -0700
From: "github-actions[bot]" <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/996842/000000-9b0325@github.com>
Subject: [bluez/bluez] 9b0325: device: Recreate paired device from storage
 after ...
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

  Branch: refs/heads/996842
  Home:   https://github.com/bluez/bluez
  Commit: 9b0325f0a941942cb4f3fe95e69c7f5c9e156ecf
      https://github.com/bluez/bluez/commit/9b0325f0a941942cb4f3fe95e69c7f5c9e156ecf
  Author: xinpeng.wang <wangxinpeng@uniontech.com>
  Date:   2025-08-29 (Fri, 29 Aug 2025)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  device: Recreate paired device from storage after failed restore

When a USB Bluetooth adapter is resumed from S4 suspend, the kernel
may trigger an "index remove" followed by an "index add". BlueZ
responds by removing all devices and attempting to recreate them
from stored configuration (storage).

However, if a connected A2DP device disconnects just before suspend,
BlueZ may have started a disconnect timer (via set_disconnect_timer)
but not yet freed the session. During this period:
- The session pointer is set to NULL and becomes inaccessible.
- The session still holds a reference to the device, preventing it
  from being freed.
- As a result, the "index add" event fails to recreate the device from
  storage (due to D-Bus path conflict or incomplete cleanup).
- Later, when the timer expires, a new device is created from discovery
  data, bypassing storage and causing it to appear as unpaired.

This leads to loss of pairing information and confuses desktop applications
that rely on paired/unpaired state.

This patch enhances the device creation logic: if loading a paired device
from storage previously failed (e.g., due to pending session cleanup), its
address is recorded in the adapter's pending list. Later, when creating a
device from scan data, BlueZ checks this list and re-attempts creation from
storage if matched, ensuring the correct paired state is restored.

This ensures that devices are properly restored after suspend/resume
cycles, even in race conditions involving delayed session cleanup.

Signed-off-by: xinpeng.wang <wangxinpeng@uniontech.com>



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
