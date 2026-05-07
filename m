Received: from out-23.smtp.github.com (out-23.smtp.github.com [192.30.252.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8338238F
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778173215; cv=none; b=dDDzkqEIlgMvI1RIPqxoZGKZ/BH35H9G5np2uIu/WHfwHAYUHtGGhIl/QR58EQ08sndGcGXEPk1RV9+z/gGaHO9PF5dNp+yCoszj7IwUE3/BAfnzzPtfUtDLC4epppIflt5dUaIllc602f3JZX6FpiEq5T+egfRo2ZfOic32n+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778173215; c=relaxed/simple;
	bh=ItXsVm2NLqE9fxjr0UpOqQ44/9NTvO4+Y0i9uoAifoc=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=ZbWfR32vwD75tN0T5DHY2HLW1hMrVSm6VjoEvY0xLpinB3iq/tp5/DvFEDXTxeU8OILEcoVa5t8k2oGfu8vSLFA/kV3gdiWRohEzOSLlu9m6ZzAbNySjbwm0S7mameZKn8EmU3wSDhkou28U7hJXMRIdFhy4DkjXLCbaioURVyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=SxBqRS9c; arc=none smtp.client-ip=192.30.252.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="SxBqRS9c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1778173213;
	bh=RXa9YVhrlwLI1uh++NTpnNLWjdmuiwtxPEtmOi7Z0a4=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=SxBqRS9c5Gn3rroy3fgMejWdBaAoisRQNZ7fweZInlEjTI4+rL7nuK49BMKekB/9Z
	 1l5gt8RdPpkfv6URGBmaEO5HKaAhBKSxNCrL4WDCF3as2i5D2lJL3OtoZ0Q6mIwMFS
	 BaG5CsMw3WGmPwCMzCWz8oCVD32P0w8l2bxoAs2U=
Received: from github.com (hubbernetes-node-23c2b05.ac4-iad.github.net [10.52.160.56])
	by smtp.github.com (Postfix) with ESMTPA id 127F520B69
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 May 2026 10:00:13 -0700 (PDT)
Date: Thu, 07 May 2026 10:00:13 -0700
From: Luiz Augusto von Dentz <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/e51115-e3dec6@github.com>
Subject: [bluez/bluez] acd0a4: tools/tester: Fix crash when hciemu_new fails
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
  Commit: acd0a49506a1a24a4fe532d77f6f5a1301b011bb
      https://github.com/bluez/bluez/commit/acd0a49506a1a24a4fe532d77f6f5a1301b011bb
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-06 (Wed, 06 May 2026)

  Changed paths:
    M tools/6lowpan-tester.c
    M tools/bnep-tester.c
    M tools/ioctl-tester.c
    M tools/iso-tester.c
    M tools/l2cap-tester.c
    M tools/mesh-tester.c
    M tools/mgmt-tester.c
    M tools/rfcomm-tester.c
    M tools/sco-tester.c
    M tools/smp-tester.c
    M tools/userchan-tester.c

  Log Message:
  -----------
  tools/tester: Fix crash when hciemu_new fails

When hciemu_new returns NULL, the mgmt object was not being unreferenced
before returning from the pre-setup failure path. This could lead to a
NULL dereference in read_info_callback when it later calls
hciemu_get_address on the NULL hciemu pointer.

Add mgmt_unref and return to the error path across all testers.


  Commit: a068db99c46f1fc34b1e2f315fd27b29eab0fee5
      https://github.com/bluez/bluez/commit/a068db99c46f1fc34b1e2f315fd27b29eab0fee5
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-06 (Wed, 06 May 2026)

  Changed paths:
    M emulator/hciemu.c
    M emulator/hciemu.h

  Log Message:
  -----------
  emulator/hciemu: Add hciemu_new_debug/hciemu_new_num_debug

Add new constructors that accept debug callback and user_data parameters,
setting them up immediately after allocation so errors during early
initialization (create_vhci, hciemu_client_new) are captured by the debug
output.


  Commit: e3dec62da2a5170f7c4f94d1eba567f30068f502
      https://github.com/bluez/bluez/commit/e3dec62da2a5170f7c4f94d1eba567f30068f502
  Author: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
  Date:   2026-05-06 (Wed, 06 May 2026)

  Changed paths:
    M tools/6lowpan-tester.c
    M tools/bnep-tester.c
    M tools/ioctl-tester.c
    M tools/iso-tester.c
    M tools/l2cap-tester.c
    M tools/mesh-tester.c
    M tools/mgmt-tester.c
    M tools/rfcomm-tester.c
    M tools/sco-tester.c
    M tools/smp-tester.c
    M tools/userchan-tester.c

  Log Message:
  -----------
  tools/tester: Retry with debug on hciemu_new failure

When hciemu_new fails, retry using hciemu_new_debug to capture early
initialization errors before reporting the failure. This helps diagnose
issues like vhci or client creation failures in CI.


Compare: https://github.com/bluez/bluez/compare/e51115ccd4df...e3dec62da2a5

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
