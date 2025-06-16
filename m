Received: from out-22.smtp.github.com (out-22.smtp.github.com [192.30.252.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58594289E30
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 18:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750097744; cv=none; b=i8FLd7NzYO/G5FhGch2yckvgnMwx9zBhwtNX6ii2xLER8u4yaU74EWoTX5p3V/KBaQUQHWIdLgGjfPiDuFw+cT0HbGAfcTLABjCDrmr6wDHRmnXF7p7HUMgTK/XKTNng6mPTvzFnGE29mFHCh8tVGCv9b/0QoGX7sFtJh7zh0Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750097744; c=relaxed/simple;
	bh=9dWCxoEfxDW1000gOz22Cnc7JNppTLbpqz2gkOc1kmw=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=JCgUA8AVKDwKZKoh+2WHZYlInbu1wm+LQ3KEqWS4R1SfI/M1vpZHo98fgo6ZJFpPP+CFfs0xdfUGD8KMpRkmG6kkNCogokyWjIhh2dtQytKaRaZDw1wPv4Q560Xe+fmYj/mDSIu5K0Fw33Zt2ruMeoLY4BfzxTia0tLi5h7uGmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=TF3tAFLq; arc=none smtp.client-ip=192.30.252.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="TF3tAFLq"
Received: from github.com (hubbernetes-node-f89cf90.ac4-iad.github.net [10.52.181.60])
	by smtp.github.com (Postfix) with ESMTPA id 8A0B7211B0
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Jun 2025 11:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1750097742;
	bh=rKHIU69RAEnKNurn4kC891BZ+b+UXXwuhLToX7hMGoY=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=TF3tAFLqdbBMHCJ3ksBXhL4lrUrAXKJjShMmbaplqEuoScaZyW5RV0IiV46asr7JP
	 Di5g9uJaUs1sSNI24IKdrYH/L8wmy6KemYoLCE1pBSjDO2QQoElyw4vjsM6xE19Y6P
	 3N9fbD/WUAlSZU2sMfLlXgiHeJFQrro2XKx4NhGE=
Date: Mon, 16 Jun 2025 11:15:42 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/972634/000000-09dfef@github.com>
Subject: [bluez/bluez] 09dfef: iso-tester: Fix crashing while attemping to
 access...
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

  Branch: refs/heads/972634
  Home:   https://github.com/bluez/bluez
  Commit: 09dfef8dca7e7ca96feceb4c9fe0dfb6a841ab15
      https://github.com/bluez/bluez/commit/09dfef8dca7e7ca96feceb4c9fe0dfb6a841ab15
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2025-06-16 (Mon, 16 Jun 2025)

  Changed paths:
    M tools/iso-tester.c

  Log Message:
  -----------
  iso-tester: Fix crashing while attemping to access isodata

Some tests may not set any isodata causing the following crash:

Invalid read of size 1
   at 0x40067A8: setup_powered_callback (iso-tester.c:1691)
   by 0x40232D5: request_complete (mgmt.c:306)
   by 0x40242B3: can_read_data (mgmt.c:394)
   by 0x4028529: watch_callback (io-glib.c:173)
   by 0x493D87F: ??? (in /usr/lib64/libglib-2.0.so.0.8400.2)
   by 0x49467A7: ??? (in /usr/lib64/libglib-2.0.so.0.8400.2)
   by 0x4946A4E: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.8400.2)
   by 0x402ABFD: mainloop_run (mainloop-glib.c:65)
   by 0x402B1D4: mainloop_run_with_signal (mainloop-notify.c:196)
   by 0x402A3F5: tester_run (tester.c:1076)
   by 0x40050FE: main (iso-tester.c:4010)
 Address 0xa8 is not stack'd, malloc'd or (recently) free'd



To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
