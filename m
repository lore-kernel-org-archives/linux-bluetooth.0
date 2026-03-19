Received: from out-27.smtp.github.com (out-27.smtp.github.com [192.30.252.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF84F387378
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 17:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.30.252.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942970; cv=none; b=ZAK1slpA+31YSVbZjQ0MWEEPt0oeW7whw35vEjbEByw+2wllnvJy2mFW4s7cQB2tyLZke0WcDt0uuwhVm3yiJuCqC3i1+cMkhAigIqi6QPi5OFHHZqc9I20HbbkwiZ59lQ9FReOrMHG5wSGUa5RNbaUm/I2NDxu2Mme1L8LXr4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942970; c=relaxed/simple;
	bh=6FTrJFuKf3/MoXN4GFXeOb5Ue17p6bfUFjyXEJkCyw8=;
	h=Date:From:To:Message-ID:Subject:Mime-Version:Content-Type; b=AZmtVJs64edxXhPen00z1Yvouv+bjqHotkXDqLA63rB8CaM1XRSvXoKfeOhdHxAXyqCCLTTXv/iMuSNz5OiAtQJxZjgbMtFdHxpNF07Je+AsMXjyn+mAIk3nsxckS/R7RbrZhQog9o72Ypzs6UYdInQfGV7DqmbGjJJGBtV9ao4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=github.com; spf=pass smtp.mailfrom=github.com; dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b=lmtpCqVR; arc=none smtp.client-ip=192.30.252.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=github.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=github.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=github.com header.i=@github.com header.b="lmtpCqVR"
Received: from github.com (hubbernetes-node-c237d22.ash1-iad.github.net [10.56.184.41])
	by smtp.github.com (Postfix) with ESMTPA id 306892E1294
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Mar 2026 10:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=github.com;
	s=pf2023; t=1773942968;
	bh=EL4+Sohs5nXeKqrCflp1JhlvSUMxwd1mxi4fiIiS/Ro=;
	h=Date:From:To:Subject:List-Unsubscribe:From;
	b=lmtpCqVRGiGTFcclekrImItk3bdo4aOq/KU7uMoxlqwZNOONwkmio9vTIWcAjRd69
	 8I0KqsIoTOEAlOFSB6ZkLTDFzUP8sU9WAelFvvNrWqEyGm+JCIqNsGvTM/bUmETMfu
	 vmw8TE1A4eXegJJ6t8cVgu7TD7yHRaDrUtgkC9ZE=
Date: Thu, 19 Mar 2026 10:56:08 -0700
From: Wouter <noreply@github.com>
To: linux-bluetooth@vger.kernel.org
Message-ID: <bluez/bluez/push/refs/heads/master/52c2b3-1436ea@github.com>
Subject: [bluez/bluez] b9a72f: adapter: Fix "Failed to set default system
 config"...
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
  Commit: b9a72fef5cd51f849ce01c9f2775d129a687d855
      https://github.com/bluez/bluez/commit/b9a72fef5cd51f849ce01c9f2775d129a687d855
  Author: Bastien Nocera <hadess@hadess.net>
  Date:   2026-03-19 (Thu, 19 Mar 2026)

  Changed paths:
    M src/adapter.c

  Log Message:
  -----------
  adapter: Fix "Failed to set default system config" startup warning

When using a stock configuration, there will be nothing in the list of
configuration changes to apply to the Bluetooth adapter, which since
5e5b46c5c0cc ("adapter: Do not send empty default system parameter
list") would throw an error, as sending an empty list to the adapter
didn't generate one.

bluetoothd[3291147]: Bluetooth daemon 5.86
bluetoothd[3291147]: Starting SDP server
bluetoothd[3291147]: Using external plugins is not officially supported.
bluetoothd[3291147]: Consider upstreaming your plugins into the BlueZ project.
bluetoothd[3291147]: Bluetooth management interface 1.23 initialized
bluetoothd[3291147]: Battery Provider Manager created
bluetoothd[3291147]: Failed to set default system config for hci0

Fixes: 5e5b46c5c0cc ("adapter: Do not send empty default system parameter list")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>


  Commit: 1436eab1d0e59f9022334ff7d75c8e5032e7a882
      https://github.com/bluez/bluez/commit/1436eab1d0e59f9022334ff7d75c8e5032e7a882
  Author: Wouter <wouter@xesxen.nl>
  Date:   2026-03-19 (Thu, 19 Mar 2026)

  Changed paths:
    M src/shared/shell.c

  Log Message:
  -----------
  shared/shell: Fix SIGSEGV on invalid input

This fixes a crash when handling "<space><tab>"

==3760495== Invalid read of size 1
==3760495==    at 0x4902187: strcmp (vg_replace_strmem.c:941)
==3760495==    by 0x4067408: menu_completion (shell.c:1126)
==3760495==    by 0x40675DE: shell_completion (shell.c:1177)
==3760495==    by 0x4B267AB: gen_completion_matches (complete.c:1282)
==3760495==    by 0x4B2F8C1: rl_complete_internal (complete.c:2104)
==3760495==    by 0x4B26B52: _rl_dispatch_subseq (readline.c:941)
==3760495==    by 0x4B27B71: readline_internal_char (readline.c:690)
==3760495==    by 0x4B48695: rl_callback_read_char (callback.c:275)
==3760495==    by 0x40655F2: bt_shell_input_line (shell.c:309)
==3760495==    by 0x406577E: input_read (shell.c:343)
==3760495==    by 0x4068CB4: watch_callback (io-glib.c:173)
==3760495==    by 0x49C1F4C: g_main_dispatch (gmain.c:3565)
==3760495==  Address 0x0 is not stack'd, malloc'd or (recently) free'd

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>


Compare: https://github.com/bluez/bluez/compare/52c2b37d90c0...1436eab1d0e5

To unsubscribe from these emails, change your notification settings at https://github.com/bluez/bluez/settings/notifications
